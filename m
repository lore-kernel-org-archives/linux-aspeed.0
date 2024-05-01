From: Peng Fan (OSS) <peng.fan@oss.nxp.com>
Date: Wed, 01 May 2024 12:51:08 -0000
Subject: [PATCH 10/21] pinctrl: st: Use scope based of_node_put() cleanups
In-Reply-To: <20240501-pinctrl-cleanup-v1-0-797ceca46e5c@nxp.com>
References: <20240501-pinctrl-cleanup-v1-0-797ceca46e5c@nxp.com>
Message-ID: <20240501-pinctrl-cleanup-v1-10-797ceca46e5c@nxp.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Peng Fan <peng.fan@nxp.com>

Use scope based of_node_put() cleanup to simplify code.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/pinctrl-st.c | 40 ++++++++++++----------------------------
 1 file changed, 12 insertions(+), 28 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
index 5d9abd6547d0..2d77160f3654 100644
--- a/drivers/pinctrl/pinctrl-st.c
+++ b/drivers/pinctrl/pinctrl-st.c
@@ -812,7 +812,7 @@ static int st_pctl_dt_node_to_map(struct pinctrl_dev *pctldev,
 	const struct st_pctl_group *grp;
 	struct device *dev = info->dev;
 	struct pinctrl_map *new_map;
-	struct device_node *parent;
+	struct device_node *parent __free(device_node) = NULL;
 	int map_num, i;
 
 	grp = st_pctl_find_group_by_name(info, np->name);
@@ -837,7 +837,6 @@ static int st_pctl_dt_node_to_map(struct pinctrl_dev *pctldev,
 	new_map[0].type = PIN_MAP_TYPE_MUX_GROUP;
 	new_map[0].data.mux.function = parent->name;
 	new_map[0].data.mux.group = np->name;
-	of_node_put(parent);
 
 	/* create config map per pin */
 	new_map++;
@@ -1161,7 +1160,7 @@ static void st_parse_syscfgs(struct st_pinctrl *info, int bank,
 static int st_pctl_dt_calculate_pin(struct st_pinctrl *info,
 				    phandle bank, unsigned int offset)
 {
-	struct device_node *np;
+	struct device_node *np __free(device_node) = NULL;
 	struct gpio_chip *chip;
 	int retval = -EINVAL;
 	int i;
@@ -1179,7 +1178,6 @@ static int st_pctl_dt_calculate_pin(struct st_pinctrl *info,
 		}
 	}
 
-	of_node_put(np);
 	return retval;
 }
 
@@ -1195,10 +1193,10 @@ static int st_pctl_dt_parse_groups(struct device_node *np,
 	struct property *pp;
 	struct device *dev = info->dev;
 	struct st_pinconf *conf;
-	struct device_node *pins;
+	struct device_node *pins __free(device_node) = NULL;
 	phandle bank;
 	unsigned int offset;
-	int i = 0, npins = 0, nr_props, ret = 0;
+	int i = 0, npins = 0, nr_props;
 
 	pins = of_get_child_by_name(np, "st,pins");
 	if (!pins)
@@ -1213,8 +1211,7 @@ static int st_pctl_dt_parse_groups(struct device_node *np,
 			npins++;
 		} else {
 			pr_warn("Invalid st,pins in %pOFn node\n", np);
-			ret = -EINVAL;
-			goto out_put_node;
+			return -EINVAL;
 		}
 	}
 
@@ -1224,8 +1221,7 @@ static int st_pctl_dt_parse_groups(struct device_node *np,
 	grp->pin_conf = devm_kcalloc(dev, npins, sizeof(*grp->pin_conf), GFP_KERNEL);
 
 	if (!grp->pins || !grp->pin_conf) {
-		ret = -ENOMEM;
-		goto out_put_node;
+		return -ENOMEM;
 	}
 
 	/* <bank offset mux direction rt_type rt_delay rt_clk> */
@@ -1260,17 +1256,13 @@ static int st_pctl_dt_parse_groups(struct device_node *np,
 		i++;
 	}
 
-out_put_node:
-	of_node_put(pins);
-
-	return ret;
+	return 0;
 }
 
 static int st_pctl_parse_functions(struct device_node *np,
 			struct st_pinctrl *info, u32 index, int *grp_index)
 {
 	struct device *dev = info->dev;
-	struct device_node *child;
 	struct st_pmx_func *func;
 	struct st_pctl_group *grp;
 	int ret, i;
@@ -1285,15 +1277,13 @@ static int st_pctl_parse_functions(struct device_node *np,
 		return -ENOMEM;
 
 	i = 0;
-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		func->groups[i] = child->name;
 		grp = &info->groups[*grp_index];
 		*grp_index += 1;
 		ret = st_pctl_dt_parse_groups(child, grp, info, i++);
-		if (ret) {
-			of_node_put(child);
+		if (ret)
 			return ret;
-		}
 	}
 	dev_info(dev, "Function[%d\t name:%s,\tgroups:%d]\n", index, func->name, func->ngroups);
 
@@ -1601,7 +1591,6 @@ static int st_pctl_probe_dt(struct platform_device *pdev,
 	int i = 0, j = 0, k = 0, bank;
 	struct pinctrl_pin_desc *pdesc;
 	struct device_node *np = dev->of_node;
-	struct device_node *child;
 	int grp_index = 0;
 	int irq = 0;
 
@@ -1646,25 +1635,21 @@ static int st_pctl_probe_dt(struct platform_device *pdev,
 	pctl_desc->pins = pdesc;
 
 	bank = 0;
-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		if (of_property_read_bool(child, "gpio-controller")) {
 			const char *bank_name = NULL;
 			char **pin_names;
 
 			ret = st_gpiolib_register_bank(info, bank, child);
-			if (ret) {
-				of_node_put(child);
+			if (ret)
 				return ret;
-			}
 
 			k = info->banks[bank].range.pin_base;
 			bank_name = info->banks[bank].range.name;
 
 			pin_names = devm_kasprintf_strarray(dev, bank_name, ST_GPIO_PINS_PER_BANK);
-			if (IS_ERR(pin_names)) {
-				of_node_put(child);
+			if (IS_ERR(pin_names))
 				return PTR_ERR(pin_names);
-			}
 
 			for (j = 0; j < ST_GPIO_PINS_PER_BANK; j++, k++) {
 				pdesc->number = k;
@@ -1678,7 +1663,6 @@ static int st_pctl_probe_dt(struct platform_device *pdev,
 							i++, &grp_index);
 			if (ret) {
 				dev_err(dev, "No functions found.\n");
-				of_node_put(child);
 				return ret;
 			}
 		}

-- 
2.37.1

