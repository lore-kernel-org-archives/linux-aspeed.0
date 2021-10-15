From: Qing Wang <wangqing@vivo.com>
Date: Thu, 14 Oct 2021 23:51:22 -0700
Subject: [PATCH] tty: 8250: replace snprintf in show functions with sysfs_emit
Message-ID: <1634280682-5002-1-git-send-email-wangqing@vivo.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

show() must not use snprintf() when formatting the value to be
returned to user space.

Fix the coccicheck warnings:
WARNING: use scnprintf or sprintf.

Signed-off-by: Qing Wang <wangqing@vivo.com>
---
 drivers/tty/serial/8250/8250_aspeed_vuart.c | 6 +++---
 drivers/tty/serial/8250/8250_port.c         | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
index 2350fb3..082b9bd 100644
--- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
+++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
@@ -82,7 +82,7 @@ static ssize_t lpc_address_show(struct device *dev,
 	addr = (aspeed_vuart_readb(vuart, ASPEED_VUART_ADDRH) << 8) |
 		(aspeed_vuart_readb(vuart, ASPEED_VUART_ADDRL));
 
-	return snprintf(buf, PAGE_SIZE - 1, "0x%x\n", addr);
+	return sysfs_emit(buf - 1, "0x%x\n", addr);
 }
 
 static int aspeed_vuart_set_lpc_address(struct aspeed_vuart *vuart, u32 addr)
@@ -124,7 +124,7 @@ static ssize_t sirq_show(struct device *dev,
 	reg &= ASPEED_VUART_GCRB_HOST_SIRQ_MASK;
 	reg >>= ASPEED_VUART_GCRB_HOST_SIRQ_SHIFT;
 
-	return snprintf(buf, PAGE_SIZE - 1, "%u\n", reg);
+	return sysfs_emit(buf - 1, "%u\n", reg);
 }
 
 static int aspeed_vuart_set_sirq(struct aspeed_vuart *vuart, u32 sirq)
@@ -171,7 +171,7 @@ static ssize_t sirq_polarity_show(struct device *dev,
 	reg = aspeed_vuart_readb(vuart, ASPEED_VUART_GCRA);
 	reg &= ASPEED_VUART_GCRA_HOST_SIRQ_POLARITY;
 
-	return snprintf(buf, PAGE_SIZE - 1, "%u\n", reg ? 1 : 0);
+	return sysfs_emit(buf - 1, "%u\n", reg ? 1 : 0);
 }
 
 static void aspeed_vuart_set_sirq_polarity(struct aspeed_vuart *vuart,
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 1da29a2..635cc42 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3085,7 +3085,7 @@ static ssize_t rx_trig_bytes_show(struct device *dev,
 	if (rxtrig_bytes < 0)
 		return rxtrig_bytes;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", rxtrig_bytes);
+	return sysfs_emit(buf, "%d\n", rxtrig_bytes);
 }
 
 static int do_set_rxtrig(struct tty_port *port, unsigned char bytes)
-- 
2.7.4

