From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 29 Aug 2019 16:47:38 +0930
Subject: [PATCH pinctrl/fixes] pinctrl: aspeed: Fix spurious mux failures on
 the AST2500
Message-ID: <20190829071738.2523-1-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Commit 674fa8daa8c9 ("pinctrl: aspeed-g5: Delay acquisition of regmaps")
was determined to be a partial fix to the problem of acquiring the LPC
Host Controller and GFX regmaps: The AST2500 pin controller may need to
fetch syscon regmaps during expression evaluation as well as when
setting mux state. For example, this case is hit by attempting to export
pins exposing the LPC Host Controller as GPIOs.

An optional eval() hook is added to the Aspeed pinmux operation struct
and called from aspeed_sig_expr_eval() if the pointer is set by the
SoC-specific driver. This enables the AST2500 to perform the custom
action of acquiring its regmap dependencies as required.

John Wang tested the fix on an Inspur FP5280G2 machine (AST2500-based)
where the issue was found, and I've booted the fix on Witherspoon
(AST2500) and Palmetto (AST2400) machines, and poked at relevant pins
under QEMU by forcing mux configurations via devmem before exporting
GPIOs to exercise the driver.

Fixes: 7d29ed88acbb ("pinctrl: aspeed: Read and write bits in LPC and GFX controllers")
Fixes: 674fa8daa8c9 ("pinctrl: aspeed-g5: Delay acquisition of regmaps")
Reported-by: John Wang <wangzqbj@inspur.com>
Tested-by: John Wang <wangzqbj@inspur.com>
Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

---
Hi Linus,

The timing of merging the AST2600 (g6) driver and 674fa8daa8c9 ("pinctrl:
aspeed-g5: Delay acquisition of regmaps") caused a bit of a rough spot a
few weeks back. This fix doesn't cause any such disruption - I've
developed it on top of pinctrl/fixes and back-merged the result into
pinctrl/devel to test for build breakage (via CONFIG_COMPILE_TEST to
enable all of the g4, g5 and g6 drivers). All three ASPEED pinctrl
drivers built successfully, so it should be enough to simply take this
patch through pinctrl/fixes and leave pinctrl/devel as is for the 5.4
merge window.
---
 drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c | 30 +++++++++++++++++++++-
 drivers/pinctrl/aspeed/pinmux-aspeed.c     |  7 +++--
 drivers/pinctrl/aspeed/pinmux-aspeed.h     |  7 ++---
 3 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c b/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
index ba6438ac4d72..ff84d1afd229 100644
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
@@ -2552,7 +2552,7 @@ static struct regmap *aspeed_g5_acquire_regmap(struct aspeed_pinmux_data *ctx,
 			if (IS_ERR(map))
 				return map;
 		} else
-			map = ERR_PTR(-ENODEV);
+			return ERR_PTR(-ENODEV);
 
 		ctx->maps[ASPEED_IP_LPC] = map;
 		dev_dbg(ctx->dev, "Acquired LPC regmap");
@@ -2562,6 +2562,33 @@ static struct regmap *aspeed_g5_acquire_regmap(struct aspeed_pinmux_data *ctx,
 	return ERR_PTR(-EINVAL);
 }
 
+static int aspeed_g5_sig_expr_eval(struct aspeed_pinmux_data *ctx,
+				   const struct aspeed_sig_expr *expr,
+				   bool enabled)
+{
+	int ret;
+	int i;
+
+	for (i = 0; i < expr->ndescs; i++) {
+		const struct aspeed_sig_desc *desc = &expr->descs[i];
+		struct regmap *map;
+
+		map = aspeed_g5_acquire_regmap(ctx, desc->ip);
+		if (IS_ERR(map)) {
+			dev_err(ctx->dev,
+				"Failed to acquire regmap for IP block %d\n",
+				desc->ip);
+			return PTR_ERR(map);
+		}
+
+		ret = aspeed_sig_desc_eval(desc, enabled, ctx->maps[desc->ip]);
+		if (ret <= 0)
+			return ret;
+	}
+
+	return 1;
+}
+
 /**
  * Configure a pin's signal by applying an expression's descriptor state for
  * all descriptors in the expression.
@@ -2647,6 +2674,7 @@ static int aspeed_g5_sig_expr_set(struct aspeed_pinmux_data *ctx,
 }
 
 static const struct aspeed_pinmux_ops aspeed_g5_ops = {
+	.eval = aspeed_g5_sig_expr_eval,
 	.set = aspeed_g5_sig_expr_set,
 };
 
diff --git a/drivers/pinctrl/aspeed/pinmux-aspeed.c b/drivers/pinctrl/aspeed/pinmux-aspeed.c
index 839c01b7953f..57305ca838a7 100644
--- a/drivers/pinctrl/aspeed/pinmux-aspeed.c
+++ b/drivers/pinctrl/aspeed/pinmux-aspeed.c
@@ -78,11 +78,14 @@ int aspeed_sig_desc_eval(const struct aspeed_sig_desc *desc,
  * neither the enabled nor disabled state. Thus we must explicitly test for
  * either condition as required.
  */
-int aspeed_sig_expr_eval(const struct aspeed_pinmux_data *ctx,
+int aspeed_sig_expr_eval(struct aspeed_pinmux_data *ctx,
 			 const struct aspeed_sig_expr *expr, bool enabled)
 {
+	int ret;
 	int i;
-	int ret;
+
+	if (ctx->ops->eval)
+		return ctx->ops->eval(ctx, expr, enabled);
 
 	for (i = 0; i < expr->ndescs; i++) {
 		const struct aspeed_sig_desc *desc = &expr->descs[i];
diff --git a/drivers/pinctrl/aspeed/pinmux-aspeed.h b/drivers/pinctrl/aspeed/pinmux-aspeed.h
index 52d299b59ce2..db3457c86f48 100644
--- a/drivers/pinctrl/aspeed/pinmux-aspeed.h
+++ b/drivers/pinctrl/aspeed/pinmux-aspeed.h
@@ -702,6 +702,8 @@ struct aspeed_pin_function {
 struct aspeed_pinmux_data;
 
 struct aspeed_pinmux_ops {
+	int (*eval)(struct aspeed_pinmux_data *ctx,
+		    const struct aspeed_sig_expr *expr, bool enabled);
 	int (*set)(struct aspeed_pinmux_data *ctx,
 		   const struct aspeed_sig_expr *expr, bool enabled);
 };
@@ -722,9 +724,8 @@ struct aspeed_pinmux_data {
 int aspeed_sig_desc_eval(const struct aspeed_sig_desc *desc, bool enabled,
 			 struct regmap *map);
 
-int aspeed_sig_expr_eval(const struct aspeed_pinmux_data *ctx,
-			 const struct aspeed_sig_expr *expr,
-			 bool enabled);
+int aspeed_sig_expr_eval(struct aspeed_pinmux_data *ctx,
+			 const struct aspeed_sig_expr *expr, bool enabled);
 
 static inline int aspeed_sig_expr_set(struct aspeed_pinmux_data *ctx,
 				      const struct aspeed_sig_expr *expr,
-- 
2.20.1

