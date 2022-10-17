From: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Date: Mon, 17 Oct 2022 17:42:48 +0530
Subject: [PATCH 09/10] mtd: spi-nor: Add parallel memories support in spi-nor
In-Reply-To: <20221017121249.19061-1-amit.kumar-mahapatra@amd.com>
References: <20221017121249.19061-1-amit.kumar-mahapatra@amd.com>
Message-ID: <20221017121249.19061-10-amit.kumar-mahapatra@amd.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The current implementation assumes that a maximum of two flashes are
connected in parallel mode. The QSPI controller splits the data evenly
between both the flashes so, both the flashes that are connected in
parallel mode should be identical.
During each operation SPI-NOR sets 0th bit for CS0 & 1st bit for CS1 in
nor->spimem->spi->cs_index_mask. The QSPI driver will then assert/de-assert
CS0 & CS1.
Write operation in parallel mode are performed in page size * 2 chunks as
each write operation results in writing both the flashes. For doubling the
address space each operation is performed at addr/2 flash offset, where
addr is the address specified by the user.

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
---
 drivers/mtd/spi-nor/core.c      | 455 +++++++++++++++++++++++---------
 drivers/mtd/spi-nor/core.h      |   4 +
 drivers/mtd/spi-nor/micron-st.c |   5 +
 3 files changed, 344 insertions(+), 120 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 3801890c17e6..8b434115a92e 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -463,17 +463,29 @@ int spi_nor_read_sr(struct spi_nor *nor, u8 *sr)
 			op.data.nbytes = 2;
 		}
 
+		if (nor->flags & SNOR_F_HAS_PARALLEL)
+			op.data.nbytes = 2;
+
 		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
 
 		ret = spi_mem_exec_op(nor->spimem, &op);
 	} else {
-		ret = spi_nor_controller_ops_read_reg(nor, SPINOR_OP_RDSR, sr,
-						      1);
+		if (nor->flags & SNOR_F_HAS_PARALLEL)
+			ret = spi_nor_controller_ops_read_reg(nor,
+							      SPINOR_OP_RDSR,
+							      sr, 2);
+		else
+			ret = spi_nor_controller_ops_read_reg(nor,
+							      SPINOR_OP_RDSR,
+							      sr, 1);
 	}
 
 	if (ret)
 		dev_dbg(nor->dev, "error %d reading SR\n", ret);
 
+	if (nor->flags & SNOR_F_HAS_PARALLEL)
+		sr[0] |= sr[1];
+
 	return ret;
 }
 
@@ -1450,12 +1462,108 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 	if (ret)
 		return ret;
 
