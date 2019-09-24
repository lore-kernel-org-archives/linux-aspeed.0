From: Tudor.Ambarus@microchip.com <Tudor.Ambarus@microchip.com>
Date: Tue, 24 Sep 2019 07:47:00 +0000
Subject: [PATCH v2 21/22] mtd: spi-nor: Update sr2_bit7_quad_enable()
In-Reply-To: <20190924074533.6618-1-tudor.ambarus@microchip.com>
References: <20190924074533.6618-1-tudor.ambarus@microchip.com>
Message-ID: <20190924074533.6618-22-tudor.ambarus@microchip.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Rename the method to spi_nor_sr2_bit7_quad_enable(). Do the
read back test on all the eight bits of the Status Register,
not just the QE one.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 8fd1c04f75d9..a53e2cdc564c 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2038,7 +2038,7 @@ static int spi_nor_sr2_bit1_quad_enable(struct spi_nor *nor)
 }
 
 /**
- * sr2_bit7_quad_enable() - set QE bit in Status Register 2.
+ * spi_nor_sr2_bit7_quad_enable() - set QE bit in Status Register 2.
  * @nor:	pointer to a 'struct spi_nor'
  *
  * Set the Quad Enable (QE) bit in the Status Register 2.
@@ -2049,10 +2049,11 @@ static int spi_nor_sr2_bit1_quad_enable(struct spi_nor *nor)
  *
  * Return: 0 on success, -errno otherwise.
  */
-static int sr2_bit7_quad_enable(struct spi_nor *nor)
+static int spi_nor_sr2_bit7_quad_enable(struct spi_nor *nor)
 {
 	u8 *sr2 = nor->bouncebuf;
 	int ret;
+	u8 sr2_written;
 
 	/* Check current Quad Enable bit value. */
 	ret = spi_nor_read_sr2(nor, sr2);
@@ -2069,13 +2070,15 @@ static int sr2_bit7_quad_enable(struct spi_nor *nor)
 	if (ret)
 		return ret;
 
+	sr2_written = *sr2;
+
 	/* Read back and check it. */
 	ret = spi_nor_read_sr2(nor, sr2);
 	if (ret)
 		return ret;
 
-	if (!(*sr2 & SR2_QUAD_EN_BIT7)) {
-		dev_err(nor->dev, "SR2 Quad bit not set\n");
+	if (*sr2 != sr2_written) {
+		dev_err(nor->dev, "Read back test failed\n");
 		return -EIO;
 	}
 
@@ -3649,7 +3652,7 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
 
 	case BFPT_DWORD15_QER_SR2_BIT7:
 		nor->flags &= ~SNOR_F_HAS_16BIT_SR;
-		flash->quad_enable = sr2_bit7_quad_enable;
+		flash->quad_enable = spi_nor_sr2_bit7_quad_enable;
 		break;
 
 	case BFPT_DWORD15_QER_SR2_BIT1:
-- 
2.9.5

