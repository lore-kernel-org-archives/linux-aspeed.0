From: Peng Fan (OSS) <peng.fan@oss.nxp.com>
Date: Wed, 01 May 2024 12:53:17 -0000
Subject: [PATCH 18/21] pinctrl: freescale: Use scope based of_node_put()
 cleanups
In-Reply-To: <20240501-pinctrl-cleanup-v1-0-797ceca46e5c@nxp.com>
References: <20240501-pinctrl-cleanup-v1-0-797ceca46e5c@nxp.com>
Message-ID: <20240501-pinctrl-cleanup-v1-18-797ceca46e5c@nxp.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Peng Fan <peng.fan@nxp.com>

Use scope based of_node_put() cleanup to simplify code.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/freescale/pinctrl-imx.c       | 31 ++++++++-------------------
 drivers/pinctrl/freescale/pinctrl-imx1-core.c | 19 ++++++----------
 drivers/pinctrl/freescale/pinctrl-mxs.c       | 24 ++++++++-------------
 3 files changed, 24 insertions(+), 50 deletions(-)

diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c b/drivers/pinctrl/freescale/pinctrl-imx.c
index 2d3d80921c0d..cb129325bf24 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx.c
@@ -63,7 +63,7 @@ static int imx_dt_node_to_map(struct pinctrl_dev *pctldev,
 	const struct imx_pinctrl_soc_info *info = ipctl->info;
 	const struct group_desc *grp;
 	struct pinctrl_map *new_map;
-	struct device_node *parent;
+	struct device_node *parent __free(device_node) = NULL;
 	struct imx_pin *pin;
 	int map_num = 1;
 	int i, j;
@@ -105,7 +105,6 @@ static int imx_dt_node_to_map(struct pinctrl_dev *pctldev,
 	new_map[0].type = PIN_MAP_TYPE_MUX_GROUP;
 	new_map[0].data.mux.function = parent->name;
 	new_map[0].data.mux.group = np->name;
-	of_node_put(parent);
 
 	/* create config map */
 	new_map++;
@@ -580,7 +579,6 @@ static int imx_pinctrl_parse_functions(struct device_node *np,
 				       u32 index)
 {
 	struct pinctrl_dev *pctl = ipctl->pctl;
-	struct device_node *child;
 	struct function_desc *func;
 	struct group_desc *grp;
 	const char **group_names;
@@ -605,17 +603,15 @@ static int imx_pinctrl_parse_functions(struct device_node *np,
 	if (!group_names)
 		return -ENOMEM;
 	i = 0;
-	for_each_child_of_node(np, child)
+	for_each_child_of_node_scoped(np, child)
 		group_names[i++] = child->name;
 	func->group_names = group_names;
 
 	i = 0;
-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		grp = devm_kzalloc(ipctl->dev, sizeof(*grp), GFP_KERNEL);
-		if (!grp) {
-			of_node_put(child);
+		if (!grp)
 			return -ENOMEM;
-		}
 
 		mutex_lock(&ipctl->mutex);
 		radix_tree_insert(&pctl->pin_group_tree,
@@ -635,21 +631,13 @@ static int imx_pinctrl_parse_functions(struct device_node *np,
  */
 static bool imx_pinctrl_dt_is_flat_functions(struct device_node *np)
 {
-	struct device_node *function_np;
-	struct device_node *pinctrl_np;
-
-	for_each_child_of_node(np, function_np) {
-		if (of_property_read_bool(function_np, "fsl,pins")) {
-			of_node_put(function_np);
+	for_each_child_of_node_scoped(np, function_np) {
+		if (of_property_read_bool(function_np, "fsl,pins"))
 			return true;
-		}
 
-		for_each_child_of_node(function_np, pinctrl_np) {
-			if (of_property_read_bool(pinctrl_np, "fsl,pins")) {
-				of_node_put(pinctrl_np);
-				of_node_put(function_np);
+		for_each_child_of_node_scoped(function_np, pinctrl_np) {
+			if (of_property_read_bool(pinctrl_np, "fsl,pins"))
 				return false;
-			}
 		}
 	}
 
@@ -720,7 +708,7 @@ int imx_pinctrl_probe(struct platform_device *pdev,
 	struct regmap_config config = { .name = "gpr" };
 	struct device_node *dev_np = pdev->dev.of_node;
 	struct pinctrl_desc *imx_pinctrl_desc;
-	struct device_node *np;
+	struct device_node *np __free(device_node) = NULL;
 	struct imx_pinctrl *ipctl;
 	struct regmap *gpr;
 	int ret, i;
@@ -765,7 +753,6 @@ int imx_pinctrl_probe(struct platform_device *pdev,
 			}
 
 			ipctl->input_sel_base = of_iomap(np, 0);
-			of_node_put(np);
 			if (!ipctl->input_sel_base) {
 				dev_err(&pdev->dev,
 					"iomuxc input select base address not found\n");
diff --git a/drivers/pinctrl/freescale/pinctrl-imx1-core.c b/drivers/pinctrl/freescale/pinctrl-imx1-core.c
index 90c696046b38..409efa1ce8f8 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx1-core.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx1-core.c
@@ -226,7 +226,7 @@ static int imx1_dt_node_to_map(struct pinctrl_dev *pctldev,
 	const struct imx1_pinctrl_soc_info *info = ipctl->info;
 	const struct imx1_pin_group *grp;
 	struct pinctrl_map *new_map;
-	struct device_node *parent;
+	struct device_node *parent __free(device_node) = NULL;
 	int map_num = 1;
 	int i, j;
 
@@ -261,7 +261,6 @@ static int imx1_dt_node_to_map(struct pinctrl_dev *pctldev,
 	new_map[0].type = PIN_MAP_TYPE_MUX_GROUP;
 	new_map[0].data.mux.function = parent->name;
 	new_map[0].data.mux.group = np->name;
-	of_node_put(parent);
 
 	/* create config map */
 	new_map++;
@@ -508,7 +507,6 @@ static int imx1_pinctrl_parse_functions(struct device_node *np,
 				       struct imx1_pinctrl_soc_info *info,
 				       u32 index)
 {
-	struct device_node *child;
 	struct imx1_pmx_func *func;
 	struct imx1_pin_group *grp;
 	int ret;
@@ -531,14 +529,12 @@ static int imx1_pinctrl_parse_functions(struct device_node *np,
 	if (!func->groups)
 		return -ENOMEM;
 
-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		func->groups[i] = child->name;
 		grp = &info->groups[grp_index++];
 		ret = imx1_pinctrl_parse_groups(child, grp, info, i++);
-		if (ret == -ENOMEM) {
-			of_node_put(child);
+		if (ret == -ENOMEM)
 			return ret;
-		}
 	}
 
 	return 0;
@@ -548,7 +544,6 @@ static int imx1_pinctrl_parse_dt(struct platform_device *pdev,
 		struct imx1_pinctrl *pctl, struct imx1_pinctrl_soc_info *info)
 {
 	struct device_node *np = pdev->dev.of_node;
-	struct device_node *child;
 	int ret;
 	u32 nfuncs = 0;
 	u32 ngroups = 0;
@@ -557,7 +552,7 @@ static int imx1_pinctrl_parse_dt(struct platform_device *pdev,
 	if (!np)
 		return -ENODEV;
 
-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		++nfuncs;
 		ngroups += of_get_child_count(child);
 	}
@@ -579,12 +574,10 @@ static int imx1_pinctrl_parse_dt(struct platform_device *pdev,
 	if (!info->functions || !info->groups)
 		return -ENOMEM;
 
-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		ret = imx1_pinctrl_parse_functions(child, info, ifunc++);
-		if (ret == -ENOMEM) {
-			of_node_put(child);
+		if (ret == -ENOMEM)
 			return -ENOMEM;
-		}
 	}
 
 	return 0;
diff --git a/drivers/pinctrl/freescale/pinctrl-mxs.c b/drivers/pinctrl/freescale/pinctrl-mxs.c
index e77311f26262..baa1e806688d 100644
--- a/drivers/pinctrl/freescale/pinctrl-mxs.c
+++ b/drivers/pinctrl/freescale/pinctrl-mxs.c
@@ -406,22 +406,22 @@ static int mxs_pinctrl_probe_dt(struct platform_device *pdev,
 {
 	struct mxs_pinctrl_soc_data *soc = d->soc;
 	struct device_node *np = pdev->dev.of_node;
-	struct device_node *child;
+	struct device_node *ch;
 	struct mxs_function *f;
 	const char *fn, *fnull = "";
 	int i = 0, idxf = 0, idxg = 0;
 	int ret;
 	u32 val;
 
-	child = of_get_next_child(np, NULL);
-	if (!child) {
+	ch = of_get_next_child(np, NULL);
+	if (!ch) {
 		dev_err(&pdev->dev, "no group is defined\n");
 		return -ENOENT;
 	}
 
 	/* Count total functions and groups */
 	fn = fnull;
-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		if (is_mxs_gpio(child))
 			continue;
 		soc->ngroups++;
@@ -450,7 +450,7 @@ static int mxs_pinctrl_probe_dt(struct platform_device *pdev,
 	/* Count groups for each function */
 	fn = fnull;
 	f = &soc->functions[idxf];
-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		if (is_mxs_gpio(child))
 			continue;
 		if (of_property_read_u32(child, "reg", &val))
@@ -490,16 +490,14 @@ static int mxs_pinctrl_probe_dt(struct platform_device *pdev,
 	/* Get groups for each function */
 	idxf = 0;
 	fn = fnull;
-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		if (is_mxs_gpio(child))
 			continue;
 		if (of_property_read_u32(child, "reg", &val)) {
 			ret = mxs_pinctrl_parse_group(pdev, child,
 						      idxg++, NULL);
-			if (ret) {
-				of_node_put(child);
+			if (ret)
 				return ret;
-			}
 			continue;
 		}
 
@@ -509,19 +507,15 @@ static int mxs_pinctrl_probe_dt(struct platform_device *pdev,
 						 f->ngroups,
 						 sizeof(*f->groups),
 						 GFP_KERNEL);
-			if (!f->groups) {
-				of_node_put(child);
+			if (!f->groups)
 				return -ENOMEM;
-			}
 			fn = child->name;
 			i = 0;
 		}
 		ret = mxs_pinctrl_parse_group(pdev, child, idxg++,
 					      &f->groups[i++]);
-		if (ret) {
-			of_node_put(child);
+		if (ret)
 			return ret;
-		}
 	}
 
 	return 0;

-- 
2.37.1

