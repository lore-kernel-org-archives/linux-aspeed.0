From: Jinjie Ruan <ruanjinjie@huawei.com>
Date: Thu, 22 Aug 2024 14:29:50 +0800
Subject: [PATCH -next 2/8] hwmon: (aspeed-pwm-tacho): Simplify with scoped for each OF child loop
In-Reply-To: <20240822062956.3490387-1-ruanjinjie@huawei.com>
References: <20240822062956.3490387-1-ruanjinjie@huawei.com>
Message-ID: <20240822062956.3490387-3-ruanjinjie@huawei.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use scoped for_each_child_of_node_scoped() when iterating over device
nodes to make code a bit simpler.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/hwmon/aspeed-pwm-tacho.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/aspeed-pwm-tacho.c b/drivers/hwmon/aspeed-pwm-tacho.c
index 4acc1858d8ac..aa159bf158a3 100644
--- a/drivers/hwmon/aspeed-pwm-tacho.c
+++ b/drivers/hwmon/aspeed-pwm-tacho.c
@@ -907,7 +907,7 @@ static void aspeed_pwm_tacho_remove(void *data)
 static int aspeed_pwm_tacho_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *np, *child;
+	struct device_node *np;
 	struct aspeed_pwm_tacho_data *priv;
 	void __iomem *regs;
 	struct device *hwmon;
@@ -951,12 +951,10 @@ static int aspeed_pwm_tacho_probe(struct platform_device *pdev)
 
 	aspeed_create_type(priv);
 
-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		ret = aspeed_create_fan(dev, child, priv);
-		if (ret) {
-			of_node_put(child);
+		if (ret)
 			return ret;
-		}
 	}
 
 	priv->groups[0] = &pwm_dev_group;
-- 
2.34.1

