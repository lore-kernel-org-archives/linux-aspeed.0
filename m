From: Cédric Le Goater <clg@kaod.org>
Date: Mon, 14 Feb 2022 10:42:27 +0100
Subject: [PATCH 06/10] spi: aspeed: Workaround AST2500 limitations
In-Reply-To: <20220214094231.3753686-1-clg@kaod.org>
References: <20220214094231.3753686-1-clg@kaod.org>
Message-ID: <20220214094231.3753686-7-clg@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

It is not possible to configure a full 128MB window for a chip of the
same size on the AST2500 SPI controller. For his case, the maximum
window size is restricted to 120MB for CE0.

Signed-off-by: C?dric Le Goater <clg@kaod.org>
---
 drivers/spi/spi-aspeed-smc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
index 9c4eacfed72c..c6ac3253d7d5 100644
--- a/drivers/spi/spi-aspeed-smc.c
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -466,6 +466,8 @@ static int aspeed_spi_set_window(struct aspeed_spi *aspi,
  * - ioremap each window, not strictly necessary since the overall window
  *   is correct.
  */
+static const struct aspeed_spi_data ast2500_spi_data;
+
 static int aspeed_spi_chip_adjust_window(struct aspeed_spi_chip *chip,
 					 u32 local_offset, u32 size)
 {
@@ -474,6 +476,16 @@ static int aspeed_spi_chip_adjust_window(struct aspeed_spi_chip *chip,
 	struct aspeed_spi_window *win = &windows[chip->cs];
 	int ret;
 
+	/*
+	 * Due to an HW issue on the AST2500 SPI controller, the CE0
+	 * window size should be smaller than the maximum 128MB.
+	 */
+	if (aspi->data == &ast2500_spi_data && chip->cs == 0 && size == SZ_128M) {
+		size = 120 << 20;
+		dev_info(aspi->dev, "CE%d window resized to %dMB (AST2500 HW quirk)",
+			 chip->cs, size >> 20);
+	}
+
 	aspeed_spi_get_windows(aspi, windows);
 
 	/* Adjust this chip window */
-- 
2.34.1

