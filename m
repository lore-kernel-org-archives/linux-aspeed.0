From: Steven Lee <steven_lee@aspeedtech.com>
Date: Mon, 3 May 2021 09:43:36 +0800
Subject: [PATCH v2 3/3] mmc: sdhci-of-aspeed: Sync capabilities from device
 tree to ast2600 SoC registers
In-Reply-To: <20210503014336.20256-1-steven_lee@aspeedtech.com>
References: <20210503014336.20256-1-steven_lee@aspeedtech.com>
Message-ID: <20210503014336.20256-4-steven_lee@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Sync Capbility Registers(SDIO140, SDIO144, SDIO240, SDIO244) of ast2600
SoC from the device tree.
The bit 26(Voltage Support 1.8v) of SDIO140/SDIO240 is set to 1 if
"mmc-hs200-1_8v" or "sd-uhs-sdr104" is added in the device tree.
The bit 1(SDR104 Supported) of SDR144/SDR244 is set to 1 if "sd-uhs-sdr104"
is added in the device tree.
"timing-phase" is synced to SDIO0F4(Colock Phase Control)

Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
---
 drivers/mmc/host/sdhci-of-aspeed.c | 107 ++++++++++++++++++++++++++---
 1 file changed, 98 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
index 7d8692e90996..2d755bac777a 100644
--- a/drivers/mmc/host/sdhci-of-aspeed.c
+++ b/drivers/mmc/host/sdhci-of-aspeed.c
@@ -13,6 +13,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/reset.h>
 #include <linux/spinlock.h>
 
 #include "sdhci-pltfm.h"
@@ -30,10 +31,18 @@
 #define   ASPEED_SDC_S0_PHASE_IN_EN	BIT(2)
 #define   ASPEED_SDC_S0_PHASE_OUT_EN	GENMASK(1, 0)
 #define   ASPEED_SDC_PHASE_MAX		31
+#define ASPEED_SDC_CAP1_1_8V           BIT(26)
+#define ASPEED_SDC_CAP2_SDR104         BIT(1)
+#define PROBE_AFTER_ASSET_DEASSERT     0x1
+
+struct aspeed_sdc_info {
+	u32 flag;
+};
 
 struct aspeed_sdc {
 	struct clk *clk;
 	struct resource *res;
+	struct reset_control *rst;
 
 	spinlock_t lock;
 	void __iomem *regs;
@@ -72,6 +81,44 @@ struct aspeed_sdhci {
 	const struct aspeed_sdhci_phase_desc *phase_desc;
 };
 
+struct aspeed_sdc_info ast2600_sdc_info = {
+	.flag = PROBE_AFTER_ASSET_DEASSERT
+};
+
+/*
+ * The function sets the mirror register for updating
+ * capbilities of the current slot.
+ *
+ *   slot | cap_idx | caps_reg | mirror_reg
+ *   -----|---------|----------|------------
+ *     0  |    0    | SDIO140  |   SDIO10
+ *     0  |    1    | SDIO144  |   SDIO14
+ *     1  |    0    | SDIO240  |   SDIO20
+ *     1  |    1    | SDIO244  |   SDIO24
+ */
+static void aspeed_sdc_set_slot_capability(struct sdhci_host *host,
+					   struct aspeed_sdc *sdc,
+					   u32 reg_val,
+					   u8 slot,
+					   u8 cap_idx)
+{
+	u8 caps_reg_offset;
+	u32 caps_reg;
+	u32 mirror_reg_offset;
+	u32 caps_val;
+
+	if (cap_idx > 1 || slot > 1)
+		return;
+
+	caps_reg_offset = (cap_idx == 0) ? 0 : 4;
+	caps_reg = 0x40 + caps_reg_offset;
+	caps_val = sdhci_readl(host, caps_reg);
+	caps_val |= reg_val;
+	mirror_reg_offset = (slot == 0) ? 0x10 : 0x20;
+	mirror_reg_offset += caps_reg_offset;
+	writel(caps_val, sdc->regs + mirror_reg_offset);
+}
+
 static void aspeed_sdc_configure_8bit_mode(struct aspeed_sdc *sdc,
 					   struct aspeed_sdhci *sdhci,
 					   bool bus8)
@@ -329,9 +376,11 @@ static int aspeed_sdhci_probe(struct platform_device *pdev)
 {
 	const struct aspeed_sdhci_pdata *aspeed_pdata;
 	struct sdhci_pltfm_host *pltfm_host;
+	struct device_node *np = pdev->dev.of_node;
 	struct aspeed_sdhci *dev;
 	struct sdhci_host *host;
 	struct resource *res;
+	u32 reg_val;
 	int slot;
 	int ret;
 
@@ -372,6 +421,21 @@ static int aspeed_sdhci_probe(struct platform_device *pdev)
 
 	sdhci_get_of_property(pdev);
 
+	if (of_property_read_bool(np, "mmc-hs200-1_8v") ||
+	    of_property_read_bool(np, "sd-uhs-sdr104"))
+		aspeed_sdc_set_slot_capability(host,
+					       dev->parent,
+					       ASPEED_SDC_CAP1_1_8V,
+					       slot,
+					       0);
+
+	if (of_property_read_bool(np, "sd-uhs-sdr104"))
+		aspeed_sdc_set_slot_capability(host,
+					       dev->parent,
+					       ASPEED_SDC_CAP2_SDR104,
+					       slot,
+					       1);
+
 	pltfm_host->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(pltfm_host->clk))
 		return PTR_ERR(pltfm_host->clk);
@@ -476,12 +540,25 @@ static struct platform_driver aspeed_sdhci_driver = {
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
+
 	int ret;
+	u32 timing_phase;
 
 	sdc = devm_kzalloc(&pdev->dev, sizeof(*sdc), GFP_KERNEL);
 	if (!sdc)
@@ -489,6 +566,23 @@ static int aspeed_sdc_probe(struct platform_device *pdev)
 
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
@@ -506,6 +600,10 @@ static int aspeed_sdc_probe(struct platform_device *pdev)
 		goto err_clk;
 	}
 
+	if (!of_property_read_u32(pdev->dev.of_node,
+				  "timing-phase", &timing_phase))
+		writel(timing_phase, sdc->regs + ASPEED_SDC_PHASE);
+
 	dev_set_drvdata(&pdev->dev, sdc);
 
 	parent = pdev->dev.of_node;
@@ -536,15 +634,6 @@ static int aspeed_sdc_remove(struct platform_device *pdev)
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

