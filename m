From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 10 May 2021 15:12:13 +0930
Subject: [PATCH v3 16/16] ipmi: kcs_bmc_aspeed: Optionally apply status address
In-Reply-To: <20210510054213.1610760-1-andrew@aj.id.au>
References: <20210510054213.1610760-1-andrew@aj.id.au>
Message-ID: <20210510054213.1610760-17-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Some Aspeed KCS devices can derive the status register address from the
address of the data register. As such, the address of the status
register can be implicit in the configuration if desired. On the other
hand, sometimes address schemes might be requested that are incompatible
with the default addressing scheme. Allow these requests where possible
if the devicetree specifies the status register address.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Reviewed-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
---
 drivers/char/ipmi/kcs_bmc_aspeed.c | 110 ++++++++++++++++++++---------
 1 file changed, 78 insertions(+), 32 deletions(-)

diff --git a/drivers/char/ipmi/kcs_bmc_aspeed.c b/drivers/char/ipmi/kcs_bmc_aspeed.c
index 558132b2b9f7..f6c58eb2883e 100644
--- a/drivers/char/ipmi/kcs_bmc_aspeed.c
+++ b/drivers/char/ipmi/kcs_bmc_aspeed.c
@@ -83,6 +83,8 @@
 #define LPC_STR2             0x040
 #define LPC_STR3             0x044
 #define LPC_HICRB            0x100
+#define     LPC_HICRB_EN16LADR2      BIT(5)
+#define     LPC_HICRB_EN16LADR1      BIT(4)
 #define     LPC_HICRB_IBFIE4         BIT(1)
 #define     LPC_HICRB_LPC4E          BIT(0)
 #define LPC_HICRC            0x104
@@ -96,6 +98,11 @@
 #define LPC_IDR4             0x114
 #define LPC_ODR4             0x118
 #define LPC_STR4             0x11C
+#define LPC_LSADR12	     0x120
+#define     LPC_LSADR12_LSADR2_MASK  GENMASK(31, 16)
+#define     LPC_LSADR12_LSADR2_SHIFT 16
+#define     LPC_LSADR12_LSADR1_MASK  GENMASK(15, 0)
+#define     LPC_LSADR12_LSADR1_SHIFT 0
 
 #define OBE_POLL_PERIOD	     (HZ / 2)
 
