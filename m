From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon,  2 Dec 2019 16:44:28 +1030
Subject: [PATCH 3/7] pinctrl: aspeed-g6: Add support for the AST2600 USB pinmux
In-Reply-To: <20191202061432.3996-1-andrew@aj.id.au>
References: <20191202061432.3996-1-andrew@aj.id.au>
Message-ID: <20191202061432.3996-4-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Johnny Huang <johnny_huang@aspeedtech.com>

AST2600 has two USB ports, A, B:

Port A supports 4 distinct modes:
	1. PCIe EHCI to Hub
	2. Hub to PHY
	3. BMC EHCI to PHY
	4. PCIe EHCI to PHY

Port B support 3 modes:
	1. USB1.1 HID controller
	2. USB2.0 Device controller
	3. BMC EHCI port2

Implement pinmux support by mapping each ports' functions onto a single
pin group for each port.

Signed-off-by: Johnny Huang <johnny_huang@aspeedtech.com>
Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c | 69 +++++++++++++++++++++-
 drivers/pinctrl/aspeed/pinmux-aspeed.h     |  1 +
 2 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c b/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
index 49fc4824ccee..22e6c07149c3 100644
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
@@ -26,6 +26,7 @@
 #define SCU430		0x430 /* Multi-function Pin Control #8  */
 #define SCU434		0x434 /* Multi-function Pin Control #9  */
 #define SCU438		0x438 /* Multi-function Pin Control #10 */
+#define SCU440		0x440 /* USB Multi-function Pin Control #12 */
 #define SCU450		0x450 /* Multi-function Pin Control #14 */
 #define SCU4B0		0x4B0 /* Multi-function Pin Control #17 */
 #define SCU4B4		0x4B4 /* Multi-function Pin Control #18 */
@@ -36,8 +37,9 @@
 #define SCU500		0x500 /* Hardware Strap 1 */
 #define SCU510		0x510 /* Hardware Strap 2 */
 #define SCU694		0x694 /* Multi-function Pin Control #25 */
+#define SCUC20		0xC20 /* PCIE configuration Setting Control */
 
-#define ASPEED_G6_NR_PINS 252
+#define ASPEED_G6_NR_PINS 256
 
 #define M24 0
 SIG_EXPR_LIST_DECL_SESG(M24, MDC3, MDIO3, SIG_DESC_SET(SCU410, 0));
@@ -1562,6 +1564,58 @@ PIN_DECL_(AE22, SIG_EXPR_LIST_PTR(AE22, I3C2SDA));
 
 FUNC_GROUP_DECL(I3C2, AF22, AE22);
 
