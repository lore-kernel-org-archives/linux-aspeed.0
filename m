From: Steven Lee <steven_lee@aspeedtech.com>
Date: Thu, 6 May 2021 18:03:11 +0800
Subject: [PATCH v3 4/5] mmc: sdhci-of-aspeed: Add a helper for updating
 capability register.
In-Reply-To: <20210506100312.1638-1-steven_lee@aspeedtech.com>
References: <20210506100312.1638-1-steven_lee@aspeedtech.com>
Message-ID: <20210506100312.1638-5-steven_lee@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The patch add a new function aspeed_sdc_set_slot_capability() for
updating sdhci capability register.

Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
---
 drivers/mmc/host/sdhci-of-aspeed.c | 57 ++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
index d001c51074a0..4979f98ffb52 100644
--- a/drivers/mmc/host/sdhci-of-aspeed.c
+++ b/drivers/mmc/host/sdhci-of-aspeed.c
@@ -31,6 +31,11 @@
 #define   ASPEED_SDC_S0_PHASE_OUT_EN	GENMASK(1, 0)
 #define   ASPEED_SDC_PHASE_MAX		31
 
+/* SDIO{10,20} */
+#define ASPEED_SDC_CAP1_1_8V           (0 * 32 + 26)
+/* SDIO{14,24} */
+#define ASPEED_SDC_CAP2_SDR104         (1 * 32 + 1)
+
 struct aspeed_sdc {
 	struct clk *clk;
 	struct resource *res;
@@ -70,8 +75,42 @@ struct aspeed_sdhci {
 	u32 width_mask;
 	struct mmc_clk_phase_map phase_map;
 	const struct aspeed_sdhci_phase_desc *phase_desc;
+
 };
 
+/*
+ * The function sets the mirror register for updating
+ * capbilities of the current slot.
+ *
+ *   slot | capability  | caps_reg | mirror_reg
+ *   -----|-------------|----------|------------
+ *     0  | CAP1_1_8V   | SDIO140  |   SDIO10
+ *     0  | CAP2_SDR104 | SDIO144  |   SDIO14
+ *     1  | CAP1_1_8V   | SDIO240  |   SDIO20
+ *     1  | CAP2_SDR104 | SDIO244  |   SDIO24
+ */
+static void aspeed_sdc_set_slot_capability(struct sdhci_host *host,
+					   struct aspeed_sdc *sdc,
+					   int capability,
+					   bool enable,
+					   u8 slot)
+{
+	u8 cap_reg;
+	u32 mirror_reg_offset, cap_val;
+
+	if (slot > 1)
+		return;
+
+	cap_reg = capability / 32;
+	cap_val = sdhci_readl(host, 0x40 + (cap_reg * 4));
+	if (enable)
+		cap_val |= BIT(capability % 32);
+	else
+		cap_val &= ~BIT(capability % 32);
+	mirror_reg_offset = ((slot + 1) * 0x10) + (cap_reg * 4);
+	writel(cap_val, sdc->regs + mirror_reg_offset);
+}
+
 static void aspeed_sdc_configure_8bit_mode(struct aspeed_sdc *sdc,
 					   struct aspeed_sdhci *sdhci,
 					   bool bus8)
@@ -329,6 +368,7 @@ static int aspeed_sdhci_probe(struct platform_device *pdev)
 {
 	const struct aspeed_sdhci_pdata *aspeed_pdata;
 	struct sdhci_pltfm_host *pltfm_host;
+	struct device_node *np = pdev->dev.of_node;
 	struct aspeed_sdhci *dev;
 	struct sdhci_host *host;
 	struct resource *res;
@@ -372,6 +412,23 @@ static int aspeed_sdhci_probe(struct platform_device *pdev)
 
 	sdhci_get_of_property(pdev);
 
+	if (of_property_read_bool(np, "mmc-hs200-1_8v") ||
+	    of_property_read_bool(np, "sd-uhs-sdr104")) {
+		aspeed_sdc_set_slot_capability(host,
+					       dev->parent,
+					       ASPEED_SDC_CAP1_1_8V,
+					       true,
+					       slot);
+	}
+
+	if (of_property_read_bool(np, "sd-uhs-sdr104")) {
+		aspeed_sdc_set_slot_capability(host,
+					       dev->parent,
+					       ASPEED_SDC_CAP2_SDR104,
+					       true,
+					       slot);
+	}
+
 	pltfm_host->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(pltfm_host->clk))
 		return PTR_ERR(pltfm_host->clk);
-- 
2.17.1

