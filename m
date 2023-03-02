From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Thu,  2 Mar 2023 08:58:33 +0800
Subject: [PATCH v5 5/6] clk: ast2600: Add comment about combined clock + reset handling
In-Reply-To: <20230302005834.13171-1-jk@codeconstruct.com.au>
References: <20230302005834.13171-1-jk@codeconstruct.com.au>
Message-ID: <20230302005834.13171-6-jk@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add a little description about how reset lines can be implicit with
clock enable/disable. This is mostly based on the commit message
from the original submission in 15ed8ce5f8.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 drivers/clk/clk-ast2600.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/clk/clk-ast2600.c b/drivers/clk/clk-ast2600.c
index 09f26ab5f9af..a094a2601a37 100644
--- a/drivers/clk/clk-ast2600.c
+++ b/drivers/clk/clk-ast2600.c
@@ -73,6 +73,27 @@ static void __iomem *scu_g6_base;
 static u8 soc_rev;
 
 /*
+ * The majority of the clocks in the system are gates paired with a reset
+ * controller that holds the IP in reset; this is represented by the @reset_idx
+ * member of entries here.
+ *
+ * This borrows from clk_hw_register_gate, but registers two 'gates', one
+ * to control the clock enable register and the other to control the reset
+ * IP. This allows us to enforce the ordering:
+ *
+ * 1. Place IP in reset
+ * 2. Enable clock
+ * 3. Delay
+ * 4. Release reset
+ *
+ * Consequently, if reset_idx is set, reset control is implicit: the clock
+ * consumer does not need its own reset handling, as enabling the clock will
+ * also deassert reset.
+ *
+ * There are some gates that do not have an associated reset; these are
+ * handled by using -1 as the index for the reset, and the consumer must
+ * explictly assert/deassert reset lines as required.
+ *
  * Clocks marked with CLK_IS_CRITICAL:
  *
  *  ref0 and ref1 are essential for the SoC to operate
-- 
2.39.1

