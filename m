From: Peng Fan (OSS) <peng.fan@oss.nxp.com>
Date: Sat, 04 May 2024 13:16:16 -0000
Subject: [PATCH v2 14/20] pinctrl: mediatek: Use scope based of_node_put()
 cleanups
In-Reply-To: <20240504-pinctrl-cleanup-v2-0-26c5f2dc1181@nxp.com>
References: <20240504-pinctrl-cleanup-v2-0-26c5f2dc1181@nxp.com>
Message-ID: <20240504-pinctrl-cleanup-v2-14-26c5f2dc1181@nxp.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Peng Fan <peng.fan@nxp.com>

Use scope based of_node_put() cleanup to simplify code.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 4 +---
 drivers/pinctrl/mediatek/pinctrl-paris.c      | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index d39afc122516..91edb539925a 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -621,7 +621,6 @@ static int mtk_pctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
 				 struct device_node *np_config,
 				 struct pinctrl_map **map, unsigned *num_maps)
 {
-	struct device_node *np;
 	unsigned reserved_maps;
 	int ret;
 
@@ -629,12 +628,11 @@ static int mtk_pctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
 	*num_maps = 0;
 	reserved_maps = 0;
 
-	for_each_child_of_node(np_config, np) {
+	for_each_child_of_node_scoped(np_config, np) {
 		ret = mtk_pctrl_dt_subnode_to_map(pctldev, np, map,
 				&reserved_maps, num_maps);
 		if (ret < 0) {
 			pinctrl_utils_free_map(pctldev, *map, *num_maps);
-			of_node_put(np);
 			return ret;
 		}
 	}
diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
index b19bc391705e..e12316c42698 100644
--- a/drivers/pinctrl/mediatek/pinctrl-paris.c
+++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
@@ -536,7 +536,6 @@ static int mtk_pctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
 				    struct pinctrl_map **map,
 				    unsigned *num_maps)
 {
-	struct device_node *np;
 	unsigned reserved_maps;
 	int ret;
 
@@ -544,13 +543,12 @@ static int mtk_pctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
 	*num_maps = 0;
 	reserved_maps = 0;
 
-	for_each_child_of_node(np_config, np) {
+	for_each_child_of_node_scoped(np_config, np) {
 		ret = mtk_pctrl_dt_subnode_to_map(pctldev, np, map,
 						  &reserved_maps,
 						  num_maps);
 		if (ret < 0) {
 			pinctrl_utils_free_map(pctldev, *map, *num_maps);
-			of_node_put(np);
 			return ret;
 		}
 	}

-- 
2.37.1

