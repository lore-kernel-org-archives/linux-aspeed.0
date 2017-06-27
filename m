From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue, 27 Jun 2017 11:42:13 +0930
Subject: [PATCH 3/4] pinctrl: aspeed: g4: Add USB device and host support
In-Reply-To: <20170627021214.23323-1-andrew@aj.id.au>
References: <20170627021214.23323-1-andrew@aj.id.au>
Message-ID: <20170627021214.23323-4-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Implement the AST2400 USB functions as described by the devicetree
bindings. Three ports are fully documented in the datasheet and exposed
through the bindings and pinctrl, though there are remnants of
documentation for a fourth port muxed with GPIO pins GPIOQ6 and GPIOQ7.
The implementation is updated to reflect this but the function and
group are not exposed.

Disregarding the mostly undocumented fourth port, the USB functions are
an outlier with respect to the rest of the muxed functionality on the
AST2400 as GPIO is not supported on these pins.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c | 66 ++++++++++++++++++++++++++----
 1 file changed, 59 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c b/drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c
index cf3106cec048..df56e58b05c1 100644
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c
@@ -1006,15 +1006,23 @@ SS_PIN_DECL(H3, GPIOQ5, SDA14);
 
 FUNC_GROUP_DECL(I2C14, H4, H3);
 
-#define DASH9028_DESC	SIG_DESC_SET(SCU90, 28)
+/*
+ * There are several opportunities to document USB port 4 in the datasheet, but
+ * it is only mentioned in one location. Particularly, the Multi-function Pins
+ * Mapping and Control table in the datasheet elides the signal names,
+ * suggesting that port 4 may not actually be functional. As such we define the
+ * signal names and control bit, but don't export the capability's function or
+ * group.
+ */
+#define USB11H3_DESC	SIG_DESC_SET(SCU90, 28)
 
 #define H2 134
-SIG_EXPR_LIST_DECL_SINGLE(DASHH2, DASHH2, DASH9028_DESC);
-SS_PIN_DECL(H2, GPIOQ6, DASHH2);
+SIG_EXPR_LIST_DECL_SINGLE(USB11HDP3, USB11H3, USB11H3_DESC);
+SS_PIN_DECL(H2, GPIOQ6, USB11HDP3);
 
 #define H1 135
-SIG_EXPR_LIST_DECL_SINGLE(DASHH1, DASHH1, DASH9028_DESC);
-SS_PIN_DECL(H1, GPIOQ7, DASHH1);
+SIG_EXPR_LIST_DECL_SINGLE(USB11HDN3, USB11H3, USB11H3_DESC);
+SS_PIN_DECL(H1, GPIOQ7, USB11HDN3);
 
 #define V20 136
 SSSF_PIN_DECL(V20, GPIOR0, ROMCS1, SIG_DESC_SET(SCU88, 24));
