From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Fri,  3 Jun 2022 23:07:46 +0200
Subject: [PATCH 02/14] mtd: spi-nor: aspeed-smc: Make aspeed_smc_unregister() return void
In-Reply-To: <20220603210758.148493-1-u.kleine-koenig@pengutronix.de>
References: <20220603210758.148493-1-u.kleine-koenig@pengutronix.de>
Message-ID: <20220603210758.148493-3-u.kleine-koenig@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The function returns zero unconditionally, so simplify to make it
obvious there is no error to handle in the callers.

This is a preparation for making platform remove callbacks return void.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/mtd/spi-nor/controllers/aspeed-smc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/spi-nor/controllers/aspeed-smc.c b/drivers/mtd/spi-nor/controllers/aspeed-smc.c
index acfe010f9dd7..bd149104533a 100644
--- a/drivers/mtd/spi-nor/controllers/aspeed-smc.c
+++ b/drivers/mtd/spi-nor/controllers/aspeed-smc.c
@@ -399,7 +399,7 @@ static ssize_t aspeed_smc_write_user(struct spi_nor *nor, loff_t to,
 	return len;
 }
 
-static int aspeed_smc_unregister(struct aspeed_smc_controller *controller)
+static void aspeed_smc_unregister(struct aspeed_smc_controller *controller)
 {
 	struct aspeed_smc_chip *chip;
 	int n;
@@ -409,13 +409,13 @@ static int aspeed_smc_unregister(struct aspeed_smc_controller *controller)
 		if (chip)
 			mtd_device_unregister(&chip->nor.mtd);
 	}
-
-	return 0;
 }
 
 static int aspeed_smc_remove(struct platform_device *dev)
 {
-	return aspeed_smc_unregister(platform_get_drvdata(dev));
+	aspeed_smc_unregister(platform_get_drvdata(dev));
+
+	return 0;
 }
 
 static const struct of_device_id aspeed_smc_matches[] = {
-- 
2.36.1

