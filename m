From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Wed, 21 Feb 2024 20:31:30 +0200
Subject: [PATCH v1 14/14] serial: 8250_uniphier: Switch to use uart_read_port_properties()
In-Reply-To: <20240221183442.4124354-1-andriy.shevchenko@linux.intel.com>
References: <20240221183442.4124354-1-andriy.shevchenko@linux.intel.com>
Message-ID: <20240221183442.4124354-15-andriy.shevchenko@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Since we have now a common helper to read port properties
use it instead of sparse home grown solution.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_uniphier.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_uniphier.c b/drivers/tty/serial/8250/8250_uniphier.c
index 6399a38ecce2..d3f270a191ee 100644
--- a/drivers/tty/serial/8250/8250_uniphier.c
+++ b/drivers/tty/serial/8250/8250_uniphier.c
@@ -162,7 +162,6 @@ static int uniphier_uart_probe(struct platform_device *pdev)
 	struct uniphier8250_priv *priv;
 	struct resource *regs;
 	void __iomem *membase;
-	int irq;
 	int ret;
 
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -175,23 +174,12 @@ static int uniphier_uart_probe(struct platform_device *pdev)
 	if (!membase)
 		return -ENOMEM;
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
-
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
 	memset(&up, 0, sizeof(up));
 
-	ret = of_alias_get_id(dev->of_node, "serial");
-	if (ret < 0) {
-		dev_err(dev, "failed to get alias id\n");
-		return ret;
-	}
-	up.port.line = ret;
-
 	priv->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(priv->clk)) {
 		dev_err(dev, "failed to get clock\n");
@@ -211,7 +199,10 @@ static int uniphier_uart_probe(struct platform_device *pdev)
 	up.port.mapbase = regs->start;
 	up.port.mapsize = resource_size(regs);
 	up.port.membase = membase;
-	up.port.irq = irq;
+
+	ret = uart_read_port_properties(&up.port, true);
+	if (ret)
+		return ret;
 
 	up.port.type = PORT_16550A;
 	up.port.iotype = UPIO_MEM32;
-- 
2.43.0.rc1.1.gbec44491f096

