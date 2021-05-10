From: Zev Weiss <zev@bewilderbeest.net>
Date: Sun,  9 May 2021 20:42:31 -0500
Subject: [PATCH 3/3] serial: 8250_aspeed_vuart: use UPF_IOREMAP to set up
 register mapping
In-Reply-To: <20210510014231.647-1-zev@bewilderbeest.net>
References: <20210510014231.647-1-zev@bewilderbeest.net>
Message-ID: <20210510014231.647-4-zev@bewilderbeest.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Previously this driver's use of devm_ioremap_resource() led to
duplicated calls to __release_region() when unbinding it (one from
serial8250_release_std_resource() and one from devres_release_all()),
the second of which resulted in a warning message:

  # echo 1e787000.serial > /sys/bus/platform/drivers/aspeed-vuart/unbind
  [33091.774200] Trying to free nonexistent resource <000000001e787000-000000001e78703f>

With this change the driver uses the generic serial8250 code's
UPF_IOREMAP to take care of the register mapping automatically instead
of doing its own devm_ioremap_resource(), thus avoiding the duplicate
__release_region() on unbind.

In doing this we eliminate vuart->regs, since it merely duplicates
vuart->port->port.membase, which we now use for our I/O accesses.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
Reported-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/tty/serial/8250/8250_aspeed_vuart.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
index 249164dc397b..2bf1d8582d9a 100644
--- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
+++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
@@ -34,7 +34,6 @@
 
 struct aspeed_vuart {
 	struct device		*dev;
-	void __iomem		*regs;
 	struct clk		*clk;
 	int			line;
 	struct timer_list	unthrottle_timer;
@@ -66,12 +65,12 @@ static const int unthrottle_timeout = HZ/10;
 
 static inline u8 aspeed_vuart_readb(struct aspeed_vuart *vuart, u8 reg)
 {
-	return readb(vuart->regs + reg);
+	return readb(vuart->port->port.membase + reg);
 }
 
 static inline void aspeed_vuart_writeb(struct aspeed_vuart *vuart, u8 val, u8 reg)
 {
-	writeb(val, vuart->regs + reg);
+	writeb(val, vuart->port->port.membase + reg);
 }
 
 static ssize_t lpc_address_show(struct device *dev,
@@ -429,13 +428,9 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
 	timer_setup(&vuart->unthrottle_timer, aspeed_vuart_unthrottle_exp, 0);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	vuart->regs = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(vuart->regs))
-		return PTR_ERR(vuart->regs);
 
 	memset(&port, 0, sizeof(port));
 	port.port.private_data = vuart;
-	port.port.membase = vuart->regs;
 	port.port.mapbase = res->start;
 	port.port.mapsize = resource_size(res);
 	port.port.startup = aspeed_vuart_startup;
@@ -492,7 +487,7 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
 	port.port.iotype = UPIO_MEM;
 	port.port.type = PORT_16550A;
 	port.port.uartclk = clk;
-	port.port.flags = UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF
+	port.port.flags = UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF | UPF_IOREMAP
 		| UPF_FIXED_PORT | UPF_FIXED_TYPE | UPF_NO_THRE_TEST;
 
 	if (of_property_read_bool(np, "no-loopback-test"))
-- 
2.31.1

