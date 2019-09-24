From: Tudor.Ambarus@microchip.com <Tudor.Ambarus@microchip.com>
Date: Tue, 24 Sep 2019 07:46:34 +0000
Subject: [PATCH v2 13/22] mtd: spi-nor: Void return type for
 spi_nor_clear_sr/fsr()
In-Reply-To: <20190924074533.6618-1-tudor.ambarus@microchip.com>
References: <20190924074533.6618-1-tudor.ambarus@microchip.com>
Message-ID: <20190924074533.6618-14-tudor.ambarus@microchip.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Tudor Ambarus <tudor.ambarus@microchip.com>

spi_nor_clear_sr() and spi_nor_clear_fsr() are called just in case
of errors. The callers didn't check their return value. Make them
of type void and print an error in case the operations fail.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index b7f86f518331..191a76c3f7bb 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -578,8 +578,16 @@ static int s3an_sr_ready(struct spi_nor *nor)
 	return !!(nor->bouncebuf[0] & XSR_RDY);
 }
 
-static int spi_nor_clear_sr(struct spi_nor *nor)
+/**
+ * spi_nor_clear_sr() - Clear the Status Register 1.
+ * @nor:        pointer to 'struct spi_nor'
+ *
+ * Prints error in case the operation fails.
+ */
+static void spi_nor_clear_sr(struct spi_nor *nor)
 {
+	int ret;
+
 	if (nor->spimem) {
 		struct spi_mem_op op =
 			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_CLSR, 1),
@@ -587,10 +595,14 @@ static int spi_nor_clear_sr(struct spi_nor *nor)
 				   SPI_MEM_OP_NO_DUMMY,
 				   SPI_MEM_OP_NO_DATA);
 
-		return spi_mem_exec_op(nor->spimem, &op);
+		ret = spi_mem_exec_op(nor->spimem, &op);
+	} else {
+		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_CLSR,
+						     NULL, 0);
 	}
 
-	return nor->controller_ops->write_reg(nor, SPINOR_OP_CLSR, NULL, 0);
+	if (ret)
+		dev_err(nor->dev, "error %d clearing Status Register 1\n", ret);
 }
 
 static int spi_nor_sr_ready(struct spi_nor *nor)
@@ -614,8 +626,16 @@ static int spi_nor_sr_ready(struct spi_nor *nor)
 	return !(nor->bouncebuf[0] & SR_WIP);
 }
 
-static int spi_nor_clear_fsr(struct spi_nor *nor)
+/**
+ * spi_nor_clear_fsr() - Clear the Flag Status Register.
+ * @nor:        pointer to 'struct spi_nor'
+ *
+ * Prints error in case the operation fails.
+ */
+static void spi_nor_clear_fsr(struct spi_nor *nor)
 {
+	int ret;
+
 	if (nor->spimem) {
 		struct spi_mem_op op =
 			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_CLFSR, 1),
@@ -623,10 +643,14 @@ static int spi_nor_clear_fsr(struct spi_nor *nor)
 				   SPI_MEM_OP_NO_DUMMY,
 				   SPI_MEM_OP_NO_DATA);
 
-		return spi_mem_exec_op(nor->spimem, &op);
+		ret = spi_mem_exec_op(nor->spimem, &op);
+	} else {
+		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_CLFSR,
+						     NULL, 0);
 	}
 
-	return nor->controller_ops->write_reg(nor, SPINOR_OP_CLFSR, NULL, 0);
+	if (ret)
+		dev_err(nor->dev, "error %d clearing FSR\n", ret);
 }
 
 static int spi_nor_fsr_ready(struct spi_nor *nor)
-- 
2.9.5

