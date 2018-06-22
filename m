From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 22 Jun 2018 12:04:47 +1000
Subject: [PATCH v3 3/4] gpio: aspeed: Add command source registers
In-Reply-To: <20180622020448.6102-1-benh@kernel.crashing.org>
References: <20180622020448.6102-1-benh@kernel.crashing.org>
Message-ID: <20180622020448.6102-4-benh@kernel.crashing.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This adds the definitions for the command source registers
and a helper to set them.

Those registers allow to control which bus master on the
SoC is allowed to modify a given bank of GPIOs and will
be used by subsequent patches.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/gpio/gpio-aspeed.c | 54 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
index a5ded50c6db0..b3968f66b1d2 100644
--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -66,6 +66,7 @@ struct aspeed_gpio_bank {
 	uint16_t	irq_regs;
 	uint16_t	debounce_regs;
 	uint16_t	tolerance_regs;
+	uint16_t	cmdsrc_regs;
 	const char	names[4][3];
 };
 
@@ -89,6 +90,7 @@ static const struct aspeed_gpio_bank aspeed_gpio_banks[] = {
 		.irq_regs = 0x0008,
 		.debounce_regs = 0x0040,
 		.tolerance_regs = 0x001c,
+		.cmdsrc_regs = 0x0060,
 		.names = { "A", "B", "C", "D" },
 	},
 	{
@@ -97,6 +99,7 @@ static const struct aspeed_gpio_bank aspeed_gpio_banks[] = {
 		.irq_regs = 0x0028,
 		.debounce_regs = 0x0048,
 		.tolerance_regs = 0x003c,
+		.cmdsrc_regs = 0x0068,
 		.names = { "E", "F", "G", "H" },
 	},
 	{
@@ -105,6 +108,7 @@ static const struct aspeed_gpio_bank aspeed_gpio_banks[] = {
 		.irq_regs = 0x0098,
 		.debounce_regs = 0x00b0,
 		.tolerance_regs = 0x00ac,
+		.cmdsrc_regs = 0x0090,
 		.names = { "I", "J", "K", "L" },
 	},
 	{
@@ -113,6 +117,7 @@ static const struct aspeed_gpio_bank aspeed_gpio_banks[] = {
 		.irq_regs = 0x00e8,
 		.debounce_regs = 0x0100,
 		.tolerance_regs = 0x00fc,
+		.cmdsrc_regs = 0x00e0,
 		.names = { "M", "N", "O", "P" },
 	},
 	{
@@ -121,6 +126,7 @@ static const struct aspeed_gpio_bank aspeed_gpio_banks[] = {
 		.irq_regs = 0x0118,
 		.debounce_regs = 0x0130,
 		.tolerance_regs = 0x012c,
+		.cmdsrc_regs = 0x0110,
 		.names = { "Q", "R", "S", "T" },
 	},
 	{
@@ -129,6 +135,7 @@ static const struct aspeed_gpio_bank aspeed_gpio_banks[] = {
 		.irq_regs = 0x0148,
 		.debounce_regs = 0x0160,
 		.tolerance_regs = 0x015c,
+		.cmdsrc_regs = 0x0140,
 		.names = { "U", "V", "W", "X" },
 	},
 	{
@@ -137,6 +144,7 @@ static const struct aspeed_gpio_bank aspeed_gpio_banks[] = {
 		.irq_regs = 0x0178,
 		.debounce_regs = 0x0190,
 		.tolerance_regs = 0x018c,
+		.cmdsrc_regs = 0x0170,
 		.names = { "Y", "Z", "AA", "AB" },
 	},
 	{
@@ -145,6 +153,7 @@ static const struct aspeed_gpio_bank aspeed_gpio_banks[] = {
 		.irq_regs = 0x01a8,
 		.debounce_regs = 0x01c0,
 		.tolerance_regs = 0x01bc,
+		.cmdsrc_regs = 0x01a0,
 		.names = { "AC", "", "", "" },
 	},
 };
@@ -161,6 +170,8 @@ enum aspeed_gpio_reg {
 	reg_debounce_sel1,
 	reg_debounce_sel2,
 	reg_tolerance,
+	reg_cmdsrc0,
+	reg_cmdsrc1,
 };
 
 #define GPIO_VAL_VALUE	0x00
@@ -175,6 +186,13 @@ enum aspeed_gpio_reg {
 #define GPIO_DEBOUNCE_SEL1 0x00
 #define GPIO_DEBOUNCE_SEL2 0x04
 
+#define GPIO_CMDSRC_0	0x00
+#define GPIO_CMDSRC_1	0x04
+#define  GPIO_CMDSRC_ARM		0
+#define  GPIO_CMDSRC_LPC		1
+#define  GPIO_CMDSRC_COLDFIRE		2
+#define  GPIO_CMDSRC_RESERVED		3
+
 /* This will be resolved at compile time */
 static inline void __iomem *bank_reg(struct aspeed_gpio *gpio,
 				     const struct aspeed_gpio_bank *bank,
@@ -203,6 +221,10 @@ static inline void __iomem *bank_reg(struct aspeed_gpio *gpio,
 		return gpio->base + bank->debounce_regs + GPIO_DEBOUNCE_SEL2;
 	case reg_tolerance:
 		return gpio->base + bank->tolerance_regs;
+	case reg_cmdsrc0:
+		return gpio->base + bank->cmdsrc_regs + GPIO_CMDSRC_0;
+	case reg_cmdsrc1:
+		return gpio->base + bank->cmdsrc_regs + GPIO_CMDSRC_1;
 	}
 	BUG_ON(1);
 }
@@ -269,6 +291,38 @@ static inline bool have_output(struct aspeed_gpio *gpio, unsigned int offset)
 	return !props || (props->output & GPIO_BIT(offset));
 }
 
+static void aspeed_gpio_change_cmd_source(struct aspeed_gpio *gpio,
+					  const struct aspeed_gpio_bank *bank,
+					  int bindex, int cmdsrc)
+{
+	void __iomem *c0 = bank_reg(gpio, bank, reg_cmdsrc0);
+	void __iomem *c1 = bank_reg(gpio, bank, reg_cmdsrc1);
+	u32 bit, reg;
+
+	/*
+	 * Each register controls 4 banks, so take the bottom 2
+	 * bits of the bank index, and use them to select the
+	 * right control bit (0, 8, 16 or 24).
+	 */
+	bit = BIT((bindex & 3) << 3);
+
+	/* Source 1 first to avoid illegal 11 combination */
+	reg = ioread32(c1);
+	if (cmdsrc & 2)
+		reg |= bit;
+	else
+		reg &= ~bit;
+	iowrite32(reg, c1);
+
+	/* Then Source 0 */
+	reg = ioread32(c0);
+	if (cmdsrc & 1)
+		reg |= bit;
+	else
+		reg &= ~bit;
+	iowrite32(reg, c0);
+}
+
 static int aspeed_gpio_get(struct gpio_chip *gc, unsigned int offset)
 {
 	struct aspeed_gpio *gpio = gpiochip_get_data(gc);
-- 
2.17.1