@@ -123,7 +130,7 @@ struct aspeed_kcs_bmc {
 
 struct aspeed_kcs_of_ops {
 	int (*get_channel)(struct platform_device *pdev);
-	int (*get_io_address)(struct platform_device *pdev);
+	int (*get_io_address)(struct platform_device *pdev, u32 addrs[2]);
 };
 
 static inline struct aspeed_kcs_bmc *to_aspeed_kcs_bmc(struct kcs_bmc_device *kcs_bmc)
@@ -217,38 +224,64 @@ static void aspeed_kcs_updateb(struct kcs_bmc_device *kcs_bmc, u32 reg, u8 mask,
  *     C. KCS4
  *        D / C : CA4h / CA5h
  */
-static void aspeed_kcs_set_address(struct kcs_bmc_device *kcs_bmc, u16 addr)
+static int aspeed_kcs_set_address(struct kcs_bmc_device *kcs_bmc, u32 addrs[2], int nr_addrs)
 {
 	struct aspeed_kcs_bmc *priv = to_aspeed_kcs_bmc(kcs_bmc);
 
-	switch (kcs_bmc->channel) {
+	if (WARN_ON(nr_addrs < 1 || nr_addrs > 2))
+		return -EINVAL;
+
+	switch (priv->kcs_bmc.channel) {
 	case 1:
-		regmap_update_bits(priv->map, LPC_HICR4,
-				LPC_HICR4_LADR12AS, 0);
-		regmap_write(priv->map, LPC_LADR12H, addr >> 8);
-		regmap_write(priv->map, LPC_LADR12L, addr & 0xFF);
+		regmap_update_bits(priv->map, LPC_HICR4, LPC_HICR4_LADR12AS, 0);
+		regmap_write(priv->map, LPC_LADR12H, addrs[0] >> 8);
+		regmap_write(priv->map, LPC_LADR12L, addrs[0] & 0xFF);
+		if (nr_addrs == 2) {
+			regmap_update_bits(priv->map, LPC_LSADR12, LPC_LSADR12_LSADR1_MASK,
+					   addrs[1] << LPC_LSADR12_LSADR1_SHIFT);
+
+			regmap_update_bits(priv->map, LPC_HICRB, LPC_HICRB_EN16LADR1,
+					   LPC_HICRB_EN16LADR1);
+		}
 		break;
 
 	case 2:
-		regmap_update_bits(priv->map, LPC_HICR4,
-				LPC_HICR4_LADR12AS, LPC_HICR4_LADR12AS);
-		regmap_write(priv->map, LPC_LADR12H, addr >> 8);
-		regmap_write(priv->map, LPC_LADR12L, addr & 0xFF);
+		regmap_update_bits(priv->map, LPC_HICR4, LPC_HICR4_LADR12AS, LPC_HICR4_LADR12AS);
+		regmap_write(priv->map, LPC_LADR12H, addrs[0] >> 8);
+		regmap_write(priv->map, LPC_LADR12L, addrs[0] & 0xFF);
+		if (nr_addrs == 2) {
+			regmap_update_bits(priv->map, LPC_LSADR12, LPC_LSADR12_LSADR2_MASK,
+					   addrs[1] << LPC_LSADR12_LSADR2_SHIFT);
+
+			regmap_update_bits(priv->map, LPC_HICRB, LPC_HICRB_EN16LADR2,
+					   LPC_HICRB_EN16LADR2);
+		}
 		break;
 
 	case 3:
-		regmap_write(priv->map, LPC_LADR3H, addr >> 8);
-		regmap_write(priv->map, LPC_LADR3L, addr & 0xFF);
+		if (nr_addrs == 2) {
+			dev_err(priv->kcs_bmc.dev,
+				"Channel 3 only supports inferred status IO address\n");
+			return -EINVAL;
+		}
+
+		regmap_write(priv->map, LPC_LADR3H, addrs[0] >> 8);
+		regmap_write(priv->map, LPC_LADR3L, addrs[0] & 0xFF);
 		break;
 
 	case 4:
-		regmap_write(priv->map, LPC_LADR4, ((addr + 1) << 16) |
-			addr);
+		if (nr_addrs == 1)
+			regmap_write(priv->map, LPC_LADR4, ((addrs[0] + 1) << 16) | addrs[0]);
+		else
+			regmap_write(priv->map, LPC_LADR4, (addrs[1] << 16) | addrs[0]);
+
 		break;
 
 	default:
-		break;
+		return -EINVAL;
 	}
+
+	return 0;
 }
 
 static inline int aspeed_kcs_map_serirq_type(u32 dt_type)
@@ -457,18 +490,18 @@ static int aspeed_kcs_of_v1_get_channel(struct platform_device *pdev)
 	return channel;
 }
 
-static int aspeed_kcs_of_v1_get_io_address(struct platform_device *pdev)
+static int
+aspeed_kcs_of_v1_get_io_address(struct platform_device *pdev, u32 addrs[2])
 {
-	u32 slave;
 	int rc;
 
-	rc = of_property_read_u32(pdev->dev.of_node, "kcs_addr", &slave);
-	if (rc || slave > 0xffff) {
+	rc = of_property_read_u32(pdev->dev.of_node, "kcs_addr", addrs);
+	if (rc || addrs[0] > 0xffff) {
 		dev_err(&pdev->dev, "no valid 'kcs_addr' configured\n");
 		return -EINVAL;
 	}
 
-	return slave;
+	return 1;
 }
 
 static int aspeed_kcs_of_v2_get_channel(struct platform_device *pdev)
@@ -504,16 +537,24 @@ static int aspeed_kcs_of_v2_get_channel(struct platform_device *pdev)
 	return -EINVAL;
 }
 
-static int aspeed_kcs_of_v2_get_io_address(struct platform_device *pdev)
+static int
+aspeed_kcs_of_v2_get_io_address(struct platform_device *pdev, u32 addrs[2])
 {
-	uint32_t slave;
 	int rc;
 
-	rc = of_property_read_u32(pdev->dev.of_node, "aspeed,lpc-io-reg", &slave);
-	if (rc || slave > 0xffff)
+	rc = of_property_read_variable_u32_array(pdev->dev.of_node,
+						 "aspeed,lpc-io-reg",
+						 addrs, 1, 2);
+	if (rc < 0)
+		return rc;
+
+	if (addrs[0] > 0xffff)
+		return -EINVAL;
+
+	if (rc == 2 && addrs[1] > 0xffff)
 		return -EINVAL;
 
-	return slave;
+	return rc;
 }
 
 static int aspeed_kcs_probe(struct platform_device *pdev)
@@ -522,9 +563,11 @@ static int aspeed_kcs_probe(struct platform_device *pdev)
 	struct kcs_bmc_device *kcs_bmc;
 	struct aspeed_kcs_bmc *priv;
 	struct device_node *np;
-	int rc, channel, addr;
 	bool have_upstream_irq;
 	u32 upstream_irq[2];
+	int rc, channel;
+	int nr_addrs;
+	u32 addrs[2];
 
 	np = pdev->dev.of_node->parent;
 	if (!of_device_is_compatible(np, "aspeed,ast2400-lpc-v2") &&
@@ -542,9 +585,9 @@ static int aspeed_kcs_probe(struct platform_device *pdev)
 	if (channel < 0)
 		return channel;
 
-	addr = ops->get_io_address(pdev);
-	if (addr < 0)
-		return addr;
+	nr_addrs = ops->get_io_address(pdev, addrs);
+	if (nr_addrs < 0)
+		return nr_addrs;
 
 	np = pdev->dev.of_node;
 	rc = of_property_read_u32_array(np, "aspeed,lpc-interrupts", upstream_irq, 2);
@@ -573,7 +616,9 @@ static int aspeed_kcs_probe(struct platform_device *pdev)
 	priv->obe.remove = false;
 	timer_setup(&priv->obe.timer, aspeed_kcs_check_obe, 0);
 
-	aspeed_kcs_set_address(kcs_bmc, addr);
+	rc = aspeed_kcs_set_address(kcs_bmc, addrs, nr_addrs);
+	if (rc)
+		return rc;
 
 	/* Host to BMC IRQ */
 	rc = aspeed_kcs_config_downstream_irq(kcs_bmc, pdev);
@@ -596,7 +641,8 @@ static int aspeed_kcs_probe(struct platform_device *pdev)
 
 	kcs_bmc_add_device(&priv->kcs_bmc);
 
-	dev_info(&pdev->dev, "Initialised channel %d at 0x%x\n", kcs_bmc->channel, addr);
+	dev_info(&pdev->dev, "Initialised channel %d at 0x%x\n",
+			kcs_bmc->channel, addrs[0]);
 
 	return 0;
 }
-- 
2.27.0

