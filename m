From: Tudor.Ambarus@microchip.com <Tudor.Ambarus@microchip.com>
Date: Tue, 17 Sep 2019 15:55:35 +0000
Subject: [PATCH 17/23] mtd: spi-nor: Fix clearing of QE bit on lock()/unlock()
In-Reply-To: <20190917155426.7432-1-tudor.ambarus@microchip.com>
References: <20190917155426.7432-1-tudor.ambarus@microchip.com>
Message-ID: <20190917155426.7432-18-tudor.ambarus@microchip.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Make sure that when doing a lock() or an unlock() operation we don't clear
the QE bit from Status Register 2.

JESD216 revB or later offers information about the *default* Status
Register commands to use (see BFPT DWORDS[15], bits 22:20). In this
standard, Status Register 1 refers to the first data byte transferred on a
Read Status (05h) or Write Status (01h) command. Status register 2 refers
to the byte read using instruction 35h. Status register 2 is the second
byte transferred in a Write Status (01h) command.

Industry naming and definitions of these Status Registers may differ.
The definitions are described in JESD216B, BFPT DWORDS[15], bits 22:20.
There are cases in which writing only one byte to the Status Register 1
has the side-effect of clearing Status Register 2 and implicitly the Quad
Enable bit. This side-effect is hit just by the
BFPT_DWORD15_QER_SR2_BIT1_BUGGY and BFPT_DWORD15_QER_SR2_BIT1 cases.

Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 170 +++++++++++++++++++++++++++++++++++++-----
 include/linux/mtd/spi-nor.h   |   2 +
 2 files changed, 152 insertions(+), 20 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 303a7bcf3423..4a513ed13807 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -836,6 +836,132 @@ static int spi_nor_read_sr2(struct spi_nor *nor, u8 *sr2)
 	return ret;
 }
 
