From: Tudor.Ambarus@microchip.com <Tudor.Ambarus@microchip.com>
Date: Tue, 24 Sep 2019 07:46:15 +0000
Subject: [PATCH v2 07/22] mtd: spi-nor: Rework read_cr()
In-Reply-To: <20190924074533.6618-1-tudor.ambarus@microchip.com>
References: <20190924074533.6618-1-tudor.ambarus@microchip.com>
Message-ID: <20190924074533.6618-8-tudor.ambarus@microchip.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Tudor Ambarus <tudor.ambarus@microchip.com>

static int read_cr(struct spi_nor *nor)
becomes
static int spi_nor_read_cr(struct spi_nor *nor, u8 *cr)

The new function returns 0 on success and -errno otherwise.
We let the callers pass the pointer to the buffer where the
value of the Configuration Register will be written. This way
we avoid the casts between int and u8, which can be confusing.

Prepend spi_nor_ to the function name, all functions should begin
with that.

Vendors are using both the "Configuration Register" and the
"Status Register 2" terminology when referring to the second byte
of the Status Register. Indicate in the description of the function
that we use the SPINOR_OP_RDCR (35h) command to interrogate the
Configuration Register.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 66 +++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 8cd1cadcb8b1..0fb124bd2e77 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -448,12 +448,16 @@ static int spi_nor_read_fsr(struct spi_nor *nor, u8 *fsr)
 	return ret;
 }
 
-/*
- * Read configuration register, returning its value in the
- * location. Return the configuration register value.
- * Returns negative if error occurred.
+/**
+ * spi_nor_read_cr() - Read the Configuration Register using the
+ * SPINOR_OP_RDCR (35h) command.
+ * @nor:	pointer to 'struct spi_nor'
+ * @cr:		buffer where the value of the Configuration Register
+ *		will be written.
+ *
+ * Return: 0 on success, -errno otherwise.
  */
-static int read_cr(struct spi_nor *nor)
+static int spi_nor_read_cr(struct spi_nor *nor, u8 *cr)
 {
 	int ret;
 
@@ -462,20 +466,17 @@ static int read_cr(struct spi_nor *nor)
 			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDCR, 1),
 				   SPI_MEM_OP_NO_ADDR,
 				   SPI_MEM_OP_NO_DUMMY,
-				   SPI_MEM_OP_DATA_IN(1, nor->bouncebuf, 1));
+				   SPI_MEM_OP_DATA_IN(1, cr, 1));
 
 		ret = spi_mem_exec_op(nor->spimem, &op);
 	} else {
-		ret = nor->controller_ops->read_reg(nor, SPINOR_OP_RDCR,
-						    nor->bouncebuf, 1);
+		ret = nor->controller_ops->read_reg(nor, SPINOR_OP_RDCR, cr, 1);
 	}
 
-	if (ret < 0) {
+	if (ret)
 		dev_err(nor->dev, "error %d reading CR\n", ret);
-		return ret;
-	}
 
-	return nor->bouncebuf[0];
+	return ret;
 }
 
 /*
@@ -1768,7 +1769,8 @@ static int macronix_quad_enable(struct spi_nor *nor)
  * some very old and few memories don't support this instruction. If a pull-up
  * resistor is present on the MISO/IO1 line, we might still be able to pass the
  * "read back" test because the QSPI memory doesn't recognize the command,
- * so leaves the MISO/IO1 line state unchanged, hence read_cr() returns 0xFF.
+ * so leaves the MISO/IO1 line state unchanged, hence spi_nor_read_cr(nor, cr)
+ * gets the 0xFF value.
  *
  * bit 1 of the Configuration Register is the QE bit for Spansion like QSPI
  * memories.
@@ -1787,8 +1789,11 @@ static int spansion_quad_enable(struct spi_nor *nor)
 		return ret;
 
 	/* read back and check it */
-	ret = read_cr(nor);
-	if (!(ret > 0 && (ret & CR_QUAD_EN_SPAN))) {
+	ret = spi_nor_read_cr(nor, &nor->bouncebuf[0]);
+	if (ret)
+		return ret;
+
+	if (!(nor->bouncebuf[0] & CR_QUAD_EN_SPAN)) {
 		dev_err(nor->dev, "Spansion Quad bit not set\n");
 		return -EINVAL;
 	}
@@ -1839,21 +1844,18 @@ static int spansion_no_read_cr_quad_enable(struct spi_nor *nor)
  */
 static int spansion_read_cr_quad_enable(struct spi_nor *nor)
 {
-	struct device *dev = nor->dev;
 	u8 *sr_cr = nor->bouncebuf;
 	int ret;
 
 	/* Check current Quad Enable bit value. */
-	ret = read_cr(nor);
-	if (ret < 0) {
-		dev_err(dev, "error while reading configuration register\n");
-		return -EINVAL;
-	}
+	ret = spi_nor_read_cr(nor, &sr_cr[1]);
+	if (ret)
+		return ret;
 
-	if (ret & CR_QUAD_EN_SPAN)
+	if (sr_cr[1] & CR_QUAD_EN_SPAN)
 		return 0;
 
-	sr_cr[1] = ret | CR_QUAD_EN_SPAN;
+	sr_cr[1] |= CR_QUAD_EN_SPAN;
 
 	/* Keep the current value of the Status Register. */
 	ret = spi_nor_read_sr(nor, &sr_cr[0]);
@@ -1865,8 +1867,11 @@ static int spansion_read_cr_quad_enable(struct spi_nor *nor)
 		return ret;
 
 	/* Read back and check it. */
-	ret = read_cr(nor);
-	if (!(ret > 0 && (ret & CR_QUAD_EN_SPAN))) {
+	ret = spi_nor_read_cr(nor, &sr_cr[1]);
+	if (ret)
+		return ret;
+
+	if (!(sr_cr[1] & CR_QUAD_EN_SPAN)) {
 		dev_err(nor->dev, "Spansion Quad bit not set\n");
 		return -EINVAL;
 	}
@@ -2007,20 +2012,15 @@ static int spi_nor_spansion_clear_sr_bp(struct spi_nor *nor)
 	u8 *sr_cr =  nor->bouncebuf;
 
 	/* Check current Quad Enable bit value. */
-	ret = read_cr(nor);
-	if (ret < 0) {
-		dev_err(nor->dev,
-			"error while reading configuration register\n");
+	ret = spi_nor_read_cr(nor, &sr_cr[1]);
+	if (ret)
 		return ret;
-	}
 
 	/*
 	 * When the configuration register Quad Enable bit is one, only the
 	 * Write Status (01h) command with two data bytes may be used.
 	 */
-	if (ret & CR_QUAD_EN_SPAN) {
-		sr_cr[1] = ret;
-
+	if (sr_cr[1] & CR_QUAD_EN_SPAN) {
 		ret = spi_nor_read_sr(nor, &sr_cr[0]);
 		if (ret)
 			return ret;
-- 
2.9.5

