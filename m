From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 23 Jul 2021 17:28:54 +0930
Subject: [RFC PATCH 2/6] pinctrl: Add hook for device-specific map parsing
In-Reply-To: <20210723075858.376378-1-andrew@aj.id.au>
References: <20210723075858.376378-1-andrew@aj.id.au>
Message-ID: <20210723075858.376378-3-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The devicetree binding for the PCA955x LED/GPIO expanders was not
written with pinctrl in mind. To maintain compatibility with existing
devicetrees while implementing pinctrl support for the PCA955x devices,
add the ability to parse a custom device node layout to pinctrl.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/pinctrl/core.c          | 6 +++++-
 include/linux/pinctrl/pinctrl.h | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 9c788f0e2844..e4862552eb9b 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -1063,7 +1063,11 @@ static struct pinctrl *create_pinctrl(struct device *dev,
 	INIT_LIST_HEAD(&p->states);
 	INIT_LIST_HEAD(&p->dt_maps);
 
-	ret = pinctrl_dt_to_map(p, pctldev);
+	if (pctldev && pctldev->desc->pctlops->dt_dev_to_map) {
+		ret = pctldev->desc->pctlops->dt_dev_to_map(pctldev, dev);
+	} else {
+		ret = pinctrl_dt_to_map(p, pctldev);
+	}
 	if (ret < 0) {
 		kfree(p);
 		return ERR_PTR(ret);
diff --git a/include/linux/pinctrl/pinctrl.h b/include/linux/pinctrl/pinctrl.h
index 1ceebc499cc4..2eeec0af61fe 100644
--- a/include/linux/pinctrl/pinctrl.h
+++ b/include/linux/pinctrl/pinctrl.h
@@ -95,6 +95,7 @@ struct pinctrl_ops {
 			       unsigned *num_pins);
 	void (*pin_dbg_show) (struct pinctrl_dev *pctldev, struct seq_file *s,
 			  unsigned offset);
+	int (*dt_dev_to_map) (struct pinctrl_dev *pctldev, struct device *dev);
 	int (*dt_node_to_map) (struct pinctrl_dev *pctldev,
 			       struct device_node *np_config,
 			       struct pinctrl_map **map, unsigned *num_maps);
-- 
2.30.2

