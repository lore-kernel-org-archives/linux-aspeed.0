From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Mon, 26 Feb 2024 16:19:28 +0200
Subject: [PATCH v2 12/14] serial: 8250_pxa: Switch to use uart_read_port_properties()
In-Reply-To: <20240226142514.1485246-1-andriy.shevchenko@linux.intel.com>
References: <20240226142514.1485246-1-andriy.shevchenko@linux.intel.com>
Message-ID: <20240226142514.1485246-13-andriy.shevchenko@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Since we have now a common helper to read port properties
use it instead of sparse home grown solution.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_pxa.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pxa.c b/drivers/tty/serial/8250/8250_pxa.c
index 77686da42ce8..0c9140b93414 100644
--- a/drivers/tty/serial/8250/8250_pxa.c
+++ b/drivers/tty/serial/8250/8250_pxa.c
@@ -92,11 +92,7 @@ static int serial_pxa_probe(struct platform_device *pdev)
 	struct uart_8250_port uart = {};
 	struct pxa8250_data *data;
 	struct resource *mmres;
-	int irq, ret;
-
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
+	int ret;
 
 	mmres = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!mmres)
@@ -114,21 +110,21 @@ static int serial_pxa_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = of_alias_get_id(pdev->dev.of_node, "serial");
-	if (ret >= 0)
-		uart.port.line = ret;
-
 	uart.port.type = PORT_XSCALE;
-	uart.port.iotype = UPIO_MEM32;
 	uart.port.mapbase = mmres->start;
-	uart.port.regshift = 2;
-	uart.port.irq = irq;
-	uart.port.fifosize = 64;
 	uart.port.flags = UPF_IOREMAP | UPF_SKIP_TEST | UPF_FIXED_TYPE;
 	uart.port.dev = &pdev->dev;
 	uart.port.uartclk = clk_get_rate(data->clk);
 	uart.port.pm = serial_pxa_pm;
 	uart.port.private_data = data;
+
+	ret = uart_read_port_properties(&uart.port, true);
+	if (ret)
+		return ret;
+
+	uart.port.iotype = UPIO_MEM32;
+	uart.port.regshift = 2;
+	uart.port.fifosize = 64;
 	uart.dl_write = serial_pxa_dl_write;
 
 	ret = serial8250_register_8250_port(&uart);
-- 
2.43.0.rc1.1.gbec44491f096

