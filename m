From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 20 May 2021 11:43:34 +0930
Subject: [PATCH v3 2/2] serial: 8250: Use BIT(x) for UART_{CAP,BUG}_*
In-Reply-To: <20210520021334.497341-1-andrew@aj.id.au>
References: <20210520021334.497341-1-andrew@aj.id.au>
Message-ID: <20210520021334.497341-3-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

BIT(x) improves readability and safety with respect to shifts.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/tty/serial/8250/8250.h | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 34aa2714f3c9..6473361525d1 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -7,6 +7,7 @@
  *  Copyright (C) 2001 Russell King.
  */
 
+#include <linux/bits.h>
 #include <linux/serial_8250.h>
 #include <linux/serial_reg.h>
 #include <linux/dmaengine.h>
@@ -70,25 +71,25 @@ struct serial8250_config {
 	unsigned int	flags;
 };
 
-#define UART_CAP_FIFO	(1 << 8)	/* UART has FIFO */
-#define UART_CAP_EFR	(1 << 9)	/* UART has EFR */
-#define UART_CAP_SLEEP	(1 << 10)	/* UART has IER sleep */
-#define UART_CAP_AFE	(1 << 11)	/* MCR-based hw flow control */
-#define UART_CAP_UUE	(1 << 12)	/* UART needs IER bit 6 set (Xscale) */
-#define UART_CAP_RTOIE	(1 << 13)	/* UART needs IER bit 4 set (Xscale, Tegra) */
-#define UART_CAP_HFIFO	(1 << 14)	/* UART has a "hidden" FIFO */
-#define UART_CAP_RPM	(1 << 15)	/* Runtime PM is active while idle */
-#define UART_CAP_IRDA	(1 << 16)	/* UART supports IrDA line discipline */
-#define UART_CAP_MINI	(1 << 17)	/* Mini UART on BCM283X family lacks:
+#define UART_CAP_FIFO	BIT(8)	/* UART has FIFO */
+#define UART_CAP_EFR	BIT(9)	/* UART has EFR */
+#define UART_CAP_SLEEP	BIT(10)	/* UART has IER sleep */
+#define UART_CAP_AFE	BIT(11)	/* MCR-based hw flow control */
+#define UART_CAP_UUE	BIT(12)	/* UART needs IER bit 6 set (Xscale) */
+#define UART_CAP_RTOIE	BIT(13)	/* UART needs IER bit 4 set (Xscale, Tegra) */
+#define UART_CAP_HFIFO	BIT(14)	/* UART has a "hidden" FIFO */
+#define UART_CAP_RPM	BIT(15)	/* Runtime PM is active while idle */
+#define UART_CAP_IRDA	BIT(16)	/* UART supports IrDA line discipline */
+#define UART_CAP_MINI	BIT(17)	/* Mini UART on BCM283X family lacks:
 					 * STOP PARITY EPAR SPAR WLEN5 WLEN6
 					 */
 
-#define UART_BUG_QUOT	(1 << 0)	/* UART has buggy quot LSB */
-#define UART_BUG_TXEN	(1 << 1)	/* UART has buggy TX IIR status */
-#define UART_BUG_NOMSR	(1 << 2)	/* UART has buggy MSR status bits (Au1x00) */
-#define UART_BUG_THRE	(1 << 3)	/* UART has buggy THRE reassertion */
-#define UART_BUG_PARITY	(1 << 4)	/* UART mishandles parity if FIFO enabled */
-#define UART_BUG_TXRACE	(1 << 5)	/* UART Tx fails to set remote DR */
+#define UART_BUG_QUOT	BIT(0)	/* UART has buggy quot LSB */
+#define UART_BUG_TXEN	BIT(1)	/* UART has buggy TX IIR status */
+#define UART_BUG_NOMSR	BIT(2)	/* UART has buggy MSR status bits (Au1x00) */
+#define UART_BUG_THRE	BIT(3)	/* UART has buggy THRE reassertion */
+#define UART_BUG_PARITY	BIT(4)	/* UART mishandles parity if FIFO enabled */
+#define UART_BUG_TXRACE	BIT(5)	/* UART Tx fails to set remote DR */
 
 
 #ifdef CONFIG_SERIAL_8250_SHARE_IRQ
-- 
2.30.2

