From: Andrew Jeffery <andrew@aj.id.au>
Date: Sat, 20 Feb 2021 00:55:22 +1030
Subject: [PATCH 18/19] ipmi: kcs_bmc_aspeed: Implement KCS SerIRQ configuration
In-Reply-To: <20210219142523.3464540-1-andrew@aj.id.au>
References: <20210219142523.3464540-1-andrew@aj.id.au>
Message-ID: <20210219142523.3464540-19-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Apply the SerIRQ ID and level/sense behaviours from the devicetree if
provided.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/char/ipmi/kcs_bmc_aspeed.c | 126 +++++++++++++++++++++++++++++
 1 file changed, 126 insertions(+)

diff --git a/drivers/char/ipmi/kcs_bmc_aspeed.c b/drivers/char/ipmi/kcs_bmc_aspeed.c
index 17afe9449e72..649d795a5a75 100644
--- a/drivers/char/ipmi/kcs_bmc_aspeed.c
+++ b/drivers/char/ipmi/kcs_bmc_aspeed.c
@@ -9,6 +9,7 @@
 #include <linux/errno.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/irq.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -39,6 +40,20 @@
 #define LPC_HICR4            0x010
 #define     LPC_HICR4_LADR12AS       BIT(7)
 #define     LPC_HICR4_KCSENBL        BIT(2)
+#define LPC_SIRQCR2	     0x078
+#define     LPC_SIRQCR2_SEL1IRQX     BIT(13)
+#define     LPC_SIRQCR2_IRQXE1       BIT(12)
+#define     LPC_SIRQCR2_ID1IRQX_MASK GENMASK(11, 8)
+#define     LPC_SIRQCR2_ID1IRQX_SHIFT 8
+#define LPC_HICR5	     0x080
+#define     LPC_HICR5_ID3IRQX_MASK   GENMASK(23, 20)
+#define     LPC_HICR5_ID3IRQX_SHIFT  20
+#define     LPC_HICR5_ID2IRQX_MASK   GENMASK(19, 16)
+#define     LPC_HICR5_ID2IRQX_SHIFT  16
+#define     LPC_HICR5_SEL3IRQX       BIT(15)
+#define     LPC_HICR5_IRQXE3         BIT(14)
+#define     LPC_HICR5_SEL2IRQX       BIT(13)
+#define     LPC_HICR5_IRQXE2         BIT(12)
 #define LPC_LADR3H           0x014
 #define LPC_LADR3L           0x018
 #define LPC_LADR12H          0x01C
@@ -55,6 +70,17 @@
 #define LPC_HICRB            0x100
 #define     LPC_HICRB_IBFIF4         BIT(1)
 #define     LPC_HICRB_LPC4E          BIT(0)
+#define LPC_HICRC            0x104
+#define     LPC_HICRC_ID4IRQX_MASK   GENMASK(7, 4)
+#define     LPC_HICRC_ID4IRQX_SHIFT  4
+#define     LPC_HICRC_TY4IRQX_MASK   GENMASK(3, 2)
+#define     LPC_HICRC_TY4IRQX_SHIFT  2
+#define     LPC_HICRC_TY4IRQX_LOW    0b00
+#define     LPC_HICRC_TY4IRQX_HIGH   0b01
+#define     LPC_HICRC_TY4IRQX_RSVD   0b10
+#define     LPC_HICRC_TY4IRQX_RISING 0b11
+#define     LPC_HICRC_OBF4_AUTO_CLR  BIT(1)
+#define     LPC_HICRC_IRQXE4         BIT(0)
 #define LPC_LADR4            0x110
 #define LPC_IDR4             0x114
 #define LPC_ODR4             0x118
@@ -99,10 +125,37 @@ static u8 aspeed_kcs_inb(struct kcs_bmc_device *kcs_bmc, u32 reg)
 static void aspeed_kcs_outb(struct kcs_bmc_device *kcs_bmc, u32 reg, u8 data)
 {
 	struct aspeed_kcs_bmc *priv = to_aspeed_kcs_bmc(kcs_bmc);
+	unsigned int ier;
 	int rc;
 
 	rc = regmap_write(priv->map, reg, data);
 	WARN(rc != 0, "regmap_write() failed: %d\n", rc);
+
+	/* Trigger the SerIRQ on ODR writes if enabled */
+	switch (kcs_bmc->channel) {
+	case 1:
+		regmap_read(priv->map, LPC_SIRQCR2, &ier);
+		if (reg == LPC_ODR1 && (ier & LPC_SIRQCR2_SEL1IRQX))
+			regmap_write(priv->map, LPC_SIRQCR2, ier | LPC_SIRQCR2_IRQXE1);
+		break;
+	case 2:
+		regmap_read(priv->map, LPC_HICR5, &ier);
+		if (reg == LPC_ODR2 && (ier & LPC_HICR5_SEL2IRQX))
+			regmap_write(priv->map, LPC_HICR5, ier | LPC_HICR5_IRQXE2);
+		break;
+	case 3:
+		regmap_read(priv->map, LPC_HICR5, &ier);
+		if (reg == LPC_ODR3 && (ier & LPC_HICR5_SEL3IRQX))
+			regmap_write(priv->map, LPC_HICR5, ier | LPC_HICR5_IRQXE3);
+		break;
+	case 4:
+		regmap_read(priv->map, LPC_HICRC, &ier);
+		if (reg == LPC_ODR4 && (ier & LPC_HICRC_ID4IRQX_MASK))
+			regmap_write(priv->map, LPC_HICRC, ier | LPC_HICRC_IRQXE4);
+		break;
+	default:
+		break;
+	}
 }
 
 static void aspeed_kcs_updateb(struct kcs_bmc_device *kcs_bmc, u32 reg, u8 mask, u8 val)
