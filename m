From: Eddie James <eajames@linux.ibm.com>
Date: Mon, 20 May 2019 15:19:22 -0500
Subject: [PATCH v2 4/7] drivers/soc: xdma: Add PCI device configuration sysfs
In-Reply-To: <1558383565-11821-1-git-send-email-eajames@linux.ibm.com>
References: <1558383565-11821-1-git-send-email-eajames@linux.ibm.com>
Message-ID: <1558383565-11821-5-git-send-email-eajames@linux.ibm.com>
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
 drivers/soc/aspeed/aspeed-xdma.c | 64 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/soc/aspeed/aspeed-xdma.c b/drivers/soc/aspeed/aspeed-xdma.c
index 2162ca0..002b571 100644
--- a/drivers/soc/aspeed/aspeed-xdma.c
+++ b/drivers/soc/aspeed/aspeed-xdma.c
@@ -667,6 +667,64 @@ static void aspeed_xdma_free_vga_blks(struct aspeed_xdma *ctx)
 	}
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
+	/* previous op didn't complete, wake up waiters anyway */
+	if (!rc)
+		wake_up_interruptible_all(&ctx->wait);
+
+	reset_control_assert(ctx->reset);
+	msleep(10);
+
+	aspeed_scu_pcie_write(ctx, conf);
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
+	rc = aspeed_xdma_change_pcie_conf(ctx, aspeed_xdma_bmc_pcie_conf);
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
+	rc = aspeed_xdma_change_pcie_conf(ctx, aspeed_xdma_vga_pcie_conf);
+	return rc ?: count;
+}
+static DEVICE_ATTR(use_vga, 0200, NULL, aspeed_xdma_use_vga);
+
 static int aspeed_xdma_probe(struct platform_device *pdev)
 {
 	int irq;
@@ -745,6 +803,9 @@ static int aspeed_xdma_probe(struct platform_device *pdev)
 		return rc;
 	}
 
+	device_create_file(dev, &dev_attr_use_bmc);
+	device_create_file(dev, &dev_attr_use_vga);
+
 	return 0;
 }
 
@@ -752,6 +813,9 @@ static int aspeed_xdma_remove(struct platform_device *pdev)
 {
 	struct aspeed_xdma *ctx = platform_get_drvdata(pdev);
 
+	device_remove_file(ctx->dev, &dev_attr_use_vga);
+	device_remove_file(ctx->dev, &dev_attr_use_bmc);
+
 	misc_deregister(&ctx->misc);
 
 	aspeed_xdma_free_vga_blks(ctx);
-- 
1.8.3.1

