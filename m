From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 27 Jun 2018 09:26:00 +1000
Subject: [PATCH 09/14] fsi: master-gpio: Add missing release function
In-Reply-To: <20180626232605.13420-1-benh@kernel.crashing.org>
References: <20180626232605.13420-1-benh@kernel.crashing.org>
Message-ID: <20180626232605.13420-10-benh@kernel.crashing.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The embedded struct device needs a release function to be
able to successfully remove the driver.

We remove the devm_gpiod_put() as they are unnecessary
(the resources will be released automatically) and because
fsi_master_unregister() will cause the master structure to
be freed.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/fsi/fsi-master-gpio.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/fsi/fsi-master-gpio.c b/drivers/fsi/fsi-master-gpio.c
index 91d89597784a..bad7951a2677 100644
--- a/drivers/fsi/fsi-master-gpio.c
+++ b/drivers/fsi/fsi-master-gpio.c
@@ -792,6 +792,15 @@ static ssize_t external_mode_store(struct device *dev,
 static DEVICE_ATTR(external_mode, 0664,
 		external_mode_show, external_mode_store);
 
+static void fsi_master_gpio_release(struct device *dev)
+{
+	struct fsi_master_gpio *master = to_fsi_master_gpio(dev_to_fsi_master(dev));
+
+	of_node_put(dev_of_node(master->dev));
+
+	kfree(dev);
+}
+
 static int fsi_master_gpio_probe(struct platform_device *pdev)
 {
 	struct fsi_master_gpio *master;
@@ -805,6 +814,7 @@ static int fsi_master_gpio_probe(struct platform_device *pdev)
 	master->dev = &pdev->dev;
 	master->master.dev.parent = master->dev;
 	master->master.dev.of_node = of_node_get(dev_of_node(master->dev));
+	master->master.dev.release = fsi_master_gpio_release;
 	master->last_addr = LAST_ADDR_INVALID;
 
 	gpio = devm_gpiod_get(&pdev->dev, "clock", 0);
@@ -871,25 +881,21 @@ static int fsi_master_gpio_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
-	return fsi_master_register(&master->master);
+	rc = fsi_master_register(&master->master);
+	if (rc)
+		device_remove_file(&pdev->dev, &dev_attr_external_mode);
+	return rc;
 }
 
 
+
 static int fsi_master_gpio_remove(struct platform_device *pdev)
 {
 	struct fsi_master_gpio *master = platform_get_drvdata(pdev);
 
-	devm_gpiod_put(&pdev->dev, master->gpio_clk);
-	devm_gpiod_put(&pdev->dev, master->gpio_data);
-	if (master->gpio_trans)
-		devm_gpiod_put(&pdev->dev, master->gpio_trans);
-	if (master->gpio_enable)
-		devm_gpiod_put(&pdev->dev, master->gpio_enable);
-	if (master->gpio_mux)
-		devm_gpiod_put(&pdev->dev, master->gpio_mux);
-	fsi_master_unregister(&master->master);
+	device_remove_file(&pdev->dev, &dev_attr_external_mode);
 
-	of_node_put(master->master.dev.of_node);
+	fsi_master_unregister(&master->master);
 
 	return 0;
 }
-- 
2.17.1