+#define USB2ADP_DESC   { ASPEED_IP_SCU, SCU440, GENMASK(25, 24), 0, 0 }
+#define USB2AD_DESC    { ASPEED_IP_SCU, SCU440, GENMASK(25, 24), 1, 0 }
+#define USB2AH_DESC    { ASPEED_IP_SCU, SCU440, GENMASK(25, 24), 2, 0 }
+#define USB2AHP_DESC   { ASPEED_IP_SCU, SCU440, GENMASK(25, 24), 3, 0 }
+#define USB11BHID_DESC { ASPEED_IP_SCU, SCU440, GENMASK(29, 28), 0, 0 }
+#define USB2BD_DESC    { ASPEED_IP_SCU, SCU440, GENMASK(29, 28), 1, 0 }
+#define USB2BH_DESC    { ASPEED_IP_SCU, SCU440, GENMASK(29, 28), 2, 0 }
+
+#define A4 252
+SIG_EXPR_LIST_DECL_SEMG(A4, USB2ADPDP, USBA, USB2ADP, USB2ADP_DESC,
+			SIG_DESC_SET(SCUC20, 16));
+SIG_EXPR_LIST_DECL_SEMG(A4, USB2ADDP, USBA, USB2AD, USB2AD_DESC);
+SIG_EXPR_LIST_DECL_SEMG(A4, USB2AHDP, USBA, USB2AH, USB2AH_DESC);
+SIG_EXPR_LIST_DECL_SEMG(A4, USB2AHPDP, USBA, USB2AHP, USB2AHP_DESC);
+PIN_DECL_(A4, SIG_EXPR_LIST_PTR(A4, USB2ADPDP), SIG_EXPR_LIST_PTR(A4, USB2ADDP),
+	  SIG_EXPR_LIST_PTR(A4, USB2AHDP));
+
+#define B4 253
+SIG_EXPR_LIST_DECL_SEMG(B4, USB2ADPDN, USBA, USB2ADP, USB2ADP_DESC);
+SIG_EXPR_LIST_DECL_SEMG(B4, USB2ADDN, USBA, USB2AD, USB2AD_DESC);
+SIG_EXPR_LIST_DECL_SEMG(B4, USB2AHDN, USBA, USB2AH, USB2AH_DESC);
+SIG_EXPR_LIST_DECL_SEMG(B4, USB2AHPDN, USBA, USB2AHP, USB2AHP_DESC);
+PIN_DECL_(B4, SIG_EXPR_LIST_PTR(B4, USB2ADPDN), SIG_EXPR_LIST_PTR(B4, USB2ADDN),
+	  SIG_EXPR_LIST_PTR(B4, USB2AHDN));
+
+GROUP_DECL(USBA, A4, B4);
+
+FUNC_DECL_1(USB2ADP, USBA);
+FUNC_DECL_1(USB2AD, USBA);
+FUNC_DECL_1(USB2AH, USBA);
+FUNC_DECL_1(USB2AHP, USBA);
+
+#define A6 254
+SIG_EXPR_LIST_DECL_SEMG(A6, USB11BDP, USBB, USB11BHID, USB11BHID_DESC);
+SIG_EXPR_LIST_DECL_SEMG(A6, USB2BDDP, USBB, USB2BD, USB2BD_DESC);
+SIG_EXPR_LIST_DECL_SEMG(A6, USB2BHDP, USBB, USB2BH, USB2BH_DESC);
+PIN_DECL_(A6, SIG_EXPR_LIST_PTR(A6, USB11BDP), SIG_EXPR_LIST_PTR(A6, USB2BDDP),
+	  SIG_EXPR_LIST_PTR(A6, USB2BHDP));
+
+#define B6 255
+SIG_EXPR_LIST_DECL_SEMG(B6, USB11BDN, USBB, USB11BHID, USB11BHID_DESC);
+SIG_EXPR_LIST_DECL_SEMG(B6, USB2BDDN, USBB, USB2BD, USB2BD_DESC);
+SIG_EXPR_LIST_DECL_SEMG(B6, USB2BHDN, USBB, USB2BH, USB2BH_DESC);
+PIN_DECL_(B6, SIG_EXPR_LIST_PTR(B6, USB11BDN), SIG_EXPR_LIST_PTR(B6, USB2BDDN),
+	  SIG_EXPR_LIST_PTR(B6, USB2BHDN));
+
+GROUP_DECL(USBB, A6, B6);
+
+FUNC_DECL_1(USB11BHID, USBB);
+FUNC_DECL_1(USB2BD, USBB);
+FUNC_DECL_1(USB2BH, USBB);
+
 /* Pins, groups and functions are sort(1):ed alphabetically for sanity */
 
 static struct pinctrl_pin_desc aspeed_g6_pins[ASPEED_G6_NR_PINS] = {
@@ -1582,6 +1636,8 @@ static struct pinctrl_pin_desc aspeed_g6_pins[ASPEED_G6_NR_PINS] = {
 	ASPEED_PINCTRL_PIN(A24),
 	ASPEED_PINCTRL_PIN(A25),
 	ASPEED_PINCTRL_PIN(A3),
+	ASPEED_PINCTRL_PIN(A4),
+	ASPEED_PINCTRL_PIN(A6),
 	ASPEED_PINCTRL_PIN(AA11),
 	ASPEED_PINCTRL_PIN(AA12),
 	ASPEED_PINCTRL_PIN(AA16),
@@ -1686,6 +1742,8 @@ static struct pinctrl_pin_desc aspeed_g6_pins[ASPEED_G6_NR_PINS] = {
 	ASPEED_PINCTRL_PIN(B25),
 	ASPEED_PINCTRL_PIN(B26),
 	ASPEED_PINCTRL_PIN(B3),
+	ASPEED_PINCTRL_PIN(B4),
+	ASPEED_PINCTRL_PIN(B6),
 	ASPEED_PINCTRL_PIN(C1),
 	ASPEED_PINCTRL_PIN(C11),
 	ASPEED_PINCTRL_PIN(C12),
@@ -2046,6 +2104,8 @@ static const struct aspeed_pin_group aspeed_g6_groups[] = {
 	ASPEED_PINCTRL_GROUP(UART7),
 	ASPEED_PINCTRL_GROUP(UART8),
 	ASPEED_PINCTRL_GROUP(UART9),
+	ASPEED_PINCTRL_GROUP(USBA),
+	ASPEED_PINCTRL_GROUP(USBB),
 	ASPEED_PINCTRL_GROUP(VB),
 	ASPEED_PINCTRL_GROUP(VGAHS),
 	ASPEED_PINCTRL_GROUP(VGAVS),
@@ -2257,6 +2317,13 @@ static const struct aspeed_pin_function aspeed_g6_functions[] = {
 	ASPEED_PINCTRL_FUNC(UART7),
 	ASPEED_PINCTRL_FUNC(UART8),
 	ASPEED_PINCTRL_FUNC(UART9),
+	ASPEED_PINCTRL_FUNC(USB11BHID),
+	ASPEED_PINCTRL_FUNC(USB2AD),
+	ASPEED_PINCTRL_FUNC(USB2ADP),
+	ASPEED_PINCTRL_FUNC(USB2AH),
+	ASPEED_PINCTRL_FUNC(USB2AHP),
+	ASPEED_PINCTRL_FUNC(USB2BD),
+	ASPEED_PINCTRL_FUNC(USB2BH),
 	ASPEED_PINCTRL_FUNC(VB),
 	ASPEED_PINCTRL_FUNC(VGAHS),
 	ASPEED_PINCTRL_FUNC(VGAVS),
diff --git a/drivers/pinctrl/aspeed/pinmux-aspeed.h b/drivers/pinctrl/aspeed/pinmux-aspeed.h
index 140c5ce9fbc1..f86739e800c3 100644
--- a/drivers/pinctrl/aspeed/pinmux-aspeed.h
+++ b/drivers/pinctrl/aspeed/pinmux-aspeed.h
@@ -737,6 +737,7 @@ struct aspeed_pin_desc {
 #define FUNC_DECL_(func, ...) \
 	static const char *FUNC_SYM(func)[] = { __VA_ARGS__ }
 
+#define FUNC_DECL_1(func, group) FUNC_DECL_(func, #group)
 #define FUNC_DECL_2(func, one, two) FUNC_DECL_(func, #one, #two)
 #define FUNC_DECL_3(func, one, two, three) FUNC_DECL_(func, #one, #two, #three)
 
-- 
2.20.1

