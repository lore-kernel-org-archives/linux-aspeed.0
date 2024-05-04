From: Peng Fan (OSS) <peng.fan@oss.nxp.com>
Date: Sat, 04 May 2024 13:14:20 -0000
Subject: [PATCH v2 06/20] pinctrl: spear: Use scope based of_node_put()
 cleanups
In-Reply-To: <20240504-pinctrl-cleanup-v2-0-26c5f2dc1181@nxp.com>
References: <20240504-pinctrl-cleanup-v2-0-26c5f2dc1181@nxp.com>
Message-ID: <20240504-pinctrl-cleanup-v2-6-26c5f2dc1181@nxp.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Peng Fan <peng.fan@nxp.com>

Use scope based of_node_put() cleanup to simplify code.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/spear/pinctrl-spear.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/pinctrl/spear/pinctrl-spear.c b/drivers/pinctrl/spear/pinctrl-spear.c
index b8caaa5a2d4e..a8c5fe973cd4 100644
--- a/drivers/pinctrl/spear/pinctrl-spear.c
+++ b/drivers/pinctrl/spear/pinctrl-spear.c
@@ -151,24 +151,19 @@ static int spear_pinctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
 					unsigned *num_maps)
 {
 	struct spear_pmx *pmx = pinctrl_dev_get_drvdata(pctldev);
-	struct device_node *np;
 	struct property *prop;
 	const char *function, *group;
 	int ret, index = 0, count = 0;
 
 	/* calculate number of maps required */
-	for_each_child_of_node(np_config, np) {
+	for_each_child_of_node_scoped(np_config, np) {
 		ret = of_property_read_string(np, "st,function", &function);
-		if (ret < 0) {
-			of_node_put(np);
+		if (ret < 0)
 			return ret;
-		}
 
 		ret = of_property_count_strings(np, "st,pins");
-		if (ret < 0) {
-			of_node_put(np);
+		if (ret < 0)
 			return ret;
-		}
 
 		count += ret;
 	}
@@ -182,7 +177,7 @@ static int spear_pinctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
 	if (!*map)
 		return -ENOMEM;
 
-	for_each_child_of_node(np_config, np) {
+	for_each_child_of_node_scoped(np_config, np) {
 		of_property_read_string(np, "st,function", &function);
 		of_property_for_each_string(np, "st,pins", prop, group) {
 			(*map)[index].type = PIN_MAP_TYPE_MUX_GROUP;

-- 
2.37.1

