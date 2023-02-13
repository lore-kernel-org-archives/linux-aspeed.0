From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Mon, 13 Feb 2023 21:24:19 +0800
Subject: [PATCH v3 3/5] clk: ast2600: Add full configs for I3C clocks
In-Reply-To: <cover.1676294433.git.jk@codeconstruct.com.au>
References: <cover.1676294433.git.jk@codeconstruct.com.au>
Message-ID: <ba80860666dd28416a7e3e9d1a6f467fbbf3eba2.1676294433.git.jk@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The current ast2600 I3C clock definitions are top-level (rather than
based on their actual hw sources: either HCLK or APLL), and include a
couple of definitions for (non-existent) i3c6 and i3c7.

Re-parent the individual I3C controller clocks to the main i3c clock,
explicitly sourced from the APLL rather than whatever G6_CLK_SELECTION5
was last set to.

While we're at it, remove the definitions for the i3c6 and i3c7 clock
lines; this hardware isn't present.

This is a partial cherry-pick and rework of ed44b8cdfdb and 1a35eb926d7
from Aspeed's own tree, originally by Dylan Hung
<dylan_hung@aspeedtech.com>.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>

---
v3:
 - split dt-bindings and clk changes
v2:
 - reword commit message
---
 drivers/clk/clk-ast2600.c | 38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/clk-ast2600.c b/drivers/clk/clk-ast2600.c
index 1f08ff3c60fa..45549cb18107 100644
--- a/drivers/clk/clk-ast2600.c
+++ b/drivers/clk/clk-ast2600.c
@@ -4,6 +4,7 @@
 
 #define pr_fmt(fmt) "clk-ast2600: " fmt
 
+#include <linux/bitfield.h>
 #include <linux/mfd/syscon.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
@@ -32,6 +33,18 @@
 #define ASPEED_G6_CLK_SELECTION1	0x300
 #define ASPEED_G6_CLK_SELECTION2	0x304
 #define ASPEED_G6_CLK_SELECTION4	0x310
+#define ASPEED_G6_CLK_SELECTION5	0x314
+#define   I3C_CLK_SELECTION		BIT(31)
+#define     I3C_CLK_SELECT_HCLK		0
+#define     I3C_CLK_SELECT_APLL_DIV	1
+#define   APLL_DIV_SELECTION		GENMASK(30, 28)
+#define     APLL_DIV_2			0b001
+#define     APLL_DIV_3			0b010
+#define     APLL_DIV_4			0b011
+#define     APLL_DIV_5			0b100
+#define     APLL_DIV_6			0b101
+#define     APLL_DIV_7			0b110
+#define     APLL_DIV_8			0b111
 
 #define ASPEED_HPLL_PARAM		0x200
 #define ASPEED_APLL_PARAM		0x210
@@ -97,14 +110,13 @@ static const struct aspeed_gate_data aspeed_g6_gates[] = {
 	[ASPEED_CLK_GATE_LHCCLK]	= { 37, -1, "lhclk-gate",	"lhclk", 0 },	/* LPC master/LPC+ */
 	/* Reserved 38 RSA: no longer used */
 	/* Reserved 39 */
-	[ASPEED_CLK_GATE_I3C0CLK]	= { 40,  40, "i3c0clk-gate",	NULL,	 0 },	/* I3C0 */
-	[ASPEED_CLK_GATE_I3C1CLK]	= { 41,  41, "i3c1clk-gate",	NULL,	 0 },	/* I3C1 */
-	[ASPEED_CLK_GATE_I3C2CLK]	= { 42,  42, "i3c2clk-gate",	NULL,	 0 },	/* I3C2 */
-	[ASPEED_CLK_GATE_I3C3CLK]	= { 43,  43, "i3c3clk-gate",	NULL,	 0 },	/* I3C3 */
-	[ASPEED_CLK_GATE_I3C4CLK]	= { 44,  44, "i3c4clk-gate",	NULL,	 0 },	/* I3C4 */
-	[ASPEED_CLK_GATE_I3C5CLK]	= { 45,  45, "i3c5clk-gate",	NULL,	 0 },	/* I3C5 */
-	[ASPEED_CLK_GATE_I3C6CLK]	= { 46,  46, "i3c6clk-gate",	NULL,	 0 },	/* I3C6 */
-	[ASPEED_CLK_GATE_I3C7CLK]	= { 47,  47, "i3c7clk-gate",	NULL,	 0 },	/* I3C7 */
+	[ASPEED_CLK_GATE_I3C0CLK]	= { 40,  40, "i3c0clk-gate",	"i3cclk", 0 }, /* I3C0 */
+	[ASPEED_CLK_GATE_I3C1CLK]	= { 41,  41, "i3c1clk-gate",	"i3cclk", 0 }, /* I3C1 */
+	[ASPEED_CLK_GATE_I3C2CLK]	= { 42,  42, "i3c2clk-gate",	"i3cclk", 0 }, /* I3C2 */
+	[ASPEED_CLK_GATE_I3C3CLK]	= { 43,  43, "i3c3clk-gate",	"i3cclk", 0 }, /* I3C3 */
+	[ASPEED_CLK_GATE_I3C4CLK]	= { 44,  44, "i3c4clk-gate",	"i3cclk", 0 }, /* I3C4 */
+	[ASPEED_CLK_GATE_I3C5CLK]	= { 45,  45, "i3c5clk-gate",	"i3cclk", 0 }, /* I3C5 */
+	/* Reserved: 46 & 47 */
 	[ASPEED_CLK_GATE_UART1CLK]	= { 48,  -1, "uart1clk-gate",	"uart",	 0 },	/* UART1 */
 	[ASPEED_CLK_GATE_UART2CLK]	= { 49,  -1, "uart2clk-gate",	"uart",	 0 },	/* UART2 */
 	[ASPEED_CLK_GATE_UART3CLK]	= { 50,  -1, "uart3clk-gate",	"uart",  0 },	/* UART3 */
@@ -775,6 +787,16 @@ static void __init aspeed_g6_cc(struct regmap *map)
 	/* USB 2.0 port1 phy 40MHz clock */
 	hw = clk_hw_register_fixed_rate(NULL, "usb-phy-40m", NULL, 0, 40000000);
 	aspeed_g6_clk_data->hws[ASPEED_CLK_USBPHY_40M] = hw;
+
+	/* i3c clock: source from apll, divide by 8 */
+	regmap_read(map, ASPEED_G6_CLK_SELECTION5, &val);
+	val &= ~(I3C_CLK_SELECTION | APLL_DIV_SELECTION);
+	val |= FIELD_PREP(I3C_CLK_SELECTION, I3C_CLK_SELECT_APLL_DIV);
+	val |= FIELD_PREP(APLL_DIV_SELECTION, APLL_DIV_8);
+	regmap_write(map, ASPEED_G6_CLK_SELECTION5, val);
+
+	hw = clk_hw_register_fixed_factor(NULL, "i3cclk", "apll", 0, 1, 8);
+	aspeed_g6_clk_data->hws[ASPEED_CLK_I3C] = hw;
 };
 
 static void __init aspeed_g6_cc_init(struct device_node *np)
-- 
2.39.1

