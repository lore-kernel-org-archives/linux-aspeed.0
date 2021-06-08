From: Steven Lee <steven_lee@aspeedtech.com>
Date: Tue, 8 Jun 2021 18:25:41 +0800
Subject: [PATCH v5 06/10] gpio: gpio-aspeed-sgpio: Add AST2400 and AST2500
 platform data.
In-Reply-To: <20210608102547.4880-1-steven_lee@aspeedtech.com>
References: <20210608102547.4880-1-steven_lee@aspeedtech.com>
Message-ID: <20210608102547.4880-7-steven_lee@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

We use platform data to store GPIO pin mask and the max number of
available GPIO pins for AST2600.
Refactor driver to also add the platform data for AST2400/AST2500 and
remove unused MAX_NR_HW_SGPIO and ASPEED_SGPIO_PINS_MASK macros.

Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
---
 drivers/gpio/gpio-aspeed-sgpio.c | 34 +++++++++++---------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/drivers/gpio/gpio-aspeed-sgpio.c b/drivers/gpio/gpio-aspeed-sgpio.c
index ea20a0127748..7d0a4f6fd9d1 100644
--- a/drivers/gpio/gpio-aspeed-sgpio.c
+++ b/drivers/gpio/gpio-aspeed-sgpio.c
@@ -17,21 +17,8 @@
 #include <linux/spinlock.h>
 #include <linux/string.h>
 
-/*
- * MAX_NR_HW_GPIO represents the number of actual hardware-supported GPIOs (ie,
- * slots within the clocked serial GPIO data). Since each HW GPIO is both an
- * input and an output, we provide MAX_NR_HW_GPIO * 2 lines on our gpiochip
- * device.
- *
- * We use SGPIO_OUTPUT_OFFSET to define the split between the inputs and
- * outputs; the inputs start at line 0, the outputs start at OUTPUT_OFFSET.
- */
-#define MAX_NR_HW_SGPIO			80
-#define SGPIO_OUTPUT_OFFSET		MAX_NR_HW_SGPIO
-
 #define ASPEED_SGPIO_CTRL		0x54
 
-#define ASPEED_SGPIO_PINS_MASK		GENMASK(9, 6)
 #define ASPEED_SGPIO_CLK_DIV_MASK	GENMASK(31, 16)
 #define ASPEED_SGPIO_ENABLE		BIT(0)
 #define ASPEED_SGPIO_PINS_SHIFT		6
@@ -484,6 +471,11 @@ static int aspeed_sgpio_setup_irqs(struct aspeed_sgpio *gpio,
 	return 0;
 }
 
+static const struct aspeed_sgpio_pdata ast2400_sgpio_pdata = {
+	.max_ngpios = 80,
+	.pin_mask = GENMASK(9, 6),
+};
+
 static const struct aspeed_sgpio_pdata ast2600_sgpiom_128_pdata = {
 	.max_ngpios = 128,
 	.pin_mask = GENMASK(10, 6),
@@ -495,8 +487,8 @@ static const struct aspeed_sgpio_pdata ast2600_sgpiom_80_pdata = {
 };
 
 static const struct of_device_id aspeed_sgpio_of_table[] = {
-	{ .compatible = "aspeed,ast2400-sgpio" },
-	{ .compatible = "aspeed,ast2500-sgpio" },
+	{ .compatible = "aspeed,ast2400-sgpio", .data = &ast2400_sgpio_pdata, },
+	{ .compatible = "aspeed,ast2500-sgpio", .data = &ast2400_sgpio_pdata, },
 	{ .compatible = "aspeed,ast2600-sgpiom-128", .data = &ast2600_sgpiom_128_pdata, },
 	{ .compatible = "aspeed,ast2600-sgpiom-80", .data = &ast2600_sgpiom_80_pdata, },
 	{}
@@ -521,13 +513,11 @@ static int __init aspeed_sgpio_probe(struct platform_device *pdev)
 		return PTR_ERR(gpio->base);
 
 	pdata = device_get_match_data(&pdev->dev);
-	if (pdata) {
-		gpio->max_ngpios = pdata->max_ngpios;
-		pin_mask = pdata->pin_mask;
-	} else {
-		gpio->max_ngpios = MAX_NR_HW_SGPIO;
-		pin_mask = ASPEED_SGPIO_PINS_MASK;
-	}
+	if (!pdata)
+		return -EINVAL;
+
+	gpio->max_ngpios = pdata->max_ngpios;
+	pin_mask = pdata->pin_mask;
 
 	rc = of_property_read_u32(pdev->dev.of_node, "ngpios", &nr_gpios);
 	if (rc < 0) {
-- 
2.17.1

