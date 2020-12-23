From: Sasha Levin <sashal@kernel.org>
Date: Tue, 22 Dec 2020 21:16:04 -0500
Subject: [PATCH AUTOSEL 5.4 001/130] soc: aspeed-lpc-ctrl: Fail probe of
 lpc-ctrl if reserved memory is not aligned
Message-ID: <20201223021813.2791612-1-sashal@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Andrew Jeffery <andrew@aj.id.au>

[ Upstream commit 6bf4ddbe2b4805f0628922446a7e85e34013cd10 ]

Alignment is a hardware constraint of the LPC2AHB bridge, and misaligned
reserved memory will present as corrupted data.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Link: https://lore.kernel.org/r/20191016233950.10100-1-andrew at aj.id.au
Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/aspeed/aspeed-lpc-ctrl.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/soc/aspeed/aspeed-lpc-ctrl.c b/drivers/soc/aspeed/aspeed-lpc-ctrl.c
index 01ed21e8bfee5..dd147af494fdf 100644
--- a/drivers/soc/aspeed/aspeed-lpc-ctrl.c
+++ b/drivers/soc/aspeed/aspeed-lpc-ctrl.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/log2.h>
 #include <linux/mfd/syscon.h>
 #include <linux/miscdevice.h>
 #include <linux/mm.h>
@@ -241,6 +242,18 @@ static int aspeed_lpc_ctrl_probe(struct platform_device *pdev)
 
 		lpc_ctrl->mem_size = resource_size(&resm);
 		lpc_ctrl->mem_base = resm.start;
+
+		if (!is_power_of_2(lpc_ctrl->mem_size)) {
+			dev_err(dev, "Reserved memory size must be a power of 2, got %u\n",
+			       (unsigned int)lpc_ctrl->mem_size);
+			return -EINVAL;
+		}
+
+		if (!IS_ALIGNED(lpc_ctrl->mem_base, lpc_ctrl->mem_size)) {
+			dev_err(dev, "Reserved memory must be naturally aligned for size %u\n",
+			       (unsigned int)lpc_ctrl->mem_size);
+			return -EINVAL;
+		}
 	}
 
 	lpc_ctrl->regmap = syscon_node_to_regmap(
-- 
2.27.0

