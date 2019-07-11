From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 11 Jul 2019 13:49:39 +0930
Subject: [PATCH 3/6] pinctrl: aspeed: Add PIN_DECL_3() helper
In-Reply-To: <20190711041942.23202-1-andrew@aj.id.au>
References: <20190711041942.23202-1-andrew@aj.id.au>
Message-ID: <20190711041942.23202-4-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This case is common in the AST2600, so add to the collection.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/pinctrl/aspeed/pinmux-aspeed.h | 72 ++++++++++++++------------
 1 file changed, 40 insertions(+), 32 deletions(-)

diff --git a/drivers/pinctrl/aspeed/pinmux-aspeed.h b/drivers/pinctrl/aspeed/pinmux-aspeed.h
index 0406beedd5ba..964dd5b242ac 100644
--- a/drivers/pinctrl/aspeed/pinmux-aspeed.h
+++ b/drivers/pinctrl/aspeed/pinmux-aspeed.h
@@ -604,38 +604,6 @@ struct aspeed_pin_desc {
 	static const struct aspeed_pin_desc PIN_SYM(pin) = \
 		{ #pin, PIN_EXPRS_PTR(pin) }
 
-/**
- * Declare a two-signal pin
- *
- * @pin: The pin number
- * @other: Macro name for "other" functionality (subjected to stringification)
- * @high: Macro name for the highest priority signal functions
- * @low: Macro name for the low signal functions
- *
- * For example:
- *
- *     #define A8 56
- *     SIG_EXPR_DECL(ROMD8, ROM16, SIG_DESC_SET(SCU90, 6));
- *     SIG_EXPR_DECL(ROMD8, ROM16S, SIG_DESC_SET(HW_STRAP1, 4),
- *              { HW_STRAP1, GENMASK(1, 0), 0, 0 });
- *     SIG_EXPR_LIST_DECL(ROMD8, SIG_EXPR_PTR(ROMD8, ROM16),
- *              SIG_EXPR_PTR(ROMD8, ROM16S));
- *     SIG_EXPR_LIST_DECL_SINGLE(NCTS6, NCTS6, SIG_DESC_SET(SCU90, 7));
- *     PIN_DECL_2(A8, GPIOH0, ROMD8, NCTS6);
- */
-#define PIN_DECL_2(pin, other, high, low) \
-	SIG_EXPR_LIST_DECL_SINGLE(other, other); \
-	PIN_DECL_(pin, \
-			SIG_EXPR_LIST_PTR(high), \
-			SIG_EXPR_LIST_PTR(low), \
-			SIG_EXPR_LIST_PTR(other))
-
-#define PIN_GROUP_SYM(func) pins_ ## func
-#define FUNC_GROUP_SYM(func) groups_ ## func
-#define FUNC_GROUP_DECL(func, ...) \
-	static const int PIN_GROUP_SYM(func)[] = { __VA_ARGS__ }; \
-	static const char *FUNC_GROUP_SYM(func)[] = { #func }
-
 /**
  * Declare a single signal pin
  *
@@ -670,6 +638,46 @@ struct aspeed_pin_desc {
 	SIG_EXPR_LIST_DECL_SINGLE(other, other); \
 	PIN_DECL_(pin, SIG_EXPR_LIST_PTR(sig), SIG_EXPR_LIST_PTR(other)); \
 	FUNC_GROUP_DECL(sig, pin)
+/**
+ * Declare a two-signal pin
+ *
+ * @pin: The pin number
+ * @other: Macro name for "other" functionality (subjected to stringification)
+ * @high: Macro name for the highest priority signal functions
+ * @low: Macro name for the low signal functions
+ *
+ * For example:
+ *
+ *     #define A8 56
+ *     SIG_EXPR_DECL(ROMD8, ROM16, SIG_DESC_SET(SCU90, 6));
+ *     SIG_EXPR_DECL(ROMD8, ROM16S, SIG_DESC_SET(HW_STRAP1, 4),
+ *              { HW_STRAP1, GENMASK(1, 0), 0, 0 });
+ *     SIG_EXPR_LIST_DECL(ROMD8, SIG_EXPR_PTR(ROMD8, ROM16),
+ *              SIG_EXPR_PTR(ROMD8, ROM16S));
+ *     SIG_EXPR_LIST_DECL_SINGLE(NCTS6, NCTS6, SIG_DESC_SET(SCU90, 7));
+ *     PIN_DECL_2(A8, GPIOH0, ROMD8, NCTS6);
+ */
+#define PIN_DECL_2(pin, other, high, low) \
+	SIG_EXPR_LIST_DECL_SINGLE(other, other); \
+	PIN_DECL_(pin, \
+			SIG_EXPR_LIST_PTR(high), \
+			SIG_EXPR_LIST_PTR(low), \
+			SIG_EXPR_LIST_PTR(other))
+
+#define PIN_DECL_3(pin, other, high, medium, low) \
+	SIG_EXPR_LIST_DECL_SINGLE(other, other); \
+	PIN_DECL_(pin, \
+			SIG_EXPR_LIST_PTR(high), \
+			SIG_EXPR_LIST_PTR(medium), \
+			SIG_EXPR_LIST_PTR(low), \
+			SIG_EXPR_LIST_PTR(other))
+
+#define PIN_GROUP_SYM(func) pins_ ## func
+#define FUNC_GROUP_SYM(func) groups_ ## func
+#define FUNC_GROUP_DECL(func, ...) \
+	static const int PIN_GROUP_SYM(func)[] = { __VA_ARGS__ }; \
+	static const char *FUNC_GROUP_SYM(func)[] = { #func }
+
 
 #define GPIO_PIN_DECL(pin, gpio) \
 	SIG_EXPR_LIST_DECL_SINGLE(gpio, gpio); \
-- 
2.20.1

