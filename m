From: Peng Fan (OSS) <peng.fan@oss.nxp.com>
Date: Wed, 01 May 2024 12:49:45 -0000
Subject: [PATCH 04/21] pinctrl: stm32: Use scope based of_node_put()
 cleanups
In-Reply-To: <20240501-pinctrl-cleanup-v1-0-797ceca46e5c@nxp.com>
References: <20240501-pinctrl-cleanup-v1-0-797ceca46e5c@nxp.com>
Message-ID: <20240501-pinctrl-cleanup-v1-4-797ceca46e5c@nxp.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Peng Fan <peng.fan@nxp.com>

Use scope based of_node_put() cleanup to simplify code.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/stm32/pinctrl-stm32.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index 978ccdbaf3d3..ca163a91e724 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -670,7 +670,6 @@ static int stm32_pctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
 				 struct device_node *np_config,
 				 struct pinctrl_map **map, unsigned *num_maps)
 {
-	struct device_node *np;
 	unsigned reserved_maps;
 	int ret;
 
@@ -678,12 +677,11 @@ static int stm32_pctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
 	*num_maps = 0;
 	reserved_maps = 0;
 
-	for_each_child_of_node(np_config, np) {
+	for_each_child_of_node_scoped(np_config, np) {
 		ret = stm32_pctrl_dt_subnode_to_map(pctldev, np, map,
 				&reserved_maps, num_maps);
 		if (ret < 0) {
 			pinctrl_utils_free_map(pctldev, *map, *num_maps);
-			of_node_put(np);
 			return ret;
 		}
 	}
@@ -1401,7 +1399,7 @@ static int stm32_gpiolib_register_bank(struct stm32_pinctrl *pctl, struct fwnode
 static struct irq_domain *stm32_pctrl_get_irq_domain(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	struct device_node *parent;
+	struct device_node *parent __free(device_node) = NULL;
 	struct irq_domain *domain;
 
 	if (!of_property_present(np, "interrupt-parent"))
@@ -1412,7 +1410,6 @@ static struct irq_domain *stm32_pctrl_get_irq_domain(struct platform_device *pde
 		return ERR_PTR(-ENXIO);
 
 	domain = irq_find_host(parent);
-	of_node_put(parent);
 	if (!domain)
 		/* domain not registered yet */
 		return ERR_PTR(-EPROBE_DEFER);

-- 
2.37.1

