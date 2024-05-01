From: Peng Fan (OSS) <peng.fan@oss.nxp.com>
Date: Wed, 01 May 2024 12:51:38 -0000
Subject: [PATCH 11/21] pinctrl: rockchip: Use scope based of_node_put()
 cleanups
In-Reply-To: <20240501-pinctrl-cleanup-v1-0-797ceca46e5c@nxp.com>
References: <20240501-pinctrl-cleanup-v1-0-797ceca46e5c@nxp.com>
Message-ID: <20240501-pinctrl-cleanup-v1-11-797ceca46e5c@nxp.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Peng Fan <peng.fan@nxp.com>

Use scope based of_node_put() cleanup to simplify code.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/pinctrl-rockchip.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index 3bedf36a0019..5c09469c84d7 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -326,7 +326,7 @@ static int rockchip_dt_node_to_map(struct pinctrl_dev *pctldev,
 	const struct rockchip_pin_group *grp;
 	struct device *dev = info->dev;
 	struct pinctrl_map *new_map;
-	struct device_node *parent;
+	struct device_node *parent __free(device_node) = NULL;
 	int map_num = 1;
 	int i;
 
@@ -358,7 +358,6 @@ static int rockchip_dt_node_to_map(struct pinctrl_dev *pctldev,
 	new_map[0].type = PIN_MAP_TYPE_MUX_GROUP;
 	new_map[0].data.mux.function = parent->name;
 	new_map[0].data.mux.group = np->name;
-	of_node_put(parent);
 
 	/* create config map */
 	new_map++;
@@ -3057,7 +3056,6 @@ static int rockchip_pinctrl_parse_functions(struct device_node *np,
 						u32 index)
 {
 	struct device *dev = info->dev;
-	struct device_node *child;
 	struct rockchip_pmx_func *func;
 	struct rockchip_pin_group *grp;
 	int ret;
@@ -3078,14 +3076,12 @@ static int rockchip_pinctrl_parse_functions(struct device_node *np,
 	if (!func->groups)
 		return -ENOMEM;
 
-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		func->groups[i] = child->name;
 		grp = &info->groups[grp_index++];
 		ret = rockchip_pinctrl_parse_groups(child, grp, info, i++);
-		if (ret) {
-			of_node_put(child);
+		if (ret)
 			return ret;
-		}
 	}
 
 	return 0;
@@ -3096,7 +3092,6 @@ static int rockchip_pinctrl_parse_dt(struct platform_device *pdev,
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
-	struct device_node *child;
 	int ret;
 	int i;
 
@@ -3115,14 +3110,13 @@ static int rockchip_pinctrl_parse_dt(struct platform_device *pdev,
 
 	i = 0;
 
-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		if (of_match_node(rockchip_bank_match, child))
 			continue;
 
 		ret = rockchip_pinctrl_parse_functions(child, info, i++);
 		if (ret) {
 			dev_err(dev, "failed to parse function\n");
-			of_node_put(child);
 			return ret;
 		}
 	}

-- 
2.37.1

