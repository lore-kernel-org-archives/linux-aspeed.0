From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Wed, 21 Feb 2024 20:31:20 +0200
Subject: [PATCH v1 04/14] serial: 8250_aspeed_vuart: Switch to use uart_read_port_properties()
In-Reply-To: <20240221183442.4124354-1-andriy.shevchenko@linux.intel.com>
References: <20240221183442.4124354-1-andriy.shevchenko@linux.intel.com>
Message-ID: <20240221183442.4124354-5-andriy.shevchenko@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Since we have now a common helper to read port properties
use it instead of sparse home grown solution.

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_aspeed_vuart.c | 50 +++++++--------------
 1 file changed, 15 insertions(+), 35 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
index 8c2aaf7af7b7..2a4bc39b11af 100644
--- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
+++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
@@ -419,8 +419,8 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
 	struct aspeed_vuart *vuart;
 	struct device_node *np;
 	struct resource *res;
-	u32 clk, prop, sirq[2];
 	int rc, sirq_polarity;
+	u32 prop, sirq[2];
 	struct clk *vclk;
 
 	np = pdev->dev.of_node;
@@ -447,53 +447,35 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
 	port.port.status = UPSTAT_SYNC_FIFO;
 	port.port.dev = &pdev->dev;
 	port.port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_8250_CONSOLE);
+	port.port.flags = UPF_BOOT_AUTOCONF | UPF_IOREMAP | UPF_FIXED_PORT | UPF_FIXED_TYPE |
+			  UPF_NO_THRE_TEST;
 	port.bugs |= UART_BUG_TXRACE;
 
 	rc = sysfs_create_group(&vuart->dev->kobj, &aspeed_vuart_attr_group);
 	if (rc < 0)
 		return rc;
 
-	if (of_property_read_u32(np, "clock-frequency", &clk)) {
+	rc = uart_read_port_properties(&port.port, true);
+	if (rc)
+		goto err_sysfs_remove;
+
+	/* Get clk rate through clk driver if present */
+	if (!port.port.uartclk) {
 		vclk = devm_clk_get_enabled(dev, NULL);
 		if (IS_ERR(vclk)) {
 			rc = dev_err_probe(dev, PTR_ERR(vclk), "clk or clock-frequency not defined\n");
 			goto err_sysfs_remove;
 		}
 
-		clk = clk_get_rate(vclk);
+		port.port.uartclk = clk_get_rate(vclk);
 	}
 
 	/* If current-speed was set, then try not to change it. */
 	if (of_property_read_u32(np, "current-speed", &prop) == 0)
-		port.port.custom_divisor = clk / (16 * prop);
+		port.port.custom_divisor = port.port.uartclk / (16 * prop);
 
-	/* Check for shifted address mapping */
-	if (of_property_read_u32(np, "reg-offset", &prop) == 0)
-		port.port.mapbase += prop;
-
-	/* Check for registers offset within the devices address range */
-	if (of_property_read_u32(np, "reg-shift", &prop) == 0)
-		port.port.regshift = prop;
-
-	/* Check for fifo size */
-	if (of_property_read_u32(np, "fifo-size", &prop) == 0)
-		port.port.fifosize = prop;
-
-	/* Check for a fixed line number */
-	rc = of_alias_get_id(np, "serial");
-	if (rc >= 0)
-		port.port.line = rc;
-
-	port.port.irq = irq_of_parse_and_map(np, 0);
 	port.port.handle_irq = aspeed_vuart_handle_irq;
-	port.port.iotype = UPIO_MEM;
 	port.port.type = PORT_ASPEED_VUART;
-	port.port.uartclk = clk;
-	port.port.flags = UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF | UPF_IOREMAP
-		| UPF_FIXED_PORT | UPF_FIXED_TYPE | UPF_NO_THRE_TEST;
-
-	if (of_property_read_bool(np, "no-loopback-test"))
-		port.port.flags |= UPF_SKIP_TEST;
 
 	if (port.port.fifosize)
 		port.capabilities = UART_CAP_FIFO;
@@ -503,7 +485,7 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
 
 	rc = serial8250_register_8250_port(&port);
 	if (rc < 0)
-		goto err_clk_disable;
+		goto err_sysfs_remove;
 
 	vuart->line = rc;
 	vuart->port = serial8250_get_port(vuart->line);
@@ -529,7 +511,7 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
 	rc = aspeed_vuart_set_lpc_address(vuart, prop);
 	if (rc < 0) {
 		dev_err_probe(dev, rc, "invalid value in aspeed,lpc-io-reg property\n");
-		goto err_clk_disable;
+		goto err_sysfs_remove;
 	}
 
 	rc = of_property_read_u32_array(np, "aspeed,lpc-interrupts", sirq, 2);
@@ -541,14 +523,14 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
 	rc = aspeed_vuart_set_sirq(vuart, sirq[0]);
 	if (rc < 0) {
 		dev_err_probe(dev, rc, "invalid sirq number in aspeed,lpc-interrupts property\n");
-		goto err_clk_disable;
+		goto err_sysfs_remove;
 	}
 
 	sirq_polarity = aspeed_vuart_map_irq_polarity(sirq[1]);
 	if (sirq_polarity < 0) {
 		rc = dev_err_probe(dev, sirq_polarity,
 				   "invalid sirq polarity in aspeed,lpc-interrupts property\n");
-		goto err_clk_disable;
+		goto err_sysfs_remove;
 	}
 
 	aspeed_vuart_set_sirq_polarity(vuart, sirq_polarity);
@@ -559,8 +541,6 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
 
 	return 0;
 
-err_clk_disable:
-	irq_dispose_mapping(port.port.irq);
 err_sysfs_remove:
 	sysfs_remove_group(&vuart->dev->kobj, &aspeed_vuart_attr_group);
 	return rc;
-- 
2.43.0.rc1.1.gbec44491f096

