From: Tudor.Ambarus@microchip.com <Tudor.Ambarus@microchip.com>
Date: Tue, 24 Sep 2019 07:46:24 +0000
Subject: [PATCH v2 10/22] mtd: spi-nor: Rework write_sr()
In-Reply-To: <20190924074533.6618-1-tudor.ambarus@microchip.com>
References: <20190924074533.6618-1-tudor.ambarus@microchip.com>
Message-ID: <20190924074533.6618-11-tudor.ambarus@microchip.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Tudor Ambarus <tudor.ambarus@microchip.com>

The Status Register can be written with one or two bytes.

Merge:
static int write_sr(struct spi_nor *nor, u8 val)
static int write_sr_cr(struct spi_nor *nor, u8 *sr_cr)
into
static int spi_nor_write_sr(struct spi_nor *nor, const u8 *sr, size_t len)

Avoid duplicating code by moving the calls to spi_nor_write_enable() and
spi_nor_wait_till_ready() inside spi_nor_write_sr().

Move the spi_nor_wait_till_ready() together with the spi_nor_ready()
methods to avoid forward declarations.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 426 +++++++++++++++++++-----------------------
 1 file changed, 191 insertions(+), 235 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index be5dee622d51..31a4622d1eb9 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -537,25 +537,198 @@ static int spi_nor_read_cr(struct spi_nor *nor, u8 *cr)
 	return ret;
 }
 
+static int spi_nor_xread_sr(struct spi_nor *nor, u8 *sr)
+{
+	if (nor->spimem) {
+		struct spi_mem_op op =
+			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_XRDSR, 1),
+				   SPI_MEM_OP_NO_ADDR,
+				   SPI_MEM_OP_NO_DUMMY,
+				   SPI_MEM_OP_DATA_IN(1, sr, 1));
+
+		return spi_mem_exec_op(nor->spimem, &op);
+	}
+
+	return nor->controller_ops->read_reg(nor, SPINOR_OP_XRDSR, sr, 1);
+}
+
+static int s3an_sr_ready(struct spi_nor *nor)
+{
+	int ret;
+
+	ret = spi_nor_xread_sr(nor, nor->bouncebuf);
+	if (ret < 0) {
+		dev_err(nor->dev, "error %d reading XRDSR\n", (int) ret);
+		return ret;
+	}
+
+	return !!(nor->bouncebuf[0] & XSR_RDY);
+}
+
+static int spi_nor_clear_sr(struct spi_nor *nor)
+{
+	if (nor->spimem) {
+		struct spi_mem_op op =
+			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_CLSR, 1),
+				   SPI_MEM_OP_NO_ADDR,
+				   SPI_MEM_OP_NO_DUMMY,
+				   SPI_MEM_OP_NO_DATA);
+
+		return spi_mem_exec_op(nor->spimem, &op);
+	}
+
+	return nor->controller_ops->write_reg(nor, SPINOR_OP_CLSR, NULL, 0);
+}
+
+static int spi_nor_sr_ready(struct spi_nor *nor)
+{
+	int ret = spi_nor_read_sr(nor, &nor->bouncebuf[0]);
+
+	if (ret)
+		return ret;
+
+	if (nor->flags & SNOR_F_USE_CLSR &&
+	    nor->bouncebuf[0] & (SR_E_ERR | SR_P_ERR)) {
+		if (nor->bouncebuf[0] & SR_E_ERR)
+			dev_err(nor->dev, "Erase Error occurred\n");
+		else
+			dev_err(nor->dev, "Programming Error occurred\n");
+
+		spi_nor_clear_sr(nor);
+		return -EIO;
+	}
+
+	return !(nor->bouncebuf[0] & SR_WIP);
+}
+
+static int spi_nor_clear_fsr(struct spi_nor *nor)
+{
+	if (nor->spimem) {
+		struct spi_mem_op op =
+			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_CLFSR, 1),
+				   SPI_MEM_OP_NO_ADDR,
+				   SPI_MEM_OP_NO_DUMMY,
+				   SPI_MEM_OP_NO_DATA);
+
+		return spi_mem_exec_op(nor->spimem, &op);
+	}
+
+	return nor->controller_ops->write_reg(nor, SPINOR_OP_CLFSR, NULL, 0);
+}
+
+static int spi_nor_fsr_ready(struct spi_nor *nor)
+{
+	int ret = spi_nor_read_fsr(nor, &nor->bouncebuf[0]);
+
+	if (ret)
+		return ret;
+
+	if (nor->bouncebuf[0] & (FSR_E_ERR | FSR_P_ERR)) {
+		if (nor->bouncebuf[0] & FSR_E_ERR)
+			dev_err(nor->dev, "Erase operation failed.\n");
+		else
+			dev_err(nor->dev, "Program operation failed.\n");
+
+		if (nor->bouncebuf[0] & FSR_PT_ERR)
+			dev_err(nor->dev,
+				"Attempted to modify a protected sector.\n");
+
+		spi_nor_clear_fsr(nor);
+		return -EIO;
+	}
+
+	return nor->bouncebuf[0] & FSR_READY;
+}
+
+static int spi_nor_ready(struct spi_nor *nor)
+{
+	int sr, fsr;
+
+	if (nor->flags & SNOR_F_READY_XSR_RDY)
+		sr = s3an_sr_ready(nor);
+	else
+		sr = spi_nor_sr_ready(nor);
+	if (sr < 0)
+		return sr;
+	fsr = nor->flags & SNOR_F_USE_FSR ? spi_nor_fsr_ready(nor) : 1;
+	if (fsr < 0)
+		return fsr;
+	return sr && fsr;
+}
+
 /*
- * Write status register 1 byte
- * Returns negative if error occurred.
+ * Service routine to read status register until ready, or timeout occurs.
+ * Returns non-zero if error.
+ */
+static int spi_nor_wait_till_ready_with_timeout(struct spi_nor *nor,
+						unsigned long timeout_jiffies)
+{
+	unsigned long deadline;
+	int timeout = 0, ret;
+
+	deadline = jiffies + timeout_jiffies;
+
+	while (!timeout) {
+		if (time_after_eq(jiffies, deadline))
+			timeout = 1;
+
+		ret = spi_nor_ready(nor);
+		if (ret < 0)
+			return ret;
+		if (ret)
+			return 0;
+
+		cond_resched();
+	}
+
+	dev_err(nor->dev, "flash operation timed out\n");
+
+	return -ETIMEDOUT;
+}
+
+static int spi_nor_wait_till_ready(struct spi_nor *nor)
+{
+	return spi_nor_wait_till_ready_with_timeout(nor,
+						    DEFAULT_READY_WAIT_JIFFIES);
+}
+
+/**
+ * spi_nor_write_sr() - Write the Status Register.
+ * @nor:	pointer to 'struct spi_nor'.
+ * @sr:		buffer to write to the Status Register.
+ * @len:	number of bytes to write to the Status Register.
+ *
+ * Return: 0 on success, -errno otherwise.
  */
