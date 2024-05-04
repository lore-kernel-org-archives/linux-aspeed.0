From: Peng Fan (OSS) <peng.fan@oss.nxp.com>
Date: Sat, 04 May 2024 13:16:49 -0000
Subject: [PATCH v2 15/20] pinctrl: freescale: Use scope based of_node_put()
 cleanups
In-Reply-To: <20240504-pinctrl-cleanup-v2-0-26c5f2dc1181@nxp.com>
References: <20240504-pinctrl-cleanup-v2-0-26c5f2dc1181@nxp.com>
Message-ID: <20240504-pinctrl-cleanup-v2-15-26c5f2dc1181@nxp.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Peng Fan <peng.fan@nxp.com>

Use scope based of_node_put() cleanup to simplify code.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/freescale/pinctrl-imx.c       | 25 +++++++------------------
 drivers/pinctrl/freescale/pinctrl-imx1-core.c | 16 +++++-----------
 drivers/pinctrl/freescale/pinctrl-mxs.c       | 14 ++++----------
 3 files changed, 16 insertions(+), 39 deletions(-)

diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c b/drivers/pinctrl/freescale/pinctrl-imx.c
index 2d3d80921c0d..2b7448e3cd65 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx.c
@@ -580,7 +580,6 @@ static int imx_pinctrl_parse_functions(struct device_node *np,
 				       u32 index)
 {
 	struct pinctrl_dev *pctl = ipctl->pctl;
-	struct device_node *child;
 	struct function_desc *func;
 	struct group_desc *grp;
 	const char **group_names;
@@ -605,17 +604,15 @@ static int imx_pinctrl_parse_functions(struct device_node *np,
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
@@ -635,21 +632,13 @@ static int imx_pinctrl_parse_functions(struct device_node *np,
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
 
diff --git a/drivers/pinctrl/freescale/pinctrl-imx1-core.c b/drivers/pinctrl/freescale/pinctrl-imx1-core.c
index 90c696046b38..af1ccfc90bff 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx1-core.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx1-core.c
@@ -508,7 +508,6 @@ static int imx1_pinctrl_parse_functions(struct device_node *np,
 				       struct imx1_pinctrl_soc_info *info,
 				       u32 index)
 {
-	struct device_node *child;
 	struct imx1_pmx_func *func;
 	struct imx1_pin_group *grp;
 	int ret;
@@ -531,14 +530,12 @@ static int imx1_pinctrl_parse_functions(struct device_node *np,
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
@@ -548,7 +545,6 @@ static int imx1_pinctrl_parse_dt(struct platform_device *pdev,
 		struct imx1_pinctrl *pctl, struct imx1_pinctrl_soc_info *info)
 {
 	struct device_node *np = pdev->dev.of_node;
-	struct device_node *child;
 	int ret;
 	u32 nfuncs = 0;
 	u32 ngroups = 0;
@@ -557,7 +553,7 @@ static int imx1_pinctrl_parse_dt(struct platform_device *pdev,
 	if (!np)
 		return -ENODEV;
 
-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		++nfuncs;
 		ngroups += of_get_child_count(child);
 	}
@@ -579,12 +575,10 @@ static int imx1_pinctrl_parse_dt(struct platform_device *pdev,
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
index e77311f26262..aee70fa55bec 100644
--- a/drivers/pinctrl/freescale/pinctrl-mxs.c
+++ b/drivers/pinctrl/freescale/pinctrl-mxs.c
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

