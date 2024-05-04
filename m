From: Peng Fan (OSS) <peng.fan@oss.nxp.com>
Date: Sat, 04 May 2024 13:15:11 -0000
Subject: [PATCH v2 10/20] pinctrl: equilibrium: Use scope based
 of_node_put() cleanups
In-Reply-To: <20240504-pinctrl-cleanup-v2-0-26c5f2dc1181@nxp.com>
References: <20240504-pinctrl-cleanup-v2-0-26c5f2dc1181@nxp.com>
Message-ID: <20240504-pinctrl-cleanup-v2-10-26c5f2dc1181@nxp.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Peng Fan <peng.fan@nxp.com>

Use scope based of_node_put() cleanup to simplify code.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/pinctrl-equilibrium.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-equilibrium.c b/drivers/pinctrl/pinctrl-equilibrium.c
index 6e1be38865c3..e727257bb697 100644
--- a/drivers/pinctrl/pinctrl-equilibrium.c
+++ b/drivers/pinctrl/pinctrl-equilibrium.c
@@ -588,14 +588,13 @@ static int funcs_utils(struct device *dev, struct eqbr_pmx_func *funcs,
 		       unsigned int *nr_funcs, funcs_util_ops op)
 {
 	struct device_node *node = dev->of_node;
-	struct device_node *np;
 	struct property *prop;
 	const char *fn_name;
 	unsigned int fid;
 	int i, j;
 
 	i = 0;
-	for_each_child_of_node(node, np) {
+	for_each_child_of_node_scoped(node, np) {
 		prop = of_find_property(np, "groups", NULL);
 		if (!prop)
 			continue;
@@ -633,7 +632,6 @@ static int funcs_utils(struct device *dev, struct eqbr_pmx_func *funcs,
 			break;
 
 		default:
-			of_node_put(np);
 			return -EINVAL;
 		}
 		i++;
@@ -706,11 +704,10 @@ static int eqbr_build_groups(struct eqbr_pinctrl_drv_data *drvdata)
 	struct device_node *node = dev->of_node;
 	unsigned int *pins, *pinmux, pin_id, pinmux_id;
 	struct pingroup group, *grp = &group;
-	struct device_node *np;
 	struct property *prop;
 	int j, err;
 
-	for_each_child_of_node(node, np) {
+	for_each_child_of_node_scoped(node, np) {
 		prop = of_find_property(np, "groups", NULL);
 		if (!prop)
 			continue;
@@ -718,42 +715,35 @@ static int eqbr_build_groups(struct eqbr_pinctrl_drv_data *drvdata)
 		err = of_property_count_u32_elems(np, "pins");
 		if (err < 0) {
 			dev_err(dev, "No pins in the group: %s\n", prop->name);
-			of_node_put(np);
 			return err;
 		}
 		grp->npins = err;
 		grp->name = prop->value;
 		pins = devm_kcalloc(dev, grp->npins, sizeof(*pins), GFP_KERNEL);
-		if (!pins) {
-			of_node_put(np);
+		if (!pins)
 			return -ENOMEM;
-		}
+
 		grp->pins = pins;
 
 		pinmux = devm_kcalloc(dev, grp->npins, sizeof(*pinmux), GFP_KERNEL);
-		if (!pinmux) {
-			of_node_put(np);
+		if (!pinmux)
 			return -ENOMEM;
-		}
 
 		for (j = 0; j < grp->npins; j++) {
 			if (of_property_read_u32_index(np, "pins", j, &pin_id)) {
 				dev_err(dev, "Group %s: Read intel pins id failed\n",
 					grp->name);
-				of_node_put(np);
 				return -EINVAL;
 			}
 			if (pin_id >= drvdata->pctl_desc.npins) {
 				dev_err(dev, "Group %s: Invalid pin ID, idx: %d, pin %u\n",
 					grp->name, j, pin_id);
-				of_node_put(np);
 				return -EINVAL;
 			}
 			pins[j] = pin_id;
 			if (of_property_read_u32_index(np, "pinmux", j, &pinmux_id)) {
 				dev_err(dev, "Group %s: Read intel pinmux id failed\n",
 					grp->name);
-				of_node_put(np);
 				return -EINVAL;
 			}
 			pinmux[j] = pinmux_id;
@@ -764,7 +754,6 @@ static int eqbr_build_groups(struct eqbr_pinctrl_drv_data *drvdata)
 						pinmux);
 		if (err < 0) {
 			dev_err(dev, "Failed to register group %s\n", grp->name);
-			of_node_put(np);
 			return err;
 		}
 		memset(&group, 0, sizeof(group));

-- 
2.37.1

