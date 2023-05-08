From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Mon,  8 May 2023 22:51:40 +0200
Subject: [PATCH 03/89] i2c: aspeed: Convert to platform remove callback returning void
In-Reply-To: <20230508205306.1474415-1-u.kleine-koenig@pengutronix.de>
References: <20230508205306.1474415-1-u.kleine-koenig@pengutronix.de>
Message-ID: <20230508205306.1474415-4-u.kleine-koenig@pengutronix.de>
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
 drivers/i2c/busses/i2c-aspeed.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index d3c99c5b3247..2e5acfeb76c8 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -1061,7 +1061,7 @@ static int aspeed_i2c_probe_bus(struct platform_device *pdev)
 	return 0;
 }
 
-static int aspeed_i2c_remove_bus(struct platform_device *pdev)
+static void aspeed_i2c_remove_bus(struct platform_device *pdev)
 {
 	struct aspeed_i2c_bus *bus = platform_get_drvdata(pdev);
 	unsigned long flags;
@@ -1077,13 +1077,11 @@ static int aspeed_i2c_remove_bus(struct platform_device *pdev)
 	reset_control_assert(bus->rst);
 
 	i2c_del_adapter(&bus->adap);
-
-	return 0;
 }
 
 static struct platform_driver aspeed_i2c_bus_driver = {
 	.probe		= aspeed_i2c_probe_bus,
-	.remove		= aspeed_i2c_remove_bus,
+	.remove_new	= aspeed_i2c_remove_bus,
 	.driver		= {
 		.name		= "aspeed-i2c-bus",
 		.of_match_table	= aspeed_i2c_bus_of_table,
-- 
2.39.2

