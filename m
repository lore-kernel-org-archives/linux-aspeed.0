From: Jeremy Kerr <jk@ozlabs.org>
Date: Tue, 27 Mar 2018 11:48:24 +0800
Subject: [PATCH v2 1/4] serial: Introduce UPSTAT_SYNC_FIFO for synchronised
 FIFOs
In-Reply-To: <20180327034827.20773-1-jk@ozlabs.org>
References: <20180323155116.GA31423@kroah.com>
 <20180327034827.20773-1-jk@ozlabs.org>
Message-ID: <20180327034827.20773-2-jk@ozlabs.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This change adds a flag to indicate that a UART is has an external means
of synchronising its FIFO, without needing CTSRTS or XON/XOFF.

This allows us to use the throttle/unthrottle callbacks, without having
to claim other methods of flow control.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Tested-by: Eddie James <eajames@linux.vnet.ibm.com>

--
v2:
 - simplify status mask checks
---
 drivers/tty/serial/serial_core.c | 4 ++--
 include/linux/serial_core.h      | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 0466f9f08a91..c47158c93202 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -674,8 +674,8 @@ static void uart_send_xchar(struct tty_struct *tty, char ch)
 static void uart_throttle(struct tty_struct *tty)
 {
 	struct uart_state *state = tty->driver_data;
+	upstat_t mask = UPSTAT_SYNC_FIFO;
 	struct uart_port *port;
-	upstat_t mask = 0;
 
 	port = uart_port_ref(state);
 	if (!port)
@@ -703,8 +703,8 @@ static void uart_throttle(struct tty_struct *tty)
 static void uart_unthrottle(struct tty_struct *tty)
 {
 	struct uart_state *state = tty->driver_data;
+	upstat_t mask = UPSTAT_SYNC_FIFO;
 	struct uart_port *port;
-	upstat_t mask = 0;
 
 	port = uart_port_ref(state);
 	if (!port)
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 1d356105f25a..d224961e1346 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -233,6 +233,7 @@ struct uart_port {
 #define UPSTAT_AUTORTS		((__force upstat_t) (1 << 2))
 #define UPSTAT_AUTOCTS		((__force upstat_t) (1 << 3))
 #define UPSTAT_AUTOXOFF		((__force upstat_t) (1 << 4))
+#define UPSTAT_SYNC_FIFO	((__force upstat_t) (1 << 5))
 
 	int			hw_stopped;		/* sw-assisted CTS flow state */
 	unsigned int		mctrl;			/* current modem ctrl settings */
-- 
2.14.1

