From: Peng Fan (OSS) <peng.fan@oss.nxp.com>
Date: Sat, 04 May 2024 13:17:41 -0000
Subject: [PATCH v2 19/20] pinctrl: k210: Use scope based of_node_put()
 cleanups
In-Reply-To: <20240504-pinctrl-cleanup-v2-0-26c5f2dc1181@nxp.com>
References: <20240504-pinctrl-cleanup-v2-0-26c5f2dc1181@nxp.com>
Message-ID: <20240504-pinctrl-cleanup-v2-19-26c5f2dc1181@nxp.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Peng Fan <peng.fan@nxp.com>

Use scope based of_node_put() cleanup to simplify code.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/pinctrl-k210.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-k210.c b/drivers/pinctrl/pinctrl-k210.c
index b6d1ed9ec9a3..2753e14c3e38 100644
--- a/drivers/pinctrl/pinctrl-k210.c
+++ b/drivers/pinctrl/pinctrl-k210.c
@@ -849,7 +849,6 @@ static int k210_pinctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
 				       unsigned int *num_maps)
 {
 	unsigned int reserved_maps;
-	struct device_node *np;
 	int ret;
 
 	reserved_maps = 0;
@@ -861,13 +860,11 @@ static int k210_pinctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
 	if (ret < 0)
 		goto err;
 
-	for_each_available_child_of_node(np_config, np) {
+	for_each_available_child_of_node_scoped(np_config, np) {
 		ret = k210_pinctrl_dt_subnode_to_map(pctldev, np, map,
 						     &reserved_maps, num_maps);
-		if (ret < 0) {
-			of_node_put(np);
+		if (ret < 0)
 			goto err;
-		}
 	}
 	return 0;
 

-- 
2.37.1