-static int write_sr(struct spi_nor *nor, u8 val)
+static int spi_nor_write_sr(struct spi_nor *nor, const u8 *sr, size_t len)
 {
-	nor->bouncebuf[0] = val;
+	int ret;
+
+	ret = spi_nor_write_enable(nor);
+	if (ret)
+		return ret;
+
 	if (nor->spimem) {
 		struct spi_mem_op op =
 			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRSR, 1),
 				   SPI_MEM_OP_NO_ADDR,
 				   SPI_MEM_OP_NO_DUMMY,
-				   SPI_MEM_OP_DATA_IN(1, nor->bouncebuf, 1));
+				   SPI_MEM_OP_DATA_OUT(len, sr, 1));
 
-		return spi_mem_exec_op(nor->spimem, &op);
+		ret = spi_mem_exec_op(nor->spimem, &op);
+	} else {
+		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_WRSR,
+						     sr, len);
 	}
 
-	return nor->controller_ops->write_reg(nor, SPINOR_OP_WRSR,
-					      nor->bouncebuf, 1);
+	if (ret) {
+		dev_err(nor->dev, "error while writing Status Register\n");
+		return ret;
+	}
+
+	ret = spi_nor_wait_till_ready(nor);
+
+	return ret;
 }
 
 static struct spi_nor *mtd_to_spi_nor(struct mtd_info *mtd)
@@ -741,161 +914,6 @@ static int winbond_set_4byte(struct spi_nor *nor, bool enable)
 	return ret;
 }
 
