From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Fri, 30 Aug 2024 11:40:47 +0800
Subject: [PATCH v2 4/4] gpio: aspeed: Support G7 Aspeed gpio controller
In-Reply-To: <20240830034047.2251482-1-billy_tsai@aspeedtech.com>
References: <20240830034047.2251482-1-billy_tsai@aspeedtech.com>
Message-ID: <20240830034047.2251482-5-billy_tsai@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

In the 7th generation of the SoC from Aspeed, the control logic of the
GPIO controller has been updated to support per-pin control. Each pin now
has its own 32-bit register, allowing for individual control of the pin?s
value, direction, interrupt type, and other settings. The permission for
coprocessor access is supported by the hardware but hasn?t been
implemented in the current patch.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/gpio/gpio-aspeed.c | 116 +++++++++++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
index 74c4e80958bf..24f9c7312351 100644
--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -30,6 +30,23 @@
 #include <linux/gpio/consumer.h>
 #include "gpiolib.h"
 
+#define GPIO_G7_IRQ_STS_BASE 0x100
+#define GPIO_G7_IRQ_STS_OFFSET(x) (GPIO_G7_IRQ_STS_BASE + (x) * 0x4)
+#define GPIO_G7_CTRL_REG_BASE 0x180
+#define GPIO_G7_CTRL_REG_OFFSET(x) (GPIO_G7_CTRL_REG_BASE + (x) * 0x4)
+#define GPIO_G7_CTRL_OUT_DATA BIT(0)
+#define GPIO_G7_CTRL_DIR BIT(1)
+#define GPIO_G7_CTRL_IRQ_EN BIT(2)
+#define GPIO_G7_CTRL_IRQ_TYPE0 BIT(3)
+#define GPIO_G7_CTRL_IRQ_TYPE1 BIT(4)
+#define GPIO_G7_CTRL_IRQ_TYPE2 BIT(5)
+#define GPIO_G7_CTRL_RST_TOLERANCE BIT(6)
+#define GPIO_G7_CTRL_DEBOUNCE_SEL2 BIT(7)
+#define GPIO_G7_CTRL_DEBOUNCE_SEL1 BIT(8)
+#define GPIO_G7_CTRL_INPUT_MASK BIT(9)
+#define GPIO_G7_CTRL_IRQ_STS BIT(12)
+#define GPIO_G7_CTRL_IN_DATA BIT(13)
+
 struct aspeed_bank_props {
 	unsigned int bank;
 	u32 input;
@@ -95,6 +112,7 @@ struct aspeed_gpio_bank {
  */
 
 static const int debounce_timers[4] = { 0x00, 0x50, 0x54, 0x58 };
+static const int g7_debounce_timers[4] = { 0x00, 0x04, 0x00, 0x08 };
 
 static const struct aspeed_gpio_copro_ops *copro_ops;
 static void *copro_data;
@@ -246,6 +264,39 @@ static inline void __iomem *bank_reg(struct aspeed_gpio *gpio,
 	BUG();
 }
 
+static inline u32 reg_mask(const enum aspeed_gpio_reg reg)
+{
+	switch (reg) {
+	case reg_val:
+		return GPIO_G7_CTRL_OUT_DATA;
+	case reg_dir:
+		return GPIO_G7_CTRL_DIR;
+	case reg_irq_enable:
+		return GPIO_G7_CTRL_IRQ_EN;
+	case reg_irq_type0:
+		return GPIO_G7_CTRL_IRQ_TYPE0;
+	case reg_irq_type1:
+		return GPIO_G7_CTRL_IRQ_TYPE1;
+	case reg_irq_type2:
+		return GPIO_G7_CTRL_IRQ_TYPE2;
+	case reg_tolerance:
+		return GPIO_G7_CTRL_RST_TOLERANCE;
+	case reg_debounce_sel1:
+		return GPIO_G7_CTRL_DEBOUNCE_SEL1;
+	case reg_debounce_sel2:
+		return GPIO_G7_CTRL_DEBOUNCE_SEL2;
+	case reg_rdata:
+		return GPIO_G7_CTRL_OUT_DATA;
+	case reg_irq_status:
+		return GPIO_G7_CTRL_IRQ_STS;
+	case reg_cmdsrc0:
+	case reg_cmdsrc1:
+	default:
+		WARN_ON_ONCE(1);
+		return 0;
+	}
+}
+
 #define GPIO_BANK(x)	((x) >> 5)
 #define GPIO_OFFSET(x)	((x) & 0x1f)
 #define GPIO_BIT(x)	BIT(GPIO_OFFSET(x))
@@ -930,6 +981,9 @@ int aspeed_gpio_copro_grab_gpio(struct gpio_desc *desc,
 	const struct aspeed_gpio_bank *bank = to_bank(offset);
 	unsigned long flags;
 
+	if (gpio->config->version == 7)
+		return -EOPNOTSUPP;
+
 	if (!gpio->cf_copro_bankmap)
 		gpio->cf_copro_bankmap = kzalloc(gpio->chip.ngpio >> 3, GFP_KERNEL);
 	if (!gpio->cf_copro_bankmap)
@@ -975,6 +1029,9 @@ int aspeed_gpio_copro_release_gpio(struct gpio_desc *desc)
 	int rc = 0, bindex, offset = gpio_chip_hwgpio(desc);
 	unsigned long flags;
 
+	if (gpio->config->version == 7)
+		return -EOPNOTSUPP;
+
 	if (!gpio->cf_copro_bankmap)
 		return -ENXIO;
 
@@ -1069,10 +1126,27 @@ static const struct aspeed_gpio_config ast2600_config =
 	 */
 	{ .nr_gpios = 208, .props = ast2600_bank_props, .version = 4};
 
+static const struct aspeed_bank_props ast2700_bank_props[] = {
+	/*     input	  output   */
+	{ 1, 0x0fffffff, 0x0fffffff }, /* E/F/G/H, 4-GPIO hole */
+	{ 6, 0x00ffffff, 0x00ffffff }, /* Y/Z/AA */
+	{},
+};
+
+static const struct aspeed_gpio_config ast2700_config =
+	/*
+	 * ast2700 has two controllers one with 212 GPIOs and one with 16 GPIOs.
+	 * 216 for simplicity, actual number is 212 (4-GPIO hole in GPIOH)
+	 * We expect ngpio being set in the device tree and this is a fallback
+	 * option.
+	 */
+	{ .nr_gpios = 216, .props = ast2700_bank_props, .version = 7 };
+
 static const struct of_device_id aspeed_gpio_of_table[] = {
 	{ .compatible = "aspeed,ast2400-gpio", .data = &ast2400_config, },
 	{ .compatible = "aspeed,ast2500-gpio", .data = &ast2500_config, },
 	{ .compatible = "aspeed,ast2600-gpio", .data = &ast2600_config, },
+	{ .compatible = "aspeed,ast2700-gpio", .data = &ast2700_config, },
 	{}
 };
 MODULE_DEVICE_TABLE(of, aspeed_gpio_of_table);
@@ -1111,6 +1185,40 @@ struct aspeed_gpio_llops aspeed_g4_llops = {
 	.reg_bits_read = aspeed_g4_reg_bits_read,
 };
 
+static void aspeed_g7_reg_bits_set(struct aspeed_gpio *gpio, unsigned int offset,
+				   const enum aspeed_gpio_reg reg, u32 val)
+{
+	u32 mask = reg_mask(reg);
+	void __iomem *addr = gpio->base + GPIO_G7_CTRL_REG_OFFSET(offset);
+	u32 write_val = (ioread32(addr) & ~(mask)) | (((val) << (ffs(mask) - 1)) & (mask));
+
+	iowrite32(write_val, addr);
+}
+
+static u32 aspeed_g7_reg_bits_read(struct aspeed_gpio *gpio, unsigned int offset,
+				   const enum aspeed_gpio_reg reg)
+{
+	u32 mask = reg_mask(reg);
+	void __iomem *addr;
+
+	if (reg == reg_irq_status) {
+		addr = gpio->base + GPIO_G7_IRQ_STS_OFFSET(offset);
+		return ioread32(addr);
+	}
+	addr = gpio->base + GPIO_G7_CTRL_REG_OFFSET(offset);
+	if (reg == reg_val)
+		mask = GPIO_G7_CTRL_IN_DATA;
+
+	return (((ioread32(addr)) & (mask)) >> (ffs(mask) - 1));
+}
+
+struct aspeed_gpio_llops aspeed_g7_llops = {
+	.copro_request = NULL,
+	.copro_release = NULL,
+	.reg_bits_set = aspeed_g7_reg_bits_set,
+	.reg_bits_read = aspeed_g7_reg_bits_read,
+};
+
 static int __init aspeed_gpio_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *gpio_id;
@@ -1152,6 +1260,14 @@ static int __init aspeed_gpio_probe(struct platform_device *pdev)
 			gpio->debounce_timers_array = debounce_timers;
 			gpio->debounce_timers_num = ARRAY_SIZE(debounce_timers);
 		}
+	} else if (gpio->config->version == 7) {
+		if (!gpio->llops)
+			gpio->llops = &aspeed_g7_llops;
+
+		if (!gpio->debounce_timers_array) {
+			gpio->debounce_timers_array = g7_debounce_timers;
+			gpio->debounce_timers_num = ARRAY_SIZE(g7_debounce_timers);
+		}
 	} else {
 		return -EOPNOTSUPP;
 	}
-- 
2.25.1

