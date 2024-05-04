From: Peng Fan (OSS) <peng.fan@oss.nxp.com>
Date: Sat, 04 May 2024 13:15:43 -0000
Subject: [PATCH v2 12/20] pinctrl: s32cc: Use scope based of_node_put()
 cleanups
In-Reply-To: <20240504-pinctrl-cleanup-v2-0-26c5f2dc1181@nxp.com>
References: <20240504-pinctrl-cleanup-v2-0-26c5f2dc1181@nxp.com>
Message-ID: <20240504-pinctrl-cleanup-v2-12-26c5f2dc1181@nxp.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Peng Fan <peng.fan@nxp.com>

Use scope based of_node_put() cleanup to simplify code.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/nxp/pinctrl-s32cc.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/drivers/pinctrl/nxp/pinctrl-s32cc.c b/drivers/pinctrl/nxp/pinctrl-s32cc.c
index f0cad2c501f7..df3e5d82da4b 100644
--- a/drivers/pinctrl/nxp/pinctrl-s32cc.c
+++ b/drivers/pinctrl/nxp/pinctrl-s32cc.c
@@ -268,28 +268,23 @@ static int s32_dt_node_to_map(struct pinctrl_dev *pctldev,
 			      unsigned int *num_maps)
 {
 	unsigned int reserved_maps;
-	struct device_node *np;
-	int ret = 0;
+	int ret;
 
 	reserved_maps = 0;
 	*map = NULL;
 	*num_maps = 0;
 
-	for_each_available_child_of_node(np_config, np) {
+	for_each_available_child_of_node_scoped(np_config, np) {
 		ret = s32_dt_group_node_to_map(pctldev, np, map,
 					       &reserved_maps, num_maps,
 					       np_config->name);
 		if (ret < 0) {
-			of_node_put(np);
-			break;
+			pinctrl_utils_free_map(pctldev, *map, *num_maps);
+			return ret;
 		}
 	}
 
-	if (ret)
-		pinctrl_utils_free_map(pctldev, *map, *num_maps);
-
-	return ret;
-
+	return 0;
 }
 
 static const struct pinctrl_ops s32_pctrl_ops = {
@@ -786,7 +781,6 @@ static int s32_pinctrl_parse_functions(struct device_node *np,
 					struct s32_pinctrl_soc_info *info,
 					u32 index)
 {
-	struct device_node *child;
 	struct pinfunction *func;
 	struct s32_pin_group *grp;
 	const char **groups;
@@ -810,14 +804,12 @@ static int s32_pinctrl_parse_functions(struct device_node *np,
 	if (!groups)
 		return -ENOMEM;
 
-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		groups[i] = child->name;
 		grp = &info->groups[info->grp_index++];
 		ret = s32_pinctrl_parse_groups(child, grp, info);
-		if (ret) {
-			of_node_put(child);
+		if (ret)
 			return ret;
-		}
 		i++;
 	}
 
@@ -831,7 +823,6 @@ static int s32_pinctrl_probe_dt(struct platform_device *pdev,
 {
 	struct s32_pinctrl_soc_info *info = ipctl->info;
 	struct device_node *np = pdev->dev.of_node;
-	struct device_node *child;
 	struct resource *res;
 	struct regmap *map;
 	void __iomem *base;
@@ -889,7 +880,7 @@ static int s32_pinctrl_probe_dt(struct platform_device *pdev,
 		return -ENOMEM;
 
 	info->ngroups = 0;
-	for_each_child_of_node(np, child)
+	for_each_child_of_node_scoped(np, child)
 		info->ngroups += of_get_child_count(child);
 
 	info->groups = devm_kcalloc(&pdev->dev, info->ngroups,
@@ -898,12 +889,10 @@ static int s32_pinctrl_probe_dt(struct platform_device *pdev,
 		return -ENOMEM;
 
 	i = 0;
-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		ret = s32_pinctrl_parse_functions(child, info, i++);
-		if (ret) {
-			of_node_put(child);
+		if (ret)
 			return ret;
-		}
 	}
 
 	return 0;

-- 
2.37.1

