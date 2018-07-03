From: Benjamin Herrenschmidt <benh@linux.vnet.ibm.com>
Date: Tue, 03 Jul 2018 17:24:47 +1000
Subject: [PATCH] clk: aspeed: Treat a gate in reset as disabled
Message-ID: <c31c3652829e8e7064f750d219237c4eb32773e4.camel@linux.vnet.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On some systems, we come out of the bootloader with some
gates set with the clock "enabled" but the reset also
asserted.

Since 8a53fc511c5e "clk: aspeed: Prevent reset if clock is enabled"
we check that enabled bit in aspeed_clk_enabled(), and do
nothing if already set.

This breaks when the above scenario occurs, as the clock
is enabled, but the reset still needs to be lifted.

This patch fixes it by also checking the reset bit (if any)
and treating a gate in "reset" as being disabled.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Fixes: 8a53fc511c5e "clk: aspeed: Prevent reset if clock is enabled"
CC: Eddie James <eajames@linux.vnet.ibm.com>
---
 drivers/clk/clk-aspeed.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/clk/clk-aspeed.c b/drivers/clk/clk-aspeed.c
index c17032bc853a..c555eac2c528 100644
--- a/drivers/clk/clk-aspeed.c
+++ b/drivers/clk/clk-aspeed.c
@@ -212,9 +212,22 @@ static int aspeed_clk_is_enabled(struct clk_hw *hw)
 {
 	struct aspeed_clk_gate *gate = to_aspeed_clk_gate(hw);
 	u32 clk = BIT(gate->clock_idx);
+	u32 rst = BIT(gate->reset_idx);
 	u32 enval = (gate->flags & CLK_GATE_SET_TO_DISABLE) ? 0 : clk;
 	u32 reg;
 
+	/*
+	 * If the IP is in reset, treat the clock as not enabled,
+	 * this happens with some clocks such as the USB one when
+	 * coming from cold reset. Without this, aspeed_clk_enable()
+	 * will fail to lift the reset.
+	 */
+	if (gate->reset_idx >= 0) {
+		regmap_read(gate->map, ASPEED_RESET_CTRL, &reg);
+		if (reg & rst)
+			return 0;
+	}
+
 	regmap_read(gate->map, ASPEED_CLK_STOP_CTRL, &reg);
 
 	return ((reg & clk) == enval) ? 1 : 0;

