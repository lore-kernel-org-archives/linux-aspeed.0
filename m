From: Xiang wangx <wangxiang@cdjrlc.com>
Date: Sat, 18 Jun 2022 21:08:54 +0800
Subject: [PATCH] pinctrl: aspeed: Fix typo in comment
Message-ID: <20220618130854.12321-1-wangxiang@cdjrlc.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Delete the redundant word 'and'.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 drivers/pinctrl/aspeed/pinmux-aspeed.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/aspeed/pinmux-aspeed.h b/drivers/pinctrl/aspeed/pinmux-aspeed.h
index 4d7548686f39..aaa78a613196 100644
--- a/drivers/pinctrl/aspeed/pinmux-aspeed.h
+++ b/drivers/pinctrl/aspeed/pinmux-aspeed.h
@@ -632,7 +632,7 @@ struct aspeed_pin_desc {
 	SIG_EXPR_LIST_ALIAS(pin, sig, group)
 
 /**
- * Similar to the above, but for pins with a dual expressions (DE) and
+ * Similar to the above, but for pins with a dual expressions (DE)
  * and a single group (SG) of pins.
  *
  * @pin: The pin the signal will be routed to
-- 
2.36.1

