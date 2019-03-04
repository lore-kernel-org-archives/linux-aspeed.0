From: Eddie James <eajames@linux.ibm.com>
Date: Mon,  4 Mar 2019 15:36:58 -0600
Subject: [PATCH 4/6] drivers/misc: xdma: Add PCI device configuration sysfs
In-Reply-To: <1551735420-16202-1-git-send-email-eajames@linux.ibm.com>
References: <1551735420-16202-1-git-send-email-eajames@linux.ibm.com>
Message-ID: <1551735420-16202-5-git-send-email-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The AST2500 has two PCI devices embedded. The XDMA engine can use either
device to perform DMA transfers. Users need the capability to choose
which device to use. This commit therefore adds two sysfs files that
toggle the AST2500 and XDMA engine between the two PCI devices.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/misc/aspeed-xdma.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/drivers/misc/aspeed-xdma.c b/drivers/misc/aspeed-xdma.c
index 16235b3..0a1a093 100644
--- a/drivers/misc/aspeed-xdma.c
+++ b/drivers/misc/aspeed-xdma.c
@@ -645,6 +645,66 @@ static void aspeed_xdma_free_vga_blks(struct aspeed_xdma *ctx)
 	}
 }
 
+static int aspeed_xdma_change_pcie_conf(struct aspeed_xdma *ctx, u32 val)
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
+	/* previous op didn't complete, wake up waiters anyway */
+	if (!rc)
+		wake_up_interruptible_all(&ctx->wait);
+
+	reset_control_assert(ctx->reset);
+	msleep(10);
+
+	regmap_update_bits(ctx->scu, SCU_PCIE_CONF,
+			   SCU_PCIE_CONF_VGA_EN | SCU_PCIE_CONF_BMC_EN,
+			   val);
+	msleep(10);
+
+	reset_control_deassert(ctx->reset);
+	msleep(10);
+
+	aspeed_xdma_init_eng(ctx);
+
+	mutex_unlock(&ctx->start_lock);
+
+	return 0;
+}
+
+static ssize_t aspeed_xdma_use_bmc(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	int rc;
+	struct aspeed_xdma *ctx = dev_get_drvdata(dev);
+
+	rc = aspeed_xdma_change_pcie_conf(ctx, SCU_PCIE_CONF_BMC_EN);
+	return rc ?: count;
+}
+static DEVICE_ATTR(use_bmc, 0200, NULL, aspeed_xdma_use_bmc);
+
+static ssize_t aspeed_xdma_use_vga(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	int rc;
+	struct aspeed_xdma *ctx = dev_get_drvdata(dev);
+
+	rc = aspeed_xdma_change_pcie_conf(ctx, SCU_PCIE_CONF_VGA_EN);
+	return rc ?: count;
+}
+static DEVICE_ATTR(use_vga, 0200, NULL, aspeed_xdma_use_vga);
+
 static int aspeed_xdma_probe(struct platform_device *pdev)
 {
 	int irq;
@@ -723,6 +783,9 @@ static int aspeed_xdma_probe(struct platform_device *pdev)
 		return rc;
 	}
 
+	device_create_file(dev, &dev_attr_use_bmc);
+	device_create_file(dev, &dev_attr_use_vga);
+
 	return 0;
 }
 
@@ -730,6 +793,9 @@ static int aspeed_xdma_remove(struct platform_device *pdev)
 {
 	struct aspeed_xdma *ctx = platform_get_drvdata(pdev);
 
+	device_remove_file(ctx->dev, &dev_attr_use_vga);
+	device_remove_file(ctx->dev, &dev_attr_use_bmc);
+
 	misc_deregister(&ctx->misc);
 
 	aspeed_xdma_free_vga_blks(ctx);
-- 
1.8.3.1

