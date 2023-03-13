From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Mon, 13 Mar 2023 17:53:10 +0200
Subject: [PATCH v1 1/1] usb: gadget: aspeed: Rectify a bit a random header inclusion
Message-ID: <20230313155310.80022-1-andriy.shevchenko@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

It looks like the driver copied'n'pasted almost random set of
headers for its code. Rectify it a bit by removing of_gpio.h
that is not only unused, but also will be removed in the future
completely.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/gadget/udc/aspeed-vhub/core.c | 1 -
 drivers/usb/gadget/udc/aspeed-vhub/dev.c  | 1 -
 drivers/usb/gadget/udc/aspeed-vhub/ep0.c  | 1 -
 drivers/usb/gadget/udc/aspeed-vhub/epn.c  | 1 -
 drivers/usb/gadget/udc/aspeed-vhub/hub.c  | 1 -
 5 files changed, 5 deletions(-)

diff --git a/drivers/usb/gadget/udc/aspeed-vhub/core.c b/drivers/usb/gadget/udc/aspeed-vhub/core.c
index ac3ca24f8b04..86398a04a012 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/core.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/core.c
@@ -21,7 +21,6 @@
 #include <linux/clk.h>
 #include <linux/usb/gadget.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/regmap.h>
 #include <linux/dma-mapping.h>
 
diff --git a/drivers/usb/gadget/udc/aspeed-vhub/dev.c b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
index 4f3bc27c1c62..573109ca5b79 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/dev.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
@@ -21,7 +21,6 @@
 #include <linux/clk.h>
 #include <linux/usb/gadget.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/regmap.h>
 #include <linux/dma-mapping.h>
 #include <linux/usb.h>
diff --git a/drivers/usb/gadget/udc/aspeed-vhub/ep0.c b/drivers/usb/gadget/udc/aspeed-vhub/ep0.c
index b4cf46249fea..e9aa74231760 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/ep0.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/ep0.c
@@ -21,7 +21,6 @@
 #include <linux/clk.h>
 #include <linux/usb/gadget.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/regmap.h>
 #include <linux/dma-mapping.h>
 
diff --git a/drivers/usb/gadget/udc/aspeed-vhub/epn.c b/drivers/usb/gadget/udc/aspeed-vhub/epn.c
index 56e55472daa1..148d7ec3ebf4 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/epn.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/epn.c
@@ -21,7 +21,6 @@
 #include <linux/clk.h>
 #include <linux/usb/gadget.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/regmap.h>
 #include <linux/dma-mapping.h>
 
diff --git a/drivers/usb/gadget/udc/aspeed-vhub/hub.c b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
index e2207d014620..a63e4af60a56 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/hub.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
@@ -21,7 +21,6 @@
 #include <linux/clk.h>
 #include <linux/usb/gadget.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/regmap.h>
 #include <linux/dma-mapping.h>
 #include <linux/bcd.h>
-- 
2.39.2

