From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 22 Jun 2018 12:04:48 +1000
Subject: [PATCH v3 4/4] gpio: aspeed: Add interfaces for co-processor to grab
 GPIOs
In-Reply-To: <20180622020448.6102-1-benh@kernel.crashing.org>
References: <20180622020448.6102-1-benh@kernel.crashing.org>
Message-ID: <20180622020448.6102-5-benh@kernel.crashing.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On the Aspeed chip, the GPIOs can be under control of the ARM
chip or of the ColdFire coprocessor. (There's a third command
source, the LPC bus, which we don't use or support yet).

The control of which master is allowed to modify a given
GPIO is per-bank (8 GPIOs).

Unfortunately, systems already exist for which we want to
use GPIOs of both sources in the same bank.

This provides an API exported by the gpio-aspeed driver
that an aspeed coprocessor driver can use to "grab" some
GPIOs for use by the coprocessor, and allow the coprocessor
driver to provide callbacks for arbitrating access.

Once at least one GPIO of a given bank has been "grabbed"
by the coprocessor, the entire bank is marked as being
under coprocessor control. It's command source is switched
to the coprocessor.

If the ARM then tries to write to a GPIO in such a marked bank,
the provided callbacks are used to request access from the
coprocessor driver, which is responsible to doing whatever
is necessary to "pause" the coprocessor or prevent it from
trying to use the GPIOs while the ARM is doing its accesses.

During that time, the command source for the bank is temporarily
switched back to the ARM.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/gpio/gpio-aspeed.c  | 235 +++++++++++++++++++++++++++++++++---
 include/linux/gpio/aspeed.h |  14 +++
 2 files changed, 229 insertions(+), 20 deletions(-)
 create mode 100644 include/linux/gpio/aspeed.h

diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
index b3968f66b1d2..6660c1889f8b 100644
--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -12,6 +12,8 @@
 #include <asm/div64.h>
 #include <linux/clk.h>
 #include <linux/gpio/driver.h>
+#include <linux/gpio/aspeed.h>
+#include <linux/gpio/consumer.h>
 #include <linux/hashtable.h>
 #include <linux/init.h>
 #include <linux/io.h>
@@ -22,6 +24,8 @@
 #include <linux/spinlock.h>
 #include <linux/string.h>
 
+#include "gpiolib.h"
+
 struct aspeed_bank_props {
 	unsigned int bank;
 	u32 input;
@@ -56,6 +60,7 @@ struct aspeed_gpio {
 	struct clk *clk;
 
 	u32 *dcache;
+	u8 *cf_copro_bankmap;
 };
 
 struct aspeed_gpio_bank {
@@ -83,6 +88,9 @@ struct aspeed_gpio_bank {
 
 static const int debounce_timers[4] = { 0x00, 0x50, 0x54, 0x58 };
 
+static const struct aspeed_gpio_copro_ops *copro_ops;
+static void *copro_data;
+
 static const struct aspeed_gpio_bank aspeed_gpio_banks[] = {
 	{
 		.val_regs = 0x0000,
@@ -323,6 +331,50 @@ static void aspeed_gpio_change_cmd_source(struct aspeed_gpio *gpio,
 	iowrite32(reg, c0);
 }
 
+static bool aspeed_gpio_copro_request(struct aspeed_gpio *gpio,
+				      unsigned int offset)
+{
+	const struct aspeed_gpio_bank *bank = to_bank(offset);
+
+	if (!copro_ops || !gpio->cf_copro_bankmap)
+		return false;
+	if (!gpio->cf_copro_bankmap[offset >> 3])
+		return false;
+	if (!copro_ops->request_access)
+		return false;
+
+	/* Pause the coprocessor */
+	copro_ops->request_access(copro_data);
+
+	/* Change command source back to ARM */
+	aspeed_gpio_change_cmd_source(gpio, bank, offset >> 3, GPIO_CMDSRC_ARM);
+
+	/* Update cache */
+	gpio->dcache[GPIO_BANK(offset)] = ioread32(bank_reg(gpio, bank, reg_rdata));
+
+	return true;
+}
+
+static void aspeed_gpio_copro_release(struct aspeed_gpio *gpio,
+				      unsigned int offset)
+{
+	const struct aspeed_gpio_bank *bank = to_bank(offset);
+
+	if (!copro_ops || !gpio->cf_copro_bankmap)
+		return;
+	if (!gpio->cf_copro_bankmap[offset >> 3])
+		return;
+	if (!copro_ops->release_access)
+		return;
+
+	/* Change command source back to ColdFire */
+	aspeed_gpio_change_cmd_source(gpio, bank, offset >> 3,
+				      GPIO_CMDSRC_COLDFIRE);
+
+	/* Restart the coprocessor */
+	copro_ops->release_access(copro_data);
+}
+
 static int aspeed_gpio_get(struct gpio_chip *gc, unsigned int offset)
 {
 	struct aspeed_gpio *gpio = gpiochip_get_data(gc);
@@ -356,11 +408,15 @@ static void aspeed_gpio_set(struct gpio_chip *gc, unsigned int offset,
 {
 	struct aspeed_gpio *gpio = gpiochip_get_data(gc);
 	unsigned long flags;
+	bool copro;
 
 	spin_lock_irqsave(&gpio->lock, flags);
+	copro = aspeed_gpio_copro_request(gpio, offset);
 
 	__aspeed_gpio_set(gc, offset, val);
 
+	if (copro)
+		aspeed_gpio_copro_release(gpio, offset);
 	spin_unlock_irqrestore(&gpio->lock, flags);
 }
 
@@ -368,7 +424,9 @@ static int aspeed_gpio_dir_in(struct gpio_chip *gc, unsigned int offset)
 {
 	struct aspeed_gpio *gpio = gpiochip_get_data(gc);
 	const struct aspeed_gpio_bank *bank = to_bank(offset);
+	void __iomem *addr = bank_reg(gpio, bank, reg_dir);
 	unsigned long flags;
+	bool copro;
 	u32 reg;
 
 	if (!have_input(gpio, offset))
@@ -376,8 +434,13 @@ static int aspeed_gpio_dir_in(struct gpio_chip *gc, unsigned int offset)
 
 	spin_lock_irqsave(&gpio->lock, flags);
 
-	reg = ioread32(bank_reg(gpio, bank, reg_dir));
-	iowrite32(reg & ~GPIO_BIT(offset), bank_reg(gpio, bank, reg_dir));
+	reg = ioread32(addr);
+	reg &= ~GPIO_BIT(offset);
+
+	copro = aspeed_gpio_copro_request(gpio, offset);
+	iowrite32(reg, addr);
+	if (copro)
+		aspeed_gpio_copro_release(gpio, offset);
 
 	spin_unlock_irqrestore(&gpio->lock, flags);
 
@@ -389,7 +452,9 @@ static int aspeed_gpio_dir_out(struct gpio_chip *gc,
 {
 	struct aspeed_gpio *gpio = gpiochip_get_data(gc);
 	const struct aspeed_gpio_bank *bank = to_bank(offset);
+	void __iomem *addr = bank_reg(gpio, bank, reg_dir);
 	unsigned long flags;
+	bool copro;
 	u32 reg;
 
 	if (!have_output(gpio, offset))
@@ -397,10 +462,15 @@ static int aspeed_gpio_dir_out(struct gpio_chip *gc,
 
 	spin_lock_irqsave(&gpio->lock, flags);
 
+	reg = ioread32(addr);
+	reg |= GPIO_BIT(offset);
+
+	copro = aspeed_gpio_copro_request(gpio, offset);
 	__aspeed_gpio_set(gc, offset, val);
-	reg = ioread32(bank_reg(gpio, bank, reg_dir));
-	iowrite32(reg | GPIO_BIT(offset), bank_reg(gpio, bank, reg_dir));
+	iowrite32(reg, addr);
 
+	if (copro)
+		aspeed_gpio_copro_release(gpio, offset);
 	spin_unlock_irqrestore(&gpio->lock, flags);
 
 	return 0;
@@ -430,24 +500,23 @@ static int aspeed_gpio_get_direction(struct gpio_chip *gc, unsigned int offset)
 }
 
 static inline int irqd_to_aspeed_gpio_data(struct irq_data *d,
-		struct aspeed_gpio **gpio,
-		const struct aspeed_gpio_bank **bank,
-		u32 *bit)
+					   struct aspeed_gpio **gpio,
+					   const struct aspeed_gpio_bank **bank,
+					   u32 *bit, int *offset)
 {
-	int offset;
 	struct aspeed_gpio *internal;
 
-	offset = irqd_to_hwirq(d);
+	*offset = irqd_to_hwirq(d);
 
 	internal = irq_data_get_irq_chip_data(d);
 
 	/* This might be a bit of a questionable place to check */
-	if (!have_irq(internal, offset))
+	if (!have_irq(internal, *offset))
 		return -ENOTSUPP;
 
 	*gpio = internal;
-	*bank = to_bank(offset);
-	*bit = GPIO_BIT(offset);
+	*bank = to_bank(*offset);
+	*bit = GPIO_BIT(*offset);
 
 	return 0;
 }
@@ -458,17 +527,23 @@ static void aspeed_gpio_irq_ack(struct irq_data *d)
 	struct aspeed_gpio *gpio;
 	unsigned long flags;
 	void __iomem *status_addr;
+	int rc, offset;
+	bool copro;
 	u32 bit;
-	int rc;
 
-	rc = irqd_to_aspeed_gpio_data(d, &gpio, &bank, &bit);
+	rc = irqd_to_aspeed_gpio_data(d, &gpio, &bank, &bit, &offset);
 	if (rc)
 		return;
 
 	status_addr = bank_reg(gpio, bank, reg_irq_status);
 
 	spin_lock_irqsave(&gpio->lock, flags);
+	copro = aspeed_gpio_copro_request(gpio, offset);
+
 	iowrite32(bit, status_addr);
+
+	if (copro)
+		aspeed_gpio_copro_release(gpio, offset);
 	spin_unlock_irqrestore(&gpio->lock, flags);
 }
 
@@ -479,15 +554,17 @@ static void aspeed_gpio_irq_set_mask(struct irq_data *d, bool set)
 	unsigned long flags;
 	u32 reg, bit;
 	void __iomem *addr;
-	int rc;
+	int rc, offset;
+	bool copro;
 
-	rc = irqd_to_aspeed_gpio_data(d, &gpio, &bank, &bit);
+	rc = irqd_to_aspeed_gpio_data(d, &gpio, &bank, &bit, &offset);
 	if (rc)
 		return;
 
 	addr = bank_reg(gpio, bank, reg_irq_enable);
 
 	spin_lock_irqsave(&gpio->lock, flags);
+	copro = aspeed_gpio_copro_request(gpio, offset);
 
 	reg = ioread32(addr);
 	if (set)
@@ -496,6 +573,8 @@ static void aspeed_gpio_irq_set_mask(struct irq_data *d, bool set)
 		reg &= ~bit;
 	iowrite32(reg, addr);
 
+	if (copro)
+		aspeed_gpio_copro_release(gpio, offset);
 	spin_unlock_irqrestore(&gpio->lock, flags);
 }
 
@@ -520,9 +599,10 @@ static int aspeed_gpio_set_type(struct irq_data *d, unsigned int type)
 	struct aspeed_gpio *gpio;
 	unsigned long flags;
 	void __iomem *addr;
-	int rc;
+	int rc, offset;
+	bool copro;
 
-	rc = irqd_to_aspeed_gpio_data(d, &gpio, &bank, &bit);
+	rc = irqd_to_aspeed_gpio_data(d, &gpio, &bank, &bit, &offset);
 	if (rc)
 		return -EINVAL;
 
@@ -548,6 +628,7 @@ static int aspeed_gpio_set_type(struct irq_data *d, unsigned int type)
 	}
 
 	spin_lock_irqsave(&gpio->lock, flags);
+	copro = aspeed_gpio_copro_request(gpio, offset);
 
 	addr = bank_reg(gpio, bank, reg_irq_type0);
 	reg = ioread32(addr);
@@ -564,6 +645,8 @@ static int aspeed_gpio_set_type(struct irq_data *d, unsigned int type)
 	reg = (reg & ~bit) | type2;
 	iowrite32(reg, addr);
 
+	if (copro)
+		aspeed_gpio_copro_release(gpio, offset);
 	spin_unlock_irqrestore(&gpio->lock, flags);
 
 	irq_set_handler_locked(d, handler);
@@ -658,11 +741,14 @@ static int aspeed_gpio_reset_tolerance(struct gpio_chip *chip,
 	struct aspeed_gpio *gpio = gpiochip_get_data(chip);
 	unsigned long flags;
 	void __iomem *treg;
+	bool copro;
 	u32 val;
 
 	treg = bank_reg(gpio, to_bank(offset), reg_tolerance);
 
 	spin_lock_irqsave(&gpio->lock, flags);
+	copro = aspeed_gpio_copro_request(gpio, offset);
+
 	val = readl(treg);
 
 	if (enable)
@@ -671,6 +757,9 @@ static int aspeed_gpio_reset_tolerance(struct gpio_chip *chip,
 		val &= ~GPIO_BIT(offset);
 
 	writel(val, treg);
+
+	if (copro)
+		aspeed_gpio_copro_release(gpio, offset);
 	spin_unlock_irqrestore(&gpio->lock, flags);
 
 	return 0;
@@ -766,6 +855,9 @@ static void configure_timer(struct aspeed_gpio *gpio, unsigned int offset,
 	void __iomem *addr;
 	u32 val;
 
+	/* Note: Debounce timer isn't under control of the command
+	 * source registers, so no need to sync with the coprocessor
+	 */
 	addr = bank_reg(gpio, bank, reg_debounce_sel1);
 	val = ioread32(addr);
 	iowrite32((val & ~mask) | GPIO_SET_DEBOUNCE1(timer, offset), addr);
@@ -912,6 +1004,101 @@ static int aspeed_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
 	return -ENOTSUPP;
 }
 
+/**
+ * aspeed_gpio_copro_set_ops - Sets the callbacks used for handhsaking with
+ *                             the coprocessor for shared GPIO banks
+ * @ops: The callbacks
+ * @data: Pointer passed back to the callbacks
+ */
+int aspeed_gpio_copro_set_ops(const struct aspeed_gpio_copro_ops *ops, void *data)
+{
+	copro_data = data;
+	copro_ops = ops;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(aspeed_gpio_copro_set_ops);
+
+/**
+ * aspeed_gpio_copro_grab_gpio - Mark a GPIO used by the coprocessor. The entire
+ *                               bank gets marked and any access from the ARM will
+ *                               result in handshaking via callbacks.
+ * @desc: The GPIO to be marked
+ */
+int aspeed_gpio_copro_grab_gpio(struct gpio_desc *desc)
+{
+	struct gpio_chip *chip = gpiod_to_chip(desc);
+	struct aspeed_gpio *gpio = gpiochip_get_data(chip);
+	int rc = 0, bindex, offset = gpio_chip_hwgpio(desc);
+	const struct aspeed_gpio_bank *bank = to_bank(offset);
+	unsigned long flags;
+
+	if (!gpio->cf_copro_bankmap)
+		gpio->cf_copro_bankmap = kzalloc(gpio->config->nr_gpios >> 3, GFP_KERNEL);
+	if (!gpio->cf_copro_bankmap)
+		return -ENOMEM;
+	if (offset < 0 || offset > gpio->config->nr_gpios)
+		return -EINVAL;
+	bindex = offset >> 3;
+
+	spin_lock_irqsave(&gpio->lock, flags);
+
+	/* Sanity check, this shouldn't happen */
+	if (gpio->cf_copro_bankmap[bindex] == 0xff) {
+		rc = -EIO;
+		goto bail;
+	}
+	gpio->cf_copro_bankmap[bindex]++;
+
+	/* Switch command source */
+	if (gpio->cf_copro_bankmap[bindex] == 1)
+		aspeed_gpio_change_cmd_source(gpio, bank, bindex,
+					      GPIO_CMDSRC_COLDFIRE);
+
+ bail:
+	spin_unlock_irqrestore(&gpio->lock, flags);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(aspeed_gpio_copro_grab_gpio);
+
+/**
+ * aspeed_gpio_copro_release_gpio - Unmark a GPIO used by the coprocessor.
+ * @desc: The GPIO to be marked
+ */
+int aspeed_gpio_copro_release_gpio(struct gpio_desc *desc)
+{
+	struct gpio_chip *chip = gpiod_to_chip(desc);
+	struct aspeed_gpio *gpio = gpiochip_get_data(chip);
+	int rc = 0, bindex, offset = gpio_chip_hwgpio(desc);
+	const struct aspeed_gpio_bank *bank = to_bank(offset);
+	unsigned long flags;
+
+	if (!gpio->cf_copro_bankmap)
+		return -ENXIO;
+
+	if (offset < 0 || offset > gpio->config->nr_gpios)
+		return -EINVAL;
+	bindex = offset >> 3;
+
+	spin_lock_irqsave(&gpio->lock, flags);
+
+	/* Sanity check, this shouldn't happen */
+	if (gpio->cf_copro_bankmap[bindex] == 0) {
+		rc = -EIO;
+		goto bail;
+	}
+	gpio->cf_copro_bankmap[bindex]--;
+
+	/* Switch command source */
+	if (gpio->cf_copro_bankmap[bindex] == 0)
+		aspeed_gpio_change_cmd_source(gpio, bank, bindex,
+					      GPIO_CMDSRC_ARM);
+ bail:
+	spin_unlock_irqrestore(&gpio->lock, flags);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(aspeed_gpio_copro_release_gpio);
+
 /*
  * Any banks not specified in a struct aspeed_bank_props array are assumed to
  * have the properties:
@@ -1002,10 +1189,18 @@ static int __init aspeed_gpio_probe(struct platform_device *pdev)
 	if (!gpio->dcache)
 		return -ENOMEM;
 
-	/* Populate it with initial values read from the HW */
+	/*
+	 * Populate it with initial values read from the HW and switch
+	 * all command sources to the ARM by default
+	 */
 	for (i = 0; i < banks; i++) {
-		void __iomem *addr = bank_reg(gpio, &aspeed_gpio_banks[i], reg_rdata);
+		const struct aspeed_gpio_bank *bank = &aspeed_gpio_banks[i];
+		void __iomem *addr = bank_reg(gpio, bank, reg_rdata);
 		gpio->dcache[i] = ioread32(addr);
+		aspeed_gpio_change_cmd_source(gpio, bank, 0, GPIO_CMDSRC_ARM);
+		aspeed_gpio_change_cmd_source(gpio, bank, 1, GPIO_CMDSRC_ARM);
+		aspeed_gpio_change_cmd_source(gpio, bank, 2, GPIO_CMDSRC_ARM);
+		aspeed_gpio_change_cmd_source(gpio, bank, 3, GPIO_CMDSRC_ARM);
 	}
 
 	rc = devm_gpiochip_add_data(&pdev->dev, &gpio->chip, gpio);
diff --git a/include/linux/gpio/aspeed.h b/include/linux/gpio/aspeed.h
new file mode 100644
index 000000000000..b6871c9b71f7
--- /dev/null
+++ b/include/linux/gpio/aspeed.h
@@ -0,0 +1,14 @@
+#ifndef __GPIO_ASPEED_H
+#define __GPIO_ASPEED_H
+
+struct aspeed_gpio_copro_ops {
+	int (*request_access)(void *data);
+	int (*release_access)(void *data);
+};
+
+int aspeed_gpio_copro_grab_gpio(struct gpio_desc *desc);
+int aspeed_gpio_copro_release_gpio(struct gpio_desc *desc);
+int aspeed_gpio_copro_set_ops(const struct aspeed_gpio_copro_ops *ops, void *data);
+
+
+#endif /* __GPIO_ASPEED_H */
-- 
2.17.1

