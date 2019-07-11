From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 11 Jul 2019 22:24:57 +0800
Subject: [PATCH -next] pinctrl: aspeed: Make aspeed_pinmux_ips static
Message-ID: <20190711142457.37028-1-yuehaibing@huawei.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Fix sparse warning:

drivers/pinctrl/aspeed/pinmux-aspeed.c:8:12: warning:
 symbol 'aspeed_pinmux_ips' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/pinctrl/aspeed/pinmux-aspeed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/aspeed/pinmux-aspeed.c b/drivers/pinctrl/aspeed/pinmux-aspeed.c
index 5b0fe17..839c01b 100644
--- a/drivers/pinctrl/aspeed/pinmux-aspeed.c
+++ b/drivers/pinctrl/aspeed/pinmux-aspeed.c
@@ -5,7 +5,7 @@
 
 #include "pinmux-aspeed.h"
 
-const char *const aspeed_pinmux_ips[] = {
+static const char *const aspeed_pinmux_ips[] = {
 	[ASPEED_IP_SCU] = "SCU",
 	[ASPEED_IP_GFX] = "GFX",
 	[ASPEED_IP_LPC] = "LPC",
-- 
2.7.4


