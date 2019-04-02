From: Eddie James <eajames@linux.ibm.com>
Date: Tue,  2 Apr 2019 18:25:03 +0000
Subject: [PATCH 4/5] clk: Aspeed: Setup video engine clocking
In-Reply-To: <1554229504-5661-1-git-send-email-eajames@linux.ibm.com>
References: <1554229504-5661-1-git-send-email-eajames@linux.ibm.com>
Message-ID: <1554229504-5661-5-git-send-email-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add eclk mux and clock divider table. Also change the video engine reset
to the correct clock; it was previously on the video capture but needs
to be on the video engine clock.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/clk/clk-aspeed.c | 42 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-aspeed.c b/drivers/clk/clk-aspeed.c
index 5961367..42b4df6 100644
--- a/drivers/clk/clk-aspeed.c
+++ b/drivers/clk/clk-aspeed.c
@@ -87,10 +87,10 @@ struct aspeed_clk_gate {
 /* TODO: ask Aspeed about the actual parent data */
 static const struct aspeed_gate_data aspeed_gates[] = {
 	/*				 clk rst   name			parent	flags */
-	[ASPEED_CLK_GATE_ECLK] =	{  0, -1, "eclk-gate",		"eclk",	0 }, /* Video Engine */
+	[ASPEED_CLK_GATE_ECLK] =	{  0,  6, "eclk-gate",		"eclk",	0 }, /* Video Engine */
 	[ASPEED_CLK_GATE_GCLK] =	{  1,  7, "gclk-gate",		NULL,	0 }, /* 2D engine */
 	[ASPEED_CLK_GATE_MCLK] =	{  2, -1, "mclk-gate",		"mpll",	CLK_IS_CRITICAL }, /* SDRAM */
-	[ASPEED_CLK_GATE_VCLK] =	{  3,  6, "vclk-gate",		NULL,	0 }, /* Video Capture */
+	[ASPEED_CLK_GATE_VCLK] =	{  3, -1, "vclk-gate",		NULL,	0 }, /* Video Capture */
 	[ASPEED_CLK_GATE_BCLK] =	{  4,  8, "bclk-gate",		"bclk",	CLK_IS_CRITICAL }, /* PCIe/PCI */
 	[ASPEED_CLK_GATE_DCLK] =	{  5, -1, "dclk-gate",		NULL,	CLK_IS_CRITICAL }, /* DAC */
 	[ASPEED_CLK_GATE_REFCLK] =	{  6, -1, "refclk-gate",	"clkin", CLK_IS_CRITICAL },
@@ -113,6 +113,24 @@ struct aspeed_clk_gate {
 	[ASPEED_CLK_GATE_LHCCLK] =	{ 28, -1, "lhclk-gate",		"lhclk", 0 }, /* LPC master/LPC+ */
 };
 
+static const char * const eclk_parent_names[] = {
+	"mpll",
+	"hpll",
+	"dpll",
+};
+
+static const struct clk_div_table ast2500_eclk_div_table[] = {
+	{ 0x0, 2 },
+	{ 0x1, 2 },
+	{ 0x2, 3 },
+	{ 0x3, 4 },
+	{ 0x4, 5 },
+	{ 0x5, 6 },
+	{ 0x6, 7 },
+	{ 0x7, 8 },
+	{ 0 }
+};
+
 static const struct clk_div_table ast2500_mac_div_table[] = {
 	{ 0x0, 4 }, /* Yep, really. Aspeed confirmed this is correct */
 	{ 0x1, 4 },
@@ -192,18 +210,21 @@ static struct clk_hw *aspeed_ast2500_calc_pll(const char *name, u32 val)
 
 struct aspeed_clk_soc_data {
 	const struct clk_div_table *div_table;
+	const struct clk_div_table *eclk_div_table;
 	const struct clk_div_table *mac_div_table;
 	struct clk_hw *(*calc_pll)(const char *name, u32 val);
 };
 
 static const struct aspeed_clk_soc_data ast2500_data = {
 	.div_table = ast2500_div_table,
+	.eclk_div_table = ast2500_eclk_div_table,
 	.mac_div_table = ast2500_mac_div_table,
 	.calc_pll = aspeed_ast2500_calc_pll,
 };
 
 static const struct aspeed_clk_soc_data ast2400_data = {
 	.div_table = ast2400_div_table,
+	.eclk_div_table = ast2400_div_table,
 	.mac_div_table = ast2400_div_table,
 	.calc_pll = aspeed_ast2400_calc_pll,
 };
@@ -522,6 +543,22 @@ static int aspeed_clk_probe(struct platform_device *pdev)
 		return PTR_ERR(hw);
 	aspeed_clk_data->hws[ASPEED_CLK_24M] = hw;
 
+	hw = clk_hw_register_mux(dev, "eclk-mux", eclk_parent_names,
+				 ARRAY_SIZE(eclk_parent_names), 0,
+				 scu_base + ASPEED_CLK_SELECTION, 2, 0x3, 0,
+				 &aspeed_clk_lock);
+	if (IS_ERR(hw))
+		return PTR_ERR(hw);
+	aspeed_clk_data->hws[ASPEED_CLK_ECLK_MUX] = hw;
+
+	hw = clk_hw_register_divider_table(dev, "eclk", "eclk-mux", 0,
+					   scu_base + ASPEED_CLK_SELECTION, 28,
+					   3, 0, soc_data->eclk_div_table,
+					   &aspeed_clk_lock);
+	if (IS_ERR(hw))
+		return PTR_ERR(hw);
+	aspeed_clk_data->hws[ASPEED_CLK_ECLK] = hw;
+
 	/*
 	 * TODO: There are a number of clocks that not included in this driver
 	 * as more information is required:
@@ -531,7 +568,6 @@ static int aspeed_clk_probe(struct platform_device *pdev)
 	 *   RGMII
 	 *   RMII
 	 *   UART[1..5] clock source mux
-	 *   Video Engine (ECLK) mux and clock divider
 	 */
 
 	for (i = 0; i < ARRAY_SIZE(aspeed_gates); i++) {
-- 
1.8.3.1