@@ -1706,10 +1714,42 @@ FUNC_GROUP_DECL(VPO12, U21, T19, V22, U20, R22, P18, P19, P20, P21, P22, M19,
 FUNC_GROUP_DECL(VPO24, U21, T19, V22, U20, L22, K18, V21, W22, R22, P18, P19,
 		P20, P21, P22, M19, M20, M21, M22, L18, L19);
 
+#define USB11H2_DESC	SIG_DESC_SET(SCU90, 3)
+#define USB11D1_DESC	SIG_DESC_BIT(SCU90, 3, 0)
+
+#define K4 220
+SIG_EXPR_LIST_DECL_SINGLE(USB11HDP2, USB11H2, USB11H2_DESC);
+SIG_EXPR_LIST_DECL_SINGLE(USB11DP1, USB11D1, USB11D1_DESC);
+MS_PIN_DECL_(K4, SIG_EXPR_LIST_PTR(USB11HDP2), SIG_EXPR_LIST_PTR(USB11DP1));
+
+#define K3 221
+SIG_EXPR_LIST_DECL_SINGLE(USB11HDN1, USB11H2, USB11H2_DESC);
+SIG_EXPR_LIST_DECL_SINGLE(USB11DDN1, USB11D1, USB11D1_DESC);
+MS_PIN_DECL_(K3, SIG_EXPR_LIST_PTR(USB11HDN1), SIG_EXPR_LIST_PTR(USB11DDN1));
+
+FUNC_GROUP_DECL(USB11H2, K4, K3);
+FUNC_GROUP_DECL(USB11D1, K4, K3);
+
+#define USB2H1_DESC	SIG_DESC_SET(SCU90, 29)
+#define USB2D1_DESC	SIG_DESC_BIT(SCU90, 29, 0)
+
+#define AB21 222
+SIG_EXPR_LIST_DECL_SINGLE(USB2HDP1, USB2H1, USB2H1_DESC);
+SIG_EXPR_LIST_DECL_SINGLE(USB2DDP1, USB2D1, USB2D1_DESC);
+MS_PIN_DECL_(AB21, SIG_EXPR_LIST_PTR(USB2HDP1), SIG_EXPR_LIST_PTR(USB2DDP1));
+
+#define AB20 223
+SIG_EXPR_LIST_DECL_SINGLE(USB2HDN1, USB2H1, USB2H1_DESC);
+SIG_EXPR_LIST_DECL_SINGLE(USB2DDN1, USB2D1, USB2D1_DESC);
+MS_PIN_DECL_(AB20, SIG_EXPR_LIST_PTR(USB2HDN1), SIG_EXPR_LIST_PTR(USB2DDN1));
+
+FUNC_GROUP_DECL(USB2H1, AB21, AB20);
+FUNC_GROUP_DECL(USB2D1, AB21, AB20);
+
 /* Note we account for GPIOY4-GPIOY7 even though they're not valid, thus 216
- * pins becomes 220.
+ * pins becomes 220. Four additional non-GPIO-capable pins are present for USB.
  */
-#define ASPEED_G4_NR_PINS 220
+#define ASPEED_G4_NR_PINS 224
 
 /* Pins, groups and functions are sort(1):ed alphabetically for sanity */
 
@@ -1749,6 +1789,8 @@ static struct pinctrl_pin_desc aspeed_g4_pins[ASPEED_G4_NR_PINS] = {
 	ASPEED_PINCTRL_PIN(AB5),
 	ASPEED_PINCTRL_PIN(AB6),
 	ASPEED_PINCTRL_PIN(AB7),
+	ASPEED_PINCTRL_PIN(AB20),
+	ASPEED_PINCTRL_PIN(AB21),
 	ASPEED_PINCTRL_PIN(B1),
 	ASPEED_PINCTRL_PIN(B10),
 	ASPEED_PINCTRL_PIN(B11),
@@ -1848,6 +1890,8 @@ static struct pinctrl_pin_desc aspeed_g4_pins[ASPEED_G4_NR_PINS] = {
 	ASPEED_PINCTRL_PIN(J5),
 	ASPEED_PINCTRL_PIN(K18),
 	ASPEED_PINCTRL_PIN(K20),
+	ASPEED_PINCTRL_PIN(K3),
+	ASPEED_PINCTRL_PIN(K4),
 	ASPEED_PINCTRL_PIN(K5),
 	ASPEED_PINCTRL_PIN(L1),
 	ASPEED_PINCTRL_PIN(L18),
@@ -2070,6 +2114,10 @@ static const struct aspeed_pin_group aspeed_g4_groups[] = {
 	ASPEED_PINCTRL_GROUP(TXD3),
 	ASPEED_PINCTRL_GROUP(TXD4),
 	ASPEED_PINCTRL_GROUP(UART6),
+	ASPEED_PINCTRL_GROUP(USB11D1),
+	ASPEED_PINCTRL_GROUP(USB11H2),
+	ASPEED_PINCTRL_GROUP(USB2D1),
+	ASPEED_PINCTRL_GROUP(USB2H1),
 	ASPEED_PINCTRL_GROUP(USBCKI),
 	ASPEED_PINCTRL_GROUP(VGABIOS_ROM),
 	ASPEED_PINCTRL_GROUP(VGAHS),
@@ -2221,6 +2269,10 @@ static const struct aspeed_pin_function aspeed_g4_functions[] = {
 	ASPEED_PINCTRL_FUNC(TXD3),
 	ASPEED_PINCTRL_FUNC(TXD4),
 	ASPEED_PINCTRL_FUNC(UART6),
+	ASPEED_PINCTRL_FUNC(USB11D1),
+	ASPEED_PINCTRL_FUNC(USB11H2),
+	ASPEED_PINCTRL_FUNC(USB2D1),
+	ASPEED_PINCTRL_FUNC(USB2H1),
 	ASPEED_PINCTRL_FUNC(USBCKI),
 	ASPEED_PINCTRL_FUNC(VGABIOS_ROM),
 	ASPEED_PINCTRL_FUNC(VGAHS),
-- 
2.11.0

