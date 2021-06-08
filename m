From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue, 08 Jun 2021 10:25:04 +0930
Subject: =?UTF-8?Q?Re:_[PATCH_v3_14/16]_ipmi:_kcs=5Fbmc=5Faspeed:_Implement_KCS_S?=
 =?UTF-8?Q?erIRQ_configuration?=
In-Reply-To: <df0d31e9-c4e1-4cf0-b800-c5dadfb43420@www.fastmail.com>
References: <20210510054213.1610760-1-andrew@aj.id.au>
 <20210510054213.1610760-15-andrew@aj.id.au> <YKdfeJJM/4LYFKe4@packtop>
 <df0d31e9-c4e1-4cf0-b800-c5dadfb43420@www.fastmail.com>
Message-ID: <e5487cab-2ca0-46c2-a644-46d8b3070eac@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Tue, 8 Jun 2021, at 10:11, Andrew Jeffery wrote:
> 
> 
> On Fri, 21 May 2021, at 16:51, Zev Weiss wrote:
> > On Mon, May 10, 2021 at 12:42:11AM CDT, Andrew Jeffery wrote:
> > >Apply the SerIRQ ID and level/sense behaviours from the devicetree if
> > >provided.
> > >
> > >Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > >---
> > > drivers/char/ipmi/kcs_bmc_aspeed.c | 182 ++++++++++++++++++++++++++++-
> > > 1 file changed, 180 insertions(+), 2 deletions(-)
> > >
> > >diff --git a/drivers/char/ipmi/kcs_bmc_aspeed.c b/drivers/char/ipmi/kcs_bmc_aspeed.c
> > >index 8a0b1e18e945..9b81806b4dcb 100644
> > >--- a/drivers/char/ipmi/kcs_bmc_aspeed.c
> > >+++ b/drivers/char/ipmi/kcs_bmc_aspeed.c
> > >@@ -9,6 +9,7 @@
> > > #include <linux/errno.h>
> > > #include <linux/interrupt.h>
> > > #include <linux/io.h>
> > >+#include <linux/irq.h>
> > > #include <linux/mfd/syscon.h>
> > > #include <linux/module.h>
> > > #include <linux/of.h>
> > >@@ -28,6 +29,22 @@
> > >
> > > #define KCS_CHANNEL_MAX     4
> > >
> > >+/*
> > >+ * Field class descriptions
> > >+ *
> > >+ * LPCyE	Enable LPC channel y
> > >+ * IBFIEy	Input Buffer Full IRQ Enable for LPC channel y
> > >+ * IRQxEy	Assert SerIRQ x for LPC channel y (Deprecated, use IDyIRQX, IRQXEy)
> > >+ * IDyIRQX	Use the specified 4-bit SerIRQ for LPC channel y
> > >+ * SELyIRQX	SerIRQ polarity for LPC channel y (low: 0, high: 1)
> > >+ * IRQXEy	Assert the SerIRQ specified in IDyIRQX for LPC channel y
> > >+ */
> > >+
> > >+#define LPC_TYIRQX_LOW       0b00
> > >+#define LPC_TYIRQX_HIGH      0b01
> > >+#define LPC_TYIRQX_RSVD      0b10
> > >+#define LPC_TYIRQX_RISING    0b11
> > >+
> > > #define LPC_HICR0            0x000
> > > #define     LPC_HICR0_LPC3E          BIT(7)
> > > #define     LPC_HICR0_LPC2E          BIT(6)
> > >@@ -39,6 +56,19 @@
> > > #define LPC_HICR4            0x010
> > > #define     LPC_HICR4_LADR12AS       BIT(7)
> > > #define     LPC_HICR4_KCSENBL        BIT(2)
> > >+#define LPC_SIRQCR0	     0x070
> > >+/* IRQ{12,1}E1 are deprecated as of AST2600 A3 but necessary for prior chips */
> > >+#define     LPC_SIRQCR0_IRQ12E1	     BIT(1)
> > >+#define     LPC_SIRQCR0_IRQ1E1	     BIT(0)
> > >+#define LPC_HICR5	     0x080
> > >+#define     LPC_HICR5_ID3IRQX_MASK   GENMASK(23, 20)
> > >+#define     LPC_HICR5_ID3IRQX_SHIFT  20
> > >+#define     LPC_HICR5_ID2IRQX_MASK   GENMASK(19, 16)
> > >+#define     LPC_HICR5_ID2IRQX_SHIFT  16
> > >+#define     LPC_HICR5_SEL3IRQX       BIT(15)
> > >+#define     LPC_HICR5_IRQXE3         BIT(14)
> > >+#define     LPC_HICR5_SEL2IRQX       BIT(13)
> > >+#define     LPC_HICR5_IRQXE2         BIT(12)
> > > #define LPC_LADR3H           0x014
> > > #define LPC_LADR3L           0x018
> > > #define LPC_LADR12H          0x01C
> > >@@ -55,6 +85,13 @@
> > > #define LPC_HICRB            0x100
> > > #define     LPC_HICRB_IBFIF4         BIT(1)
> > > #define     LPC_HICRB_LPC4E          BIT(0)
> > >+#define LPC_HICRC            0x104
> > >+#define     LPC_HICRC_ID4IRQX_MASK   GENMASK(7, 4)
> > >+#define     LPC_HICRC_ID4IRQX_SHIFT  4
> > >+#define     LPC_HICRC_TY4IRQX_MASK   GENMASK(3, 2)
> > >+#define     LPC_HICRC_TY4IRQX_SHIFT  2
> > >+#define     LPC_HICRC_OBF4_AUTO_CLR  BIT(1)
> > >+#define     LPC_HICRC_IRQXE4         BIT(0)
> > > #define LPC_LADR4            0x110
> > > #define LPC_IDR4             0x114
> > > #define LPC_ODR4             0x118
> > >@@ -62,11 +99,21 @@
> > >
> > > #define OBE_POLL_PERIOD	     (HZ / 2)
> > >
> > >+enum aspeed_kcs_irq_mode {
> > >+	aspeed_kcs_irq_none,
> > >+	aspeed_kcs_irq_serirq,
> > >+};
> > >+
> > > struct aspeed_kcs_bmc {
> > > 	struct kcs_bmc_device kcs_bmc;
> > >
> > > 	struct regmap *map;
> > >
> > >+	struct {
> > >+		enum aspeed_kcs_irq_mode mode;
> > >+		int id;
> > >+	} upstream_irq;
> > >+
> > > 	struct {
> > > 		spinlock_t lock;
> > > 		bool remove;
> > >@@ -103,6 +150,49 @@ static void aspeed_kcs_outb(struct kcs_bmc_device *kcs_bmc, u32 reg, u8 data)
> > >
> > > 	rc = regmap_write(priv->map, reg, data);
> > > 	WARN(rc != 0, "regmap_write() failed: %d\n", rc);
> > >+
> > >+	/* Trigger the upstream IRQ on ODR writes, if enabled */
> > >+
> > >+	switch (reg) {
> > >+	case LPC_ODR1:
> > >+	case LPC_ODR2:
> > >+	case LPC_ODR3:
> > >+	case LPC_ODR4:
> > >+		break;
> > >+	default:
> > >+		return;
> > >+	}
> > >+
> > >+	if (priv->upstream_irq.mode != aspeed_kcs_irq_serirq)
> > >+		return;
> > >+
> > >+	switch (kcs_bmc->channel) {
> > >+	case 1:
> > >+		switch (priv->upstream_irq.id) {
> > >+		case 12:
> > >+			regmap_update_bits(priv->map, LPC_SIRQCR0, LPC_SIRQCR0_IRQ12E1,
> > >+					   LPC_SIRQCR0_IRQ12E1);
> > >+			break;
> > >+		case 1:
> > >+			regmap_update_bits(priv->map, LPC_SIRQCR0, LPC_SIRQCR0_IRQ1E1,
> > >+					   LPC_SIRQCR0_IRQ1E1);
> > >+			break;

This is the code supporting the comment below.

> > >+		default:
> > >+			break;
> > >+		}
> > >+		break;
> > >+	case 2:
> > >+		regmap_update_bits(priv->map, LPC_HICR5, LPC_HICR5_IRQXE2, LPC_HICR5_IRQXE2);
> > >+		break;
> > >+	case 3:
> > >+		regmap_update_bits(priv->map, LPC_HICR5, LPC_HICR5_IRQXE3, LPC_HICR5_IRQXE3);
> > >+		break;
> > >+	case 4:
> > >+		regmap_update_bits(priv->map, LPC_HICRC, LPC_HICRC_IRQXE4, LPC_HICRC_IRQXE4);
> > >+		break;
> > >+	default:
> > >+		break;
> > >+	}
> > > }
> > >
> > > static void aspeed_kcs_updateb(struct kcs_bmc_device *kcs_bmc, u32 reg, u8 mask, u8 val)
> > >@@ -161,6 +251,73 @@ static void aspeed_kcs_set_address(struct kcs_bmc_device *kcs_bmc, u16 addr)
> > > 	}
> > > }
> > >
> > >+static inline int aspeed_kcs_map_serirq_type(u32 dt_type)
> > >+{
> > >+	switch (dt_type) {
> > >+	case IRQ_TYPE_EDGE_RISING:
> > >+		return LPC_TYIRQX_RISING;
> > >+	case IRQ_TYPE_LEVEL_HIGH:
> > >+		return LPC_TYIRQX_HIGH;
> > >+	case IRQ_TYPE_LEVEL_LOW:
> > >+		return LPC_TYIRQX_LOW;
> > >+	default:
> > >+		return -EINVAL;
> > >+	}
> > >+}
> > >+
> > >+static int aspeed_kcs_config_upstream_irq(struct aspeed_kcs_bmc *priv, u32 id, u32 dt_type)
> > >+{
> > >+	unsigned int mask, val, hw_type;
> > >+
> > >+	if (id > 15)
> > >+		return -EINVAL;
> > >+
> > >+	hw_type = aspeed_kcs_map_serirq_type(dt_type);
> > >+	if (hw_type < 0)
> > >+		return hw_type;
> > >+
> > >+	priv->upstream_irq.mode = aspeed_kcs_irq_serirq;
> > >+	priv->upstream_irq.id = id;
> > >+
> > >+	switch (priv->kcs_bmc.channel) {
> > >+	case 1:
> > >+		/* Needs IRQxE1 rather than (ID1IRQX, SEL1IRQX, IRQXE1) before AST2600 A3 */
> > 
> > I'm struggling a bit with understanding this comment, and relating it to
> > the code -- it sounds like "we need to do things one way on A3 and
> > later, and another way on pre-A3", but then...we just break without
> > doing anything at all either way.  Can you clarify any further?
> 
> Hah! You're struggling because it doesn't make any sense, the code's 
> gone missing :/ I'll fix that up.

Wait, no, this is fine. I just refreshed my memory on what's happening here. This function just configures the SerIRQ - in the case of channel 1 no configuration is necessary as it only has a fixed set of IRQs that we can associate with it. To enable one of them, we just set the appropriate bit in aspeed_kcs_outb() above.

Andrew
