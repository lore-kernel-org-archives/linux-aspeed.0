From: Dmitry Safonov <dima@arista.com>
Date: Fri, 13 Dec 2019 00:06:03 +0000
Subject: [PATCH 04/58] tty/serial: Migrate aspeed_vuart to use has_sysrq
In-Reply-To: <20191213000657.931618-1-dima@arista.com>
References: <20191213000657.931618-1-dima@arista.com>
Message-ID: <20191213000657.931618-5-dima@arista.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The SUPPORT_SYSRQ ifdeffery is not nice as:
- May create misunderstanding about sizeof(struct uart_port) between
  different objects
- Prevents moving functions from serial_core.h
- Reduces readability (well, it's ifdeffery - it's hard to follow)

In order to remove SUPPORT_SYSRQ, has_sysrq variable has been added.
Initialise it in driver's probe and remove ifdeffery.

Cc: Andrew Jeffery <andrew@aj.id.au>
Cc: Joel Stanley <joel@jms.id.au>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-aspeed at lists.ozlabs.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/serial/8250/8250_aspeed_vuart.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
index 6e67fd89445a..d657aa14c3e4 100644
--- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
+++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
@@ -5,10 +5,6 @@
  *    Copyright (C) 2016 Jeremy Kerr <jk@ozlabs.org>, IBM Corp.
  *    Copyright (C) 2006 Arnd Bergmann <arnd@arndb.de>, IBM Corp.
  */
-#if defined(CONFIG_SERIAL_8250_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
-#define SUPPORT_SYSRQ
-#endif
-
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
@@ -406,6 +402,7 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
 	port.port.unthrottle = aspeed_vuart_unthrottle;
 	port.port.status = UPSTAT_SYNC_FIFO;
 	port.port.dev = &pdev->dev;
+	port.port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_8250_CONSOLE);
 
 	rc = sysfs_create_group(&vuart->dev->kobj, &aspeed_vuart_attr_group);
 	if (rc < 0)
-- 
2.24.0

