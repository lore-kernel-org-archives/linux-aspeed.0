From: Eddie James <eajames@linux.ibm.com>
Date: Wed,  5 Jun 2024 16:22:52 -0500
Subject: [PATCH v4 20/40] fsi: aspeed: Switch to spinlock
In-Reply-To: <20240605212312.349188-1-eajames@linux.ibm.com>
References: <20240605212312.349188-1-eajames@linux.ibm.com>
Message-ID: <20240605212312.349188-21-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

In preparation for interrupt support, switch to a spinlock rather
than a mutex.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-master-aspeed.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
index 10ca23cf58c2e..176e596b4391b 100644
--- a/drivers/fsi/fsi-master-aspeed.c
+++ b/drivers/fsi/fsi-master-aspeed.c
@@ -8,11 +8,11 @@
 #include <linux/io.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
-#include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
+#include <linux/spinlock.h>
 #include <linux/iopoll.h>
 #include <linux/gpio/consumer.h>
 
@@ -24,7 +24,7 @@ struct fsi_master_aspeed_data {
 
 struct fsi_master_aspeed {
 	struct fsi_master	master;
-	struct mutex		lock;	/* protect HW access */
+	spinlock_t		lock;	/* protect HW access */
 	struct device		*dev;
 	void __iomem		*base;
 	void __iomem		*ctrl;
@@ -251,6 +251,7 @@ static int aspeed_master_read(struct fsi_master *master, int link,
 			uint8_t id, uint32_t addr, void *val, size_t size)
 {
 	struct fsi_master_aspeed *aspeed = to_fsi_master_aspeed(master);
+	unsigned long flags;
 	int ret;
 
 	if (id > 0x3)
@@ -259,7 +260,7 @@ static int aspeed_master_read(struct fsi_master *master, int link,
 	addr |= id << 21;
 	addr += link * FSI_HUB_LINK_SIZE;
 
-	mutex_lock(&aspeed->lock);
+	spin_lock_irqsave(&aspeed->lock, flags);
 
 	switch (size) {
 	case 1:
@@ -278,7 +279,7 @@ static int aspeed_master_read(struct fsi_master *master, int link,
 
 	ret = check_errors(aspeed, ret);
 done:
-	mutex_unlock(&aspeed->lock);
+	spin_unlock_irqrestore(&aspeed->lock, flags);
 	return ret;
 }
 
@@ -286,6 +287,7 @@ static int aspeed_master_write(struct fsi_master *master, int link,
 			uint8_t id, uint32_t addr, const void *val, size_t size)
 {
 	struct fsi_master_aspeed *aspeed = to_fsi_master_aspeed(master);
+	unsigned long flags;
 	int ret;
 
 	if (id > 0x3)
@@ -294,7 +296,7 @@ static int aspeed_master_write(struct fsi_master *master, int link,
 	addr |= id << 21;
 	addr += link * FSI_HUB_LINK_SIZE;
 
-	mutex_lock(&aspeed->lock);
+	spin_lock_irqsave(&aspeed->lock, flags);
 
 	switch (size) {
 	case 1:
@@ -313,7 +315,7 @@ static int aspeed_master_write(struct fsi_master *master, int link,
 
 	ret = check_errors(aspeed, ret);
 done:
-	mutex_unlock(&aspeed->lock);
+	spin_unlock_irqrestore(&aspeed->lock, flags);
 	return ret;
 }
 
@@ -396,15 +398,16 @@ static ssize_t cfam_reset_store(struct device *dev, struct device_attribute *att
 				const char *buf, size_t count)
 {
 	struct fsi_master_aspeed *aspeed = dev_get_drvdata(dev);
+	unsigned long flags;
 
 	trace_fsi_master_aspeed_cfam_reset(true);
-	mutex_lock(&aspeed->lock);
+	spin_lock_irqsave(&aspeed->lock, flags);
 	gpiod_set_value(aspeed->cfam_reset_gpio, 1);
-	usleep_range(900, 1000);
+	udelay(900);
 	gpiod_set_value(aspeed->cfam_reset_gpio, 0);
-	usleep_range(900, 1000);
+	udelay(900);
 	regmap_write(aspeed->master.map, FSI_MRESP0, FSI_MRESP_RST_ALL_MASTER);
-	mutex_unlock(&aspeed->lock);
+	spin_unlock_irqrestore(&aspeed->lock, flags);
 	trace_fsi_master_aspeed_cfam_reset(false);
 
 	return count;
@@ -498,6 +501,7 @@ static int fsi_master_aspeed_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	aspeed->dev = &pdev->dev;
+	spin_lock_init(&aspeed->lock);
 
 	aspeed->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(aspeed->base)) {
@@ -583,7 +587,6 @@ static int fsi_master_aspeed_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(&pdev->dev, aspeed);
 
-	mutex_init(&aspeed->lock);
 	rc = fsi_master_init(&aspeed->master, clk_get_rate(aspeed->clk));
 	if (rc)
 		goto err_regmap;
-- 
2.39.3