-	/* whole-chip erase? */
-	if (len == mtd->size && !(nor->flags & SNOR_F_NO_OP_CHIP_ERASE)) {
-		unsigned long timeout;
+	if (!(nor->flags & SNOR_F_HAS_PARALLEL)) {
+		/* whole-chip erase? */
+		if (len == mtd->size && !(nor->flags & SNOR_F_NO_OP_CHIP_ERASE)) {
+			unsigned long timeout;
+
+			while (cur_cs_num < SNOR_FLASH_CNT_MAX && (nor->params[cur_cs_num])) {
+				nor->spimem->spi->cs_index_mask = 0x01 << cur_cs_num;
+				ret = spi_nor_write_enable(nor);
+				if (ret)
+					goto erase_err;
+
+				ret = spi_nor_erase_chip(nor);
+				if (ret)
+					goto erase_err;
+
+				/*
+				 * Scale the timeout linearly with the size of the flash, with
+				 * a minimum calibrated to an old 2MB flash. We could try to
+				 * pull these from CFI/SFDP, but these values should be good
+				 * enough for now.
+				 */
+				timeout = max(CHIP_ERASE_2MB_READY_WAIT_JIFFIES,
+					      CHIP_ERASE_2MB_READY_WAIT_JIFFIES *
+					      (unsigned long)(nor->params[cur_cs_num]->size /
+							      SZ_2M));
+				ret = spi_nor_wait_till_ready_with_timeout(nor, timeout);
+				if (ret)
+					goto erase_err;
+				cur_cs_num++;
+			}
+
+		/* REVISIT in some cases we could speed up erasing large regions
+		 * by using SPINOR_OP_SE instead of SPINOR_OP_BE_4K.  We may have set up
+		 * to use "small sector erase", but that's not always optimal.
+		 */
+
+		/* "sector"-at-a-time erase */
+		} else if (spi_nor_has_uniform_erase(nor)) {
+			/* Determine the flash from which the operation need to start */
+			while ((cur_cs_num < SNOR_FLASH_CNT_MAX) &&
+			       (addr > sz - 1) && (nor->params[cur_cs_num]))
+				sz += nor->params[++cur_cs_num]->size;
+
+			while (len) {
+				nor->spimem->spi->cs_index_mask = 0x01 << cur_cs_num;
+				ret = spi_nor_write_enable(nor);
+				if (ret)
+					goto erase_err;
+
+				offset = addr;
+				if (nor->flags & SNOR_F_HAS_STACKED)
+					offset -= (sz - nor->params[cur_cs_num]->size);
+
+				ret = spi_nor_erase_sector(nor, offset);
+				if (ret)
+					goto erase_err;
+
+				ret = spi_nor_wait_till_ready(nor);
+				if (ret)
+					goto erase_err;
+
+				addr += mtd->erasesize;
+				len -= mtd->erasesize;
+
+				/*
+				 * Flash cross over condition in stacked mode.
+				 */
+				if ((nor->flags & SNOR_F_HAS_STACKED) && (addr > sz - 1))
+					sz += nor->params[++cur_cs_num]->size;
+			}
+
+		/* erase multiple sectors */
+		} else {
+			u64 erase_len = 0;
+
+			/* Determine the flash from which the operation need to start */
+			while ((cur_cs_num < SNOR_FLASH_CNT_MAX) &&
+			       (addr > sz - 1) && (nor->params[cur_cs_num]))
+				sz += nor->params[++cur_cs_num]->size;
+			/* perform multi sector erase onec per Flash*/
+			while (len) {
+				erase_len = (len > (sz - addr)) ? (sz - addr) : len;
+				offset = addr;
+				nor->spimem->spi->cs_index_mask = 0x01 << cur_cs_num;
+				if (nor->flags & SNOR_F_HAS_STACKED)
+					offset -= (sz - nor->params[cur_cs_num]->size);
+				ret = spi_nor_erase_multi_sectors(nor, offset, erase_len);
+				if (ret)
+					goto erase_err;
+				len -= erase_len;
+				addr += erase_len;
+				sz += nor->params[++cur_cs_num]->size;
+			}
+		}
+	} else {
+		nor->spimem->spi->cs_index_mask = SPI_NOR_ENABLE_MULTI_CS;
+
+		/* whole-chip erase? */
+		if (len == mtd->size && !(nor->flags &
+					  SNOR_F_NO_OP_CHIP_ERASE)) {
+			unsigned long timeout;
 
-		while (cur_cs_num < SNOR_FLASH_CNT_MAX && (nor->params[cur_cs_num])) {
-			nor->spimem->spi->cs_index_mask = 0x01 << cur_cs_num;
 			ret = spi_nor_write_enable(nor);
 			if (ret)
 				goto erase_err;
@@ -1472,77 +1580,45 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 			 */
 			timeout = max(CHIP_ERASE_2MB_READY_WAIT_JIFFIES,
 				      CHIP_ERASE_2MB_READY_WAIT_JIFFIES *
-				      (unsigned long)(nor->params[cur_cs_num]->size / SZ_2M));
+				      (unsigned long)(mtd->size / SZ_2M));
 			ret = spi_nor_wait_till_ready_with_timeout(nor, timeout);
 			if (ret)
 				goto erase_err;
-			cur_cs_num++;
-		}
 
-	/* REVISIT in some cases we could speed up erasing large regions
-	 * by using SPINOR_OP_SE instead of SPINOR_OP_BE_4K.  We may have set up
-	 * to use "small sector erase", but that's not always optimal.
-	 */
-
-	/* "sector"-at-a-time erase */
-	} else if (spi_nor_has_uniform_erase(nor)) {
-		/* Determine the flash from which the operation need to start */
-		while ((cur_cs_num < SNOR_FLASH_CNT_MAX) &&
-		       (addr > sz - 1) && (nor->params[cur_cs_num]))
-			sz += nor->params[++cur_cs_num]->size;
+		/* REVISIT in some cases we could speed up erasing large regions
+		 * by using SPINOR_OP_SE instead of SPINOR_OP_BE_4K.  We may have set up
+		 * to use "small sector erase", but that's not always optimal.
+		 */
 
-		while (len) {
-			nor->spimem->spi->cs_index_mask = 0x01 << cur_cs_num;
-			ret = spi_nor_write_enable(nor);
-			if (ret)
-				goto erase_err;
+		/* "sector"-at-a-time erase */
+		} else if (spi_nor_has_uniform_erase(nor)) {
+			while (len) {
+				ret = spi_nor_write_enable(nor);
+				if (ret)
+					goto erase_err;
 
-			offset = addr;
-			if (nor->flags & SNOR_F_HAS_STACKED)
-				offset -= (sz - nor->params[cur_cs_num]->size);
+				offset = addr / 2;
 
-			ret = spi_nor_erase_sector(nor, offset);
-			if (ret)
-				goto erase_err;
+				ret = spi_nor_erase_sector(nor, offset);
+				if (ret)
+					goto erase_err;
 
-			ret = spi_nor_wait_till_ready(nor);
-			if (ret)
-				goto erase_err;
+				ret = spi_nor_wait_till_ready(nor);
+				if (ret)
+					goto erase_err;
 
-			addr += mtd->erasesize;
-			len -= mtd->erasesize;
-
-			/*
-			 * Flash cross over condition in stacked mode.
-			 */
-			if ((nor->flags & SNOR_F_HAS_STACKED) && (addr > sz - 1))
-				sz += nor->params[++cur_cs_num]->size;
-		}
-
-	/* erase multiple sectors */
-	} else {
-		u64 erase_len = 0;
+				offset += mtd->erasesize;
+				len -= mtd->erasesize;
+			}
 
-		/* Determine the flash from which the operation need to start */
-		while ((cur_cs_num < SNOR_FLASH_CNT_MAX) &&
-		       (addr > sz - 1) && (nor->params[cur_cs_num]))
-			sz += nor->params[++cur_cs_num]->size;
-		/* perform multi sector erase onec per Flash*/
-		while (len) {
-			erase_len = (len > (sz - addr)) ? (sz - addr) : len;
-			offset = addr;
-			nor->spimem->spi->cs_index_mask = 0x01 << cur_cs_num;
-			if (nor->flags & SNOR_F_HAS_STACKED)
-				offset -= (sz - nor->params[cur_cs_num]->size);
-			ret = spi_nor_erase_multi_sectors(nor, offset, erase_len);
+		/* erase multiple sectors */
+		} else {
+			offset = addr / 2;
+			ret = spi_nor_erase_multi_sectors(nor, offset, len);
 			if (ret)
 				goto erase_err;
-			len -= erase_len;
-			addr += erase_len;
-			sz += nor->params[++cur_cs_num]->size;
 		}
 	}
-
 	ret = spi_nor_write_disable(nor);
 
 erase_err:
@@ -1719,27 +1795,52 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 	ssize_t ret, read_len;
 	u32 cur_cs_num = 0;
 	u64 sz = nor->params[cur_cs_num]->size;
+	u_char *readbuf;
+	bool is_ofst_odd = false;
 
 	dev_dbg(nor->dev, "from 0x%08x, len %zd\n", (u32)from, len);
 
+	/*
+	 * Cannot read from odd offset in parallel mode, so read
+	 * len + 1 from offset + 1 and ignore offset[0] data.
+	 */
+	if ((nor->flags & SNOR_F_HAS_PARALLEL) && (from & 0x01)) {
+		from = (loff_t)(from - 1);
+		len = (size_t)(len + 1);
+		is_ofst_odd = true;
+		readbuf = kmalloc(len, GFP_KERNEL);
+		if (!readbuf)
+			return -ENOMEM;
+	} else {
+		readbuf = buf;
+	}
+
+	if (!(nor->flags & SNOR_F_HAS_PARALLEL)) {
+		/* Determine the flash from which the operation need to start */
+		while ((cur_cs_num < SNOR_FLASH_CNT_MAX) && (from > sz - 1) &&
+		       (nor->params[cur_cs_num]))
+			sz += nor->params[++cur_cs_num]->size;
+	}
 	ret = spi_nor_lock_and_prep(nor);
 	if (ret)
 		return ret;
 
-	/* Determine the flash from which the operation need to start */
-	while ((cur_cs_num < SNOR_FLASH_CNT_MAX) && (from > sz - 1) &&
-	       (nor->params[cur_cs_num]))
-		sz += nor->params[++cur_cs_num]->size;
 	while (len) {
 		loff_t addr = from;
 
-		nor->spimem->spi->cs_index_mask = 0x01 << cur_cs_num;
-		read_len = (len > (sz - addr)) ? (sz - addr) : len;
-		addr -= (sz - nor->params[cur_cs_num]->size);
+		if (nor->flags & SNOR_F_HAS_PARALLEL) {
+			nor->spimem->spi->cs_index_mask = SPI_NOR_ENABLE_MULTI_CS;
+			read_len = len;
+			addr /= 2;
+		} else {
+			nor->spimem->spi->cs_index_mask = 0x01 << cur_cs_num;
+			read_len = (len > (sz - addr)) ? (sz - addr) : len;
+			addr -= (sz - nor->params[cur_cs_num]->size);
+		}
 
 		addr = spi_nor_convert_addr(nor, addr);
 
-		ret = spi_nor_read_data(nor, addr, len, buf);
+		ret = spi_nor_read_data(nor, addr, read_len, readbuf);
 		if (ret == 0) {
 			/* We shouldn't see 0-length reads */
 			ret = -EIO;
@@ -1749,8 +1850,15 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 			goto read_err;
 
 		WARN_ON(ret > read_len);
-		*retlen += ret;
+		if (is_ofst_odd) {
+			memcpy(buf, (readbuf + 1), (len - 1));
+			*retlen += (ret - 1);
+		} else {
+			*retlen += ret;
+		}
 		buf += ret;
+		if (!is_ofst_odd)
+			readbuf += ret;
 		from += ret;
 		len -= ret;
 
@@ -1765,6 +1873,9 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 	ret = 0;
 
 read_err:
+	if (is_ofst_odd)
+		kfree(readbuf);
+
 	spi_nor_unlock_and_unprep(nor);
 	return ret;
 }
@@ -1786,11 +1897,36 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 
 	dev_dbg(nor->dev, "to 0x%08x, len %zd\n", (u32)to, len);
 
-	/* Determine the flash from which the operation need to start */
-	while ((cur_cs_num < SNOR_FLASH_CNT_MAX) && (to > sz - 1) &&
-	       (nor->params[cur_cs_num]))
-		sz += nor->params[++cur_cs_num]->size;
+	if (nor->flags & SNOR_F_HAS_PARALLEL) {
+		/*
+		 * Cannot write to odd offset in parallel mode,
+		 * so write 2 byte first.
+		 */
+		if (to & 0x01) {
+			u8 two[2] = {0xff, buf[0]};
+			size_t written_len;
+
+			ret = spi_nor_write(mtd, to & ~1, 2, &written_len, two);
+			if (ret < 0)
+				return ret;
+			*retlen += 1; /* We've written only one actual byte */
+			++buf;
+			--len;
+			++to;
+		}
+		/*
+		 * Write operation are performed in page size chunks and in
+		 * parallel memories both the flashes are written simultaneously,
+		 * hence doubled the page_size.
+		 */
+		page_size <<= 1;
 
+	} else {
+		/* Determine the flash from which the operation need to start */
+		while ((cur_cs_num < SNOR_FLASH_CNT_MAX) && (to > sz - 1) &&
+		       (nor->params[cur_cs_num]))
+			sz += nor->params[++cur_cs_num]->size;
+	}
 	ret = spi_nor_lock_and_prep(nor);
 	if (ret)
 		return ret;
@@ -1814,8 +1950,13 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 		/* the size of data remaining on the first page */
 		page_remain = min_t(size_t, page_size - page_offset, len - i);
 
-		nor->spimem->spi->cs_index_mask = 0x01 << cur_cs_num;
-		addr -= (sz - nor->params[cur_cs_num]->size);
+		if (nor->flags & SNOR_F_HAS_PARALLEL) {
+			nor->spimem->spi->cs_index_mask = SPI_NOR_ENABLE_MULTI_CS;
+			addr /= 2;
+		} else {
+			nor->spimem->spi->cs_index_mask = 0x01 << cur_cs_num;
+			addr -= (sz - nor->params[cur_cs_num]->size);
+		}
 
 		addr = spi_nor_convert_addr(nor, addr);
 
@@ -2240,7 +2381,15 @@ static int spi_nor_select_erase(struct spi_nor *nor)
 		if (!erase)
 			return -EINVAL;
 		nor->erase_opcode = erase->opcode;
-		mtd->erasesize = erase->size;
+		/*
+		 * In parallel-memories the erase operation is
+		 * performed on both the flashes simultaneously
+		 * so, double the erasesize.
+		 */
+		if (nor->flags & SNOR_F_HAS_PARALLEL)
+			mtd->erasesize = erase->size * 2;
+		else
+			mtd->erasesize = erase->size;
 		return 0;
 	}
 
@@ -2258,7 +2407,15 @@ static int spi_nor_select_erase(struct spi_nor *nor)
 	if (!erase)
 		return -EINVAL;
 
-	mtd->erasesize = erase->size;
+	/*
+	 * In parallel-memories the erase operation is
+	 * performed on both the flashes simultaneously
+	 * so, double the erasesize.
+	 */
+	if (nor->flags & SNOR_F_HAS_PARALLEL)
+		mtd->erasesize = erase->size * 2;
+	else
+		mtd->erasesize = erase->size;
 	return 0;
 }
 
