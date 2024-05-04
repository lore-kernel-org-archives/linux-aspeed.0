From: Peng Fan (OSS) <peng.fan@oss.nxp.com>
Date: Sat, 04 May 2024 13:13:47 -0000
Subject: [PATCH v2 05/20] pinctrl: sprd: Use scope based of_node_put()
 cleanups
In-Reply-To: <20240504-pinctrl-cleanup-v2-0-26c5f2dc1181@nxp.com>
References: <20240504-pinctrl-cleanup-v2-0-26c5f2dc1181@nxp.com>
Message-ID: <20240504-pinctrl-cleanup-v2-5-26c5f2dc1181@nxp.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Peng Fan <peng.fan@nxp.com>

Use scope based of_node_put() cleanup to simplify code.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/sprd/pinctrl-sprd.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/sprd/pinctrl-sprd.c b/drivers/pinctrl/sprd/pinctrl-sprd.c
index d0b6d3e655a2..c4a1d99dfed0 100644
--- a/drivers/pinctrl/sprd/pinctrl-sprd.c
+++ b/drivers/pinctrl/sprd/pinctrl-sprd.c
@@ -934,7 +934,6 @@ static int sprd_pinctrl_parse_dt(struct sprd_pinctrl *sprd_pctl)
 {
 	struct sprd_pinctrl_soc_info *info = sprd_pctl->info;
 	struct device_node *np = sprd_pctl->dev->of_node;
-	struct device_node *child, *sub_child;
 	struct sprd_pin_group *grp;
 	const char **temp;
 	int ret;
@@ -962,25 +961,20 @@ static int sprd_pinctrl_parse_dt(struct sprd_pinctrl *sprd_pctl)
 	temp = info->grp_names;
 	grp = info->groups;
 
-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		ret = sprd_pinctrl_parse_groups(child, sprd_pctl, grp);
-		if (ret) {
-			of_node_put(child);
+		if (ret)
 			return ret;
-		}
 
 		*temp++ = grp->name;
 		grp++;
 
 		if (of_get_child_count(child) > 0) {
-			for_each_child_of_node(child, sub_child) {
+			for_each_child_of_node_scoped(child, sub_child) {
 				ret = sprd_pinctrl_parse_groups(sub_child,
 								sprd_pctl, grp);
-				if (ret) {
-					of_node_put(sub_child);
-					of_node_put(child);
+				if (ret)
 					return ret;
-				}
 
 				*temp++ = grp->name;
 				grp++;

-- 
2.37.1

