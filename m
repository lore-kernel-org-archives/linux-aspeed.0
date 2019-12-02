From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon,  2 Dec 2019 16:44:27 +1030
Subject: [PATCH 2/7] pinctrl: aspeed-g6: Add AST2600 I3C1 and I3C2 pinmux
 config
In-Reply-To: <20191202061432.3996-1-andrew@aj.id.au>
References: <20191202061432.3996-1-andrew@aj.id.au>
Message-ID: <20191202061432.3996-3-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Johnny Huang <johnny_huang@aspeedtech.com>

These pins only expose a single function but are not fixed-function as
their I3C capability can be disabled.

Signed-off-by: Johnny Huang <johnny_huang@aspeedtech.com>
[AJ: Tweak commit message, sort pins list]
Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c | 30 +++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c b/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
index c6800d220920..49fc4824ccee 100644
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
@@ -37,7 +37,7 @@
 #define SCU510		0x510 /* Hardware Strap 2 */
 #define SCU694		0x694 /* Multi-function Pin Control #25 */
 
-#define ASPEED_G6_NR_PINS 248
+#define ASPEED_G6_NR_PINS 252
 
 #define M24 0
 SIG_EXPR_LIST_DECL_SESG(M24, MDC3, MDIO3, SIG_DESC_SET(SCU410, 0));
@@ -1542,6 +1542,26 @@ GROUP_DECL(I3C4, AE25, AF24);
 FUNC_DECL_2(I3C4, HVI3C4, I3C4);
 FUNC_GROUP_DECL(FSI2, AE25, AF24);
 
+#define AF23 248
+SIG_EXPR_LIST_DECL_SESG(AF23, I3C1SCL, I3C1, SIG_DESC_SET(SCU438, 16));
+PIN_DECL_(AF23, SIG_EXPR_LIST_PTR(AF23, I3C1SCL));
+
+#define AE24 249
+SIG_EXPR_LIST_DECL_SESG(AE24, I3C1SDA, I3C1, SIG_DESC_SET(SCU438, 17));
+PIN_DECL_(AE24, SIG_EXPR_LIST_PTR(AE24, I3C1SDA));
+
+FUNC_GROUP_DECL(I3C1, AF23, AE24);
+
+#define AF22 250
+SIG_EXPR_LIST_DECL_SESG(AF22, I3C2SCL, I3C2, SIG_DESC_SET(SCU438, 18));
+PIN_DECL_(AF22, SIG_EXPR_LIST_PTR(AF22, I3C2SCL));
+
+#define AE22 251
+SIG_EXPR_LIST_DECL_SESG(AE22, I3C2SDA, I3C2, SIG_DESC_SET(SCU438, 19));
+PIN_DECL_(AE22, SIG_EXPR_LIST_PTR(AE22, I3C2SDA));
+
+FUNC_GROUP_DECL(I3C2, AF22, AE22);
+
 /* Pins, groups and functions are sort(1):ed alphabetically for sanity */
 
 static struct pinctrl_pin_desc aspeed_g6_pins[ASPEED_G6_NR_PINS] = {
@@ -1633,6 +1653,8 @@ static struct pinctrl_pin_desc aspeed_g6_pins[ASPEED_G6_NR_PINS] = {
 	ASPEED_PINCTRL_PIN(AE16),
 	ASPEED_PINCTRL_PIN(AE18),
 	ASPEED_PINCTRL_PIN(AE19),
+	ASPEED_PINCTRL_PIN(AE22),
+	ASPEED_PINCTRL_PIN(AE24),
 	ASPEED_PINCTRL_PIN(AE25),
 	ASPEED_PINCTRL_PIN(AE26),
 	ASPEED_PINCTRL_PIN(AE7),
@@ -1642,6 +1664,8 @@ static struct pinctrl_pin_desc aspeed_g6_pins[ASPEED_G6_NR_PINS] = {
 	ASPEED_PINCTRL_PIN(AF12),
 	ASPEED_PINCTRL_PIN(AF14),
 	ASPEED_PINCTRL_PIN(AF15),
+	ASPEED_PINCTRL_PIN(AF22),
+	ASPEED_PINCTRL_PIN(AF23),
 	ASPEED_PINCTRL_PIN(AF24),
 	ASPEED_PINCTRL_PIN(AF25),
 	ASPEED_PINCTRL_PIN(AF7),
@@ -1855,6 +1879,8 @@ static const struct aspeed_pin_group aspeed_g6_groups[] = {
 	ASPEED_PINCTRL_GROUP(I2C7),
 	ASPEED_PINCTRL_GROUP(I2C8),
 	ASPEED_PINCTRL_GROUP(I2C9),
+	ASPEED_PINCTRL_GROUP(I3C1),
+	ASPEED_PINCTRL_GROUP(I3C2),
 	ASPEED_PINCTRL_GROUP(I3C3),
 	ASPEED_PINCTRL_GROUP(I3C4),
 	ASPEED_PINCTRL_GROUP(I3C5),
@@ -2087,6 +2113,8 @@ static const struct aspeed_pin_function aspeed_g6_functions[] = {
 	ASPEED_PINCTRL_FUNC(I2C7),
 	ASPEED_PINCTRL_FUNC(I2C8),
 	ASPEED_PINCTRL_FUNC(I2C9),
+	ASPEED_PINCTRL_FUNC(I3C1),
+	ASPEED_PINCTRL_FUNC(I3C2),
 	ASPEED_PINCTRL_FUNC(I3C3),
 	ASPEED_PINCTRL_FUNC(I3C4),
 	ASPEED_PINCTRL_FUNC(I3C5),
-- 
2.20.1

