From: Peng Fan (OSS) <peng.fan@oss.nxp.com>
Date: Sat, 04 May 2024 13:18:13 -0000
Subject: [PATCH v2 20/20] pinctrl: samsung: Use scope based of_node_put()
 cleanups
In-Reply-To: <20240504-pinctrl-cleanup-v2-0-26c5f2dc1181@nxp.com>
References: <20240504-pinctrl-cleanup-v2-0-26c5f2dc1181@nxp.com>
Message-ID: <20240504-pinctrl-cleanup-v2-20-26c5f2dc1181@nxp.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Peng Fan <peng.fan@nxp.com>

Use scope based of_node_put() cleanup to simplify code.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/samsung/pinctrl-exynos.c  | 16 ++++------------
 drivers/pinctrl/samsung/pinctrl-samsung.c | 19 +++++--------------
 2 files changed, 9 insertions(+), 26 deletions(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
index 871c1eb46ddf..3775999536e2 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
@@ -582,7 +582,7 @@ static void exynos_irq_demux_eint16_31(struct irq_desc *desc)
 __init int exynos_eint_wkup_init(struct samsung_pinctrl_drv_data *d)
 {
 	struct device *dev = d->dev;
-	struct device_node *wkup_np = NULL;
+	struct device_node *wkup_np __free(device_node) = NULL;
 	struct device_node *np;
 	struct samsung_pin_bank *bank;
 	struct exynos_weint_data *weint_data;
@@ -612,17 +612,14 @@ __init int exynos_eint_wkup_init(struct samsung_pinctrl_drv_data *d)
 
 		bank->irq_chip = devm_kmemdup(dev, irq_chip, sizeof(*irq_chip),
 					      GFP_KERNEL);
-		if (!bank->irq_chip) {
-			of_node_put(wkup_np);
+		if (!bank->irq_chip)
 			return -ENOMEM;
-		}
 		bank->irq_chip->chip.name = bank->name;
 
 		bank->irq_domain = irq_domain_create_linear(bank->fwnode,
 				bank->nr_pins, &exynos_eint_irqd_ops, bank);
 		if (!bank->irq_domain) {
 			dev_err(dev, "wkup irq domain add failed\n");
-			of_node_put(wkup_np);
 			return -ENXIO;
 		}
 
@@ -635,10 +632,8 @@ __init int exynos_eint_wkup_init(struct samsung_pinctrl_drv_data *d)
 		weint_data = devm_kcalloc(dev,
 					  bank->nr_pins, sizeof(*weint_data),
 					  GFP_KERNEL);
-		if (!weint_data) {
-			of_node_put(wkup_np);
+		if (!weint_data)
 			return -ENOMEM;
-		}
 
 		for (idx = 0; idx < bank->nr_pins; ++idx) {
 			irq = irq_of_parse_and_map(to_of_node(bank->fwnode), idx);
@@ -655,13 +650,10 @@ __init int exynos_eint_wkup_init(struct samsung_pinctrl_drv_data *d)
 		}
 	}
 
-	if (!muxed_banks) {
-		of_node_put(wkup_np);
+	if (!muxed_banks)
 		return 0;
-	}
 
 	irq = irq_of_parse_and_map(wkup_np, 0);
-	of_node_put(wkup_np);
 	if (!irq) {
 		dev_err(dev, "irq number for muxed EINTs not found\n");
 		return 0;
diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
index ed07e23e0912..0d4d7ebf7145 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -250,7 +250,6 @@ static int samsung_dt_node_to_map(struct pinctrl_dev *pctldev,
 {
 	struct samsung_pinctrl_drv_data *drvdata;
 	unsigned reserved_maps;
-	struct device_node *np;
 	int ret;
 
 	drvdata = pinctrl_dev_get_drvdata(pctldev);
@@ -265,12 +264,11 @@ static int samsung_dt_node_to_map(struct pinctrl_dev *pctldev,
 							&reserved_maps,
 							num_maps);
 
-	for_each_child_of_node(np_config, np) {
+	for_each_child_of_node_scoped(np_config, np) {
 		ret = samsung_dt_subnode_to_map(drvdata, pctldev->dev, np, map,
 						&reserved_maps, num_maps);
 		if (ret < 0) {
 			samsung_dt_free_map(pctldev, *map, *num_maps);
-			of_node_put(np);
 			return ret;
 		}
 	}
@@ -791,16 +789,12 @@ static struct samsung_pmx_func *samsung_pinctrl_create_functions(
 	 * and create pin groups and pin function lists.
 	 */
 	func_cnt = 0;
-	for_each_child_of_node(dev_np, cfg_np) {
-		struct device_node *func_np;
-
+	for_each_child_of_node_scoped(dev_np, cfg_np) {
 		if (!of_get_child_count(cfg_np)) {
 			ret = samsung_pinctrl_create_function(dev, drvdata,
 							cfg_np, func);
-			if (ret < 0) {
-				of_node_put(cfg_np);
+			if (ret < 0)
 				return ERR_PTR(ret);
-			}
 			if (ret > 0) {
 				++func;
 				++func_cnt;
@@ -808,14 +802,11 @@ static struct samsung_pmx_func *samsung_pinctrl_create_functions(
 			continue;
 		}
 
-		for_each_child_of_node(cfg_np, func_np) {
+		for_each_child_of_node_scoped(cfg_np, func_np) {
 			ret = samsung_pinctrl_create_function(dev, drvdata,
 						func_np, func);
-			if (ret < 0) {
-				of_node_put(func_np);
-				of_node_put(cfg_np);
+			if (ret < 0)
 				return ERR_PTR(ret);
-			}
 			if (ret > 0) {
 				++func;
 				++func_cnt;

-- 
2.37.1

