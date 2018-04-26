From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Thu, 26 Apr 2018 08:50:55 +0300
Subject: [PATCH] serial/aspeed-vuart: fix a couple mod_timer() calls
Message-ID: <20180426055055.GA9742@mwanda>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The "unthrottle_timeout" is HZ/10 but mod_timer() takes a the actual
jiffie where you want it to timeout, not an offset.

Fixes: 5909c0bf9c7a ("serial/aspeed-vuart: Implement quick throttle mechanism")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
index 023db3266757..435bec40dee6 100644
--- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
+++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
@@ -226,7 +226,8 @@ static void aspeed_vuart_unthrottle_exp(struct timer_list *timer)
 	struct uart_8250_port *up = vuart->port;
 
 	if (!tty_buffer_space_avail(&up->port.state->port)) {
-		mod_timer(&vuart->unthrottle_timer, unthrottle_timeout);
+		mod_timer(&vuart->unthrottle_timer,
+			  jiffies + unthrottle_timeout);
 		return;
 	}
 
@@ -271,7 +272,7 @@ static int aspeed_vuart_handle_irq(struct uart_port *port)
 			if (!timer_pending(&vuart->unthrottle_timer)) {
 				vuart->port = up;
 				mod_timer(&vuart->unthrottle_timer,
-						unthrottle_timeout);
+					  jiffies + unthrottle_timeout);
 			}
 
 		} else {
