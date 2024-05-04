From: Peng Fan (OSS) <peng.fan@oss.nxp.com>
Date: Sat, 04 May 2024 13:17:08 -0000
Subject: [PATCH v2 17/20] pinctrl: pinconf-generic: Use scope based
 of_node_put() cleanups
In-Reply-To: <20240504-pinctrl-cleanup-v2-0-26c5f2dc1181@nxp.com>
References: <20240504-pinctrl-cleanup-v2-0-26c5f2dc1181@nxp.com>
Message-ID: <20240504-pinctrl-cleanup-v2-17-26c5f2dc1181@nxp.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Peng Fan <peng.fan@nxp.com>

Use scope based of_node_put() cleanup to simplify code.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/pinconf-generic.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/pinconf-generic.c b/drivers/pinctrl/pinconf-generic.c
index 80de389199bd..a499b8af5c1f 100644
--- a/drivers/pinctrl/pinconf-generic.c
+++ b/drivers/pinctrl/pinconf-generic.c
@@ -382,7 +382,6 @@ int pinconf_generic_dt_node_to_map(struct pinctrl_dev *pctldev,
 		unsigned int *num_maps, enum pinctrl_map_type type)
 {
 	unsigned int reserved_maps;
-	struct device_node *np;
 	int ret;
 
 	reserved_maps = 0;
@@ -394,13 +393,11 @@ int pinconf_generic_dt_node_to_map(struct pinctrl_dev *pctldev,
 	if (ret < 0)
 		goto exit;
 
-	for_each_available_child_of_node(np_config, np) {
+	for_each_available_child_of_node_scoped(np_config, np) {
 		ret = pinconf_generic_dt_subnode_to_map(pctldev, np, map,
 					&reserved_maps, num_maps, type);
-		if (ret < 0) {
-			of_node_put(np);
+		if (ret < 0)
 			goto exit;
-		}
 	}
 	return 0;
 

-- 
2.37.1

