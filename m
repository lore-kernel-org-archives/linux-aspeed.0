From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 11 Sep 2020 17:14:51 +0930
Subject: [PATCH v2 2/3] mmc: sdhci-of-aspeed: Expose phase delay tuning
In-Reply-To: <20200911074452.3148259-1-andrew@aj.id.au>
References: <20200911074452.3148259-1-andrew@aj.id.au>
Message-ID: <20200911074452.3148259-3-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The Aspeed SD/eMMC controllers feature up to two SDHCIs alongside a
a set of "global" configuration registers. The global configuration
registers house controller-specific settings that aren't exposed by the
SDHCI, one example being a register for phase tuning.

The phase tuning feature is new in the AST2600 design. It's exposed as a
single register in the global register set and controls both the input
and output phase adjustment for each slot. As the settings are
slot-specific, the values to program are extracted from properties in
the SDHCI devicetree nodes.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
In v2:

* Rework devicetree parsing to minimise state disruption
* Switch some log statements from dev_info() to dev_dbg()
---
 drivers/mmc/host/sdhci-of-aspeed.c | 126 +++++++++++++++++++++++++++--
 1 file changed, 121 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
index 4f008ba3280e..c61eb42e1ebb 100644
--- a/drivers/mmc/host/sdhci-of-aspeed.c
+++ b/drivers/mmc/host/sdhci-of-aspeed.c
@@ -16,9 +16,19 @@
 
 #include "sdhci-pltfm.h"
 
