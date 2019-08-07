From: Nathan Chancellor <natechancellor@gmail.com>
Date: Tue,  6 Aug 2019 17:30:37 -0700
Subject: [PATCH] pinctrl: aspeed: g6: Remove const specifier from
 aspeed_g6_sig_expr_set's ctx parameter
Message-ID: <20190807003037.48457-1-natechancellor@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

clang errors:

drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c:2325:9: error: incompatible
pointer types initializing 'int (*)(struct aspeed_pinmux_data *, const
struct aspeed_sig_expr *, bool)' with an expression of type 'int (const
struct aspeed_pinmux_data *, const struct aspeed_sig_expr *, bool)'
[-Werror,-Wincompatible-pointer-types]
        .set = aspeed_g6_sig_expr_set,
               ^~~~~~~~~~~~~~~~~~~~~~
1 error generated.

Commit 674fa8daa8c9 ("pinctrl: aspeed-g5: Delay acquisition of regmaps")
changed the set function pointer declaration and the g6 one wasn't
updated (I assume because it wasn't merged yet).

Fixes: 2eda1cdec49f ("pinctrl: aspeed: Add AST2600 pinmux support")
Link: https://github.com/ClangBuiltLinux/linux/issues/632
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c b/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
index 6012d7d4a22a..648ddb7f038a 100644
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
@@ -2267,7 +2267,7 @@ static const struct aspeed_pin_function aspeed_g6_functions[] = {
  * Return: 0 if the expression is configured as requested and a negative error
  * code otherwise
  */
-static int aspeed_g6_sig_expr_set(const struct aspeed_pinmux_data *ctx,
+static int aspeed_g6_sig_expr_set(struct aspeed_pinmux_data *ctx,
 				  const struct aspeed_sig_expr *expr,
 				  bool enable)
 {
-- 
2.23.0.rc1

