From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 18 Jun 2018 14:53:50 +1000
Subject: [PATCH v2 2/4] gpio: aspeed: Add "Read Data" register to read the
 write latch
In-Reply-To: <20180618045352.9489-1-benh@kernel.crashing.org>
References: <20180618045352.9489-1-benh@kernel.crashing.org>
Message-ID: <20180618045352.9489-3-benh@kernel.crashing.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The Aspeed GPIO hardware has a quirk: the value register, for an
output GPIO, doesn't contain the last value written (the write
latch content) but the sampled input value.

This means that when reading back shortly after writing, you can
get an incorrect value as the input value is delayed by a few
synchronizers.

The HW supports a separate read-only register "Data Read Register"
which allows you to read the write latch instead.

This adds the definition for it, and uses it for the initial
population of the GPIO value cache. It will be used more in
subsequent patches.
can be

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/gpio/gpio-aspeed.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
index c9baeeb7f0cc..a5ded50c6db0 100644
--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -59,18 +59,33 @@ struct aspeed_gpio {
 };
 
 struct aspeed_gpio_bank {
-	uint16_t	val_regs;
+	uint16_t	val_regs;	/* +0: Rd: read input value, Wr: set write latch
+					 * +4: Rd/Wr: Direction (0=in, 1=out)
+					 */
+	uint16_t	rdata_reg;	/*     Rd: read write latch, Wr: <none>  */
 	uint16_t	irq_regs;
 	uint16_t	debounce_regs;
 	uint16_t	tolerance_regs;
 	const char	names[4][3];
 };
 
+/*
+ * Note: The "value" register returns the input value sampled on the
+ *       line even when the GPIO is configured as an output. Since
+ *       that input goes through synchronizers, writing, then reading
+ *       back may not return the written value right away.
+ *
+ *       The "rdata" register returns the content of the write latch
+ *       and thus can be used to read back what was last written
+ *       reliably.
+ */
+
 static const int debounce_timers[4] = { 0x00, 0x50, 0x54, 0x58 };
 
 static const struct aspeed_gpio_bank aspeed_gpio_banks[] = {
 	{
 		.val_regs = 0x0000,
+		.rdata_reg = 0x00c0,
 		.irq_regs = 0x0008,
 		.debounce_regs = 0x0040,
 		.tolerance_regs = 0x001c,
@@ -78,6 +93,7 @@ static const struct aspeed_gpio_bank aspeed_gpio_banks[] = {
 	},
 	{
 		.val_regs = 0x0020,
+		.rdata_reg = 0x00c4,
 		.irq_regs = 0x0028,
 		.debounce_regs = 0x0048,
 		.tolerance_regs = 0x003c,
@@ -85,6 +101,7 @@ static const struct aspeed_gpio_bank aspeed_gpio_banks[] = {
 	},
 	{
 		.val_regs = 0x0070,
+		.rdata_reg = 0x00c8,
 		.irq_regs = 0x0098,
 		.debounce_regs = 0x00b0,
 		.tolerance_regs = 0x00ac,
@@ -92,6 +109,7 @@ static const struct aspeed_gpio_bank aspeed_gpio_banks[] = {
 	},
 	{
 		.val_regs = 0x0078,
+		.rdata_reg = 0x00cc,
 		.irq_regs = 0x00e8,
 		.debounce_regs = 0x0100,
 		.tolerance_regs = 0x00fc,
@@ -99,6 +117,7 @@ static const struct aspeed_gpio_bank aspeed_gpio_banks[] = {
 	},
 	{
 		.val_regs = 0x0080,
+		.rdata_reg = 0x00d0,
 		.irq_regs = 0x0118,
 		.debounce_regs = 0x0130,
 		.tolerance_regs = 0x012c,
@@ -106,6 +125,7 @@ static const struct aspeed_gpio_bank aspeed_gpio_banks[] = {
 	},
 	{
 		.val_regs = 0x0088,
+		.rdata_reg = 0x00d4,
 		.irq_regs = 0x0148,
 		.debounce_regs = 0x0160,
 		.tolerance_regs = 0x015c,
@@ -113,6 +133,7 @@ static const struct aspeed_gpio_bank aspeed_gpio_banks[] = {
 	},
 	{
 		.val_regs = 0x01E0,
+		.rdata_reg = 0x00d8,
 		.irq_regs = 0x0178,
 		.debounce_regs = 0x0190,
 		.tolerance_regs = 0x018c,
@@ -120,6 +141,7 @@ static const struct aspeed_gpio_bank aspeed_gpio_banks[] = {
 	},
 	{
 		.val_regs = 0x01e8,
+		.rdata_reg = 0x00dc,
 		.irq_regs = 0x01a8,
 		.debounce_regs = 0x01c0,
 		.tolerance_regs = 0x01bc,
@@ -129,6 +151,7 @@ static const struct aspeed_gpio_bank aspeed_gpio_banks[] = {
 
 enum aspeed_gpio_reg {
 	reg_val,
+	reg_rdata,
 	reg_dir,
 	reg_irq_enable,
 	reg_irq_type0,
@@ -160,6 +183,8 @@ static inline void __iomem *bank_reg(struct aspeed_gpio *gpio,
 	switch (reg) {
 	case reg_val:
 		return gpio->base + bank->val_regs + GPIO_VAL_VALUE;
+	case reg_rdata:
+		return gpio->base + bank->rdata_reg;
 	case reg_dir:
 		return gpio->base + bank->val_regs + GPIO_VAL_DIR;
 	case reg_irq_enable:
@@ -925,7 +950,7 @@ static int __init aspeed_gpio_probe(struct platform_device *pdev)
 
 	/* Populate it with initial values read from the HW */
 	for (i = 0; i < banks; i++) {
-		void __iomem *addr = bank_reg(gpio, &aspeed_gpio_banks[i], reg_val);
+		void __iomem *addr = bank_reg(gpio, &aspeed_gpio_banks[i], reg_rdata);
 		gpio->dcache[i] = ioread32(addr);
 	}
 
-- 
2.17.1

