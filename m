From: Xu Wang <vulab@iscas.ac.cn>
Date: Fri,  4 Dec 2020 08:51:50 +0000
Subject: [PATCH] usb: gadget: aspeed: Remove redundant null check before
 clk_disable_unprepare
Message-ID: <20201204085150.3063-1-vulab@iscas.ac.cn>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Because clk_disable_unprepare() already checked NULL clock parameter,
so the additional check is unnecessary, just remove it.

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
---
 drivers/usb/gadget/udc/aspeed-vhub/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/aspeed-vhub/core.c b/drivers/usb/gadget/udc/aspeed-vhub/core.c
index be7bb64e3594..ea47f4b98de9 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/core.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/core.c
@@ -282,8 +282,7 @@ static int ast_vhub_remove(struct platform_device *pdev)
 	       VHUB_CTRL_PHY_RESET_DIS,
 	       vhub->regs + AST_VHUB_CTRL);
 
-	if (vhub->clk)
-		clk_disable_unprepare(vhub->clk);
+	clk_disable_unprepare(vhub->clk);
 
 	spin_unlock_irqrestore(&vhub->lock, flags);
 
-- 
2.17.1

