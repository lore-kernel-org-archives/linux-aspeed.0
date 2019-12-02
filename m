From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon,  2 Dec 2019 16:44:32 +1030
Subject: [PATCH 7/7] pinctrl: aspeed-g6: Add AST2600 pinconf support
In-Reply-To: <20191202061432.3996-1-andrew@aj.id.au>
References: <20191202061432.3996-1-andrew@aj.id.au>
Message-ID: <20191202061432.3996-8-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Johnny Huang <johnny_huang@aspeedtech.com>

The AST2600 pinconf is a little different from previous generations of
ASPEED BMC SoCs in terms of architecture. The pull-down setting is
per-pin setting now, and drive-strength support 4 kind of value (e.g.
4ma, 8ma, 12ma, 16ma).

Signed-off-by: Johnny Huang <johnny_huang@aspeedtech.com>
[AJ: Trim unused pinctrl register macros]
Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c | 290 +++++++++++++++++++++
 drivers/pinctrl/aspeed/pinctrl-aspeed.h    |   7 +
 2 files changed, 297 insertions(+)

diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c b/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
index 22e6c07149c3..eb0c11a9fbf2 100644
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
@@ -28,6 +28,8 @@
 #define SCU438		0x438 /* Multi-function Pin Control #10 */
 #define SCU440		0x440 /* USB Multi-function Pin Control #12 */
 #define SCU450		0x450 /* Multi-function Pin Control #14 */
+#define SCU454		0x454 /* Multi-function Pin Control #15 */
+#define SCU458		0x458 /* Multi-function Pin Control #16 */
 #define SCU4B0		0x4B0 /* Multi-function Pin Control #17 */
 #define SCU4B4		0x4B4 /* Multi-function Pin Control #18 */
 #define SCU4B8		0x4B8 /* Multi-function Pin Control #19 */
@@ -36,6 +38,13 @@
 #define SCU4D8		0x4D8 /* Multi-function Pin Control #23 */
 #define SCU500		0x500 /* Hardware Strap 1 */
 #define SCU510		0x510 /* Hardware Strap 2 */
+#define SCU610		0x610 /* Disable GPIO Internal Pull-Down #0 */
+#define SCU614		0x614 /* Disable GPIO Internal Pull-Down #1 */
+#define SCU618		0x618 /* Disable GPIO Internal Pull-Down #2 */
+#define SCU61C		0x61c /* Disable GPIO Internal Pull-Down #3 */
+#define SCU620		0x620 /* Disable GPIO Internal Pull-Down #4 */
+#define SCU634		0x634 /* Disable GPIO Internal Pull-Down #5 */
+#define SCU638		0x638 /* Disable GPIO Internal Pull-Down #6 */
 #define SCU694		0x694 /* Multi-function Pin Control #25 */
 #define SCUC20		0xC20 /* PCIE configuration Setting Control */
 
@@ -2333,6 +2342,260 @@ static const struct aspeed_pin_function aspeed_g6_functions[] = {
 	ASPEED_PINCTRL_FUNC(WDTRST4),
 };
 