-static int spi_nor_xread_sr(struct spi_nor *nor, u8 *sr)
-{
-	if (nor->spimem) {
-		struct spi_mem_op op =
-			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_XRDSR, 1),
-				   SPI_MEM_OP_NO_ADDR,
-				   SPI_MEM_OP_NO_DUMMY,
-				   SPI_MEM_OP_DATA_IN(1, sr, 1));
-
-		return spi_mem_exec_op(nor->spimem, &op);
-	}
-
-	return nor->controller_ops->read_reg(nor, SPINOR_OP_XRDSR, sr, 1);
-}
-
-static int s3an_sr_ready(struct spi_nor *nor)
-{
-	int ret;
-
-	ret = spi_nor_xread_sr(nor, nor->bouncebuf);
-	if (ret < 0) {
-		dev_err(nor->dev, "error %d reading XRDSR\n", (int) ret);
-		return ret;
-	}
-
-	return !!(nor->bouncebuf[0] & XSR_RDY);
-}
-
-static int spi_nor_clear_sr(struct spi_nor *nor)
-{
-	if (nor->spimem) {
-		struct spi_mem_op op =
-			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_CLSR, 1),
-				   SPI_MEM_OP_NO_ADDR,
-				   SPI_MEM_OP_NO_DUMMY,
-				   SPI_MEM_OP_NO_DATA);
-
-		return spi_mem_exec_op(nor->spimem, &op);
-	}
-
-	return nor->controller_ops->write_reg(nor, SPINOR_OP_CLSR, NULL, 0);
-}
-
-static int spi_nor_sr_ready(struct spi_nor *nor)
-{
-	int ret = spi_nor_read_sr(nor, &nor->bouncebuf[0]);
-
-	if (ret)
-		return ret;
-
-	if (nor->flags & SNOR_F_USE_CLSR &&
-	    nor->bouncebuf[0] & (SR_E_ERR | SR_P_ERR)) {
-		if (nor->bouncebuf[0] & SR_E_ERR)
-			dev_err(nor->dev, "Erase Error occurred\n");
-		else
-			dev_err(nor->dev, "Programming Error occurred\n");
-
-		spi_nor_clear_sr(nor);
-		return -EIO;
-	}
-
-	return !(nor->bouncebuf[0] & SR_WIP);
-}
-
-static int spi_nor_clear_fsr(struct spi_nor *nor)
-{
-	if (nor->spimem) {
-		struct spi_mem_op op =
-			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_CLFSR, 1),
-				   SPI_MEM_OP_NO_ADDR,
-				   SPI_MEM_OP_NO_DUMMY,
-				   SPI_MEM_OP_NO_DATA);
-
-		return spi_mem_exec_op(nor->spimem, &op);
-	}
-
-	return nor->controller_ops->write_reg(nor, SPINOR_OP_CLFSR, NULL, 0);
-}
-
-static int spi_nor_fsr_ready(struct spi_nor *nor)
-{
-	int ret = spi_nor_read_fsr(nor, &nor->bouncebuf[0]);
-
-	if (ret)
-		return ret;
-
-	if (nor->bouncebuf[0] & (FSR_E_ERR | FSR_P_ERR)) {
-		if (nor->bouncebuf[0] & FSR_E_ERR)
-			dev_err(nor->dev, "Erase operation failed.\n");
-		else
-			dev_err(nor->dev, "Program operation failed.\n");
-
-		if (nor->bouncebuf[0] & FSR_PT_ERR)
-			dev_err(nor->dev,
-				"Attempted to modify a protected sector.\n");
-
-		spi_nor_clear_fsr(nor);
-		return -EIO;
-	}
-
-	return nor->bouncebuf[0] & FSR_READY;
-}
-
-static int spi_nor_ready(struct spi_nor *nor)
-{
-	int sr, fsr;
-
-	if (nor->flags & SNOR_F_READY_XSR_RDY)
-		sr = s3an_sr_ready(nor);
-	else
-		sr = spi_nor_sr_ready(nor);
-	if (sr < 0)
-		return sr;
-	fsr = nor->flags & SNOR_F_USE_FSR ? spi_nor_fsr_ready(nor) : 1;
-	if (fsr < 0)
-		return fsr;
-	return sr && fsr;
-}
-
-/*
- * Service routine to read status register until ready, or timeout occurs.
- * Returns non-zero if error.
- */
-static int spi_nor_wait_till_ready_with_timeout(struct spi_nor *nor,
-						unsigned long timeout_jiffies)
-{
-	unsigned long deadline;
-	int timeout = 0, ret;
-
-	deadline = jiffies + timeout_jiffies;
-
-	while (!timeout) {
-		if (time_after_eq(jiffies, deadline))
-			timeout = 1;
-
-		ret = spi_nor_ready(nor);
-		if (ret < 0)
-			return ret;
-		if (ret)
-			return 0;
-
-		cond_resched();
-	}
-
-	dev_err(nor->dev, "flash operation timed out\n");
-
-	return -ETIMEDOUT;
-}
-
-static int spi_nor_wait_till_ready(struct spi_nor *nor)
-{
-	return spi_nor_wait_till_ready_with_timeout(nor,
-						    DEFAULT_READY_WAIT_JIFFIES);
-}
-
 /*
  * Erase the whole flash memory
  *
@@ -1375,15 +1393,9 @@ static int write_sr_and_check(struct spi_nor *nor, u8 status_new, u8 mask)
 {
 	int ret;
 
-	ret = spi_nor_write_enable(nor);
-	if (ret)
-		return ret;
-
-	ret = write_sr(nor, status_new);
-	if (ret)
-		return ret;
+	nor->bouncebuf[0] = status_new;
 
-	ret = spi_nor_wait_till_ready(nor);
+	ret = spi_nor_write_sr(nor, &nor->bouncebuf[0], 1);
 	if (ret)
 		return ret;
 
@@ -1713,49 +1725,6 @@ static int spi_nor_is_locked(struct mtd_info *mtd, loff_t ofs, uint64_t len)
 	return ret;
 }
 
-/*
- * Write status Register and configuration register with 2 bytes
- * The first byte will be written to the status register, while the
- * second byte will be written to the configuration register.
- * Return negative if error occurred.
- */
-static int write_sr_cr(struct spi_nor *nor, u8 *sr_cr)
-{
-	int ret;
-
-	ret = spi_nor_write_enable(nor);
-	if (ret)
-		return ret;
-
-	if (nor->spimem) {
-		struct spi_mem_op op =
-			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRSR, 1),
-				   SPI_MEM_OP_NO_ADDR,
-				   SPI_MEM_OP_NO_DUMMY,
-				   SPI_MEM_OP_DATA_OUT(2, sr_cr, 1));
-
-		ret = spi_mem_exec_op(nor->spimem, &op);
-	} else {
-		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_WRSR,
-						     sr_cr, 2);
-	}
-
-	if (ret < 0) {
-		dev_err(nor->dev,
-			"error while writing configuration register\n");
-		return -EINVAL;
-	}
-
-	ret = spi_nor_wait_till_ready(nor);
-	if (ret) {
-		dev_err(nor->dev,
-			"timeout while writing configuration register\n");
-		return ret;
-	}
-
-	return 0;
-}
-
 /**
  * macronix_quad_enable() - set QE bit in Status Register.
  * @nor:	pointer to a 'struct spi_nor'
@@ -1777,13 +1746,9 @@ static int macronix_quad_enable(struct spi_nor *nor)
 	if (nor->bouncebuf[0] & SR_QUAD_EN_MX)
 		return 0;
 
-	ret = spi_nor_write_enable(nor);
-	if (ret)
-		return ret;
-
-	write_sr(nor, nor->bouncebuf[0] | SR_QUAD_EN_MX);
+	nor->bouncebuf[0] |= SR_QUAD_EN_MX;
 
-	ret = spi_nor_wait_till_ready(nor);
+	ret = spi_nor_write_sr(nor, &nor->bouncebuf[0], 1);
 	if (ret)
 		return ret;
 
@@ -1830,7 +1795,7 @@ static int spansion_quad_enable(struct spi_nor *nor)
 
 	sr_cr[0] = 0;
 	sr_cr[1] = CR_QUAD_EN_SPAN;
-	ret = write_sr_cr(nor, sr_cr);
+	ret = spi_nor_write_sr(nor, sr_cr, 2);
 	if (ret)
 		return ret;
 
@@ -1872,7 +1837,7 @@ static int spansion_no_read_cr_quad_enable(struct spi_nor *nor)
 
 	sr_cr[1] = CR_QUAD_EN_SPAN;
 
-	return write_sr_cr(nor, sr_cr);
+	return spi_nor_write_sr(nor, sr_cr, 2);
 }
 
 /**
@@ -1908,7 +1873,7 @@ static int spansion_read_cr_quad_enable(struct spi_nor *nor)
 	if (ret)
 		return ret;
 
-	ret = write_sr_cr(nor, sr_cr);
+	ret = spi_nor_write_sr(nor, sr_cr, 2);
 	if (ret)
 		return ret;
 
@@ -2026,19 +1991,10 @@ static int spi_nor_clear_sr_bp(struct spi_nor *nor)
 	if (ret)
 		return ret;
 
-	ret = spi_nor_write_enable(nor);
-	if (ret)
-		return ret;
+	nor->bouncebuf[0] &= mask;
 
-	ret = write_sr(nor, nor->bouncebuf[0] & ~mask);
-	if (ret) {
-		dev_err(nor->dev, "write to status register failed\n");
-		return ret;
-	}
+	ret = spi_nor_write_sr(nor, &nor->bouncebuf[0], 1);
 
-	ret = spi_nor_wait_till_ready(nor);
-	if (ret)
-		dev_err(nor->dev, "timeout while writing status register\n");
 	return ret;
 }
 
@@ -2077,7 +2033,7 @@ static int spi_nor_spansion_clear_sr_bp(struct spi_nor *nor)
 
 		sr_cr[0] &= ~mask;
 
-		ret = write_sr_cr(nor, sr_cr);
+		ret = spi_nor_write_sr(nor, sr_cr, 2);
 		if (ret)
 			dev_err(nor->dev, "16-bit write register failed\n");
 		return ret;
-- 
2.9.5

