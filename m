From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Mon, 26 Feb 2024 16:19:27 +0200
Subject: [PATCH v2 11/14] serial: 8250_omap: Switch to use uart_read_port_properties()
In-Reply-To: <20240226142514.1485246-1-andriy.shevchenko@linux.intel.com>
References: <20240226142514.1485246-1-andriy.shevchenko@linux.intel.com>
Message-ID: <20240226142514.1485246-12-andriy.shevchenko@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Since we have now a common helper to read port properties
use it instead of sparse home grown solution.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_omap.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 6942990a333c..173af575a43e 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1394,11 +1394,7 @@ static int omap8250_probe(struct platform_device *pdev)
 	struct uart_8250_port up;
 	struct resource *regs;
 	void __iomem *membase;
-	int irq, ret;
-
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
+	int ret;
 
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!regs) {
@@ -1419,7 +1415,6 @@ static int omap8250_probe(struct platform_device *pdev)
 	up.port.dev = &pdev->dev;
 	up.port.mapbase = regs->start;
 	up.port.membase = membase;
-	up.port.irq = irq;
 	/*
 	 * It claims to be 16C750 compatible however it is a little different.
 	 * It has EFR and has no FCR7_64byte bit. The AFE (which it claims to
@@ -1429,13 +1424,9 @@ static int omap8250_probe(struct platform_device *pdev)
 	 * or pm callback.
 	 */
 	up.port.type = PORT_8250;
-	up.port.iotype = UPIO_MEM;
-	up.port.flags = UPF_FIXED_PORT | UPF_FIXED_TYPE | UPF_SOFT_FLOW |
-		UPF_HARD_FLOW;
+	up.port.flags = UPF_FIXED_PORT | UPF_FIXED_TYPE | UPF_SOFT_FLOW | UPF_HARD_FLOW;
 	up.port.private_data = priv;
 
-	up.port.regshift = OMAP_UART_REGSHIFT;
-	up.port.fifosize = 64;
 	up.tx_loadsz = 64;
 	up.capabilities = UART_CAP_FIFO;
 #ifdef CONFIG_PM
@@ -1461,14 +1452,14 @@ static int omap8250_probe(struct platform_device *pdev)
 	up.rs485_stop_tx = serial8250_em485_stop_tx;
 	up.port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_8250_CONSOLE);
 
-	ret = of_alias_get_id(np, "serial");
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to get alias\n");
+	ret = uart_read_port_properties(&up.port, true);
+	if (ret)
 		return ret;
-	}
-	up.port.line = ret;
 
-	if (of_property_read_u32(np, "clock-frequency", &up.port.uartclk)) {
+	up.port.regshift = OMAP_UART_REGSHIFT;
+	up.port.fifosize = 64;
+
+	if (!up.port.uartclk) {
 		struct clk *clk;
 
 		clk = devm_clk_get(&pdev->dev, NULL);
@@ -1560,8 +1551,8 @@ static int omap8250_probe(struct platform_device *pdev)
 	}
 #endif
 
-	irq_set_status_flags(irq, IRQ_NOAUTOEN);
-	ret = devm_request_irq(&pdev->dev, irq, omap8250_irq, 0,
+	irq_set_status_flags(up.port.irq, IRQ_NOAUTOEN);
+	ret = devm_request_irq(&pdev->dev, up.port.irq, omap8250_irq, 0,
 			       dev_name(&pdev->dev), priv);
 	if (ret < 0)
 		return ret;
-- 
2.43.0.rc1.1.gbec44491f096

