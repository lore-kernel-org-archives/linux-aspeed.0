From: Steven Lee <steven_lee@aspeedtech.com>
Date: Thu, 6 May 2021 18:03:12 +0800
Subject: [PATCH v3 5/5] mmc: sdhci-of-aspeed: Assert/Deassert reset signal
 before probing eMMC
In-Reply-To: <20210506100312.1638-1-steven_lee@aspeedtech.com>
References: <20210506100312.1638-1-steven_lee@aspeedtech.com>
Message-ID: <20210506100312.1638-6-steven_lee@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

For cleaning up the AST2600 eMMC controller, the reset signal should be
asserted and deasserted before it is probed.

Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
---
 drivers/mmc/host/sdhci-of-aspeed.c | 49 ++++++++++++++++++++++++------
 1 file changed, 40 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
index 4979f98ffb52..8ef06f32abff 100644
--- a/drivers/mmc/host/sdhci-of-aspeed.c
+++ b/drivers/mmc/host/sdhci-of-aspeed.c
@@ -13,6 +13,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/reset.h>
 #include <linux/spinlock.h>
 
 #include "sdhci-pltfm.h"
@@ -36,9 +37,16 @@
 /* SDIO{14,24} */
 #define ASPEED_SDC_CAP2_SDR104         (1 * 32 + 1)
 
+#define PROBE_AFTER_ASSET_DEASSERT	0x1
+
+struct aspeed_sdc_info {
+	u32 flag;
+};
+
 struct aspeed_sdc {
 	struct clk *clk;
 	struct resource *res;
+	struct reset_control *rst;
 
 	spinlock_t lock;
 	void __iomem *regs;
@@ -78,6 +86,10 @@ struct aspeed_sdhci {
 
 };
 
+struct aspeed_sdc_info ast2600_sdc_info = {
+	.flag = PROBE_AFTER_ASSET_DEASSERT
+};
+
 /*
  * The function sets the mirror register for updating
  * capbilities of the current slot.
@@ -533,11 +545,22 @@ static struct platform_driver aspeed_sdhci_driver = {
 	.remove		= aspeed_sdhci_remove,
 };
 
+static const struct of_device_id aspeed_sdc_of_match[] = {
+	{ .compatible = "aspeed,ast2400-sd-controller", },
+	{ .compatible = "aspeed,ast2500-sd-controller", },
+	{ .compatible = "aspeed,ast2600-sd-controller", .data = &ast2600_sdc_info},
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, aspeed_sdc_of_match);
+
 static int aspeed_sdc_probe(struct platform_device *pdev)
 
 {
 	struct device_node *parent, *child;
 	struct aspeed_sdc *sdc;
+	const struct of_device_id *match = NULL;
+	const struct aspeed_sdc_info *info = NULL;
 	int ret;
 
 	sdc = devm_kzalloc(&pdev->dev, sizeof(*sdc), GFP_KERNEL);
@@ -546,6 +569,23 @@ static int aspeed_sdc_probe(struct platform_device *pdev)
 
 	spin_lock_init(&sdc->lock);
 
+	match = of_match_device(aspeed_sdc_of_match, &pdev->dev);
+	if (!match)
+		return -ENODEV;
+
+	if (match->data)
+		info = match->data;
+
+	if (info) {
+		if (info->flag & PROBE_AFTER_ASSET_DEASSERT) {
+			sdc->rst = devm_reset_control_get(&pdev->dev, NULL);
+			if (!IS_ERR(sdc->rst)) {
+				reset_control_assert(sdc->rst);
+				reset_control_deassert(sdc->rst);
+			}
+		}
+	}
+
 	sdc->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(sdc->clk))
 		return PTR_ERR(sdc->clk);
@@ -593,15 +633,6 @@ static int aspeed_sdc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id aspeed_sdc_of_match[] = {
-	{ .compatible = "aspeed,ast2400-sd-controller", },
-	{ .compatible = "aspeed,ast2500-sd-controller", },
-	{ .compatible = "aspeed,ast2600-sd-controller", },
-	{ }
-};
-
-MODULE_DEVICE_TABLE(of, aspeed_sdc_of_match);
-
 static struct platform_driver aspeed_sdc_driver = {
 	.driver		= {
 		.name	= "sd-controller-aspeed",
-- 
2.17.1

