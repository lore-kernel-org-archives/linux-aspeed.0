From: Jinjie Ruan <ruanjinjie@huawei.com>
Date: Thu, 22 Aug 2024 14:29:49 +0800
Subject: [PATCH -next 1/8] hwmon: (aspeed-g6-pwm-tacho): Simplify with scoped for each OF child loop
In-Reply-To: <20240822062956.3490387-1-ruanjinjie@huawei.com>
References: <20240822062956.3490387-1-ruanjinjie@huawei.com>
Message-ID: <20240822062956.3490387-2-ruanjinjie@huawei.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use scoped for_each_child_of_node_scoped() when iterating over device
nodes to make code a bit simpler.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/hwmon/aspeed-g6-pwm-tach.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hwmon/aspeed-g6-pwm-tach.c b/drivers/hwmon/aspeed-g6-pwm-tach.c
index 08a2ded95e45..75eadda738ab 100644
--- a/drivers/hwmon/aspeed-g6-pwm-tach.c
+++ b/drivers/hwmon/aspeed-g6-pwm-tach.c
@@ -456,7 +456,6 @@ static int aspeed_pwm_tach_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev, *hwmon;
 	int ret;
-	struct device_node *child;
 	struct aspeed_pwm_tach_data *priv;
 	struct pwm_chip *chip;
 
@@ -498,10 +497,9 @@ static int aspeed_pwm_tach_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to add PWM chip\n");
 
-	for_each_child_of_node(dev->of_node, child) {
+	for_each_child_of_node_scoped(dev->of_node, child) {
 		ret = aspeed_create_fan_monitor(dev, child, priv);
 		if (ret) {
-			of_node_put(child);
 			dev_warn(dev, "Failed to create fan %d", ret);
 			return 0;
 		}
-- 
2.34.1

