From: Joel Stanley <joel@jms.id.au>
Date: Wed,  1 Jul 2020 12:30:39 +0930
Subject: [PATCH] pinctrl: aspeed: Improve debug output
Message-ID: <20200701030039.2834418-1-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Andrew Jeffery <andrew@aj.id.au>

We need to iterate over each pin in a group for a function and
disable higher priority mux configurations on the pin before finally
muxing the relevant function's signal. With the current debug output it
is hard to track what register output is relevant to which operation, so
break up the actions in the debug output by providing some more context.

Before:

    [    5.446656] aspeed-g6-pinctrl 1e6e2000.syscon:pinctrl: request pin 37 (B26) for 1e780000.gpio:341
    [    5.447377] Want SCU414[0x00000020]=0x1, got 0x0 from 0x00000000
    [    5.447854] Want SCU4B4[0x00000020]=0x1, got 0x0 from 0x00000000
    [    5.448340] Want SCU4B4[0x00000020]=0x1, got 0x0 from 0x00000000

After:

    [    5.298053] Muxing pin 37 for GPIO
    [    5.298294] Disabling signal NRI4 for NRI4
    [    5.298593] Want SCU414[0x00000020]=0x1, got 0x0 from 0x00000000
    [    5.298983] Disabling signal RGMII4RXD1 for RGMII4
    [    5.299309] Want SCU4B4[0x00000020]=0x1, got 0x0 from 0x00000000
    [    5.299694] Disabling signal RMII4RXD1 for RMII4
    [    5.300014] Want SCU4B4[0x00000020]=0x1, got 0x0 from 0x00000000
    [    5.300396] Enabling signal GPIOE5 for GPIOE5
    [    5.300687] Muxed pin 37 as GPIOE5

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/pinctrl/aspeed/pinctrl-aspeed.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed.c b/drivers/pinctrl/aspeed/pinctrl-aspeed.c
index b625a657171e..53f3f8aec695 100644
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed.c
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed.c
@@ -76,6 +76,9 @@ static int aspeed_sig_expr_enable(struct aspeed_pinmux_data *ctx,
 {
 	int ret;
 
+	pr_debug("Enabling signal %s for %s\n", expr->signal,
+		 expr->function);
+
 	ret = aspeed_sig_expr_eval(ctx, expr, true);
 	if (ret < 0)
 		return ret;
@@ -91,6 +94,9 @@ static int aspeed_sig_expr_disable(struct aspeed_pinmux_data *ctx,
 {
 	int ret;
 
+	pr_debug("Disabling signal %s for %s\n", expr->signal,
+		 expr->function);
+
 	ret = aspeed_sig_expr_eval(ctx, expr, true);
 	if (ret < 0)
 		return ret;
@@ -229,7 +235,7 @@ int aspeed_pinmux_set_mux(struct pinctrl_dev *pctldev, unsigned int function,
 		const struct aspeed_sig_expr **funcs;
 		const struct aspeed_sig_expr ***prios;
 
-		pr_debug("Muxing pin %d for %s\n", pin, pfunc->name);
+		pr_debug("Muxing pin %s for %s\n", pdesc->name, pfunc->name);
 
 		if (!pdesc)
 			return -EINVAL;
@@ -269,6 +275,9 @@ int aspeed_pinmux_set_mux(struct pinctrl_dev *pctldev, unsigned int function,
 		ret = aspeed_sig_expr_enable(&pdata->pinmux, expr);
 		if (ret)
 			return ret;
+
+		pr_debug("Muxed pin %s as %s for %s\n", pdesc->name, expr->signal,
+			 expr->function);
 	}
 
 	return 0;
@@ -317,6 +326,8 @@ int aspeed_gpio_request_enable(struct pinctrl_dev *pctldev,
 	if (!prios)
 		return -ENXIO;
 
+	pr_debug("Muxing pin %s for GPIO\n", pdesc->name);
+
 	/* Disable any functions of higher priority than GPIO */
 	while ((funcs = *prios)) {
 		if (aspeed_gpio_in_exprs(funcs))
@@ -346,14 +357,22 @@ int aspeed_gpio_request_enable(struct pinctrl_dev *pctldev,
 	 * lowest-priority signal type. As such it has no associated
 	 * expression.
 	 */
-	if (!expr)
+	if (!expr) {
+		pr_debug("Muxed pin %s as GPIO\n", pdesc->name);
 		return 0;
+	}
 
 	/*
 	 * If GPIO is not the lowest priority signal type, assume there is only
 	 * one expression defined to enable the GPIO function
 	 */
-	return aspeed_sig_expr_enable(&pdata->pinmux, expr);
+	ret = aspeed_sig_expr_enable(&pdata->pinmux, expr);
+	if (ret)
+		return ret;
+
+	pr_debug("Muxed pin %s as %s\n", pdesc->name, expr->signal);
+
+	return 0;
 }
 
 int aspeed_pinctrl_probe(struct platform_device *pdev,
-- 
2.27.0

