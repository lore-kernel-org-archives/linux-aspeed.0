From: Peng Fan (OSS) <peng.fan@oss.nxp.com>
Date: Sat, 04 May 2024 13:16:50 -0000
Subject: [PATCH v2 16/20] pinctrl: bcm: bcm63xx: Use scope based
 of_node_put() cleanups
In-Reply-To: <20240504-pinctrl-cleanup-v2-0-26c5f2dc1181@nxp.com>
References: <20240504-pinctrl-cleanup-v2-0-26c5f2dc1181@nxp.com>
Message-ID: <20240504-pinctrl-cleanup-v2-16-26c5f2dc1181@nxp.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Peng Fan <peng.fan@nxp.com>

Use scope based of_node_put() cleanup to simplify code.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/bcm/pinctrl-bcm63xx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pinctrl/bcm/pinctrl-bcm63xx.c b/drivers/pinctrl/bcm/pinctrl-bcm63xx.c
index e1285fe2fbc0..59d2ce8462d8 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm63xx.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm63xx.c
@@ -67,7 +67,6 @@ int bcm63xx_pinctrl_probe(struct platform_device *pdev,
 {
 	struct device *dev = &pdev->dev;
 	struct bcm63xx_pinctrl *pc;
-	struct device_node *node;
 	int err;
 
 	pc = devm_kzalloc(dev, sizeof(*pc), GFP_KERNEL);
@@ -94,12 +93,11 @@ int bcm63xx_pinctrl_probe(struct platform_device *pdev,
 	if (IS_ERR(pc->pctl_dev))
 		return PTR_ERR(pc->pctl_dev);
 
-	for_each_child_of_node(dev->parent->of_node, node) {
+	for_each_child_of_node_scoped(dev->parent->of_node, node) {
 		if (of_match_node(bcm63xx_gpio_of_match, node)) {
 			err = bcm63xx_gpio_probe(dev, node, soc, pc);
 			if (err) {
 				dev_err(dev, "could not add GPIO chip\n");
-				of_node_put(node);
 				return err;
 			}
 		}

-- 
2.37.1

