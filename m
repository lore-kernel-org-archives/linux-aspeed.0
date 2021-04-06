From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Date: Tue,  6 Apr 2021 11:59:58 +0800
Subject: [PATCH] usb: gadget: aspeed: Remove unnecessary version.h includes
Message-ID: <1617681598-28165-1-git-send-email-jiapeng.chong@linux.alibaba.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

"make versioncheck" shows:

./drivers/usb/gadget/udc/aspeed-vhub/hub.c: 33 linux/version.h not
needed.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/usb/gadget/udc/aspeed-vhub/hub.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/aspeed-vhub/hub.c b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
index 5c7dea5..e5bbc0c 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/hub.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
@@ -30,7 +30,6 @@
 #include <linux/regmap.h>
 #include <linux/dma-mapping.h>
 #include <linux/bcd.h>
-#include <linux/version.h>
 #include <linux/usb.h>
 #include <linux/usb/hcd.h>
 
-- 
1.8.3.1

