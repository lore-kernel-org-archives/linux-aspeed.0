From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Wed, 21 Feb 2024 20:31:26 +0200
Subject: [PATCH v1 10/14] serial: 8250_of: Switch to use uart_read_port_properties()
In-Reply-To: <20240221183442.4124354-1-andriy.shevchenko@linux.intel.com>
References: <20240221183442.4124354-1-andriy.shevchenko@linux.intel.com>
Message-ID: <20240221183442.4124354-11-andriy.shevchenko@linux.intel.com>
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
 drivers/tty/serial/8250/8250_of.c | 105 +++++++-----------------------
 1 file changed, 22 insertions(+), 83 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index 9dcc17e33269..1a699ce2e812 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -69,37 +69,22 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 	struct device *dev = &ofdev->dev;
 	struct device_node *np = dev->of_node;
 	struct uart_port *port = &up->port;
-	u32 clk, spd, prop;
-	int ret, irq;
+	u32 spd;
+	int ret;
 
 	memset(port, 0, sizeof *port);
 
 	pm_runtime_enable(&ofdev->dev);
 	pm_runtime_get_sync(&ofdev->dev);
 
-	if (of_property_read_u32(np, "clock-frequency", &clk)) {
-
-		/* Get clk rate through clk driver if present */
-		info->clk = devm_clk_get_enabled(dev, NULL);
-		if (IS_ERR(info->clk)) {
-			ret = dev_err_probe(dev, PTR_ERR(info->clk), "failed to get clock\n");
-			goto err_pmruntime;
-		}
-
-		clk = clk_get_rate(info->clk);
-	}
-	/* If current-speed was set, then try not to change it. */
-	if (of_property_read_u32(np, "current-speed", &spd) == 0)
-		port->custom_divisor = clk / (16 * spd);
-
 	ret = of_address_to_resource(np, 0, &resource);
 	if (ret) {
 		dev_err_probe(dev, ret, "invalid address\n");
 		goto err_pmruntime;
 	}
 
-	port->flags = UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF | UPF_FIXED_PORT |
-				  UPF_FIXED_TYPE;
+	port->dev = &ofdev->dev;
+	port->flags = UPF_BOOT_AUTOCONF | UPF_FIXED_PORT | UPF_FIXED_TYPE;
 	spin_lock_init(&port->lock);
 
 	if (resource_type(&resource) == IORESOURCE_IO) {
@@ -108,70 +93,31 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 	} else {
 		port->mapbase = resource.start;
 		port->mapsize = resource_size(&resource);
-
-		/* Check for shifted address mapping */
-		if (of_property_read_u32(np, "reg-offset", &prop) == 0) {
-			if (prop >= port->mapsize) {
-				ret = dev_err_probe(dev, -EINVAL, "reg-offset %u exceeds region size %pa\n",
-						    prop, &port->mapsize);
-				goto err_pmruntime;
-			}
-
-			port->mapbase += prop;
-			port->mapsize -= prop;
-		}
-
-		port->iotype = UPIO_MEM;
-		if (of_property_read_u32(np, "reg-io-width", &prop) == 0) {
-			switch (prop) {
-			case 1:
-				port->iotype = UPIO_MEM;
-				break;
-			case 2:
-				port->iotype = UPIO_MEM16;
-				break;
-			case 4:
-				port->iotype = of_device_is_big_endian(np) ?
-					       UPIO_MEM32BE : UPIO_MEM32;
-				break;
-			default:
-				ret = dev_err_probe(dev, -EINVAL, "unsupported reg-io-width (%u)\n",
-						    prop);
-				goto err_pmruntime;
-			}
-		}
 		port->flags |= UPF_IOREMAP;
 	}
 
+	ret = uart_read_port_properties(port, false);
+	if (ret)
+		goto err_pmruntime;
+
+	/* Get clk rate through clk driver if present */
+	if (!port->uartclk) {
+		info->clk = devm_clk_get_enabled(dev, NULL);
+		if (IS_ERR(info->clk)) {
+			ret = dev_err_probe(dev, PTR_ERR(info->clk), "failed to get clock\n");
+			goto err_pmruntime;
+		}
+
+		port->uartclk = clk_get_rate(info->clk);
+	}
+	/* If current-speed was set, then try not to change it. */
+	if (of_property_read_u32(np, "current-speed", &spd) == 0)
+		port->custom_divisor = port->uartclk / (16 * spd);
+
 	/* Compatibility with the deprecated pxa driver and 8250_pxa drivers. */
 	if (of_device_is_compatible(np, "mrvl,mmp-uart"))
 		port->regshift = 2;
 
-	/* Check for registers offset within the devices address range */
-	if (of_property_read_u32(np, "reg-shift", &prop) == 0)
-		port->regshift = prop;
-
-	/* Check for fifo size */
-	if (of_property_read_u32(np, "fifo-size", &prop) == 0)
-		port->fifosize = prop;
-
-	/* Check for a fixed line number */
-	ret = of_alias_get_id(np, "serial");
-	if (ret >= 0)
-		port->line = ret;
-
-	irq = of_irq_get(np, 0);
-	if (irq < 0) {
-		if (irq == -EPROBE_DEFER) {
-			ret = -EPROBE_DEFER;
-			goto err_pmruntime;
-		}
-		/* IRQ support not mandatory */
-		irq = 0;
-	}
-
-	port->irq = irq;
-
 	info->rst = devm_reset_control_get_optional_shared(&ofdev->dev, NULL);
 	if (IS_ERR(info->rst)) {
 		ret = PTR_ERR(info->rst);
@@ -183,12 +129,6 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 		goto err_pmruntime;
 
 	port->type = type;
-	port->uartclk = clk;
-
-	if (of_property_read_bool(np, "no-loopback-test"))
-		port->flags |= UPF_SKIP_TEST;
-
-	port->dev = &ofdev->dev;
 	port->rs485_config = serial8250_em485_config;
 	port->rs485_supported = serial8250_em485_supported;
 	up->rs485_start_tx = serial8250_em485_start_tx;
@@ -280,7 +220,6 @@ static int of_platform_serial_probe(struct platform_device *ofdev)
 	platform_set_drvdata(ofdev, info);
 	return 0;
 err_dispose:
-	irq_dispose_mapping(port8250.port.irq);
 	pm_runtime_put_sync(&ofdev->dev);
 	pm_runtime_disable(&ofdev->dev);
 err_free:
-- 
2.43.0.rc1.1.gbec44491f096

