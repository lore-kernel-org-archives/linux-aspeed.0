From: Joel Stanley <joel@jms.id.au>
Date: Wed, 16 Oct 2019 23:43:19 +1030
Subject: [PATCH] clk: ast2600: Fix enabling of clocks
Message-ID: <20191016131319.31318-1-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The struct clk_ops enable callback for the aspeed gates mixes up the set
to clear and write to set registers.

Fixes: d3d04f6c330a ("clk: Add support for AST2600 SoC")
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/clk/clk-ast2600.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-ast2600.c b/drivers/clk/clk-ast2600.c
index 1c1bb39bb04e..b1318e6b655b 100644
--- a/drivers/clk/clk-ast2600.c
+++ b/drivers/clk/clk-ast2600.c
@@ -266,10 +266,11 @@ static int aspeed_g6_clk_enable(struct clk_hw *hw)
 
 	/* Enable clock */
 	if (gate->flags & CLK_GATE_SET_TO_DISABLE) {
-		regmap_write(gate->map, get_clock_reg(gate), clk);
-	} else {
-		/* Use set to clear register */
+		/* Clock is clear to enable, so use set to clear register */
 		regmap_write(gate->map, get_clock_reg(gate) + 0x04, clk);
+	} else {
+		/* Clock is set to enable, so use write to set register */
+		regmap_write(gate->map, get_clock_reg(gate), clk);
 	}
 
 	if (gate->reset_idx >= 0) {
-- 
2.23.0

