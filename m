From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Tue,  9 Apr 2024 10:55:53 +0200
Subject: [PATCH] hwmon: (aspeed-g6-pwm-tach) Convert to platform remove callback returning void
Message-ID: <20240409085552.19868-2-u.kleine-koenig@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.
To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new() which already returns void. Eventually after all drivers
are converted, .remove_new() is renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Hello,

most of drivers/hwmon was already converted to struct
platform_driver::remove_new during the v6.7 development cycle. This
driver was added for v6.9-rc1 still using the old prototype.

There are still more drivers to be converted, so there is from my side
no need to get this into v6.9, but the next merge window would be nice.

Best regards
Uwe

 drivers/hwmon/aspeed-g6-pwm-tach.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/aspeed-g6-pwm-tach.c b/drivers/hwmon/aspeed-g6-pwm-tach.c
index 597b3b019d49..262d46fed3aa 100644
--- a/drivers/hwmon/aspeed-g6-pwm-tach.c
+++ b/drivers/hwmon/aspeed-g6-pwm-tach.c
@@ -516,13 +516,11 @@ static int aspeed_pwm_tach_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int aspeed_pwm_tach_remove(struct platform_device *pdev)
+static void aspeed_pwm_tach_remove(struct platform_device *pdev)
 {
 	struct aspeed_pwm_tach_data *priv = platform_get_drvdata(pdev);
 
 	reset_control_assert(priv->reset);
-
-	return 0;
 }
 
 static const struct of_device_id aspeed_pwm_tach_match[] = {
@@ -535,7 +533,7 @@ MODULE_DEVICE_TABLE(of, aspeed_pwm_tach_match);
 
 static struct platform_driver aspeed_pwm_tach_driver = {
 	.probe = aspeed_pwm_tach_probe,
-	.remove = aspeed_pwm_tach_remove,
+	.remove_new = aspeed_pwm_tach_remove,
 	.driver	= {
 		.name = "aspeed-g6-pwm-tach",
 		.of_match_table = aspeed_pwm_tach_match,

base-commit: 4cece764965020c22cff7665b18a012006359095
-- 
2.43.0

