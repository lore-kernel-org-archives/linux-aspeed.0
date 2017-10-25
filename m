From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 25 Oct 2017 15:34:17 +1030
Subject: [PATCH 2/2] gpio: aspeed: Add support for reset tolerance
In-Reply-To: <20171025050417.27992-1-andrew@aj.id.au>
References: <20171025050417.27992-1-andrew@aj.id.au>
Message-ID: <20171025050417.27992-3-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use the new pinconf parameter for reset tolerance to expose the
associated capability of the Aspeed GPIO controller.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/gpio/gpio-aspeed.c | 39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
index 00dc1c020198..856498925538 100644
--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -60,6 +60,7 @@ struct aspeed_gpio_bank {
 	uint16_t	val_regs;
 	uint16_t	irq_regs;
 	uint16_t	debounce_regs;
+	uint16_t	tolerance_regs;
 	const char	names[4][3];
 };
 
@@ -70,48 +71,56 @@ static const struct aspeed_gpio_bank aspeed_gpio_banks[] = {
 		.val_regs = 0x0000,
 		.irq_regs = 0x0008,
 		.debounce_regs = 0x0040,
+		.tolerance_regs = 0x001c,
 		.names = { "A", "B", "C", "D" },
 	},
 	{
 		.val_regs = 0x0020,
 		.irq_regs = 0x0028,
 		.debounce_regs = 0x0048,
+		.tolerance_regs = 0x003c,
 		.names = { "E", "F", "G", "H" },
 	},
 	{
 		.val_regs = 0x0070,
 		.irq_regs = 0x0098,
 		.debounce_regs = 0x00b0,
+		.tolerance_regs = 0x00ac,
 		.names = { "I", "J", "K", "L" },
 	},
 	{
 		.val_regs = 0x0078,
 		.irq_regs = 0x00e8,
 		.debounce_regs = 0x0100,
+		.tolerance_regs = 0x00fc,
 		.names = { "M", "N", "O", "P" },
 	},
 	{
 		.val_regs = 0x0080,
 		.irq_regs = 0x0118,
 		.debounce_regs = 0x0130,
+		.tolerance_regs = 0x012c,
 		.names = { "Q", "R", "S", "T" },
 	},
 	{
 		.val_regs = 0x0088,
 		.irq_regs = 0x0148,
 		.debounce_regs = 0x0160,
+		.tolerance_regs = 0x015c,
 		.names = { "U", "V", "W", "X" },
 	},
 	{
 		.val_regs = 0x01E0,
 		.irq_regs = 0x0178,
 		.debounce_regs = 0x0190,
+		.tolerance_regs = 0x018c,
 		.names = { "Y", "Z", "AA", "AB" },
 	},
 	{
-		.val_regs = 0x01E8,
-		.irq_regs = 0x01A8,
+		.val_regs = 0x01e8,
+		.irq_regs = 0x01a8,
 		.debounce_regs = 0x01c0,
+		.tolerance_regs = 0x01bc,
 		.names = { "AC", "", "", "" },
 	},
 };
@@ -534,6 +543,30 @@ static int aspeed_gpio_setup_irqs(struct aspeed_gpio *gpio,
 	return 0;
 }
 
+static int aspeed_gpio_reset_tolerance(struct gpio_chip *chip,
+					unsigned int offset, bool enable)
+{
+	struct aspeed_gpio *gpio = gpiochip_get_data(chip);
+	const struct aspeed_gpio_bank *bank;
+	unsigned long flags;
+	u32 val;
+
+	bank = to_bank(offset);
+
+	spin_lock_irqsave(&gpio->lock, flags);
+	val = readl(gpio->base + bank->tolerance_regs);
+
+	if (enable)
+		val |= GPIO_BIT(offset);
+	else
+		val &= ~GPIO_BIT(offset);
+
+	writel(val, gpio->base + bank->tolerance_regs);
+	spin_unlock_irqrestore(&gpio->lock, flags);
+
+	return 0;
+}
+
 static int aspeed_gpio_request(struct gpio_chip *chip, unsigned int offset)
 {
 	if (!have_gpio(gpiochip_get_data(chip), offset))
@@ -771,6 +804,8 @@ static int aspeed_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
 			param == PIN_CONFIG_DRIVE_OPEN_SOURCE)
 		/* Return -ENOTSUPP to trigger emulation, as per datasheet */
 		return -ENOTSUPP;
+	else if (param == PIN_CONFIG_RESET_TOLERANT)
+		return aspeed_gpio_reset_tolerance(chip, offset, arg);
 
 	return -ENOTSUPP;
 }
-- 
2.11.0

