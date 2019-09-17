From: Tudor.Ambarus@microchip.com <Tudor.Ambarus@microchip.com>
Date: Tue, 17 Sep 2019 15:54:43 +0000
Subject: [PATCH 01/23] mtd: spi-nor: hisi-sfc: Drop nor->erase NULL assignment
In-Reply-To: <20190917155426.7432-1-tudor.ambarus@microchip.com>
References: <20190917155426.7432-1-tudor.ambarus@microchip.com>
Message-ID: <20190917155426.7432-2-tudor.ambarus@microchip.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Tudor Ambarus <tudor.ambarus@microchip.com>

The pointer to 'struct spi_nor' is kzalloc'ed above in the code.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/hisi-sfc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/hisi-sfc.c b/drivers/mtd/spi-nor/hisi-sfc.c
index 6dac9dd8bf42..c99ed9cdbf9c 100644
--- a/drivers/mtd/spi-nor/hisi-sfc.c
+++ b/drivers/mtd/spi-nor/hisi-sfc.c
@@ -364,7 +364,6 @@ static int hisi_spi_nor_register(struct device_node *np,
 	nor->write_reg = hisi_spi_nor_write_reg;
 	nor->read = hisi_spi_nor_read;
 	nor->write = hisi_spi_nor_write;
-	nor->erase = NULL;
 	ret = spi_nor_scan(nor, NULL, &hwcaps);
 	if (ret)
 		return ret;
-- 
2.9.5

