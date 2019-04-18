From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 18 Apr 2019 12:58:18 -0700
Subject: [PATCH 4/6] hwmon: (mlxreg-fan) Use
 devm_thermal_of_cooling_device_register
In-Reply-To: <1555617500-10862-1-git-send-email-linux@roeck-us.net>
References: <1555617500-10862-1-git-send-email-linux@roeck-us.net>
Message-ID: <1555617500-10862-5-git-send-email-linux@roeck-us.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Call devm_thermal_of_cooling_device_register() to register the cooling
device. Also introduce struct device *dev = &pdev->dev; to make the code
easier to read.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/mlxreg-fan.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/drivers/hwmon/mlxreg-fan.c b/drivers/hwmon/mlxreg-fan.c
index db8c6de0b6a0..a14347ea0d77 100644
--- a/drivers/hwmon/mlxreg-fan.c
+++ b/drivers/hwmon/mlxreg-fan.c
@@ -420,42 +420,42 @@ static int mlxreg_fan_config(struct mlxreg_fan *fan,
 static int mlxreg_fan_probe(struct platform_device *pdev)
 {
 	struct mlxreg_core_platform_data *pdata;
+	struct device *dev = &pdev->dev;
 	struct mlxreg_fan *fan;
 	struct device *hwm;
 	int err;
 
-	pdata = dev_get_platdata(&pdev->dev);
+	pdata = dev_get_platdata(dev);
 	if (!pdata) {
-		dev_err(&pdev->dev, "Failed to get platform data.\n");
+		dev_err(dev, "Failed to get platform data.\n");
 		return -EINVAL;
 	}
 
-	fan = devm_kzalloc(&pdev->dev, sizeof(*fan), GFP_KERNEL);
+	fan = devm_kzalloc(dev, sizeof(*fan), GFP_KERNEL);
 	if (!fan)
 		return -ENOMEM;
 
-	fan->dev = &pdev->dev;
+	fan->dev = dev;
 	fan->regmap = pdata->regmap;
-	platform_set_drvdata(pdev, fan);
 
 	err = mlxreg_fan_config(fan, pdata);
 	if (err)
 		return err;
 
-	hwm = devm_hwmon_device_register_with_info(&pdev->dev, "mlxreg_fan",
+	hwm = devm_hwmon_device_register_with_info(dev, "mlxreg_fan",
 						   fan,
 						   &mlxreg_fan_hwmon_chip_info,
 						   NULL);
 	if (IS_ERR(hwm)) {
-		dev_err(&pdev->dev, "Failed to register hwmon device\n");
+		dev_err(dev, "Failed to register hwmon device\n");
 		return PTR_ERR(hwm);
 	}
 
 	if (IS_REACHABLE(CONFIG_THERMAL)) {
-		fan->cdev = thermal_cooling_device_register("mlxreg_fan", fan,
-						&mlxreg_fan_cooling_ops);
+		fan->cdev = devm_thermal_of_cooling_device_register(dev,
+			NULL, "mlxreg_fan", fan, &mlxreg_fan_cooling_ops);
 		if (IS_ERR(fan->cdev)) {
-			dev_err(&pdev->dev, "Failed to register cooling device\n");
+			dev_err(dev, "Failed to register cooling device\n");
 			return PTR_ERR(fan->cdev);
 		}
 	}
@@ -463,22 +463,11 @@ static int mlxreg_fan_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int mlxreg_fan_remove(struct platform_device *pdev)
-{
-	struct mlxreg_fan *fan = platform_get_drvdata(pdev);
-
-	if (IS_REACHABLE(CONFIG_THERMAL))
-		thermal_cooling_device_unregister(fan->cdev);
-
-	return 0;
-}
-
 static struct platform_driver mlxreg_fan_driver = {
 	.driver = {
 	    .name = "mlxreg-fan",
 	},
 	.probe = mlxreg_fan_probe,
-	.remove = mlxreg_fan_remove,
 };
 
 module_platform_driver(mlxreg_fan_driver);
-- 
2.7.4