-#define ASPEED_SDC_INFO		0x00
-#define   ASPEED_SDC_S1MMC8	BIT(25)
-#define   ASPEED_SDC_S0MMC8	BIT(24)
+#define ASPEED_SDC_INFO			0x00
+#define   ASPEED_SDC_S1_MMC8		BIT(25)
+#define   ASPEED_SDC_S0_MMC8		BIT(24)
+#define ASPEED_SDC_PHASE		0xf4
+#define   ASPEED_SDC_S1_PHASE_IN	GENMASK(25, 21)
+#define   ASPEED_SDC_S0_PHASE_IN	GENMASK(20, 16)
+#define   ASPEED_SDC_S1_PHASE_OUT	GENMASK(15, 11)
+#define   ASPEED_SDC_S1_PHASE_IN_EN	BIT(10)
+#define   ASPEED_SDC_S1_PHASE_OUT_EN	GENMASK(9, 8)
+#define   ASPEED_SDC_S0_PHASE_OUT	GENMASK(7, 3)
+#define   ASPEED_SDC_S0_PHASE_IN_EN	BIT(2)
+#define   ASPEED_SDC_S0_PHASE_OUT_EN	GENMASK(1, 0)
+#define   ASPEED_SDC_PHASE_MAX		31
 
 struct aspeed_sdc {
 	struct clk *clk;
@@ -28,9 +38,21 @@ struct aspeed_sdc {
 	void __iomem *regs;
 };
 
+struct aspeed_sdhci_phase_desc {
+	u32 value_mask;
+	u32 enable_mask;
+	u8 enable_value;
+};
+
+struct aspeed_sdhci_phase {
+	struct aspeed_sdhci_phase_desc in;
+	struct aspeed_sdhci_phase_desc out;
+};
+
 struct aspeed_sdhci {
 	struct aspeed_sdc *parent;
 	u32 width_mask;
+	const struct aspeed_sdhci_phase *phase;
 };
 
 static void aspeed_sdc_configure_8bit_mode(struct aspeed_sdc *sdc,
@@ -50,6 +72,22 @@ static void aspeed_sdc_configure_8bit_mode(struct aspeed_sdc *sdc,
 	spin_unlock(&sdc->lock);
 }
 
+static void
+aspeed_sdc_configure_phase(struct aspeed_sdc *sdc,
+			   const struct aspeed_sdhci_phase_desc *phase,
+			   uint8_t value)
+{
+	u32 reg;
+
+	spin_lock(&sdc->lock);
+	reg = readl(sdc->regs + ASPEED_SDC_PHASE);
+	reg &= ~(phase->enable_mask | phase->value_mask);
+	reg |= value << __ffs(phase->value_mask);
+	reg |= phase->enable_value << __ffs(phase->enable_mask);
+	writel(reg, sdc->regs + ASPEED_SDC_PHASE);
+	spin_unlock(&sdc->lock);
+}
+
 static void aspeed_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	struct sdhci_pltfm_host *pltfm_host;
@@ -155,8 +193,49 @@ static inline int aspeed_sdhci_calculate_slot(struct aspeed_sdhci *dev,
 	return (delta / 0x100) - 1;
 }
 
+static int aspeed_sdhci_configure_of(struct platform_device *pdev,
+				     struct aspeed_sdhci *sdhci)
+{
+	struct device_node *np;
+	struct device *dev;
+	u32 phase;
+
+	if (!sdhci->phase)
+		return 0;
+
+	dev = &pdev->dev;
+	np = dev->of_node;
+
+	if (!of_property_read_u32(np, "aspeed,input-phase", &phase)) {
+		if (phase <= ASPEED_SDC_PHASE_MAX) {
+			aspeed_sdc_configure_phase(sdhci->parent,
+						   &sdhci->phase->in,
+						   phase);
+			dev_dbg(dev, "Input phase adjustment: %u", phase);
+		} else {
+			dev_err(dev, "Invalid input phase value: %u", phase);
+			return -EINVAL;
+		}
+	}
+
+	if (!of_property_read_u32(np, "aspeed,output-phase", &phase)) {
+		if (phase <= ASPEED_SDC_PHASE_MAX) {
+			aspeed_sdc_configure_phase(sdhci->parent,
+						   &sdhci->phase->out,
+						   phase);
+			dev_dbg(dev, "Output phase adjustment: %u", phase);
+		} else {
+			dev_err(dev, "Invalid output phase value: %u", phase);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 static int aspeed_sdhci_probe(struct platform_device *pdev)
 {
+	const struct aspeed_sdhci_phase *phase;
 	struct sdhci_pltfm_host *pltfm_host;
 	struct aspeed_sdhci *dev;
 	struct sdhci_host *host;
@@ -181,7 +260,10 @@ static int aspeed_sdhci_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	dev_info(&pdev->dev, "Configuring for slot %d\n", slot);
-	dev->width_mask = !slot ? ASPEED_SDC_S0MMC8 : ASPEED_SDC_S1MMC8;
+	dev->width_mask = !slot ? ASPEED_SDC_S0_MMC8 : ASPEED_SDC_S1_MMC8;
+	phase = of_device_get_match_data(&pdev->dev);
+	if (phase)
+		dev->phase = &phase[slot];
 
 	sdhci_get_of_property(pdev);
 
@@ -195,6 +277,10 @@ static int aspeed_sdhci_probe(struct platform_device *pdev)
 		goto err_pltfm_free;
 	}
 
+	ret = aspeed_sdhci_configure_of(pdev, dev);
+	if (ret)
+		goto err_sdhci_add;
+
 	ret = mmc_of_parse(host->mmc);
 	if (ret)
 		goto err_sdhci_add;
@@ -230,10 +316,40 @@ static int aspeed_sdhci_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct aspeed_sdhci_phase ast2600_sdhci_phase[] = {
+	/* SDHCI/Slot 0 */
+	[0] = {
+		.in = {
+			.value_mask = ASPEED_SDC_S0_PHASE_IN,
+			.enable_mask = ASPEED_SDC_S0_PHASE_IN_EN,
+			.enable_value = 1,
+		},
+		.out = {
+			.value_mask = ASPEED_SDC_S0_PHASE_OUT,
+			.enable_mask = ASPEED_SDC_S0_PHASE_OUT_EN,
+			.enable_value = 3,
+		},
+	},
+	/* SDHCI/Slot 1 */
+	[1] = {
+		.in = {
+			.value_mask = ASPEED_SDC_S1_PHASE_IN,
+			.enable_mask = ASPEED_SDC_S1_PHASE_IN_EN,
+			.enable_value = 1,
+		},
+		.out = {
+			.value_mask = ASPEED_SDC_S1_PHASE_OUT,
+			.enable_mask = ASPEED_SDC_S1_PHASE_OUT_EN,
+			.enable_value = 3,
+		},
+	},
+};
+
+/* If supported, phase adjustment fields are stored in the data pointer */
 static const struct of_device_id aspeed_sdhci_of_match[] = {
 	{ .compatible = "aspeed,ast2400-sdhci", },
 	{ .compatible = "aspeed,ast2500-sdhci", },
-	{ .compatible = "aspeed,ast2600-sdhci", },
+	{ .compatible = "aspeed,ast2600-sdhci", .data = ast2600_sdhci_phase },
 	{ }
 };
 
-- 
2.25.1

