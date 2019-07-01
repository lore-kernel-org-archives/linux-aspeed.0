From: Eddie James <eajames@linux.ibm.com>
Date: Mon,  1 Jul 2019 14:53:56 -0500
Subject: [PATCH v4 5/8] drivers/soc: xdma: Add PCI device configuration sysfs
In-Reply-To: <1562010839-1113-1-git-send-email-eajames@linux.ibm.com>
References: <1562010839-1113-1-git-send-email-eajames@linux.ibm.com>
Message-ID: <1562010839-1113-6-git-send-email-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The AST2500 has two PCI devices embedded. The XDMA engine can use either
device to perform DMA transfers. Users need the capability to choose
which device to use. This commit therefore adds a sysfs file that can
toggle the AST2500 and XDMA engine between the two PCI devices.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/soc/aspeed/aspeed-xdma.c | 103 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 100 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/aspeed/aspeed-xdma.c b/drivers/soc/aspeed/aspeed-xdma.c
index 622e3d9..72b4c4b 100644
--- a/drivers/soc/aspeed/aspeed-xdma.c
+++ b/drivers/soc/aspeed/aspeed-xdma.c
@@ -170,6 +170,7 @@ struct aspeed_xdma {
 	void *cmdq_vga_virt;
 	struct gen_pool *vga_pool;
 
+	char pcidev[4];
 	struct miscdevice misc;
 };
 
@@ -192,6 +193,10 @@ struct aspeed_xdma_client {
 	SCU_PCIE_CONF_VGA_EN_IRQ | SCU_PCIE_CONF_VGA_EN_DMA |
 	SCU_PCIE_CONF_RSVD;
 
+static char *_pcidev = "bmc";
+module_param_named(pcidev, _pcidev, charp, 0600);
+MODULE_PARM_DESC(pcidev, "Default PCI device used by XDMA engine for DMA ops");
+
 static void aspeed_scu_pcie_write(struct aspeed_xdma *ctx, u32 conf)
 {
 	u32 v = 0;
@@ -540,7 +545,7 @@ static int aspeed_xdma_release(struct inode *inode, struct file *file)
 	.release		= aspeed_xdma_release,
 };
 
-static int aspeed_xdma_init_mem(struct aspeed_xdma *ctx)
+static int aspeed_xdma_init_mem(struct aspeed_xdma *ctx, u32 conf)
 {
 	int rc;
 	u32 scu_conf = 0;
@@ -550,7 +555,7 @@ static int aspeed_xdma_init_mem(struct aspeed_xdma *ctx)
 	const u32 vga_sizes[4] = { 0x800000, 0x1000000, 0x2000000, 0x4000000 };
 	void __iomem *sdmc_base = ioremap(0x1e6e0000, 0x100);
 
-	aspeed_scu_pcie_write(ctx, aspeed_xdma_bmc_pcie_conf);
+	aspeed_scu_pcie_write(ctx, conf);
 
 	regmap_write(ctx->scu, SCU_BMC_CLASS_REV, SCU_BMC_CLASS_REV_XDMA);
 
@@ -609,10 +614,91 @@ static int aspeed_xdma_init_mem(struct aspeed_xdma *ctx)
 	return 0;
 }
 
+static int aspeed_xdma_change_pcie_conf(struct aspeed_xdma *ctx, u32 conf)
+{
+	int rc;
+
+	mutex_lock(&ctx->start_lock);
+	rc = wait_event_interruptible_timeout(ctx->wait,
+					      !test_bit(XDMA_IN_PRG,
+							&ctx->flags),
+					      msecs_to_jiffies(1000));
+	if (rc < 0) {
+		mutex_unlock(&ctx->start_lock);
+		return -EINTR;
+	}
+
+	/* Previous operation didn't complete; wake up waiters anyway. */
+	if (!rc)
+		wake_up_interruptible_all(&ctx->wait);
+
+	reset_control_assert(ctx->reset);
+	msleep(XDMA_RESET_TIME_MS);
+
+	aspeed_scu_pcie_write(ctx, conf);
+	msleep(XDMA_RESET_TIME_MS);
+
+	reset_control_deassert(ctx->reset);
+	msleep(XDMA_RESET_TIME_MS);
+
+	aspeed_xdma_init_eng(ctx);
+
+	mutex_unlock(&ctx->start_lock);
+
+	return 0;
+}
+
+static int aspeed_xdma_pcidev_to_conf(struct aspeed_xdma *ctx,
+				      const char *pcidev, u32 *conf)
+{
+	if (!strncasecmp(pcidev, "vga", 3)) {
+		*conf = aspeed_xdma_vga_pcie_conf;
+		return 0;
+	}
+
+	if (!strncasecmp(pcidev, "bmc", 3)) {
+		*conf = aspeed_xdma_bmc_pcie_conf;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static ssize_t aspeed_xdma_show_pcidev(struct device *dev,
+				       struct device_attribute *attr,
+				       char *buf)
+{
+	struct aspeed_xdma *ctx = dev_get_drvdata(dev);
+
+	return snprintf(buf, PAGE_SIZE - 1, "%s\n", ctx->pcidev);
+}
+
+static ssize_t aspeed_xdma_store_pcidev(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t count)
+{
+	u32 conf;
+	struct aspeed_xdma *ctx = dev_get_drvdata(dev);
+	int rc = aspeed_xdma_pcidev_to_conf(ctx, buf, &conf);
+
+	if (rc)
+		return rc;
+
+	rc = aspeed_xdma_change_pcie_conf(ctx, conf);
+	if (rc)
+		return rc;
+
+	strncpy(ctx->pcidev, buf, 3);
+	return count;
+}
+static DEVICE_ATTR(pcidev, 0644, aspeed_xdma_show_pcidev,
+		   aspeed_xdma_store_pcidev);
+
 static int aspeed_xdma_probe(struct platform_device *pdev)
 {
 	int irq;
 	int rc;
+	u32 conf;
 	struct resource *res;
 	struct device *dev = &pdev->dev;
 	struct aspeed_xdma *ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
@@ -668,7 +754,14 @@ static int aspeed_xdma_probe(struct platform_device *pdev)
 
 	msleep(XDMA_RESET_TIME_MS);
 
-	rc = aspeed_xdma_init_mem(ctx);
+	if (aspeed_xdma_pcidev_to_conf(ctx, _pcidev, &conf)) {
+		conf = aspeed_xdma_bmc_pcie_conf;
+		strncpy(ctx->pcidev, "bmc", 3);
+	} else {
+		strncpy(ctx->pcidev, _pcidev, 3);
+	}
+
+	rc = aspeed_xdma_init_mem(ctx, conf);
 	if (rc) {
 		reset_control_assert(ctx->reset);
 		return rc;
@@ -691,6 +784,8 @@ static int aspeed_xdma_probe(struct platform_device *pdev)
 		return rc;
 	}
 
+	device_create_file(dev, &dev_attr_pcidev);
+
 	return 0;
 }
 
@@ -698,6 +793,8 @@ static int aspeed_xdma_remove(struct platform_device *pdev)
 {
 	struct aspeed_xdma *ctx = platform_get_drvdata(pdev);
 
+	device_remove_file(ctx->dev, &dev_attr_pcidev);
+
 	misc_deregister(&ctx->misc);
 	gen_pool_free(ctx->vga_pool, (unsigned long)ctx->cmdq_vga_virt,
 		      XDMA_CMDQ_SIZE);
-- 
1.8.3.1

