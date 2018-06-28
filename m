From: Joel Stanley <joel@jms.id.au>
Date: Fri, 29 Jun 2018 08:45:40 +0930
Subject: [PATCH] clk: aspeed: Support HPLL strapping on ast2400
Message-ID: <20180628231540.26633-1-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

The HPLL can be configured through a register (SCU24), however some
platforms chose to configure it through the strapping settings and do
not use the register. This was not noticed as the logic for bit 18 in
SCU24 was confused: set means programmed, but the driver read it as set
means strapped.

This gives us the correct HPLL value on Palmetto systems, from which
most of the peripheral clocks are generated.

Fixes: 5eda5d79e4be ("clk: Add clock driver for ASPEED BMC SoCs")
Cc: stable at vger.kernel.org # v4.15
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/clk/clk-aspeed.c | 42 +++++++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/clk-aspeed.c b/drivers/clk/clk-aspeed.c
index 38b366b00c57..2ef4ad7bdbdc 100644
--- a/drivers/clk/clk-aspeed.c
+++ b/drivers/clk/clk-aspeed.c
@@ -24,7 +24,7 @@
 #define ASPEED_MPLL_PARAM	0x20
 #define ASPEED_HPLL_PARAM	0x24
 #define  AST2500_HPLL_BYPASS_EN	BIT(20)
-#define  AST2400_HPLL_STRAPPED	BIT(18)
+#define  AST2400_HPLL_PROGRAMMED BIT(18)
 #define  AST2400_HPLL_BYPASS_EN	BIT(17)
 #define ASPEED_MISC_CTRL	0x2c
 #define  UART_DIV13_EN		BIT(12)
@@ -565,29 +565,45 @@ builtin_platform_driver(aspeed_clk_driver);
 static void __init aspeed_ast2400_cc(struct regmap *map)
 {
 	struct clk_hw *hw;
-	u32 val, freq, div;
+	u32 val, div, clkin, hpll;
+	const u16 hpll_rates[][4] =3D {
+		{384, 360, 336, 408},
+		{400, 375, 350, 425},
+	};
+	int rate;
=20
 	/*
 	 * CLKIN is the crystal oscillator, 24, 48 or 25MHz selected by
 	 * strapping
 	 */
 	regmap_read(map, ASPEED_STRAP, &val);
-	if (val & CLKIN_25MHZ_EN)
-		freq =3D 25000000;
-	else if (val & AST2400_CLK_SOURCE_SEL)
-		freq =3D 48000000;
-	else
-		freq =3D 24000000;
-	hw =3D clk_hw_register_fixed_rate(NULL, "clkin", NULL, 0, freq);
-	pr_debug("clkin @%u MHz\n", freq / 1000000);
+	rate =3D (val >> 8) & 3;
+	if (val & CLKIN_25MHZ_EN) {
+		clkin =3D 25000000;
+		hpll =3D hpll_rates[1][rate];
+	} else if (val & AST2400_CLK_SOURCE_SEL) {
+		clkin =3D 48000000;
+		hpll =3D hpll_rates[0][rate];
+	} else {
+		clkin =3D 24000000;
+		hpll =3D hpll_rates[0][rate];
+	}
+	hw =3D clk_hw_register_fixed_rate(NULL, "clkin", NULL, 0, clkin);
+	pr_debug("clkin @%u MHz\n", clkin / 1000000);
=20
 	/*
 	 * High-speed PLL clock derived from the crystal. This the CPU clock,
-	 * and we assume that it is enabled
+	 * and we assume that it is enabled. It can be configured through the
+	 * HPLL_PARAM register, or set to a specified frequency by strapping.
 	 */
 	regmap_read(map, ASPEED_HPLL_PARAM, &val);
-	WARN(val & AST2400_HPLL_STRAPPED, "hpll is strapped not configured");
-	aspeed_clk_data->hws[ASPEED_CLK_HPLL] =3D aspeed_ast2400_calc_pll("hpll",=
 val);
+	if (val & AST2400_HPLL_PROGRAMMED)
+		hw =3D aspeed_ast2400_calc_pll("hpll", val);
+	else
+		hw =3D clk_hw_register_fixed_rate(NULL, "hpll", "clkin", 0,
+				hpll * 1000000);
+
+	aspeed_clk_data->hws[ASPEED_CLK_HPLL] =3D hw;
=20
 	/*
 	 * Strap bits 11:10 define the CPU/AHB clock frequency ratio (aka HCLK)
--=20
2.17.1