@@ -161,6 +214,66 @@ static void aspeed_kcs_set_address(struct kcs_bmc_device *kcs_bmc, u16 addr)
 	}
 }
 
+static inline int aspeed_kcs_map_serirq_type(u32 dt_type)
+{
+	switch (dt_type) {
+	case IRQ_TYPE_EDGE_RISING:
+		return LPC_HICRC_TY4IRQX_RISING;
+	case IRQ_TYPE_LEVEL_HIGH:
+		return LPC_HICRC_TY4IRQX_HIGH;
+	case IRQ_TYPE_LEVEL_LOW:
+		return LPC_HICRC_TY4IRQX_LOW;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int aspeed_kcs_config_serirq(struct aspeed_kcs_bmc *priv, u32 id, u32 dt_type)
+{
+	unsigned int mask, val;
+
+	if (id > 15)
+		return -EINVAL;
+
+	switch (priv->kcs_bmc.channel) {
+	case 1:
+		mask = LPC_SIRQCR2_SEL1IRQX | LPC_SIRQCR2_ID1IRQX_MASK;
+		val = LPC_SIRQCR2_SEL1IRQX | (id << LPC_SIRQCR2_ID1IRQX_SHIFT);
+		regmap_update_bits(priv->map, LPC_SIRQCR2, mask, val);
+		break;
+	case 2:
+		mask = LPC_HICR5_SEL2IRQX | LPC_HICR5_ID2IRQX_MASK;
+		val = LPC_HICR5_SEL2IRQX | (id << LPC_HICR5_ID2IRQX_SHIFT);
+		regmap_update_bits(priv->map, LPC_HICR5, mask, val);
+		break;
+	case 3:
+		mask = LPC_HICR5_SEL3IRQX | LPC_HICR5_ID3IRQX_MASK;
+		val = LPC_HICR5_SEL3IRQX | (id << LPC_HICR5_ID3IRQX_SHIFT);
+		regmap_update_bits(priv->map, LPC_HICR5, mask, val);
+		break;
+	case 4:
+	{
+		unsigned int hw_type;
+
+		hw_type = aspeed_kcs_map_serirq_type(dt_type);
+		if (hw_type < 0)
+			return hw_type;
+
+		mask = LPC_HICRC_ID4IRQX_MASK | LPC_HICRC_TY4IRQX_MASK | LPC_HICRC_OBF4_AUTO_CLR;
+		val = (id << LPC_HICRC_ID4IRQX_SHIFT) | (hw_type << LPC_HICRC_TY4IRQX_SHIFT);
+		regmap_update_bits(priv->map, LPC_HICRC, mask, val);
+		break;
+	}
+	default:
+		dev_warn(priv->kcs_bmc.dev,
+			 "SerIRQ configuration not supported on KCS channel %d\n",
+			 priv->kcs_bmc.channel);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static void aspeed_kcs_enable_channel(struct kcs_bmc_device *kcs_bmc, bool enable)
 {
 	struct aspeed_kcs_bmc *priv = to_aspeed_kcs_bmc(kcs_bmc);
@@ -371,6 +484,8 @@ static int aspeed_kcs_probe(struct platform_device *pdev)
 	struct aspeed_kcs_bmc *priv;
 	struct device_node *np;
 	int rc, channel, addr;
+	bool have_serirq;
+	u32 serirq[2];
 
 	np = pdev->dev.of_node->parent;
 	if (!of_device_is_compatible(np, "aspeed,ast2400-lpc-v2") &&
@@ -379,6 +494,7 @@ static int aspeed_kcs_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "unsupported LPC device binding\n");
 		return -ENODEV;
 	}
+
 	ops = of_device_get_match_data(&pdev->dev);
 	if (!ops)
 		return -EINVAL;
@@ -391,6 +507,12 @@ static int aspeed_kcs_probe(struct platform_device *pdev)
 	if (addr < 0)
 		return addr;
 
+	rc = of_property_read_u32_array(pdev->dev.of_node, "aspeed,lpc-interrupts", serirq, 2);
+	if ((rc && rc != -EINVAL))
+		return -EINVAL;
+
+	have_serirq = !rc;
+
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
@@ -413,6 +535,9 @@ static int aspeed_kcs_probe(struct platform_device *pdev)
 
 	aspeed_kcs_set_address(kcs_bmc, addr);
 
+	if (have_serirq)
+		aspeed_kcs_config_serirq(priv, serirq[0], serirq[1]);
+
 	rc = aspeed_kcs_config_irq(kcs_bmc, pdev);
 	if (rc)
 		return rc;
@@ -482,4 +607,5 @@ module_platform_driver(ast_kcs_bmc_driver);
 
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Haiyue Wang <haiyue.wang@linux.intel.com>");
+MODULE_AUTHOR("Andrew Jeffery <andrew@aj.id.au>");
 MODULE_DESCRIPTION("Aspeed device interface to the KCS BMC device");
-- 
2.27.0

