From: Tudor.Ambarus@microchip.com <Tudor.Ambarus@microchip.com>
Date: Mon, 2 Mar 2020 18:07:57 +0000
Subject: [PATCH 22/23] mtd: spi-nor: Get rid of the now empty spi_nor_ids[]
 table
In-Reply-To: <20200302180730.1886678-1-tudor.ambarus@microchip.com>
References: <20200302180730.1886678-1-tudor.ambarus@microchip.com>
Message-ID: <20200302180730.1886678-23-tudor.ambarus@microchip.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Boris Brezillon <bbrezillon@kernel.org>

All entries have been moved to manufacturer drivers. Get rid of this
empty table.

Signed-off-by: Boris Brezillon <bbrezillon@kernel.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/core.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index f4178cd65c45..a2e1917b608d 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -1953,21 +1953,6 @@ int spi_nor_sr2_bit7_quad_enable(struct spi_nor *nor)
 	return 0;
 }
 
-/* NOTE: double check command sets and memory organization when you add
- * more nor chips.  This current list focusses on newer chips, which
- * have been converging on command sets which including JEDEC ID.
- *
- * All newly added entries should describe *hardware* and should use SECT_4K
- * (or SECT_4K_PMC) if hardware supports erasing 4 KiB sectors. For usage
- * scenarios excluding small sectors there is config option that can be
- * disabled: CONFIG_MTD_SPI_NOR_USE_4K_SECTORS.
- * For historical (and compatibility) reasons (before we got above config) some
- * old entries may be missing 4K flag.
- */
-static const struct flash_info spi_nor_ids[] = {
-	{ },
-};
-
 static const struct spi_nor_manufacturer *manufacturers[] = {
 	&spi_nor_atmel,
 	&spi_nor_catalyst,
@@ -2037,11 +2022,6 @@ static const struct flash_info *spi_nor_read_id(struct spi_nor *nor)
 		}
 	}
 
-	info = spi_nor_search_part_by_id(spi_nor_ids,
-					 ARRAY_SIZE(spi_nor_ids) - 1, id);
-	if (info)
-		return info;
-
 	dev_err(nor->dev, "unrecognized JEDEC id bytes: %*ph\n",
 		SPI_NOR_MAX_ID_LEN, id);
 	return ERR_PTR(-ENODEV);
@@ -2952,11 +2932,6 @@ static const struct flash_info *spi_nor_match_id(struct spi_nor *nor,
 {
 	unsigned int i, j;
 
-	for (i = 0; i < ARRAY_SIZE(spi_nor_ids) - 1; i++) {
-		if (!strcmp(name, spi_nor_ids[i].name))
-			return &spi_nor_ids[i];
-	}
-
 	for (i = 0; i < ARRAY_SIZE(manufacturers); i++) {
 		for (j = 0; j < manufacturers[i]->nparts; j++) {
 			if (!strcmp(name, manufacturers[i]->parts[j].name)) {
-- 
2.23.0
