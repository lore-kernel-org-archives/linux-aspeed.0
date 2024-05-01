From: Peng Fan (OSS) <peng.fan@oss.nxp.com>
Date: Wed, 01 May 2024 12:51:07 -0000
Subject: [PATCH 09/21] pinctrl: renesas: Use scope based of_node_put()
 cleanups
In-Reply-To: <20240501-pinctrl-cleanup-v1-0-797ceca46e5c@nxp.com>
References: <20240501-pinctrl-cleanup-v1-0-797ceca46e5c@nxp.com>
Message-ID: <20240501-pinctrl-cleanup-v1-9-797ceca46e5c@nxp.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Peng Fan <peng.fan@nxp.com>

Use scope based of_node_put() cleanup to simplify code.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/renesas/pinctrl-rza1.c  | 14 ++++----------
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 10 +++-------
 drivers/pinctrl/renesas/pinctrl-rzn1.c  | 23 +++++++----------------
 drivers/pinctrl/renesas/pinctrl-rzv2m.c |  7 ++-----
 drivers/pinctrl/renesas/pinctrl.c       |  7 ++-----
 5 files changed, 18 insertions(+), 43 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rza1.c b/drivers/pinctrl/renesas/pinctrl-rza1.c
index edcbe7c9ad56..6527872813dc 100644
--- a/drivers/pinctrl/renesas/pinctrl-rza1.c
+++ b/drivers/pinctrl/renesas/pinctrl-rza1.c
@@ -852,7 +852,6 @@ static const struct gpio_chip rza1_gpiochip_template = {
  */
 static int rza1_dt_node_pin_count(struct device_node *np)
 {
-	struct device_node *child;
 	struct property *of_pins;
 	unsigned int npins;
 
@@ -861,12 +860,10 @@ static int rza1_dt_node_pin_count(struct device_node *np)
 		return of_pins->length / sizeof(u32);
 
 	npins = 0;
-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		of_pins = of_find_property(child, "pinmux", NULL);
-		if (!of_pins) {
-			of_node_put(child);
+		if (!of_pins)
 			return -EINVAL;
-		}
 
 		npins += of_pins->length / sizeof(u32);
 	}
@@ -986,7 +983,6 @@ static int rza1_dt_node_to_map(struct pinctrl_dev *pctldev,
 	struct rza1_pinctrl *rza1_pctl = pinctrl_dev_get_drvdata(pctldev);
 	struct rza1_mux_conf *mux_confs, *mux_conf;
 	unsigned int *grpins, *grpin;
-	struct device_node *child;
 	const char *grpname;
 	const char **fngrps;
 	int ret, npins;
@@ -1023,13 +1019,11 @@ static int rza1_dt_node_to_map(struct pinctrl_dev *pctldev,
 
 	ret = rza1_parse_pinmux_node(rza1_pctl, np, mux_conf, grpin);
 	if (ret == -ENOENT)
-		for_each_child_of_node(np, child) {
+		for_each_child_of_node_scoped(np, child) {
 			ret = rza1_parse_pinmux_node(rza1_pctl, child, mux_conf,
 						     grpin);
-			if (ret < 0) {
-				of_node_put(child);
+			if (ret < 0)
 				return ret;
-			}
 
 			grpin += ret;
 			mux_conf += ret;
diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index c3256bfde502..85a4f3c7d73c 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -745,7 +745,6 @@ static int rzg2l_dt_node_to_map(struct pinctrl_dev *pctldev,
 				unsigned int *num_maps)
 {
 	struct rzg2l_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
-	struct device_node *child;
 	unsigned int index;
 	int ret;
 
@@ -753,13 +752,11 @@ static int rzg2l_dt_node_to_map(struct pinctrl_dev *pctldev,
 	*num_maps = 0;
 	index = 0;
 
-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		ret = rzg2l_dt_subnode_to_map(pctldev, child, np, map,
 					      num_maps, &index);
-		if (ret < 0) {
-			of_node_put(child);
+		if (ret < 0)
 			goto done;
-		}
 	}
 
 	if (*num_maps == 0) {
@@ -2201,7 +2198,7 @@ static int rzg2l_gpio_register(struct rzg2l_pinctrl *pctrl)
 	const char *name = dev_name(pctrl->dev);
 	struct irq_domain *parent_domain;
 	struct of_phandle_args of_args;
-	struct device_node *parent_np;
+	struct device_node *parent_np __free(device_node) = of_irq_find_parent(np);
 	struct gpio_irq_chip *girq;
 	int ret;
 
@@ -2210,7 +2207,6 @@ static int rzg2l_gpio_register(struct rzg2l_pinctrl *pctrl)
 		return -ENXIO;
 
 	parent_domain = irq_find_host(parent_np);
-	of_node_put(parent_np);
 	if (!parent_domain)
 		return -EPROBE_DEFER;
 
diff --git a/drivers/pinctrl/renesas/pinctrl-rzn1.c b/drivers/pinctrl/renesas/pinctrl-rzn1.c
index 4b2f107824fe..e1b4203c66c6 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzn1.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzn1.c
@@ -404,7 +404,6 @@ static int rzn1_dt_node_to_map(struct pinctrl_dev *pctldev,
 			       struct pinctrl_map **map,
 			       unsigned int *num_maps)
 {
-	struct device_node *child;
 	int ret;
 
 	*map = NULL;
@@ -414,12 +413,10 @@ static int rzn1_dt_node_to_map(struct pinctrl_dev *pctldev,
 	if (ret < 0)
 		return ret;
 
-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		ret = rzn1_dt_node_to_map_one(pctldev, child, map, num_maps);
-		if (ret < 0) {
-			of_node_put(child);
+		if (ret < 0)
 			return ret;
-		}
 	}
 
 	return 0;
@@ -760,7 +757,6 @@ static int rzn1_pinctrl_parse_functions(struct device_node *np,
 {
 	struct rzn1_pmx_func *func;
 	struct rzn1_pin_group *grp;
-	struct device_node *child;
 	unsigned int i = 0;
 	int ret;
 
@@ -793,15 +789,13 @@ static int rzn1_pinctrl_parse_functions(struct device_node *np,
 		ipctl->ngroups++;
 	}
 
-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		func->groups[i] = child->name;
 		grp = &ipctl->groups[ipctl->ngroups];
 		grp->func = func->name;
 		ret = rzn1_pinctrl_parse_groups(child, grp, ipctl);
-		if (ret < 0) {
-			of_node_put(child);
+		if (ret < 0)
 			return ret;
-		}
 		i++;
 		ipctl->ngroups++;
 	}
@@ -816,7 +810,6 @@ static int rzn1_pinctrl_probe_dt(struct platform_device *pdev,
 				 struct rzn1_pinctrl *ipctl)
 {
 	struct device_node *np = pdev->dev.of_node;
-	struct device_node *child;
 	unsigned int maxgroups = 0;
 	unsigned int i = 0;
 	int nfuncs = 0;
@@ -834,7 +827,7 @@ static int rzn1_pinctrl_probe_dt(struct platform_device *pdev,
 		return -ENOMEM;
 
 	ipctl->ngroups = 0;
-	for_each_child_of_node(np, child)
+	for_each_child_of_node_scoped(np, child)
 		maxgroups += rzn1_pinctrl_count_function_groups(child);
 
 	ipctl->groups = devm_kmalloc_array(&pdev->dev,
@@ -844,12 +837,10 @@ static int rzn1_pinctrl_probe_dt(struct platform_device *pdev,
 	if (!ipctl->groups)
 		return -ENOMEM;
 
-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		ret = rzn1_pinctrl_parse_functions(child, ipctl, i++);
-		if (ret < 0) {
-			of_node_put(child);
+		if (ret < 0)
 			return ret;
-		}
 	}
 
 	return 0;
diff --git a/drivers/pinctrl/renesas/pinctrl-rzv2m.c b/drivers/pinctrl/renesas/pinctrl-rzv2m.c
index 0767a5ac23e0..0cae5472ac67 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzv2m.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzv2m.c
@@ -388,7 +388,6 @@ static int rzv2m_dt_node_to_map(struct pinctrl_dev *pctldev,
 				unsigned int *num_maps)
 {
 	struct rzv2m_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
-	struct device_node *child;
 	unsigned int index;
 	int ret;
 
@@ -396,13 +395,11 @@ static int rzv2m_dt_node_to_map(struct pinctrl_dev *pctldev,
 	*num_maps = 0;
 	index = 0;
 
-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		ret = rzv2m_dt_subnode_to_map(pctldev, child, np, map,
 					      num_maps, &index);
-		if (ret < 0) {
-			of_node_put(child);
+		if (ret < 0)
 			goto done;
-		}
 	}
 
 	if (*num_maps == 0) {
diff --git a/drivers/pinctrl/renesas/pinctrl.c b/drivers/pinctrl/renesas/pinctrl.c
index 4d9d58fc1356..03e9bdbc82b9 100644
--- a/drivers/pinctrl/renesas/pinctrl.c
+++ b/drivers/pinctrl/renesas/pinctrl.c
@@ -241,7 +241,6 @@ static int sh_pfc_dt_node_to_map(struct pinctrl_dev *pctldev,
 {
 	struct sh_pfc_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
 	struct device *dev = pmx->pfc->dev;
-	struct device_node *child;
 	unsigned int index;
 	int ret;
 
@@ -249,13 +248,11 @@ static int sh_pfc_dt_node_to_map(struct pinctrl_dev *pctldev,
 	*num_maps = 0;
 	index = 0;
 
-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		ret = sh_pfc_dt_subnode_to_map(pctldev, child, map, num_maps,
 					       &index);
-		if (ret < 0) {
-			of_node_put(child);
+		if (ret < 0)
 			goto done;
-		}
 	}
 
 	/* If no mapping has been found in child nodes try the config node. */

-- 
2.37.1

