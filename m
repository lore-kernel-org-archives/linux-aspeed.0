From: Joel Stanley <joel@jms.id.au>
Date: Thu, 20 Jun 2019 18:47:38 +0930
Subject: [PATCH] soc: aspeed: lpc-ctrl: Fix probe error handling
Message-ID: <20190620091738.14683-1-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

gcc warns that a mising "flash" phandle node leads to undefined
behavior later:

drivers/soc/aspeed/aspeed-lpc-ctrl.c: In function 'aspeed_lpc_ctrl_probe':
drivers/soc/aspeed/aspeed-lpc-ctrl.c:201:18: error: '*((void *)&resm+8)' may be used uninitialized in this function [-Werror=maybe-uninitialized]

Only set the flash base and size if we find a phandle in the device
tree.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/soc/aspeed/aspeed-lpc-ctrl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/aspeed/aspeed-lpc-ctrl.c b/drivers/soc/aspeed/aspeed-lpc-ctrl.c
index aca13779764a..eee26c2d8b52 100644
--- a/drivers/soc/aspeed/aspeed-lpc-ctrl.c
+++ b/drivers/soc/aspeed/aspeed-lpc-ctrl.c
@@ -223,10 +223,11 @@ static int aspeed_lpc_ctrl_probe(struct platform_device *pdev)
 			dev_err(dev, "Couldn't address to resource for flash\n");
 			return rc;
 		}
+
+		lpc_ctrl->pnor_size = resource_size(&resm);
+		lpc_ctrl->pnor_base = resm.start;
 	}
 
-	lpc_ctrl->pnor_size = resource_size(&resm);
-	lpc_ctrl->pnor_base = resm.start;
 
 	dev_set_drvdata(&pdev->dev, lpc_ctrl);
 
-- 
2.20.1