@@ -2572,11 +2729,25 @@ static void spi_nor_late_init_params(struct spi_nor *nor)
 				nor->flags |= SNOR_F_HAS_STACKED;
 		}
 	}
-	if (nor->flags & SNOR_F_HAS_STACKED) {
+	i = 0;
+	idx = 0;
+	while (i < SNOR_FLASH_CNT_MAX) {
+		rc = of_property_read_u64_index(np, "parallel-memories", idx, &flash_size[i]);
+		if (rc == -EINVAL) {
+			break;
+		} else if (rc == -EOVERFLOW) {
+			idx++;
+		} else {
+			idx++;
+			i++;
+			if (!(nor->flags & SNOR_F_HAS_PARALLEL))
+				nor->flags |= SNOR_F_HAS_PARALLEL;
+		}
+	}
+	if (nor->flags & (SNOR_F_HAS_STACKED | SNOR_F_HAS_PARALLEL)) {
 		for (idx = 1; idx < SNOR_FLASH_CNT_MAX; idx++) {
 			nor->params[idx] = devm_kzalloc(nor->dev,
-							sizeof(*nor->params[0]),
-							GFP_KERNEL);
+							sizeof(*nor->params[0]), GFP_KERNEL);
 			if (nor->params[idx]) {
 				memcpy(nor->params[idx], nor->params[0], sizeof(*nor->params[0]));
 				nor->params[idx]->size = flash_size[idx];
@@ -2782,23 +2953,40 @@ static int spi_nor_quad_enable(struct spi_nor *nor)
 {
 	int err, idx;
 
-	for (idx = 0; idx < SNOR_FLASH_CNT_MAX; idx++) {
-		if (nor->params[idx]) {
-			if (!nor->params[idx]->quad_enable)
-				return 0;
+	if (nor->flags & SNOR_F_HAS_PARALLEL) {
+		if (!nor->params[0]->quad_enable)
+			return 0;
 
-			if (!(spi_nor_get_protocol_width(nor->read_proto) == 4 ||
-			      spi_nor_get_protocol_width(nor->write_proto) == 4))
-				return 0;
-			/*
-			 * Set the appropriate CS index before
-			 * issuing the command.
-			 */
-			nor->spimem->spi->cs_index_mask = 0x01 << idx;
+		if (!(spi_nor_get_protocol_width(nor->read_proto) == 4 ||
+		      spi_nor_get_protocol_width(nor->write_proto) == 4))
+			return 0;
+		/*
+		 * In parallel mode both chip selects i.e., CS0 &
+		 * CS1 need to be asserted simulatneously.
+		 */
+		nor->spimem->spi->cs_index_mask = SPI_NOR_ENABLE_MULTI_CS;
+		err = nor->params[0]->quad_enable(nor);
+		if (err)
+			return err;
+	} else {
+		for (idx = 0; idx < SNOR_FLASH_CNT_MAX; idx++) {
+			if (nor->params[idx]) {
+				if (!nor->params[idx]->quad_enable)
+					return 0;
+
+				if (!(spi_nor_get_protocol_width(nor->read_proto) == 4 ||
+				      spi_nor_get_protocol_width(nor->write_proto) == 4))
+					return 0;
+				/*
+				 * Set the appropriate CS index before
+				 * issuing the command.
+				 */
+				nor->spimem->spi->cs_index_mask = 0x01 << idx;
 
-			err = nor->params[idx]->quad_enable(nor);
-			if (err)
-				return err;
+				err = nor->params[idx]->quad_enable(nor);
+				if (err)
+					return err;
+			}
 		}
 	}
 	return err;
@@ -2847,16 +3035,25 @@ static int spi_nor_init(struct spi_nor *nor)
 		 */
 		WARN_ONCE(nor->flags & SNOR_F_BROKEN_RESET,
 			  "enabling reset hack; may not recover from unexpected reboots\n");
-		for (idx = 0; idx < SNOR_FLASH_CNT_MAX; idx++) {
-			if (nor->params[idx]) {
-				/*
-				 * Select the appropriate CS index before
-				 * issuing the command.
-				 */
-				nor->spimem->spi->cs_index_mask = 0x01 << idx;
-				err = nor->params[idx]->set_4byte_addr_mode(nor, true);
-				if (err)
-					return err;
+		if (nor->flags & SNOR_F_HAS_PARALLEL) {
+			/*
+			 * In parallel mode both chip selects i.e., CS0 &
+			 * CS1 need to be asserted simulatneously.
+			 */
+			nor->spimem->spi->cs_index_mask = SPI_NOR_ENABLE_MULTI_CS;
+			nor->params[0]->set_4byte_addr_mode(nor, true);
+		} else {
+			for (idx = 0; idx < SNOR_FLASH_CNT_MAX; idx++) {
+				if (nor->params[idx]) {
+					/*
+					 * Select the appropriate CS index before
+					 * issuing the command.
+					 */
+					nor->spimem->spi->cs_index_mask = 0x01 << idx;
+					err = nor->params[idx]->set_4byte_addr_mode(nor, true);
+					if (err)
+						return err;
+				}
 			}
 		}
 	}
@@ -2977,14 +3174,23 @@ void spi_nor_restore(struct spi_nor *nor)
 	/* restore the addressing mode */
 	if (nor->addr_nbytes == 4 && !(nor->flags & SNOR_F_4B_OPCODES) &&
 	    nor->flags & SNOR_F_BROKEN_RESET) {
-		for (idx = 0; idx < SNOR_FLASH_CNT_MAX; idx++) {
-			if (nor->params[idx]) {
-				/*
-				 * Select the appropriate CS index before
-				 * issuing the command.
-				 */
-				nor->spimem->spi->cs_index_mask = 0x01 << idx;
-				nor->params[idx]->set_4byte_addr_mode(nor, false);
+		if (nor->flags & SNOR_F_HAS_PARALLEL) {
+			/*
+			 * In parallel mode both chip selects i.e., CS0 &
+			 * CS1 need to be asserted simulatneously.
+			 */
+			nor->spimem->spi->cs_index_mask = SPI_NOR_ENABLE_MULTI_CS;
+			nor->params[0]->set_4byte_addr_mode(nor, false);
+		} else {
+			for (idx = 0; idx < SNOR_FLASH_CNT_MAX; idx++) {
+				if (nor->params[idx]) {
+					/*
+					 * Select the appropriate CS index before
+					 * issuing the command.
+					 */
+					nor->spimem->spi->cs_index_mask = 0x01 << idx;
+					nor->params[idx]->set_4byte_addr_mode(nor, false);
+				}
 			}
 		}
 	}
@@ -3069,7 +3275,16 @@ static void spi_nor_set_mtd_info(struct spi_nor *nor)
 	else
 		mtd->_erase = spi_nor_erase;
 	mtd->writesize = nor->params[0]->writesize;
-	mtd->writebufsize = nor->params[0]->page_size;
+	/*
+	 * In parallel-memories the write operation is
+	 * performed on both the flashes simultaneously
+	 * one page per flash, so double the writebufsize.
+	 */
+	if (nor->flags & SNOR_F_HAS_PARALLEL)
+		mtd->writebufsize = nor->params[0]->page_size << 1;
+	else
+		mtd->writebufsize = nor->params[0]->page_size;
+
 	for (idx = 0; idx < SNOR_FLASH_CNT_MAX; idx++) {
 		if (nor->params[idx])
 			total_sz += nor->params[idx]->size;
@@ -3185,7 +3400,7 @@ static int spi_nor_create_read_dirmap(struct spi_nor *nor)
 	};
 	struct spi_mem_op *op = &info.op_tmpl;
 
-	if (nor->flags & SNOR_F_HAS_STACKED) {
+	if (nor->flags & (SNOR_F_HAS_STACKED | SNOR_F_HAS_PARALLEL)) {
 		for (idx = 1; idx < SNOR_FLASH_CNT_MAX; idx++)
 			info.length += nor->params[idx]->size;
 	}
@@ -3221,7 +3436,7 @@ static int spi_nor_create_write_dirmap(struct spi_nor *nor)
 	};
 	struct spi_mem_op *op = &info.op_tmpl;
 
-	if (nor->flags & SNOR_F_HAS_STACKED) {
+	if (nor->flags & (SNOR_F_HAS_STACKED | SNOR_F_HAS_PARALLEL)) {
 		for (idx = 1; idx < SNOR_FLASH_CNT_MAX; idx++)
 			info.length += nor->params[idx]->size;
 	}
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 285b7a46a1da..5c0e756c6df1 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -14,6 +14,9 @@
 /* In single configuration enable CS0 */
 #define SPI_NOR_ENABLE_CS0     BIT(0)
 
+/* In parallel configuration enable multiple CS */
+#define SPI_NOR_ENABLE_MULTI_CS	(BIT(0) | BIT(1))
+
 /* Standard SPI NOR flash operations. */
 #define SPI_NOR_READID_OP(naddr, ndummy, buf, len)			\
 	SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDID, 0),			\
@@ -134,6 +137,7 @@ enum spi_nor_option_flags {
 	SNOR_F_SOFT_RESET	= BIT(12),
 	SNOR_F_SWP_IS_VOLATILE	= BIT(13),
 	SNOR_F_HAS_STACKED      = BIT(14),
+	SNOR_F_HAS_PARALLEL	= BIT(15),
 };
 
 struct spi_nor_read_command {
diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index ad2a2e126c4a..ec1e19a0e011 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -345,6 +345,9 @@ static int micron_st_nor_read_fsr(struct spi_nor *nor, u8 *fsr)
 			op.data.nbytes = 2;
 		}
 
+		if (nor->flags & SNOR_F_HAS_PARALLEL)
+			op.data.nbytes = 2;
+
 		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
 
 		ret = spi_mem_exec_op(nor->spimem, &op);
@@ -356,6 +359,8 @@ static int micron_st_nor_read_fsr(struct spi_nor *nor, u8 *fsr)
 	if (ret)
 		dev_dbg(nor->dev, "error %d reading FSR\n", ret);
 
+	if (nor->flags & SNOR_F_HAS_PARALLEL)
+		fsr[0] &= fsr[1];
 	return ret;
 }
 
-- 
2.17.1

