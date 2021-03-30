From: Zev Weiss <zev@bewilderbeest.net>
Date: Mon, 29 Mar 2021 19:23:36 -0500
Subject: [PATCH 1/3] drivers/tty/serial/8250: simplify Aspeed VUART SIRQ
 polarity DT config
In-Reply-To: <20210330002338.335-1-zev@bewilderbeest.net>
References: <20210330002338.335-1-zev@bewilderbeest.net>
Message-ID: <20210330002338.335-2-zev@bewilderbeest.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The initial implementation of this configuration conflated the SIRQ
polarity setting with the syscon eSPI/LPC strapping; this patch
disentangles them by reducing the DT config to a simple boolean.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 drivers/tty/serial/8250/8250_aspeed_vuart.c | 39 ++-------------------
 drivers/tty/serial/8250/Kconfig             |  1 -
 2 files changed, 2 insertions(+), 38 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
index c33e02cbde93..b9b5fa58ab28 100644
--- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
+++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
@@ -10,8 +10,6 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
-#include <linux/regmap.h>
-#include <linux/mfd/syscon.h>
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
 #include <linux/clk.h>
@@ -346,30 +344,8 @@ static int aspeed_vuart_handle_irq(struct uart_port *port)
 	return 1;
 }
 
-static void aspeed_vuart_auto_configure_sirq_polarity(
-	struct aspeed_vuart *vuart, struct device_node *syscon_np,
-	u32 reg_offset, u32 reg_mask)
-{
-	struct regmap *regmap;
-	u32 value;
-
-	regmap = syscon_node_to_regmap(syscon_np);
-	if (IS_ERR(regmap)) {
-		dev_warn(vuart->dev,
-			 "could not get regmap for aspeed,sirq-polarity-sense\n");
-		return;
-	}
-	if (regmap_read(regmap, reg_offset, &value)) {
-		dev_warn(vuart->dev, "could not read hw strap table\n");
-		return;
-	}
-
-	aspeed_vuart_set_sirq_polarity(vuart, (value & reg_mask) == 0);
-}
-
 static int aspeed_vuart_probe(struct platform_device *pdev)
 {
-	struct of_phandle_args sirq_polarity_sense_args;
 	struct uart_8250_port port;
 	struct aspeed_vuart *vuart;
 	struct device_node *np;
@@ -468,19 +444,8 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
 
 	vuart->line = rc;
 
-	rc = of_parse_phandle_with_fixed_args(
-		np, "aspeed,sirq-polarity-sense", 2, 0,
-		&sirq_polarity_sense_args);
-	if (rc < 0) {
-		dev_dbg(&pdev->dev,
-			"aspeed,sirq-polarity-sense property not found\n");
-	} else {
-		aspeed_vuart_auto_configure_sirq_polarity(
-			vuart, sirq_polarity_sense_args.np,
-			sirq_polarity_sense_args.args[0],
-			BIT(sirq_polarity_sense_args.args[1]));
-		of_node_put(sirq_polarity_sense_args.np);
-	}
+	if (of_property_read_bool(np, "aspeed,sirq-active-high"))
+		aspeed_vuart_set_sirq_polarity(vuart, 1);
 
 	aspeed_vuart_set_enabled(vuart, true);
 	aspeed_vuart_set_host_tx_discard(vuart, true);
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 603137da4736..105a325bcdd1 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -254,7 +254,6 @@ config SERIAL_8250_ASPEED_VUART
 	tristate "Aspeed Virtual UART"
 	depends on SERIAL_8250
 	depends on OF
-	depends on REGMAP && MFD_SYSCON
 	help
 	  If you want to use the virtual UART (VUART) device on Aspeed
 	  BMC platforms, enable this option. This enables the 16550A-
-- 
2.31.1

