From: Peng Fan (OSS) <peng.fan@oss.nxp.com>
Date: Wed, 01 May 2024 12:52:13 -0000
Subject: [PATCH 14/21] pinctrl: at91: Use scope based of_node_put()
 cleanups
In-Reply-To: <20240501-pinctrl-cleanup-v1-0-797ceca46e5c@nxp.com>
References: <20240501-pinctrl-cleanup-v1-0-797ceca46e5c@nxp.com>
Message-ID: <20240501-pinctrl-cleanup-v1-14-797ceca46e5c@nxp.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Peng Fan <peng.fan@nxp.com>

Use scope based of_node_put() cleanup to simplify code.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/pinctrl-at91-pio4.c |  7 ++-----
 drivers/pinctrl/pinctrl-at91.c      | 17 +++++------------
 2 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-at91-pio4.c b/drivers/pinctrl/pinctrl-at91-pio4.c
index a27c01fcbb47..8b01d312305a 100644
--- a/drivers/pinctrl/pinctrl-at91-pio4.c
+++ b/drivers/pinctrl/pinctrl-at91-pio4.c
@@ -632,7 +632,6 @@ static int atmel_pctl_dt_node_to_map(struct pinctrl_dev *pctldev,
 				     struct pinctrl_map **map,
 				     unsigned int *num_maps)
 {
-	struct device_node *np;
 	unsigned int reserved_maps;
 	int ret;
 
@@ -648,13 +647,11 @@ static int atmel_pctl_dt_node_to_map(struct pinctrl_dev *pctldev,
 	ret = atmel_pctl_dt_subnode_to_map(pctldev, np_config, map,
 					   &reserved_maps, num_maps);
 	if (ret) {
-		for_each_child_of_node(np_config, np) {
+		for_each_child_of_node_scoped(np_config, np) {
 			ret = atmel_pctl_dt_subnode_to_map(pctldev, np, map,
 						    &reserved_maps, num_maps);
-			if (ret < 0) {
-				of_node_put(np);
+			if (ret < 0)
 				break;
-			}
 		}
 	}
 
diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index 5aa9d5c533c6..cc32db0797e6 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -292,7 +292,7 @@ static int at91_dt_node_to_map(struct pinctrl_dev *pctldev,
 	struct at91_pinctrl *info = pinctrl_dev_get_drvdata(pctldev);
 	const struct at91_pin_group *grp;
 	struct pinctrl_map *new_map;
-	struct device_node *parent;
+	struct device_node *parent __free(device_node) = NULL;
 	int map_num = 1;
 	int i;
 
@@ -325,7 +325,6 @@ static int at91_dt_node_to_map(struct pinctrl_dev *pctldev,
 	new_map[0].type = PIN_MAP_TYPE_MUX_GROUP;
 	new_map[0].data.mux.function = parent->name;
 	new_map[0].data.mux.group = np->name;
-	of_node_put(parent);
 
 	/* create config map */
 	new_map++;
@@ -1244,7 +1243,6 @@ static int at91_pinctrl_parse_groups(struct device_node *np,
 static int at91_pinctrl_parse_functions(struct device_node *np,
 					struct at91_pinctrl *info, u32 index)
 {
-	struct device_node *child;
 	struct at91_pmx_func *func;
 	struct at91_pin_group *grp;
 	int ret;
@@ -1267,14 +1265,12 @@ static int at91_pinctrl_parse_functions(struct device_node *np,
 	if (!func->groups)
 		return -ENOMEM;
 
-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		func->groups[i] = child->name;
 		grp = &info->groups[grp_index++];
 		ret = at91_pinctrl_parse_groups(child, grp, info, i++);
-		if (ret) {
-			of_node_put(child);
+		if (ret)
 			return ret;
-		}
 	}
 
 	return 0;
@@ -1296,7 +1292,6 @@ static int at91_pinctrl_probe_dt(struct platform_device *pdev,
 	int i, j, ngpio_chips_enabled = 0;
 	uint32_t *tmp;
 	struct device_node *np = dev->of_node;
-	struct device_node *child;
 
 	if (!np)
 		return -ENODEV;
@@ -1349,14 +1344,12 @@ static int at91_pinctrl_probe_dt(struct platform_device *pdev,
 
 	i = 0;
 
-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		if (of_device_is_compatible(child, gpio_compat))
 			continue;
 		ret = at91_pinctrl_parse_functions(child, info, i++);
-		if (ret) {
-			of_node_put(child);
+		if (ret)
 			return dev_err_probe(dev, ret, "failed to parse function\n");
-		}
 	}
 
 	return 0;

-- 
2.37.1

