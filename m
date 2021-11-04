From: jae.hyun.yoo@intel.com <jae.hyun.yoo@intel.com>
Date: Thu,  4 Nov 2021 10:37:09 -0700
Subject: [PATCH v2] soc: aspeed: lpc-ctrl: Block error printing on probe defer
 cases
Message-ID: <20211104173709.222912-1-jae.hyun.yoo@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>

Add a checking code when it gets -EPROBE_DEFER while getting a clock
resource. In this case, it doesn't need to print out an error message
because the probing will be re-visited.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
---
v1 -> v2:
 * Simplified it using dev_err_probe. (Iwona)

 drivers/soc/aspeed/aspeed-lpc-ctrl.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/aspeed/aspeed-lpc-ctrl.c b/drivers/soc/aspeed/aspeed-lpc-ctrl.c
index 72771e018c42..258894ed234b 100644
--- a/drivers/soc/aspeed/aspeed-lpc-ctrl.c
+++ b/drivers/soc/aspeed/aspeed-lpc-ctrl.c
@@ -306,10 +306,9 @@ static int aspeed_lpc_ctrl_probe(struct platform_device *pdev)
 	}
 
 	lpc_ctrl->clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(lpc_ctrl->clk)) {
-		dev_err(dev, "couldn't get clock\n");
-		return PTR_ERR(lpc_ctrl->clk);
-	}
+	if (IS_ERR(lpc_ctrl->clk))
+		return dev_err_probe(dev, PTR_ERR(lpc_ctrl->clk),
+				     "couldn't get clock\n");
 	rc = clk_prepare_enable(lpc_ctrl->clk);
 	if (rc) {
 		dev_err(dev, "couldn't enable clock\n");
-- 
2.25.1

