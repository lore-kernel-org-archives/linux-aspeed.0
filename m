From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Fri,  3 Mar 2023 18:19:17 +0100
Subject: [PATCH 03/87] spi: aspeed-smc: Convert to platform remove callback returning void
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
Message-ID: <20230303172041.2103336-4-u.kleine-koenig@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is (mostly) ignored
and this typically results in resource leaks. To improve here there is a
quest to make the remove callback return void. In the first step of this
quest all drivers are converted to .remove_new() which already returns
void.

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/spi/spi-aspeed-smc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
index 873ff2cf72c9..3f2548860317 100644
--- a/drivers/spi/spi-aspeed-smc.c
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -787,13 +787,12 @@ static int aspeed_spi_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int aspeed_spi_remove(struct platform_device *pdev)
+static void aspeed_spi_remove(struct platform_device *pdev)
 {
 	struct aspeed_spi *aspi = platform_get_drvdata(pdev);
 
 	aspeed_spi_enable(aspi, false);
 	clk_disable_unprepare(aspi->clk);
-	return 0;
 }
 
 /*
@@ -1201,7 +1200,7 @@ MODULE_DEVICE_TABLE(of, aspeed_spi_matches);
 
 static struct platform_driver aspeed_spi_driver = {
 	.probe			= aspeed_spi_probe,
-	.remove			= aspeed_spi_remove,
+	.remove_new		= aspeed_spi_remove,
 	.driver	= {
 		.name		= DEVICE_NAME,
 		.of_match_table = aspeed_spi_matches,
-- 
2.39.1

