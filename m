From: Zev Weiss <zev@bewilderbeest.net>
Date: Sun,  9 May 2021 20:42:29 -0500
Subject: [PATCH 1/3] serial: 8250_aspeed_vuart: factor out aspeed_vuart_{read,
 write}b() helper functions
In-Reply-To: <20210510014231.647-1-zev@bewilderbeest.net>
References: <20210510014231.647-1-zev@bewilderbeest.net>
Message-ID: <20210510014231.647-2-zev@bewilderbeest.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This is a small prepatory step for changing the way this driver does
its I/O accesses.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 drivers/tty/serial/8250/8250_aspeed_vuart.c | 38 +++++++++++++--------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
index 61550f24a2d3..9e8b2e8e32b6 100644
--- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
+++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
@@ -64,14 +64,24 @@ static const int unthrottle_timeout = HZ/10;
  * different system (though most of them use 3f8/4).
  */
 
+static inline u8 aspeed_vuart_readb(struct aspeed_vuart *vuart, u8 reg)
+{
+	return readb(vuart->regs + reg);
+}
+
+static inline void aspeed_vuart_writeb(struct aspeed_vuart *vuart, u8 val, u8 reg)
+{
+	writeb(val, vuart->regs + reg);
+}
+
 static ssize_t lpc_address_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	struct aspeed_vuart *vuart = dev_get_drvdata(dev);
 	u16 addr;
 
-	addr = (readb(vuart->regs + ASPEED_VUART_ADDRH) << 8) |
-		(readb(vuart->regs + ASPEED_VUART_ADDRL));
+	addr = (aspeed_vuart_readb(vuart, ASPEED_VUART_ADDRH) << 8) |
+		(aspeed_vuart_readb(vuart, ASPEED_VUART_ADDRL));
 
 	return snprintf(buf, PAGE_SIZE - 1, "0x%x\n", addr);
 }
@@ -81,8 +91,8 @@ static int aspeed_vuart_set_lpc_address(struct aspeed_vuart *vuart, u32 addr)
 	if (addr > U16_MAX)
 		return -EINVAL;
 
-	writeb(addr >> 8, vuart->regs + ASPEED_VUART_ADDRH);
-	writeb(addr >> 0, vuart->regs + ASPEED_VUART_ADDRL);
+	aspeed_vuart_writeb(vuart, addr >> 8, ASPEED_VUART_ADDRH);
+	aspeed_vuart_writeb(vuart, addr >> 0, ASPEED_VUART_ADDRL);
 
 	return 0;
 }
@@ -111,7 +121,7 @@ static ssize_t sirq_show(struct device *dev,
 	struct aspeed_vuart *vuart = dev_get_drvdata(dev);
 	u8 reg;
 
-	reg = readb(vuart->regs + ASPEED_VUART_GCRB);
+	reg = aspeed_vuart_readb(vuart, ASPEED_VUART_GCRB);
 	reg &= ASPEED_VUART_GCRB_HOST_SIRQ_MASK;
 	reg >>= ASPEED_VUART_GCRB_HOST_SIRQ_SHIFT;
 
@@ -128,10 +138,10 @@ static int aspeed_vuart_set_sirq(struct aspeed_vuart *vuart, u32 sirq)
 	sirq <<= ASPEED_VUART_GCRB_HOST_SIRQ_SHIFT;
 	sirq &= ASPEED_VUART_GCRB_HOST_SIRQ_MASK;
 
-	reg = readb(vuart->regs + ASPEED_VUART_GCRB);
+	reg = aspeed_vuart_readb(vuart, ASPEED_VUART_GCRB);
 	reg &= ~ASPEED_VUART_GCRB_HOST_SIRQ_MASK;
 	reg |= sirq;
-	writeb(reg, vuart->regs + ASPEED_VUART_GCRB);
+	aspeed_vuart_writeb(vuart, reg, ASPEED_VUART_GCRB);
 
 	return 0;
 }
@@ -159,7 +169,7 @@ static ssize_t sirq_polarity_show(struct device *dev,
 	struct aspeed_vuart *vuart = dev_get_drvdata(dev);
 	u8 reg;
 
-	reg = readb(vuart->regs + ASPEED_VUART_GCRA);
+	reg = aspeed_vuart_readb(vuart, ASPEED_VUART_GCRA);
 	reg &= ASPEED_VUART_GCRA_HOST_SIRQ_POLARITY;
 
 	return snprintf(buf, PAGE_SIZE - 1, "%u\n", reg ? 1 : 0);
@@ -168,14 +178,14 @@ static ssize_t sirq_polarity_show(struct device *dev,
 static void aspeed_vuart_set_sirq_polarity(struct aspeed_vuart *vuart,
 					   bool polarity)
 {
-	u8 reg = readb(vuart->regs + ASPEED_VUART_GCRA);
+	u8 reg = aspeed_vuart_readb(vuart, ASPEED_VUART_GCRA);
 
 	if (polarity)
 		reg |= ASPEED_VUART_GCRA_HOST_SIRQ_POLARITY;
 	else
 		reg &= ~ASPEED_VUART_GCRA_HOST_SIRQ_POLARITY;
 
-	writeb(reg, vuart->regs + ASPEED_VUART_GCRA);
+	aspeed_vuart_writeb(vuart, reg, ASPEED_VUART_GCRA);
 }
 
 static ssize_t sirq_polarity_store(struct device *dev,
@@ -210,14 +220,14 @@ static const struct attribute_group aspeed_vuart_attr_group = {
 
 static void aspeed_vuart_set_enabled(struct aspeed_vuart *vuart, bool enabled)
 {
-	u8 reg = readb(vuart->regs + ASPEED_VUART_GCRA);
+	u8 reg = aspeed_vuart_readb(vuart, ASPEED_VUART_GCRA);
 
 	if (enabled)
 		reg |= ASPEED_VUART_GCRA_VUART_EN;
 	else
 		reg &= ~ASPEED_VUART_GCRA_VUART_EN;
 
-	writeb(reg, vuart->regs + ASPEED_VUART_GCRA);
+	aspeed_vuart_writeb(vuart, reg, ASPEED_VUART_GCRA);
 }
 
 static void aspeed_vuart_set_host_tx_discard(struct aspeed_vuart *vuart,
@@ -225,7 +235,7 @@ static void aspeed_vuart_set_host_tx_discard(struct aspeed_vuart *vuart,
 {
 	u8 reg;
 
-	reg = readb(vuart->regs + ASPEED_VUART_GCRA);
+	reg = aspeed_vuart_readb(vuart, ASPEED_VUART_GCRA);
 
 	/* If the DISABLE_HOST_TX_DISCARD bit is set, discard is disabled */
 	if (!discard)
@@ -233,7 +243,7 @@ static void aspeed_vuart_set_host_tx_discard(struct aspeed_vuart *vuart,
 	else
 		reg &= ~ASPEED_VUART_GCRA_DISABLE_HOST_TX_DISCARD;
 
-	writeb(reg, vuart->regs + ASPEED_VUART_GCRA);
+	aspeed_vuart_writeb(vuart, reg, ASPEED_VUART_GCRA);
 }
 
 static int aspeed_vuart_startup(struct uart_port *uart_port)
-- 
2.31.1

