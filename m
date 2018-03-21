From: Jeremy Kerr <jk@ozlabs.org>
Date: Wed, 21 Mar 2018 10:52:41 +0800
Subject: [PATCH 5/5] serial/aspeed-vuart: Implement quick throttle mechanism
In-Reply-To: <20180321025241.19785-1-jk@ozlabs.org>
References: <20180321025241.19785-1-jk@ozlabs.org>
Message-ID: <20180321025241.19785-6-jk@ozlabs.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Although we populate the ->throttle and ->unthrottle UART operations,
these may not be called until the ldisc has had a chance to schedule and
check buffer space. This means that we may overflow the flip buffers
without ever hitting the ldisc's throttle threshold.

This change implements an interrupt-based throttle, where we check for
space in the flip buffers before reading characters from the UART's
FIFO. If there's no space available, we disable the RX interrupt and
schedule a timer to check for space later.

This prevents a case where we drop characters under heavy RX load.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
---
 drivers/tty/serial/8250/8250_aspeed_vuart.c | 103 ++++++++++++++++++++++++++--
 1 file changed, 99 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
index 50c082b4a1ac..bc2b63578e58 100644
--- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
+++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
@@ -14,6 +14,8 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
+#include <linux/tty.h>
+#include <linux/tty_flip.h>
 #include <linux/clk.h>
 
 #include "8250.h"
@@ -32,8 +34,16 @@ struct aspeed_vuart {
 	void __iomem		*regs;
 	struct clk		*clk;
 	int			line;
+	struct timer_list	unthrottle_timer;
 };
 
+/*
+ * If we fill the tty flip buffers, we throttle the data ready interrupt
+ * to prevent dropped characters. This timeout defines how long we wait
+ * to (conditionally, depending on buffer state) unthrottle.
+ */
+static const int unthrottle_timeout = HZ/10;
+
 /*
  * The VUART is basically two UART 'front ends' connected by their FIFO
  * (no actual serial line in between). One is on the BMC side (management
@@ -183,17 +193,23 @@ static void aspeed_vuart_shutdown(struct uart_port *uart_port)
 	serial8250_do_shutdown(uart_port);
 }
 
-static void aspeed_vuart_set_throttle(struct uart_port *port, bool throttle)
+static void __aspeed_vuart_set_throttle(struct uart_8250_port *up,
+		bool throttle)
 {
 	unsigned char irqs = UART_IER_RLSI | UART_IER_RDI;
-	struct uart_8250_port *up = up_to_u8250p(port);
-	unsigned long flags;
 
-	spin_lock_irqsave(&port->lock, flags);
 	up->ier &= ~irqs;
 	if (!throttle)
 		up->ier |= irqs;
 	serial_out(up, UART_IER, up->ier);
+}
+static void aspeed_vuart_set_throttle(struct uart_port *port, bool throttle)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+	unsigned long flags;
+
+	spin_lock_irqsave(&port->lock, flags);
+	__aspeed_vuart_set_throttle(up, throttle);
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
@@ -207,6 +223,81 @@ static void aspeed_vuart_unthrottle(struct uart_port *port)
 	aspeed_vuart_set_throttle(port, false);
 }
 
+static void aspeed_vuart_unthrottle_exp(unsigned long data)
+{
+	struct uart_8250_port *up = (void *)data;
+	struct aspeed_vuart *vuart = up->port.private_data;
+
+	if (!tty_buffer_space_avail(&up->port.state->port)) {
+		mod_timer(&vuart->unthrottle_timer, unthrottle_timeout);
+		return;
+	}
+
+	aspeed_vuart_unthrottle(&up->port);
+}
+
+/*
+ * Custom interrupt handler to manage finer-grained flow control. Although we
+ * have throttle/unthrottle callbacks, we've seen that the VUART device can
+ * deliver characters faster than the ldisc has a chance to check buffer space
+ * against the throttle threshold. This results in dropped characters before
+ * the throttle.
+ *
+ * We do this by checking for flip buffer space before RX. If we have no space,
+ * throttle now and schedule an unthrottle for later, once the ldisc has had
+ * a chance to drain the buffers.
+ */
+static int aspeed_vuart_handle_irq(struct uart_port *port) { struct
+	uart_8250_port *up = up_to_u8250p(port); unsigned int iir, lsr;
+	unsigned long flags; int space, count;
+
+	iir = serial_port_in(port, UART_IIR);
+
+	if (iir & UART_IIR_NO_INT)
+		return 0;
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	lsr = serial_port_in(port, UART_LSR);
+
+	if (lsr & (UART_LSR_DR | UART_LSR_BI)) {
+		space = tty_buffer_space_avail(&port->state->port);
+
+		if (!space) {
+			/* throttle and schedule an unthrottle later */
+			struct aspeed_vuart *vuart = port->private_data;
+			__aspeed_vuart_set_throttle(up, true);
+
+			if (!timer_pending(&vuart->unthrottle_timer)) {
+				vuart->unthrottle_timer.data =
+					(unsigned long)up;
+				mod_timer(&vuart->unthrottle_timer,
+						unthrottle_timeout);
+			}
+
+		} else {
+			count = min(space, 256);
+
+			do {
+				serial8250_read_char(up, lsr);
+				lsr = serial_in(up, UART_LSR);
+				if (--count == 0)
+					break;
+			} while (lsr & (UART_LSR_DR | UART_LSR_BI));
+
+			tty_flip_buffer_push(&port->state->port);
+		}
+	}
+
+	serial8250_modem_status(up);
+	if (lsr & UART_LSR_THRE)
+		serial8250_tx_chars(up);
+
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	return 1;
+}
+
 static int aspeed_vuart_probe(struct platform_device *pdev)
 {
 	struct uart_8250_port port;
@@ -223,6 +314,8 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	vuart->dev = &pdev->dev;
+	setup_timer(&vuart->unthrottle_timer,
+			aspeed_vuart_unthrottle_exp, (unsigned long)vuart);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	vuart->regs = devm_ioremap_resource(&pdev->dev, res);
@@ -284,6 +377,7 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
 
 	port.port.irq = irq_of_parse_and_map(np, 0);
 	port.port.irqflags = IRQF_SHARED;
+	port.port.handle_irq = aspeed_vuart_handle_irq;
 	port.port.iotype = UPIO_MEM;
 	port.port.type = PORT_16550A;
 	port.port.uartclk = clk;
@@ -323,6 +417,7 @@ static int aspeed_vuart_remove(struct platform_device *pdev)
 {
 	struct aspeed_vuart *vuart = platform_get_drvdata(pdev);
 
+	del_timer_sync(&vuart->unthrottle_timer);
 	aspeed_vuart_set_enabled(vuart, false);
 	serial8250_unregister_port(vuart->line);
 	sysfs_remove_group(&vuart->dev->kobj, &aspeed_vuart_attr_group);
-- 
2.14.1