+/**
+ * spi_nor_write_sr1_and_check() - Write one byte to the Status Register and
+ * ensure the bits in the mask match the written value.
+ * @nor:	pointer to a 'struct spi_nor'.
+ * status_new:	byte value to be written to the Status Register.
+ * mask:	mask with which to check the written value.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int spi_nor_write_sr1_and_check(struct spi_nor *nor, u8 status_new,
+				       u8 mask)
+{
+	int ret;
+
+	nor->bouncebuf[0] = status_new;
+
+	ret = spi_nor_write_sr(nor, &nor->bouncebuf[0], 1);
+	if (ret)
+		return ret;
+
+	ret = spi_nor_read_sr(nor, &nor->bouncebuf[0]);
+	if (ret)
+		return ret;
+
+	if ((nor->bouncebuf[0] & mask) != (status_new & mask)) {
+		dev_err(nor->dev, "Read back test failed\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/**
+ * spi_nor_write_16bit_sr_and_check() - Write the Status Register 1 and the
+ * Status Register 2 in one shot. Ensure that the bits in the mask match the
+ * written value in the Status Register 1, and that the 16-bit Write did not
+ * affect what was already in the Status Register 2.
+ * @nor:	pointer to a 'struct spi_nor'.
+ * status_new:	byte value to be written to the Status Register 1.
+ * mask:	mask with which to check the written value on Status Register 1.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int spi_nor_write_16bit_sr_and_check(struct spi_nor *nor, u8 status_new,
+					    u8 mask)
+{
+	int ret;
+	u8 *sr_cr = nor->bouncebuf;
+	u8 cr_written;
+
+	/* Make sure we don't overwrite the contents of Status Register 2. */
+	if (!(nor->flags & SNOR_F_NO_READ_CR)) {
+		ret = spi_nor_read_cr(nor, &sr_cr[1]);
+		if (ret)
+			return ret;
+	} else if (nor->flash.quad_enable) {
+		/*
+		 * If the Status Register 2 Read command (35h) is not
+		 * supported, we should at least be sure we don't
+		 * change the value of the SR2 Quad Enable bit.
+		 *
+		 * We can safely assume that when the Quad Enable method is
+		 * set, the value of the QE bit is one, as a consequence of the
+		 * nor->flash.quad_enable() call.
+		 *
+		 * We can safely assume that the Quad Enable bit is present in
+		 * the Status Register 2 at BIT(1). According to the JESD216
+		 * revB standard, BFPT DWORDS[15], bits 22:20, the 16-bit
+		 * Write Status (01h) command is available just for the cases
+		 * in which the QE bit is described in SR2 at BIT(1).
+		 */
+		sr_cr[1] = CR_QUAD_EN_SPAN;
+	} else {
+		sr_cr[1] = 0;
+	}
+
+	sr_cr[0] = status_new;
+
+	ret = spi_nor_write_sr(nor, sr_cr, 2);
+	if (ret)
+		return ret;
+
+	cr_written = sr_cr[1];
+
+	ret = spi_nor_read_sr(nor, &sr_cr[0]);
+	if (ret)
+		return ret;
+
+	if ((sr_cr[0] & mask) != (status_new & mask)) {
+		dev_err(nor->dev, "Read back test failed\n");
+		return -EIO;
+	}
+
+	if (nor->flags & SNOR_F_NO_READ_CR)
+		return 0;
+
+	ret = spi_nor_read_cr(nor, &sr_cr[1]);
+	if (ret)
+		return ret;
+
+	if (cr_written != sr_cr[1]) {
+		dev_err(nor->dev, "Read back test failed\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/**
+ * spi_nor_write_sr_and_check() - Write the Status Register and ensure the bits
+ * in the mask match the written values.
+ * @nor:	pointer to a 'struct spi_nor'.
+ * status_new:	byte value to be written to the Status Register.
+ * mask:	mask with which to check the written values.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int spi_nor_write_sr_and_check(struct spi_nor *nor, u8 status_new,
+				      u8 mask)
+{
+	if (nor->flags == SNOR_F_HAS_16BIT_SR)
+		return spi_nor_write_16bit_sr_and_check(nor, status_new, mask);
+
+	return spi_nor_write_sr1_and_check(nor, status_new, mask);
+}
+
 static struct spi_nor *mtd_to_spi_nor(struct mtd_info *mtd)
 {
 	return mtd->priv;
@@ -1492,24 +1618,6 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 	return ret;
 }
 
-/* Write status register and ensure bits in mask match written values */
-static int write_sr_and_check(struct spi_nor *nor, u8 status_new, u8 mask)
-{
-	int ret;
-
-	nor->bouncebuf[0] = status_new;
-
-	ret = spi_nor_write_sr(nor, &nor->bouncebuf[0], 1);
-	if (ret)
-		return ret;
-
-	ret = spi_nor_read_sr(nor, &nor->bouncebuf[0]);
-	if (ret)
-		return ret;
-
-	return ((nor->bouncebuf[0] & mask) != (status_new & mask)) ? -EIO : 0;
-}
-
 static void stm_get_locked_range(struct spi_nor *nor, u8 sr, loff_t *ofs,
 				 uint64_t *len)
 {
@@ -1673,7 +1781,7 @@ static int stm_lock(struct spi_nor *nor, loff_t ofs, uint64_t len)
 	if ((status_new & mask) < (status_old & mask))
 		return -EINVAL;
 
-	return write_sr_and_check(nor, status_new, mask);
+	return spi_nor_write_sr_and_check(nor, status_new, mask);
 }
 
 /*
@@ -1758,7 +1866,7 @@ static int stm_unlock(struct spi_nor *nor, loff_t ofs, uint64_t len)
 	if ((status_new & mask) > (status_old & mask))
 		return -EINVAL;
 
-	return write_sr_and_check(nor, status_new, mask);
+	return spi_nor_write_sr_and_check(nor, status_new, mask);
 }
 
 /*
@@ -3536,19 +3644,39 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
 		break;
 
 	case BFPT_DWORD15_QER_SR2_BIT1_BUGGY:
+		/*
+		 * Writing only one byte to the Status Register has the
+		 * side-effect of clearing Status Register 2.
+		 */
+		/* fall through */
 	case BFPT_DWORD15_QER_SR2_BIT1_NO_RD:
+		nor->flags |= SNOR_F_HAS_16BIT_SR;
+		/*
+		 * Read Configuration Register (35h) instruction is not
+		 * supported.
+		 */
+		nor->flags |= SNOR_F_NO_READ_CR;
 		flash->quad_enable = spansion_no_read_cr_quad_enable;
 		break;
 
 	case BFPT_DWORD15_QER_SR1_BIT6:
+		nor->flags &= ~SNOR_F_HAS_16BIT_SR;
 		flash->quad_enable = macronix_quad_enable;
 		break;
 
 	case BFPT_DWORD15_QER_SR2_BIT7:
+		nor->flags &= ~SNOR_F_HAS_16BIT_SR;
 		flash->quad_enable = sr2_bit7_quad_enable;
 		break;
 
 	case BFPT_DWORD15_QER_SR2_BIT1:
+		/*
+		 * JESD216 rev B or later does not specify if writing only one
+		 * byte to the Status Register clears or not the Status
+		 * Register 2, so let's be cautious and keep the default
+		 * assumption of a 16-bit Write Status (01h) command.
+		 */
+		nor->flags |= SNOR_F_HAS_16BIT_SR;
 		flash->quad_enable = spansion_read_cr_quad_enable;
 		break;
 
@@ -4515,6 +4643,8 @@ static void spi_nor_info_init_flash_params(struct spi_nor *nor)
 	flash->quad_enable = spansion_read_cr_quad_enable;
 	flash->set_4byte = spansion_set_4byte;
 	flash->setup = spi_nor_default_setup;
+	/* Default to 16-bit Write Status (01h) Command */
+	nor->flags |= SNOR_F_HAS_16BIT_SR;
 
 	/* Set SPI NOR sizes. */
 	flash->size = (u64)info->sector_size * info->n_sectors;
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 12961b157743..fc3a8f5209f0 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -243,6 +243,8 @@ enum spi_nor_option_flags {
 	SNOR_F_4B_OPCODES	= BIT(6),
 	SNOR_F_HAS_4BAIT	= BIT(7),
 	SNOR_F_HAS_LOCK		= BIT(8),
+	SNOR_F_HAS_16BIT_SR	= BIT(9),
+	SNOR_F_NO_READ_CR	= BIT(10),
 };
 
 /**
-- 
2.9.5

