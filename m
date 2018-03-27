From: Jeremy Kerr <jk@ozlabs.org>
Date: Tue, 27 Mar 2018 11:48:25 +0800
Subject: [PATCH v2 2/4] serial/8250: export serial8250_read_char
In-Reply-To: <20180327034827.20773-1-jk@ozlabs.org>
References: <20180323155116.GA31423@kroah.com>
 <20180327034827.20773-1-jk@ozlabs.org>
Message-ID: <20180327034827.20773-3-jk@ozlabs.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Currently, we export serial8250_rx_chars, which does a whole bunch of
reads from the 8250 data register, without any form of flow control
between reads.

An upcoming change to the aspeed vuart driver implements more
fine-grained flow control in the interrupt handler, requiring
character-at-a-time control over the rx path.

This change exports serial8250_read_char to allow this.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Tested-by: Eddie James <eajames@linux.vnet.ibm.com>
---
 drivers/tty/serial/8250/8250_port.c | 3 ++-
 include/linux/serial_8250.h         | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 95833cbc4338..8fbd5fbeb318 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1680,7 +1680,7 @@ static void serial8250_enable_ms(struct uart_port *port)
 	serial8250_rpm_put(up);
 }
 
-static void serial8250_read_char(struct uart_8250_port *up, unsigned char lsr)
+void serial8250_read_char(struct uart_8250_port *up, unsigned char lsr)
 {
 	struct uart_port *port = &up->port;
 	unsigned char ch;
@@ -1740,6 +1740,7 @@ static void serial8250_read_char(struct uart_8250_port *up, unsigned char lsr)
 
 	uart_insert_char(port, lsr, UART_LSR_OE, ch, flag);
 }
+EXPORT_SYMBOL_GPL(serial8250_read_char);
 
 /*
  * serial8250_rx_chars: processes according to the passed in LSR
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index a27ef5f56431..76b9db71e489 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -163,6 +163,7 @@ extern void serial8250_do_set_mctrl(struct uart_port *port, unsigned int mctrl);
 extern int fsl8250_handle_irq(struct uart_port *port);
 int serial8250_handle_irq(struct uart_port *port, unsigned int iir);
 unsigned char serial8250_rx_chars(struct uart_8250_port *up, unsigned char lsr);
+void serial8250_read_char(struct uart_8250_port *up, unsigned char lsr);
 void serial8250_tx_chars(struct uart_8250_port *up);
 unsigned int serial8250_modem_status(struct uart_8250_port *up);
 void serial8250_init_port(struct uart_8250_port *up);
-- 
2.14.1