+static struct aspeed_pin_config aspeed_g6_configs[] = {
+	/* GPIOB7 */
+	ASPEED_PULL_DOWN_PINCONF(J24, SCU610, 15),
+	/* GPIOB6 */
+	ASPEED_PULL_DOWN_PINCONF(H25, SCU610, 14),
+	/* GPIOB5 */
+	ASPEED_PULL_DOWN_PINCONF(G26, SCU610, 13),
+	/* GPIOB4 */
+	ASPEED_PULL_DOWN_PINCONF(J23, SCU610, 12),
+	/* GPIOB3 */
+	ASPEED_PULL_DOWN_PINCONF(J25, SCU610, 11),
+	/* GPIOB2 */
+	ASPEED_PULL_DOWN_PINCONF(H26, SCU610, 10),
+	/* GPIOB1 */
+	ASPEED_PULL_DOWN_PINCONF(K23, SCU610, 9),
+	/* GPIOB0 */
+	ASPEED_PULL_DOWN_PINCONF(J26, SCU610, 8),
+
+	/* GPIOH3 */
+	ASPEED_PULL_DOWN_PINCONF(A17, SCU614, 27),
+	/* GPIOH2 */
+	ASPEED_PULL_DOWN_PINCONF(C18, SCU614, 26),
+	/* GPIOH1 */
+	ASPEED_PULL_DOWN_PINCONF(B18, SCU614, 25),
+	/* GPIOH0 */
+	ASPEED_PULL_DOWN_PINCONF(A18, SCU614, 24),
+
+	/* GPIOL7 */
+	ASPEED_PULL_DOWN_PINCONF(C14, SCU618, 31),
+	/* GPIOL6 */
+	ASPEED_PULL_DOWN_PINCONF(B14, SCU618, 30),
+	/* GPIOL5 */
+	ASPEED_PULL_DOWN_PINCONF(F15, SCU618, 29),
+	/* GPIOL4 */
+	ASPEED_PULL_DOWN_PINCONF(C15, SCU618, 28),
+
+	/* GPIOJ7 */
+	ASPEED_PULL_UP_PINCONF(D19, SCU618, 15),
+	/* GPIOJ6 */
+	ASPEED_PULL_UP_PINCONF(C20, SCU618, 14),
+	/* GPIOJ5 */
+	ASPEED_PULL_UP_PINCONF(A19, SCU618, 13),
+	/* GPIOJ4 */
+	ASPEED_PULL_UP_PINCONF(C19, SCU618, 12),
+	/* GPIOJ3 */
+	ASPEED_PULL_UP_PINCONF(D20, SCU618, 11),
+	/* GPIOJ2 */
+	ASPEED_PULL_UP_PINCONF(E19, SCU618, 10),
+	/* GPIOJ1 */
+	ASPEED_PULL_UP_PINCONF(A20, SCU618, 9),
+	/* GPIOJ0 */
+	ASPEED_PULL_UP_PINCONF(B20, SCU618, 8),
+
+	/* GPIOI7 */
+	ASPEED_PULL_DOWN_PINCONF(A15, SCU618, 7),
+	/* GPIOI6 */
+	ASPEED_PULL_DOWN_PINCONF(B16, SCU618, 6),
+	/* GPIOI5 */
+	ASPEED_PULL_DOWN_PINCONF(E16, SCU618, 5),
+	/* GPIOI4 */
+	ASPEED_PULL_DOWN_PINCONF(C16, SCU618, 4),
+	/* GPIOI3 */
+	ASPEED_PULL_DOWN_PINCONF(D16, SCU618, 3),
+	/* GPIOI2 */
+	ASPEED_PULL_DOWN_PINCONF(E17, SCU618, 2),
+	/* GPIOI1 */
+	ASPEED_PULL_DOWN_PINCONF(A16, SCU618, 1),
+	/* GPIOI0 */
+	ASPEED_PULL_DOWN_PINCONF(D17, SCU618, 0),
+
+	/* GPIOP7 */
+	ASPEED_PULL_DOWN_PINCONF(Y23, SCU61C, 31),
+	/* GPIOP6 */
+	ASPEED_PULL_DOWN_PINCONF(AB24, SCU61C, 30),
+	/* GPIOP5 */
+	ASPEED_PULL_DOWN_PINCONF(AB23, SCU61C, 29),
+	/* GPIOP4 */
+	ASPEED_PULL_DOWN_PINCONF(W23, SCU61C, 28),
+	/* GPIOP3 */
+	ASPEED_PULL_DOWN_PINCONF(AA24, SCU61C, 27),
+	/* GPIOP2 */
+	ASPEED_PULL_DOWN_PINCONF(AA23, SCU61C, 26),
+	/* GPIOP1 */
+	ASPEED_PULL_DOWN_PINCONF(W24, SCU61C, 25),
+	/* GPIOP0 */
+	ASPEED_PULL_DOWN_PINCONF(AB22, SCU61C, 24),
+
+	/* GPIOO7 */
+	ASPEED_PULL_DOWN_PINCONF(AC23, SCU61C, 23),
+	/* GPIOO6 */
+	ASPEED_PULL_DOWN_PINCONF(AC24, SCU61C, 22),
+	/* GPIOO5 */
+	ASPEED_PULL_DOWN_PINCONF(AC22, SCU61C, 21),
+	/* GPIOO4 */
+	ASPEED_PULL_DOWN_PINCONF(AD25, SCU61C, 20),
+	/* GPIOO3 */
+	ASPEED_PULL_DOWN_PINCONF(AD24, SCU61C, 19),
+	/* GPIOO2 */
+	ASPEED_PULL_DOWN_PINCONF(AD23, SCU61C, 18),
+	/* GPIOO1 */
+	ASPEED_PULL_DOWN_PINCONF(AD22, SCU61C, 17),
+	/* GPIOO0 */
+	ASPEED_PULL_DOWN_PINCONF(AD26, SCU61C, 16),
+
+	/* GPION7 */
+	ASPEED_PULL_DOWN_PINCONF(M26, SCU61C, 15),
+	/* GPION6 */
+	ASPEED_PULL_DOWN_PINCONF(N26, SCU61C, 14),
+	/* GPION5 */
+	ASPEED_PULL_DOWN_PINCONF(M23, SCU61C, 13),
+	/* GPION4 */
+	ASPEED_PULL_DOWN_PINCONF(P26, SCU61C, 12),
+	/* GPION3 */
+	ASPEED_PULL_DOWN_PINCONF(N24, SCU61C, 11),
+	/* GPION2 */
+	ASPEED_PULL_DOWN_PINCONF(N25, SCU61C, 10),
+	/* GPION1 */
+	ASPEED_PULL_DOWN_PINCONF(N23, SCU61C, 9),
+	/* GPION0 */
+	ASPEED_PULL_DOWN_PINCONF(P25, SCU61C, 8),
+
+	/* GPIOM7 */
+	ASPEED_PULL_DOWN_PINCONF(D13, SCU61C, 7),
+	/* GPIOM6 */
+	ASPEED_PULL_DOWN_PINCONF(C13, SCU61C, 6),
+	/* GPIOM5 */
+	ASPEED_PULL_DOWN_PINCONF(C12, SCU61C, 5),
+	/* GPIOM4 */
+	ASPEED_PULL_DOWN_PINCONF(B12, SCU61C, 4),
+	/* GPIOM3 */
+	ASPEED_PULL_DOWN_PINCONF(E14, SCU61C, 3),
+	/* GPIOM2 */
+	ASPEED_PULL_DOWN_PINCONF(A12, SCU61C, 2),
+	/* GPIOM1 */
+	ASPEED_PULL_DOWN_PINCONF(B13, SCU61C, 1),
+	/* GPIOM0 */
+	ASPEED_PULL_DOWN_PINCONF(D14, SCU61C, 0),
+
+	/* GPIOS7 */
+	ASPEED_PULL_DOWN_PINCONF(T24, SCU620, 23),
+	/* GPIOS6 */
+	ASPEED_PULL_DOWN_PINCONF(P23, SCU620, 22),
+	/* GPIOS5 */
+	ASPEED_PULL_DOWN_PINCONF(P24, SCU620, 21),
+	/* GPIOS4 */
+	ASPEED_PULL_DOWN_PINCONF(R26, SCU620, 20),
+	/* GPIOS3*/
+	ASPEED_PULL_DOWN_PINCONF(R24, SCU620, 19),
+	/* GPIOS2 */
+	ASPEED_PULL_DOWN_PINCONF(T26, SCU620, 18),
+	/* GPIOS1 */
+	ASPEED_PULL_DOWN_PINCONF(T25, SCU620, 17),
+	/* GPIOS0 */
+	ASPEED_PULL_DOWN_PINCONF(R23, SCU620, 16),
+
+	/* GPIOR7 */
+	ASPEED_PULL_DOWN_PINCONF(U26, SCU620, 15),
+	/* GPIOR6 */
+	ASPEED_PULL_DOWN_PINCONF(W26, SCU620, 14),
+	/* GPIOR5 */
+	ASPEED_PULL_DOWN_PINCONF(T23, SCU620, 13),
+	/* GPIOR4 */
+	ASPEED_PULL_DOWN_PINCONF(U25, SCU620, 12),
+	/* GPIOR3*/
+	ASPEED_PULL_DOWN_PINCONF(V26, SCU620, 11),
+	/* GPIOR2 */
+	ASPEED_PULL_DOWN_PINCONF(V24, SCU620, 10),
+	/* GPIOR1 */
+	ASPEED_PULL_DOWN_PINCONF(U24, SCU620, 9),
+	/* GPIOR0 */
+	ASPEED_PULL_DOWN_PINCONF(V25, SCU620, 8),
+
+	/* GPIOX7 */
+	ASPEED_PULL_DOWN_PINCONF(AB10, SCU634, 31),
+	/* GPIOX6 */
+	ASPEED_PULL_DOWN_PINCONF(AF9, SCU634, 30),
+	/* GPIOX5 */
+	ASPEED_PULL_DOWN_PINCONF(AD9, SCU634, 29),
+	/* GPIOX4 */
+	ASPEED_PULL_DOWN_PINCONF(AB9, SCU634, 28),
+	/* GPIOX3*/
+	ASPEED_PULL_DOWN_PINCONF(AF8, SCU634, 27),
+	/* GPIOX2 */
+	ASPEED_PULL_DOWN_PINCONF(AC9, SCU634, 26),
+	/* GPIOX1 */
+	ASPEED_PULL_DOWN_PINCONF(AA9, SCU634, 25),
+	/* GPIOX0 */
+	ASPEED_PULL_DOWN_PINCONF(AE8, SCU634, 24),
+
+	/* GPIOV7 */
+	ASPEED_PULL_DOWN_PINCONF(AF15, SCU634, 15),
+	/* GPIOV6 */
+	ASPEED_PULL_DOWN_PINCONF(AD15, SCU634, 14),
+	/* GPIOV5 */
+	ASPEED_PULL_DOWN_PINCONF(AE14, SCU634, 13),
+	/* GPIOV4 */
+	ASPEED_PULL_DOWN_PINCONF(AE15, SCU634, 12),
+	/* GPIOV3*/
+	ASPEED_PULL_DOWN_PINCONF(AC15, SCU634, 11),
+	/* GPIOV2 */
+	ASPEED_PULL_DOWN_PINCONF(AD14, SCU634, 10),
+	/* GPIOV1 */
+	ASPEED_PULL_DOWN_PINCONF(AF14, SCU634, 9),
+	/* GPIOV0 */
+	ASPEED_PULL_DOWN_PINCONF(AB15, SCU634, 8),
+
+	/* GPIOZ7 */
+	ASPEED_PULL_DOWN_PINCONF(AF10, SCU638, 15),
+	/* GPIOZ6 */
+	ASPEED_PULL_DOWN_PINCONF(AD11, SCU638, 14),
+	/* GPIOZ5 */
+	ASPEED_PULL_DOWN_PINCONF(AA11, SCU638, 13),
+	/* GPIOZ4 */
+	ASPEED_PULL_DOWN_PINCONF(AC11, SCU638, 12),
+	/* GPIOZ3*/
+	ASPEED_PULL_DOWN_PINCONF(AB11, SCU638, 11),
+
+	/* GPIOZ1 */
+	ASPEED_PULL_DOWN_PINCONF(AD10, SCU638, 9),
+	/* GPIOZ0 */
+	ASPEED_PULL_DOWN_PINCONF(AC10, SCU638, 8),
+
+	/* GPIOY6 */
+	ASPEED_PULL_DOWN_PINCONF(AC12, SCU638, 6),
+	/* GPIOY5 */
+	ASPEED_PULL_DOWN_PINCONF(AF12, SCU638, 5),
+	/* GPIOY4 */
+	ASPEED_PULL_DOWN_PINCONF(AE12, SCU638, 4),
+	/* GPIOY3 */
+	ASPEED_PULL_DOWN_PINCONF(AA12, SCU638, 3),
+	/* GPIOY2 */
+	ASPEED_PULL_DOWN_PINCONF(AE11, SCU638, 2),
+	/* GPIOY1 */
+	ASPEED_PULL_DOWN_PINCONF(AD12, SCU638, 1),
+	/* GPIOY0 */
+	ASPEED_PULL_DOWN_PINCONF(AF11, SCU638, 0),
+
+	/* LAD3 */
+	{ PIN_CONFIG_DRIVE_STRENGTH, { AC7, AC7 }, SCU454, GENMASK(31, 30)},
+	/* LAD2 */
+	{ PIN_CONFIG_DRIVE_STRENGTH, { AC8, AC8 }, SCU454, GENMASK(29, 28)},
+	/* LAD1 */
+	{ PIN_CONFIG_DRIVE_STRENGTH, { AB8, AB8 }, SCU454, GENMASK(27, 26)},
+	/* LAD0 */
+	{ PIN_CONFIG_DRIVE_STRENGTH, { AB7, AB7 }, SCU454, GENMASK(25, 24)},
+
+	/* MAC3 */
+	{ PIN_CONFIG_POWER_SOURCE,   { H24, E26 }, SCU458, BIT_MASK(4)},
+	{ PIN_CONFIG_DRIVE_STRENGTH, { H24, E26 }, SCU458, GENMASK(1, 0)},
+	/* MAC4 */
+	{ PIN_CONFIG_POWER_SOURCE,   { F24, B24 }, SCU458, BIT_MASK(5)},
+	{ PIN_CONFIG_DRIVE_STRENGTH, { F24, B24 }, SCU458, GENMASK(3, 2)},
+};
+
 /**
  * Configure a pin's signal by applying an expression's descriptor state for
  * all descriptors in the expression.
@@ -2400,6 +2663,20 @@ static int aspeed_g6_sig_expr_set(struct aspeed_pinmux_data *ctx,
 	return 0;
 }
 
+static const struct aspeed_pin_config_map aspeed_g6_pin_config_map[] = {
+	{ PIN_CONFIG_BIAS_PULL_DOWN,  0,   1, BIT_MASK(0)},
+	{ PIN_CONFIG_BIAS_PULL_DOWN, -1,   0, BIT_MASK(0)},
+	{ PIN_CONFIG_BIAS_PULL_UP,    0,   1, BIT_MASK(0)},
+	{ PIN_CONFIG_BIAS_PULL_UP,   -1,   0, BIT_MASK(0)},
+	{ PIN_CONFIG_BIAS_DISABLE,   -1,   1, BIT_MASK(0)},
+	{ PIN_CONFIG_DRIVE_STRENGTH,  4,   0, GENMASK(1, 0)},
+	{ PIN_CONFIG_DRIVE_STRENGTH,  8,   1, GENMASK(1, 0)},
+	{ PIN_CONFIG_DRIVE_STRENGTH, 12,   2, GENMASK(1, 0)},
+	{ PIN_CONFIG_DRIVE_STRENGTH, 16,   3, GENMASK(1, 0)},
+	{ PIN_CONFIG_POWER_SOURCE,   3300, 0, BIT_MASK(0)},
+	{ PIN_CONFIG_POWER_SOURCE,   1800, 1, BIT_MASK(0)},
+};
+
 static const struct aspeed_pinmux_ops aspeed_g5_ops = {
 	.set = aspeed_g6_sig_expr_set,
 };
@@ -2414,6 +2691,10 @@ static struct aspeed_pinctrl_data aspeed_g6_pinctrl_data = {
 		.functions = aspeed_g6_functions,
 		.nfunctions = ARRAY_SIZE(aspeed_g6_functions),
 	},
+	.configs = aspeed_g6_configs,
+	.nconfigs = ARRAY_SIZE(aspeed_g6_configs),
+	.confmaps = aspeed_g6_pin_config_map,
+	.nconfmaps = ARRAY_SIZE(aspeed_g6_pin_config_map),
 };
 
 static const struct pinmux_ops aspeed_g6_pinmux_ops = {
@@ -2434,12 +2715,21 @@ static const struct pinctrl_ops aspeed_g6_pinctrl_ops = {
 	.dt_free_map = pinctrl_utils_free_map,
 };
 
+static const struct pinconf_ops aspeed_g6_conf_ops = {
+	.is_generic = true,
+	.pin_config_get = aspeed_pin_config_get,
+	.pin_config_set = aspeed_pin_config_set,
+	.pin_config_group_get = aspeed_pin_config_group_get,
+	.pin_config_group_set = aspeed_pin_config_group_set,
+};
+
 static struct pinctrl_desc aspeed_g6_pinctrl_desc = {
 	.name = "aspeed-g6-pinctrl",
 	.pins = aspeed_g6_pins,
 	.npins = ARRAY_SIZE(aspeed_g6_pins),
 	.pctlops = &aspeed_g6_pinctrl_ops,
 	.pmxops = &aspeed_g6_pinmux_ops,
+	.confops = &aspeed_g6_conf_ops,
 };
 
 static int aspeed_g6_pinctrl_probe(struct platform_device *pdev)
diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed.h b/drivers/pinctrl/aspeed/pinctrl-aspeed.h
index 6f0f03395617..4dcde3bc29c8 100644
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed.h
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed.h
@@ -41,6 +41,13 @@ struct aspeed_pin_config {
 	.mask = BIT_MASK(bit_) \
 }
 
+#define ASPEED_PULL_DOWN_PINCONF(pin_, reg_, bit_) \
+	ASPEED_SB_PINCONF(PIN_CONFIG_BIAS_PULL_DOWN, pin_, pin_, reg_, bit_), \
+	ASPEED_SB_PINCONF(PIN_CONFIG_BIAS_DISABLE,   pin_, pin_, reg_, bit_)
+
+#define ASPEED_PULL_UP_PINCONF(pin_, reg_, bit_) \
+	ASPEED_SB_PINCONF(PIN_CONFIG_BIAS_PULL_UP, pin_, pin_, reg_, bit_), \
+	ASPEED_SB_PINCONF(PIN_CONFIG_BIAS_DISABLE, pin_, pin_, reg_, bit_)
 /*
  * Aspeed pin configuration description.
  *
-- 
2.20.1

