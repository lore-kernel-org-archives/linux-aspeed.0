From: jae.hyun.yoo@intel.com <jae.hyun.yoo@intel.com>
Date: Wed,  3 Nov 2021 14:54:30 -0700
Subject: [PATCH] soc: aspeed: lpc-ctrl: Block error printing on probe defer
 cases
Message-ID: <20211103215430.192229-1-jae.hyun.yoo@intel.com>
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
 drivers/soc/aspeed/aspeed-lpc-ctrl.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/aspeed/aspeed-lpc-ctrl.c b/drivers/soc/aspeed/aspeed-lpc-ctrl.c
index 72771e018c42..e2262dbc7cf6 100644
--- a/drivers/soc/aspeed/aspeed-lpc-ctrl.c
+++ b/drivers/soc/aspeed/aspeed-lpc-ctrl.c
@@ -307,8 +307,10 @@ static int aspeed_lpc_ctrl_probe(struct platform_device *pdev)
 
 	lpc_ctrl->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(lpc_ctrl->clk)) {
-		dev_err(dev, "couldn't get clock\n");
-		return PTR_ERR(lpc_ctrl->clk);
+		rc = PTR_ERR(lpc_ctrl->clk);
+		if (rc != -EPROBE_DEFER)
+			dev_err(dev, "couldn't get clock\n");
+		return rc;
 	}
 	rc = clk_prepare_enable(lpc_ctrl->clk);
 	if (rc) {
-- 
2.25.1

