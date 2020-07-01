From: Joel Stanley <joel@jms.id.au>
Date: Wed,  1 Jul 2020 12:37:56 +0930
Subject: [PATCH] pinctrl: aspeed: Describe the heartbeat function on ball Y23
Message-ID: <20200701030756.2834657-1-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Andrew Jeffery <andrew@aj.id.au>

The default pinmux configuration for Y23 is to route a heartbeat to
drive a LED. Previous revisions of the AST2600 datasheet did not include
a description of this function.

Fixes: 2eda1cdec49f ("pinctrl: aspeed: Add AST2600 pinmux support")
Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c b/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
index fa32c3e9c9d1..7efe6dbe4398 100644
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
@@ -46,6 +46,7 @@
 #define SCU634		0x634 /* Disable GPIO Internal Pull-Down #5 */
 #define SCU638		0x638 /* Disable GPIO Internal Pull-Down #6 */
 #define SCU694		0x694 /* Multi-function Pin Control #25 */
+#define SCU69C		0x69C /* Multi-function Pin Control #27 */
 #define SCUC20		0xC20 /* PCIE configuration Setting Control */
 
 #define ASPEED_G6_NR_PINS 256
@@ -819,11 +820,13 @@ FUNC_DECL_2(PWM14, PWM14G0, PWM14G1);
 #define Y23 127
 SIG_EXPR_LIST_DECL_SEMG(Y23, PWM15, PWM15G1, PWM15, SIG_DESC_SET(SCU41C, 31));
 SIG_EXPR_LIST_DECL_SESG(Y23, THRUOUT3, THRU3, SIG_DESC_SET(SCU4BC, 31));
-PIN_DECL_2(Y23, GPIOP7, PWM15, THRUOUT3);
+SIG_EXPR_LIST_DECL_SESG(Y23, HEARTBEAT, HEARTBEAT, SIG_DESC_SET(SCU69C, 31));
+PIN_DECL_3(Y23, GPIOP7, PWM15, THRUOUT3, HEARTBEAT);
 GROUP_DECL(PWM15G1, Y23);
 FUNC_DECL_2(PWM15, PWM15G0, PWM15G1);
 
 FUNC_GROUP_DECL(THRU3, AB24, Y23);
+FUNC_GROUP_DECL(HEARTBEAT, Y23);
 
 #define AA25 128
 SSSF_PIN_DECL(AA25, GPIOQ0, TACH0, SIG_DESC_SET(SCU430, 0));
@@ -1920,6 +1923,7 @@ static const struct aspeed_pin_group aspeed_g6_groups[] = {
 	ASPEED_PINCTRL_GROUP(GPIU5),
 	ASPEED_PINCTRL_GROUP(GPIU6),
 	ASPEED_PINCTRL_GROUP(GPIU7),
+	ASPEED_PINCTRL_GROUP(HEARTBEAT),
 	ASPEED_PINCTRL_GROUP(HVI3C3),
 	ASPEED_PINCTRL_GROUP(HVI3C4),
 	ASPEED_PINCTRL_GROUP(I2C1),
@@ -2158,6 +2162,7 @@ static const struct aspeed_pin_function aspeed_g6_functions[] = {
 	ASPEED_PINCTRL_FUNC(GPIU5),
 	ASPEED_PINCTRL_FUNC(GPIU6),
 	ASPEED_PINCTRL_FUNC(GPIU7),
+	ASPEED_PINCTRL_FUNC(HEARTBEAT),
 	ASPEED_PINCTRL_FUNC(I2C1),
 	ASPEED_PINCTRL_FUNC(I2C10),
 	ASPEED_PINCTRL_FUNC(I2C11),
-- 
2.27.0

