From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 10 Jul 2019 23:40:09 +0930
Subject: [PATCH] clk: aspeed: Add SDIO gate
Message-ID: <20190710141009.20651-1-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Joel Stanley <joel@jms.id.au>

The clock divisor comes with an enable bit (gate). This was not
implemented as we didn't have access to SD hardware when writing the
driver. Now that we can test it, add the gate as a parent to the
divisor.

There is no reason to expose the gate separately, so users will enable
it by turning on the ASPEED_CLK_SDIO divisor.

Signed-off-by: Joel Stanley <joel@jms.id.au>
[aj: Minor style cleanup]
Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/clk/clk-aspeed.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-aspeed.c b/drivers/clk/clk-aspeed.c
index 42b4df6ba249..898291501f45 100644
--- a/drivers/clk/clk-aspeed.c
+++ b/drivers/clk/clk-aspeed.c
@@ -500,9 +500,14 @@ static int aspeed_clk_probe(struct platform_device *pdev)
 		return PTR_ERR(hw);
 	aspeed_clk_data->hws[ASPEED_CLK_MPLL] =	hw;
 
-	/* SD/SDIO clock divider (TODO: There's a gate too) */
-	hw = clk_hw_register_divider_table(dev, "sdio", "hpll", 0,
-			scu_base + ASPEED_CLK_SELECTION, 12, 3, 0,
+	/* SD/SDIO clock divider and gate */
+	hw = clk_hw_register_gate(dev, "sd_extclk_gate", "hpll", 0,
+				  scu_base + ASPEED_CLK_SELECTION, 15, 0,
+				  &aspeed_clk_lock);
+	if (IS_ERR(hw))
+		return PTR_ERR(hw);
+	hw = clk_hw_register_divider_table(dev, "sd_extclk", "sd_extclk_gate",
+			0, scu_base + ASPEED_CLK_SELECTION, 12, 3, 0,
 			soc_data->div_table,
 			&aspeed_clk_lock);
 	if (IS_ERR(hw))
-- 
2.20.1

