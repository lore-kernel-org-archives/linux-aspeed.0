From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Mon, 26 Feb 2024 16:19:24 +0200
Subject: [PATCH v2 08/14] serial: 8250_ingenic: Switch to use uart_read_port_properties()
In-Reply-To: <20240226142514.1485246-1-andriy.shevchenko@linux.intel.com>
References: <20240226142514.1485246-1-andriy.shevchenko@linux.intel.com>
Message-ID: <20240226142514.1485246-9-andriy.shevchenko@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Since we have now a common helper to read port properties
use it instead of sparse home grown solution.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_ingenic.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_ingenic.c b/drivers/tty/serial/8250/8250_ingenic.c
index a12f737924c0..7603129f1c07 100644
--- a/drivers/tty/serial/8250/8250_ingenic.c
+++ b/drivers/tty/serial/8250/8250_ingenic.c
@@ -234,7 +234,7 @@ static int ingenic_uart_probe(struct platform_device *pdev)
 	struct ingenic_uart_data *data;
 	const struct ingenic_uart_config *cdata;
 	struct resource *regs;
-	int irq, err, line;
+	int err;
 
 	cdata = of_device_get_match_data(&pdev->dev);
 	if (!cdata) {
@@ -242,10 +242,6 @@ static int ingenic_uart_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
-
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!regs) {
 		dev_err(&pdev->dev, "no registers defined\n");
@@ -259,21 +255,19 @@ static int ingenic_uart_probe(struct platform_device *pdev)
 	spin_lock_init(&uart.port.lock);
 	uart.port.type = PORT_16550A;
 	uart.port.flags = UPF_SKIP_TEST | UPF_IOREMAP | UPF_FIXED_TYPE;
-	uart.port.iotype = UPIO_MEM;
 	uart.port.mapbase = regs->start;
-	uart.port.regshift = 2;
 	uart.port.serial_out = ingenic_uart_serial_out;
 	uart.port.serial_in = ingenic_uart_serial_in;
-	uart.port.irq = irq;
 	uart.port.dev = &pdev->dev;
-	uart.port.fifosize = cdata->fifosize;
 	uart.tx_loadsz = cdata->tx_loadsz;
 	uart.capabilities = UART_CAP_FIFO | UART_CAP_RTOIE;
 
-	/* Check for a fixed line number */
-	line = of_alias_get_id(pdev->dev.of_node, "serial");
-	if (line >= 0)
-		uart.port.line = line;
+	err = uart_read_port_properties(&uart.port, true);
+	if (err)
+		return err;
+
+	uart.port.regshift = 2;
+	uart.port.fifosize = cdata->fifosize;
 
 	uart.port.membase = devm_ioremap(&pdev->dev, regs->start,
 					 resource_size(regs));
-- 
2.43.0.rc1.1.gbec44491f096

