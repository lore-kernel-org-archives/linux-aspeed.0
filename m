From: Tudor.Ambarus@microchip.com <Tudor.Ambarus@microchip.com>
Date: Tue, 24 Sep 2019 07:46:56 +0000
Subject: [PATCH v2 20/22] mtd: spi-nor: Rework
 spansion(_no)_read_cr_quad_enable()
In-Reply-To: <20190924074533.6618-1-tudor.ambarus@microchip.com>
References: <20190924074533.6618-1-tudor.ambarus@microchip.com>
Message-ID: <20190924074533.6618-21-tudor.ambarus@microchip.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Merge:
spansion_no_read_cr_quad_enable()
spansion_read_cr_quad_enable()

in spi_nor_sr2_bit1_quad_enable().

Introduce spi_nor_write_16bit_cr_and_check(). The Configuration Register
contains bits that can be updated in future: FREEZE, CMP. Provide a
generic method that allows updating all bits of the Configuration
Register.

Do the Read Back test even for the old spansion_no_read_cr_quad_enable()
case.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 136 +++++++++++++++++++++---------------------
 include/linux/mtd/spi-nor.h   |   4 +-
 2 files changed, 70 insertions(+), 70 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 112f93cec7ba..8fd1c04f75d9 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -903,7 +903,7 @@ static int spi_nor_write_16bit_sr_and_check(struct spi_nor *nor, u8 sr1)
 		 * Write Status (01h) command is available just for the cases
 		 * in which the QE bit is described in SR2 at BIT(1).
 		 */
-		sr_cr[1] = CR_QUAD_EN_SPAN;
+		sr_cr[1] = SR2_QUAD_EN_BIT1;
 	} else {
 		sr_cr[1] = 0;
 	}
