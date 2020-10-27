From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Tue, 27 Oct 2020 16:44:17 +0800
Subject: [PATCH] pinctrl: aspeed: Fix GPI only function problem.
Message-ID: <20201027084417.10137-1-billy_tsai@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Some gpio pin at aspeed soc is input only and the prefix name of these
pin is "GPI" only. This patch fine-tune the condition of GPIO check from
"GPIO" to "GPI".

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/pinctrl/aspeed/pinctrl-aspeed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed.c b/drivers/pinctrl/aspeed/pinctrl-aspeed.c
index 53f3f8aec695..a2f5ede3f897 100644
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed.c
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed.c
@@ -292,7 +292,7 @@ static bool aspeed_expr_is_gpio(const struct aspeed_sig_expr *expr)
 	 *
 	 * expr->signal might look like "GPIOT3" in the GPIO case.
 	 */
-	return strncmp(expr->signal, "GPIO", 4) == 0;
+	return strncmp(expr->signal, "GPI", 3) == 0;
 }
 
 static bool aspeed_gpio_in_exprs(const struct aspeed_sig_expr **exprs)
-- 
2.17.1

