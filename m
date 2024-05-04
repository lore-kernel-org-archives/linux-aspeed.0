From: Peng Fan (OSS) <peng.fan@oss.nxp.com>
Date: Sat, 04 May 2024 13:13:11 -0000
Subject: [PATCH v2 02/20] pinctrl: tegra: Use scope based of_node_put()
 cleanups
In-Reply-To: <20240504-pinctrl-cleanup-v2-0-26c5f2dc1181@nxp.com>
References: <20240504-pinctrl-cleanup-v2-0-26c5f2dc1181@nxp.com>
Message-ID: <20240504-pinctrl-cleanup-v2-2-26c5f2dc1181@nxp.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Peng Fan <peng.fan@nxp.com>

Use scope based of_node_put() cleanup to simplify code.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/tegra/pinctrl-tegra-xusb.c | 7 ++-----
 drivers/pinctrl/tegra/pinctrl-tegra.c      | 4 +---
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/tegra/pinctrl-tegra-xusb.c b/drivers/pinctrl/tegra/pinctrl-tegra-xusb.c
index 96ef57a7d385..49c5edeba87f 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra-xusb.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra-xusb.c
@@ -238,20 +238,17 @@ static int tegra_xusb_padctl_dt_node_to_map(struct pinctrl_dev *pinctrl,
 {
 	struct tegra_xusb_padctl *padctl = pinctrl_dev_get_drvdata(pinctrl);
 	unsigned int reserved_maps = 0;
-	struct device_node *np;
 	int err;
 
 	*num_maps = 0;
 	*maps = NULL;
 
-	for_each_child_of_node(parent, np) {
+	for_each_child_of_node_scoped(parent, np) {
 		err = tegra_xusb_padctl_parse_subnode(padctl, np, maps,
 						      &reserved_maps,
 						      num_maps);
-		if (err < 0) {
-			of_node_put(np);
+		if (err < 0)
 			return err;
-		}
 	}
 
 	return 0;
diff --git a/drivers/pinctrl/tegra/pinctrl-tegra.c b/drivers/pinctrl/tegra/pinctrl-tegra.c
index ccfa3870a67d..c83e5a65e680 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra.c
@@ -188,20 +188,18 @@ static int tegra_pinctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
 					unsigned *num_maps)
 {
 	unsigned reserved_maps;
-	struct device_node *np;
 	int ret;
 
 	reserved_maps = 0;
 	*map = NULL;
 	*num_maps = 0;
 
-	for_each_child_of_node(np_config, np) {
+	for_each_child_of_node_scoped(np_config, np) {
 		ret = tegra_pinctrl_dt_subnode_to_map(pctldev, np, map,
 						      &reserved_maps, num_maps);
 		if (ret < 0) {
 			pinctrl_utils_free_map(pctldev, *map,
 				*num_maps);
-			of_node_put(np);
 			return ret;
 		}
 	}

-- 
2.37.1

