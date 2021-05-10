From: Zev Weiss <zev@bewilderbeest.net>
Date: Sun,  9 May 2021 20:42:30 -0500
Subject: [PATCH 2/3] serial: 8250_aspeed_vuart: initialize vuart->port in
 aspeed_vuart_probe()
In-Reply-To: <20210510014231.647-1-zev@bewilderbeest.net>
References: <20210510014231.647-1-zev@bewilderbeest.net>
Message-ID: <20210510014231.647-3-zev@bewilderbeest.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Previously this had only been initialized if we hit the throttling path
in aspeed_vuart_handle_irq(); moving it to the probe function is a
slight consistency improvement and avoids redundant reinitialization in
the interrupt handler.  It also serves as preparation for converting the
driver's I/O accesses to use port->port.membase instead of its own
vuart->regs.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 drivers/tty/serial/8250/8250_aspeed_vuart.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
index 9e8b2e8e32b6..249164dc397b 100644
--- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
+++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
@@ -349,11 +349,9 @@ static int aspeed_vuart_handle_irq(struct uart_port *port)
 			struct aspeed_vuart *vuart = port->private_data;
 			__aspeed_vuart_set_throttle(up, true);
 
-			if (!timer_pending(&vuart->unthrottle_timer)) {
-				vuart->port = up;
+			if (!timer_pending(&vuart->unthrottle_timer))
 				mod_timer(&vuart->unthrottle_timer,
 					  jiffies + unthrottle_timeout);
-			}
 
 		} else {
 			count = min(space, 256);
@@ -511,6 +509,7 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
 		goto err_clk_disable;
 
 	vuart->line = rc;
+	vuart->port = serial8250_get_port(vuart->line);
 
 	rc = of_parse_phandle_with_fixed_args(
 		np, "aspeed,sirq-polarity-sense", 2, 0,
-- 
2.31.1

