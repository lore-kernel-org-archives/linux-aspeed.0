From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 18 Apr 2019 12:58:17 -0700
Subject: [PATCH 3/6] hwmon: (gpio-fan) Use
 devm_thermal_of_cooling_device_register
In-Reply-To: <1555617500-10862-1-git-send-email-linux@roeck-us.net>
References: <1555617500-10862-1-git-send-email-linux@roeck-us.net>
Message-ID: <1555617500-10862-4-git-send-email-linux@roeck-us.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Call devm_thermal_of_cooling_device_register() to register the cooling
device. Also use devm_add_action_or_reset() to stop the fan on device
removal. This fixes a race condition since the fan was stopped before
the hwmon device was removed.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/gpio-fan.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/hwmon/gpio-fan.c b/drivers/hwmon/gpio-fan.c
index f1bf67aca9e8..3f6e5b4e3997 100644
--- a/drivers/hwmon/gpio-fan.c
+++ b/drivers/hwmon/gpio-fan.c
@@ -498,6 +498,11 @@ static const struct of_device_id of_gpio_fan_match[] = {
 };
 MODULE_DEVICE_TABLE(of, of_gpio_fan_match);
 
+static void gpio_fan_stop(void *data)
+{
+	set_fan_speed(data, 0);
+}
+
 static int gpio_fan_probe(struct platform_device *pdev)
 {
 	int err;
@@ -532,6 +537,7 @@ static int gpio_fan_probe(struct platform_device *pdev)
 		err = fan_ctrl_init(fan_data);
 		if (err)
 			return err;
+		devm_add_action_or_reset(dev, gpio_fan_stop, fan_data);
 	}
 
 	/* Make this driver part of hwmon class. */
@@ -543,32 +549,20 @@ static int gpio_fan_probe(struct platform_device *pdev)
 		return PTR_ERR(fan_data->hwmon_dev);
 
 	/* Optional cooling device register for Device tree platforms */
-	fan_data->cdev = thermal_of_cooling_device_register(np,
-							    "gpio-fan",
-							    fan_data,
-							    &gpio_fan_cool_ops);
+	fan_data->cdev = devm_thermal_of_cooling_device_register(dev, np,
+				"gpio-fan", fan_data, &gpio_fan_cool_ops);
 
 	dev_info(dev, "GPIO fan initialized\n");
 
 	return 0;
 }
 
-static int gpio_fan_remove(struct platform_device *pdev)
+static void gpio_fan_shutdown(struct platform_device *pdev)
 {
 	struct gpio_fan_data *fan_data = platform_get_drvdata(pdev);
 
-	if (!IS_ERR(fan_data->cdev))
-		thermal_cooling_device_unregister(fan_data->cdev);
-
 	if (fan_data->gpios)
 		set_fan_speed(fan_data, 0);
-
-	return 0;
-}
-
-static void gpio_fan_shutdown(struct platform_device *pdev)
-{
-	gpio_fan_remove(pdev);
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -602,7 +596,6 @@ static SIMPLE_DEV_PM_OPS(gpio_fan_pm, gpio_fan_suspend, gpio_fan_resume);
 
 static struct platform_driver gpio_fan_driver = {
 	.probe		= gpio_fan_probe,
-	.remove		= gpio_fan_remove,
 	.shutdown	= gpio_fan_shutdown,
 	.driver	= {
 		.name	= "gpio-fan",
-- 
2.7.4

