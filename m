From: Tudor.Ambarus@microchip.com <Tudor.Ambarus@microchip.com>
Date: Tue, 17 Sep 2019 15:55:54 +0000
Subject: [PATCH 23/23] mtd: spi-nor: Unlock global block protection on
 sst26vf064b
In-Reply-To: <20190917155426.7432-1-tudor.ambarus@microchip.com>
References: <20190917155426.7432-1-tudor.ambarus@microchip.com>
Message-ID: <20190917155426.7432-24-tudor.ambarus@microchip.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Tudor Ambarus <tudor.ambarus@microchip.com>

To avoid inadvertent writes during power-up, sst26vf064b is
write-protected by default after a power-on reset cycle.
Unlock the serial flash memory by using the Global Block Protection
Unlock command - it offers a single command cycle that unlocks
the entire memory array.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 19556a9dd3fa..19919c9c1bd8 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2442,7 +2442,9 @@ static const struct flash_info spi_nor_ids[] = {
 	{ "sst25wf080",  INFO(0xbf2505, 0, 64 * 1024, 16, SECT_4K | SST_WRITE) },
 	{ "sst26wf016b", INFO(0xbf2651, 0, 64 * 1024, 32, SECT_4K |
 			      SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
-	{ "sst26vf064b", INFO(0xbf2643, 0, 64 * 1024, 128, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ "sst26vf064b", INFO(0xbf2643, 0, 64 * 1024, 128,
+			      SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+			      UNLOCK_GLOBAL_BLOCK) },
 
 	/* ST Microelectronics -- newer production may have feature updates */
 	{ "m25p05",  INFO(0x202010,  0,  32 * 1024,   2, 0) },
-- 
2.9.5

