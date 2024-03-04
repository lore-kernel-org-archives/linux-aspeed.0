From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Mon,  4 Mar 2024 14:27:10 +0200
Subject: [PATCH v3 09/14] serial: 8250_lpc18xx: Switch to use uart_read_port_properties()
In-Reply-To: <20240304123035.758700-1-andriy.shevchenko@linux.intel.com>
References: <20240304123035.758700-1-andriy.shevchenko@linux.intel.com>
Message-ID: <20240304123035.758700-10-andriy.shevchenko@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Since we have now a common helper to read port properties
use it instead of sparse home grown solution.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_lpc18xx.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_lpc18xx.c b/drivers/tty/serial/8250/8250_lpc18xx.c
index 8d728a6a5991..7984ee05af1d 100644
--- a/drivers/tty/serial/8250/8250_lpc18xx.c
+++ b/drivers/tty/serial/8250/8250_lpc18xx.c
@@ -92,11 +92,7 @@ static int lpc18xx_serial_probe(struct platform_device *pdev)
 	struct lpc18xx_uart_data *data;
 	struct uart_8250_port uart;
 	struct resource *res;
-	int irq, ret;
-
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
+	int ret;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
@@ -139,19 +135,12 @@ static int lpc18xx_serial_probe(struct platform_device *pdev)
 		goto dis_clk_reg;
 	}
 
-	ret = of_alias_get_id(pdev->dev.of_node, "serial");
-	if (ret >= 0)
-		uart.port.line = ret;
-
 	data->dma.rx_param = data;
 	data->dma.tx_param = data;
 
 	spin_lock_init(&uart.port.lock);
 	uart.port.dev = &pdev->dev;
-	uart.port.irq = irq;
-	uart.port.iotype = UPIO_MEM32;
 	uart.port.mapbase = res->start;
-	uart.port.regshift = 2;
 	uart.port.type = PORT_16550A;
 	uart.port.flags = UPF_FIXED_PORT | UPF_FIXED_TYPE | UPF_SKIP_TEST;
 	uart.port.uartclk = clk_get_rate(data->clk_uart);
@@ -160,6 +149,13 @@ static int lpc18xx_serial_probe(struct platform_device *pdev)
 	uart.port.rs485_supported = lpc18xx_rs485_supported;
 	uart.port.serial_out = lpc18xx_uart_serial_out;
 
+	ret = uart_read_port_properties(&uart.port);
+	if (ret)
+		return ret;
+
+	uart.port.iotype = UPIO_MEM32;
+	uart.port.regshift = 2;
+
 	uart.dma = &data->dma;
 	uart.dma->rxconf.src_maxburst = 1;
 	uart.dma->txconf.dst_maxburst = 1;
-- 
2.43.0.rc1.1.gbec44491f096

