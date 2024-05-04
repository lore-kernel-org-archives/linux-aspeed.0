From: Peng Fan (OSS) <peng.fan@oss.nxp.com>
Date: Sat, 04 May 2024 13:13:46 -0000
Subject: [PATCH v2 04/20] pinctrl: starfive: Use scope based of_node_put()
 cleanups
In-Reply-To: <20240504-pinctrl-cleanup-v2-0-26c5f2dc1181@nxp.com>
References: <20240504-pinctrl-cleanup-v2-0-26c5f2dc1181@nxp.com>
Message-ID: <20240504-pinctrl-cleanup-v2-4-26c5f2dc1181@nxp.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Peng Fan <peng.fan@nxp.com>

Use scope based of_node_put() cleanup to simplify code.

Acked-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c | 27 +++++++++-------------
 drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c | 18 +++++++--------
 2 files changed, 19 insertions(+), 26 deletions(-)

diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c b/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c
index 6df7a310c7ed..27f99183d994 100644
--- a/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c
@@ -480,7 +480,6 @@ static int starfive_dt_node_to_map(struct pinctrl_dev *pctldev,
 {
 	struct starfive_pinctrl *sfp = pinctrl_dev_get_drvdata(pctldev);
 	struct device *dev = sfp->gc.parent;
-	struct device_node *child;
 	struct pinctrl_map *map;
 	const char **pgnames;
 	const char *grpname;
@@ -492,20 +491,18 @@ static int starfive_dt_node_to_map(struct pinctrl_dev *pctldev,
 
 	nmaps = 0;
 	ngroups = 0;
-	for_each_available_child_of_node(np, child) {
+	for_each_available_child_of_node_scoped(np, child) {
 		int npinmux = of_property_count_u32_elems(child, "pinmux");
 		int npins   = of_property_count_u32_elems(child, "pins");
 
 		if (npinmux > 0 && npins > 0) {
 			dev_err(dev, "invalid pinctrl group %pOFn.%pOFn: both pinmux and pins set\n",
 				np, child);
-			of_node_put(child);
 			return -EINVAL;
 		}
 		if (npinmux == 0 && npins == 0) {
 			dev_err(dev, "invalid pinctrl group %pOFn.%pOFn: neither pinmux nor pins set\n",
 				np, child);
-			of_node_put(child);
 			return -EINVAL;
 		}
 
@@ -527,14 +524,14 @@ static int starfive_dt_node_to_map(struct pinctrl_dev *pctldev,
 	nmaps = 0;
 	ngroups = 0;
 	mutex_lock(&sfp->mutex);
-	for_each_available_child_of_node(np, child) {
+	for_each_available_child_of_node_scoped(np, child) {
 		int npins;
 		int i;
 
 		grpname = devm_kasprintf(dev, GFP_KERNEL, "%pOFn.%pOFn", np, child);
 		if (!grpname) {
 			ret = -ENOMEM;
-			goto put_child;
+			goto free_map;
 		}
 
 		pgnames[ngroups++] = grpname;
@@ -543,18 +540,18 @@ static int starfive_dt_node_to_map(struct pinctrl_dev *pctldev,
 			pins = devm_kcalloc(dev, npins, sizeof(*pins), GFP_KERNEL);
 			if (!pins) {
 				ret = -ENOMEM;
-				goto put_child;
+				goto free_map;
 			}
 
 			pinmux = devm_kcalloc(dev, npins, sizeof(*pinmux), GFP_KERNEL);
 			if (!pinmux) {
 				ret = -ENOMEM;
-				goto put_child;
+				goto free_map;
 			}
 
 			ret = of_property_read_u32_array(child, "pinmux", pinmux, npins);
 			if (ret)
-				goto put_child;
+				goto free_map;
 
 			for (i = 0; i < npins; i++) {
 				unsigned int gpio = starfive_pinmux_to_gpio(pinmux[i]);
@@ -570,7 +567,7 @@ static int starfive_dt_node_to_map(struct pinctrl_dev *pctldev,
 			pins = devm_kcalloc(dev, npins, sizeof(*pins), GFP_KERNEL);
 			if (!pins) {
 				ret = -ENOMEM;
-				goto put_child;
+				goto free_map;
 			}
 
 			pinmux = NULL;
@@ -580,18 +577,18 @@ static int starfive_dt_node_to_map(struct pinctrl_dev *pctldev,
 
 				ret = of_property_read_u32_index(child, "pins", i, &v);
 				if (ret)
-					goto put_child;
+					goto free_map;
 				pins[i] = v;
 			}
 		} else {
 			ret = -EINVAL;
-			goto put_child;
+			goto free_map;
 		}
 
 		ret = pinctrl_generic_add_group(pctldev, grpname, pins, npins, pinmux);
 		if (ret < 0) {
 			dev_err(dev, "error adding group %s: %d\n", grpname, ret);
-			goto put_child;
+			goto free_map;
 		}
 
 		ret = pinconf_generic_parse_dt_config(child, pctldev,
@@ -600,7 +597,7 @@ static int starfive_dt_node_to_map(struct pinctrl_dev *pctldev,
 		if (ret) {
 			dev_err(dev, "error parsing pin config of group %s: %d\n",
 				grpname, ret);
-			goto put_child;
+			goto free_map;
 		}
 
 		/* don't create a map if there are no pinconf settings */
@@ -623,8 +620,6 @@ static int starfive_dt_node_to_map(struct pinctrl_dev *pctldev,
 	mutex_unlock(&sfp->mutex);
 	return 0;
 
-put_child:
-	of_node_put(child);
 free_map:
 	pinctrl_utils_free_map(pctldev, map, nmaps);
 	mutex_unlock(&sfp->mutex);
diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
index 9609eb1ecc3d..4ce080caa233 100644
--- a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
@@ -150,7 +150,7 @@ static int jh7110_dt_node_to_map(struct pinctrl_dev *pctldev,
 	nmaps = 0;
 	ngroups = 0;
 	mutex_lock(&sfp->mutex);
-	for_each_available_child_of_node(np, child) {
+	for_each_available_child_of_node_scoped(np, child) {
 		int npins = of_property_count_u32_elems(child, "pinmux");
 		int *pins;
 		u32 *pinmux;
@@ -161,13 +161,13 @@ static int jh7110_dt_node_to_map(struct pinctrl_dev *pctldev,
 				"invalid pinctrl group %pOFn.%pOFn: pinmux not set\n",
 				np, child);
 			ret = -EINVAL;
-			goto put_child;
+			goto free_map;
 		}
 
 		grpname = devm_kasprintf(dev, GFP_KERNEL, "%pOFn.%pOFn", np, child);
 		if (!grpname) {
 			ret = -ENOMEM;
-			goto put_child;
+			goto free_map;
 		}
 
 		pgnames[ngroups++] = grpname;
@@ -175,18 +175,18 @@ static int jh7110_dt_node_to_map(struct pinctrl_dev *pctldev,
 		pins = devm_kcalloc(dev, npins, sizeof(*pins), GFP_KERNEL);
 		if (!pins) {
 			ret = -ENOMEM;
-			goto put_child;
+			goto free_map;
 		}
 
 		pinmux = devm_kcalloc(dev, npins, sizeof(*pinmux), GFP_KERNEL);
 		if (!pinmux) {
 			ret = -ENOMEM;
-			goto put_child;
+			goto free_map;
 		}
 
 		ret = of_property_read_u32_array(child, "pinmux", pinmux, npins);
 		if (ret)
-			goto put_child;
+			goto free_map;
 
 		for (i = 0; i < npins; i++)
 			pins[i] = jh7110_pinmux_pin(pinmux[i]);
@@ -200,7 +200,7 @@ static int jh7110_dt_node_to_map(struct pinctrl_dev *pctldev,
 						pins, npins, pinmux);
 		if (ret < 0) {
 			dev_err(dev, "error adding group %s: %d\n", grpname, ret);
-			goto put_child;
+			goto free_map;
 		}
 
 		ret = pinconf_generic_parse_dt_config(child, pctldev,
@@ -209,7 +209,7 @@ static int jh7110_dt_node_to_map(struct pinctrl_dev *pctldev,
 		if (ret) {
 			dev_err(dev, "error parsing pin config of group %s: %d\n",
 				grpname, ret);
-			goto put_child;
+			goto free_map;
 		}
 
 		/* don't create a map if there are no pinconf settings */
@@ -233,8 +233,6 @@ static int jh7110_dt_node_to_map(struct pinctrl_dev *pctldev,
 	*num_maps = nmaps;
 	return 0;
 
-put_child:
-	of_node_put(child);
 free_map:
 	pinctrl_utils_free_map(pctldev, map, nmaps);
 	mutex_unlock(&sfp->mutex);

-- 
2.37.1

