From: Zev Weiss <zev@bewilderbeest.net>
Date: Wed, 29 Sep 2021 04:54:06 -0700
Subject: [PATCH 4/6] mtd: spi-nor: aspeed: Allow attaching & detaching chips
 at runtime
In-Reply-To: <20210929115409.21254-1-zev@bewilderbeest.net>
References: <20210929115409.21254-1-zev@bewilderbeest.net>
Message-ID: <20210929115409.21254-5-zev@bewilderbeest.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

There are now two new sysfs attributes, attach_chip and detach_chip,
into which a chip select number can be written to attach or detach the
corresponding chip.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 .../ABI/stable/sysfs-driver-aspeed-smc        |  17 +++
 drivers/mtd/spi-nor/controllers/aspeed-smc.c  | 101 +++++++++++++++++-
 2 files changed, 115 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/ABI/stable/sysfs-driver-aspeed-smc

diff --git a/Documentation/ABI/stable/sysfs-driver-aspeed-smc b/Documentation/ABI/stable/sysfs-driver-aspeed-smc
new file mode 100644
index 000000000000..871b4d65ccb2
--- /dev/null
+++ b/Documentation/ABI/stable/sysfs-driver-aspeed-smc
@@ -0,0 +1,17 @@
+What:		/sys/bus/platform/drivers/aspeed-smc/*/attach_chip
+Date:		September 2021
+Contact:	Zev Weiss <zev@bewilderbeest.net>
+Description:	A chip select number may be written into this file to
+		request that the corresponding chip be attached by the
+		driver.
+Users:		OpenBMC.  Proposed changes should be mailed to
+		openbmc at lists.ozlabs.org
+
+What:		/sys/bus/platform/drivers/aspeed-smc/*/detach_chip
+Date:		September 2021
+Contact:	Zev Weiss <zev@bewilderbeest.net>
+Description:	A chip select number may be written into this file to
+		request that the corresponding chip be detached by the
+		driver.
+Users:		OpenBMC.  Proposed changes should be mailed to
+		openbmc at lists.ozlabs.org
diff --git a/drivers/mtd/spi-nor/controllers/aspeed-smc.c b/drivers/mtd/spi-nor/controllers/aspeed-smc.c
index 3c153104a905..da49192a8220 100644
--- a/drivers/mtd/spi-nor/controllers/aspeed-smc.c
+++ b/drivers/mtd/spi-nor/controllers/aspeed-smc.c
@@ -91,6 +91,7 @@ struct aspeed_smc_controller;
 
 struct aspeed_smc_chip {
 	int cs;
+	bool attached;
 	struct aspeed_smc_controller *controller;
 	void __iomem *ctl;			/* control register */
 	void __iomem *ahb_base;			/* base of chip window */
@@ -402,7 +403,15 @@ static ssize_t aspeed_smc_write_user(struct spi_nor *nor, loff_t to,
 
 static int aspeed_smc_unregister_chip(struct aspeed_smc_chip *chip)
 {
-	return mtd_device_unregister(&chip->nor.mtd);
+	int ret = -ENOENT;
+	mutex_lock(&chip->controller->mutex);
+	if (chip->attached) {
+		ret = mtd_device_unregister(&chip->nor.mtd);
+		if (!ret)
+			chip->attached = false;
+	}
+	mutex_unlock(&chip->controller->mutex);
+	return ret;
 }
 
 static int aspeed_smc_unregister(struct aspeed_smc_controller *controller)
@@ -412,7 +421,7 @@ static int aspeed_smc_unregister(struct aspeed_smc_controller *controller)
 
 	for (n = 0; n < controller->info->nce; n++) {
 		chip = controller->chips[n];
-		if (chip) {
+		if (chip && chip->attached) {
 			ret = aspeed_smc_unregister_chip(chip);
 			if (ret)
 				dev_warn(controller->dev, "failed to unregister CS%d: %d\n",
@@ -775,6 +784,13 @@ static int aspeed_smc_register_chip(struct aspeed_smc_chip *chip)
 	};
 	int ret;
 
+	mutex_lock(&chip->controller->mutex);
+
+	if (chip->attached) {
+		ret = -EEXIST;
+		goto out;
+	}
+
 	ret = aspeed_smc_chip_setup_init(chip, chip->controller->ahb_res);
 	if (ret)
 		goto out;
@@ -792,7 +808,12 @@ static int aspeed_smc_register_chip(struct aspeed_smc_chip *chip)
 		goto out;
 
 	ret = mtd_device_register(&chip->nor.mtd, NULL, 0);
+	if (ret)
+		goto out;
+
+	chip->attached = true;
 out:
+	mutex_unlock(&chip->controller->mutex);
 	return ret;
 }
 
@@ -865,6 +886,72 @@ static int aspeed_smc_setup_flash(struct aspeed_smc_controller *controller,
 	return ret;
 }
 
+static inline struct aspeed_smc_controller *to_aspeed_smc_controller(struct device *dev)
+{
+	struct platform_device *pdev = container_of(dev, struct platform_device, dev);
+	return platform_get_drvdata(pdev);
+}
+
+static ssize_t attach_chip_store(struct device *dev, struct device_attribute *attr,
+                                 const char *buf, size_t count)
+{
+	unsigned long cs;
+	struct aspeed_smc_controller *controller;
+	struct aspeed_smc_chip *chip;
+	ssize_t ret = kstrtoul(buf, 0, &cs);
+	if (ret)
+		return ret;
+
+	controller = to_aspeed_smc_controller(dev);
+	if (cs >= controller->info->nce)
+		return -EINVAL;
+
+	chip = controller->chips[cs];
+
+	if (!chip)
+		return -ENODEV;
+
+	ret = aspeed_smc_register_chip(chip);
+
+	return ret ? ret : count;
+}
+static DEVICE_ATTR_WO(attach_chip);
+
+static ssize_t detach_chip_store(struct device *dev, struct device_attribute *attr,
+                                 const char *buf, size_t count)
+{
+	unsigned long cs;
+	struct aspeed_smc_controller *controller;
+	struct aspeed_smc_chip *chip;
+	ssize_t ret = kstrtoul(buf, 0, &cs);
+	if (ret)
+		return ret;
+
+	controller = to_aspeed_smc_controller(dev);
+	if (cs >= controller->info->nce)
+		return -EINVAL;
+
+	chip = controller->chips[cs];
+
+	if (!chip)
+		return -ENODEV;
+
+	ret = aspeed_smc_unregister_chip(chip);
+
+	return ret ? ret : count;
+}
+static DEVICE_ATTR_WO(detach_chip);
+
+static struct attribute *aspeed_smc_sysfs_attrs[] = {
+	&dev_attr_attach_chip.attr,
+	&dev_attr_detach_chip.attr,
+	NULL,
+};
+
+static const struct attribute_group aspeed_smc_sysfs_attr_group = {
+	.attrs = aspeed_smc_sysfs_attrs,
+};
+
 static int aspeed_smc_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -905,8 +992,16 @@ static int aspeed_smc_probe(struct platform_device *pdev)
 	controller->ahb_window_size = resource_size(res);
 
 	ret = aspeed_smc_setup_flash(controller, np, res);
-	if (ret)
+	if (ret) {
 		dev_err(dev, "Aspeed SMC probe failed %d\n", ret);
+		return ret;
+	}
+
+	ret = devm_device_add_group(dev, &aspeed_smc_sysfs_attr_group);
+	if (ret) {
+		dev_err(dev, "Failed to create sysfs files\n");
+		aspeed_smc_unregister(controller);
+	}
 
 	return ret;
 }
-- 
2.33.0