@@ -941,6 +941,59 @@ static int spi_nor_write_16bit_sr_and_check(struct spi_nor *nor, u8 sr1)
 }
 
 /**
+ * spi_nor_write_16bit_cr_and_check() - Write the Status Register 1 and the
+ * Configuration Register in one shot. Ensure that the byte written in the
+ * Configuration Register match the received value, and that the 16-bit Write
+ * did not affect what was already in the Status Register 1.
+ * @nor:	pointer to a 'struct spi_nor'.
+ * @cr:		byte value to be written to the Configuration Register.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int spi_nor_write_16bit_cr_and_check(struct spi_nor *nor, u8 cr)
+{
+	int ret;
+	u8 *sr_cr = nor->bouncebuf;
+	u8 sr_written;
+
+	/* Keep the current value of the Status Register 1. */
+	ret = spi_nor_read_sr(nor, &sr_cr[0]);
+	if (ret)
+		return ret;
+
+	sr_cr[1] = cr;
+
+	ret = spi_nor_write_sr(nor, sr_cr, 2);
+	if (ret)
+		return ret;
+
+	sr_written = sr_cr[0];
+
+	ret = spi_nor_read_sr(nor, &sr_cr[0]);
+	if (ret)
+		return ret;
+
+	if (sr_written != sr_cr[0]) {
+		dev_err(nor->dev, "SR1: Read back test failed\n");
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
+	if (cr != sr_cr[1]) {
+		dev_err(nor->dev, "CR: read back test failed\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/**
  * spi_nor_write_sr_and_check() - Write the Status Register 1 and ensure that
  * the byte written match the received value without affecting other bits in the
  * Status Register 1 and 2.
@@ -1958,81 +2011,30 @@ static int spi_nor_sr1_bit6_quad_enable(struct spi_nor *nor)
 }
 
 /**
- * spansion_no_read_cr_quad_enable() - set QE bit in Configuration Register.
+ * spi_nor_sr2_bit1_quad_enable() - set the Quad Enable BIT(1) in the Status
+ * Register 2.
  * @nor:	pointer to a 'struct spi_nor'
  *
- * Set the Quad Enable (QE) bit in the Configuration Register.
- * This function should be used with QSPI memories not supporting the Read
- * Configuration Register (35h) instruction.
- *
- * bit 1 of the Configuration Register is the QE bit for Spansion like QSPI
- * memories.
+ * Bit 1 of the Status Register 2 is the QE bit for Spansion like QSPI memories.
  *
  * Return: 0 on success, -errno otherwise.
  */
-static int spansion_no_read_cr_quad_enable(struct spi_nor *nor)
+static int spi_nor_sr2_bit1_quad_enable(struct spi_nor *nor)
 {
-	u8 *sr_cr = nor->bouncebuf;
 	int ret;
 
-	/* Keep the current value of the Status Register. */
-	ret = spi_nor_read_sr(nor, &sr_cr[0]);
-	if (ret)
-		return ret;
-
-	sr_cr[1] = CR_QUAD_EN_SPAN;
-
-	return spi_nor_write_sr(nor, sr_cr, 2);
-}
-
-/**
- * spansion_read_cr_quad_enable() - set QE bit in Configuration Register.
- * @nor:	pointer to a 'struct spi_nor'
- *
- * Set the Quad Enable (QE) bit in the Configuration Register.
- * This function should be used with QSPI memories supporting the Read
- * Configuration Register (35h) instruction.
- *
- * bit 1 of the Configuration Register is the QE bit for Spansion like QSPI
- * memories.
- *
- * Return: 0 on success, -errno otherwise.
- */
-static int spansion_read_cr_quad_enable(struct spi_nor *nor)
-{
-	u8 *sr_cr = nor->bouncebuf;
-	int ret;
+	if (nor->flags & SNOR_F_NO_READ_CR)
+		return spi_nor_write_16bit_cr_and_check(nor, SR2_QUAD_EN_BIT1);
 
 	/* Check current Quad Enable bit value. */
-	ret = spi_nor_read_cr(nor, &sr_cr[1]);
+	ret = spi_nor_read_cr(nor, &nor->bouncebuf[0]);
 	if (ret)
 		return ret;
 
-	if (sr_cr[1] & CR_QUAD_EN_SPAN)
+	if (nor->bouncebuf[0] & SR2_QUAD_EN_BIT1)
 		return 0;
 
-	sr_cr[1] |= CR_QUAD_EN_SPAN;
-
-	/* Keep the current value of the Status Register. */
-	ret = spi_nor_read_sr(nor, &sr_cr[0]);
-	if (ret)
-		return ret;
-
-	ret = spi_nor_write_sr(nor, sr_cr, 2);
-	if (ret)
-		return ret;
-
-	/* Read back and check it. */
-	ret = spi_nor_read_cr(nor, &sr_cr[1]);
-	if (ret)
-		return ret;
-
-	if (!(sr_cr[1] & CR_QUAD_EN_SPAN)) {
-		dev_err(nor->dev, "Spansion Quad bit not set\n");
-		return -EIO;
-	}
-
-	return 0;
+	return spi_nor_write_16bit_cr_and_check(nor, nor->bouncebuf[0]);
 }
 
 /**
@@ -2112,7 +2114,7 @@ static int spi_nor_clear_sr_bp(struct spi_nor *nor)
  *
  * Read-modify-write function that clears the Block Protection bits from the
  * Status Register without affecting other bits. The function is tightly
- * coupled with the spansion_read_cr_quad_enable() function. Both assume that
+ * coupled with the spi_nor_sr2_bit1_quad_enable() function. Both assume that
  * the Write Register with 16 bits, together with the Read Configuration
  * Register (35h) instructions are supported.
  *
@@ -2133,7 +2135,7 @@ static int spi_nor_spansion_clear_sr_bp(struct spi_nor *nor)
 	 * When the configuration register Quad Enable bit is one, only the
 	 * Write Status (01h) command with two data bytes may be used.
 	 */
-	if (sr_cr[1] & CR_QUAD_EN_SPAN) {
+	if (sr_cr[1] & SR2_QUAD_EN_BIT1) {
 		ret = spi_nor_read_sr(nor, &sr_cr[0]);
 		if (ret)
 			return ret;
@@ -3637,7 +3639,7 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
 		 * supported.
 		 */
 		nor->flags |= SNOR_F_NO_READ_CR;
-		flash->quad_enable = spansion_no_read_cr_quad_enable;
+		flash->quad_enable = spi_nor_sr2_bit1_quad_enable;
 		break;
 
 	case BFPT_DWORD15_QER_SR1_BIT6:
@@ -3658,7 +3660,7 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
 		 * assumption of a 16-bit Write Status (01h) command.
 		 */
 		nor->flags |= SNOR_F_HAS_16BIT_SR;
-		flash->quad_enable = spansion_read_cr_quad_enable;
+		flash->quad_enable = spi_nor_sr2_bit1_quad_enable;
 		break;
 
 	default:
@@ -4621,7 +4623,7 @@ static void spi_nor_info_init_flash_params(struct spi_nor *nor)
 	u8 i, erase_mask;
 
 	/* Initialize legacy flash parameters and settings. */
-	flash->quad_enable = spansion_read_cr_quad_enable;
+	flash->quad_enable = spi_nor_sr2_bit1_quad_enable;
 	flash->set_4byte = spansion_set_4byte;
 	flash->setup = spi_nor_default_setup;
 	/* Default to 16-bit Write Status (01h) Command */
@@ -4839,7 +4841,7 @@ static int spi_nor_init(struct spi_nor *nor)
 	int err;
 
 	if (nor->clear_sr_bp) {
-		if (nor->flash.quad_enable == spansion_read_cr_quad_enable)
+		if (nor->flash.quad_enable == spi_nor_sr2_bit1_quad_enable)
 			nor->clear_sr_bp = spi_nor_spansion_clear_sr_bp;
 
 		err = nor->clear_sr_bp(nor);
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 3a835de90b6a..5590a36eb43e 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -144,10 +144,8 @@
 #define FSR_P_ERR		BIT(4)	/* Program operation status */
 #define FSR_PT_ERR		BIT(1)	/* Protection error bit */
 
-/* Configuration Register bits. */
-#define CR_QUAD_EN_SPAN		BIT(1)	/* Spansion Quad I/O */
-
 /* Status Register 2 bits. */
+#define SR2_QUAD_EN_BIT1	BIT(1)
 #define SR2_QUAD_EN_BIT7	BIT(7)
 
 /* Supported SPI protocols */
-- 
2.9.5

