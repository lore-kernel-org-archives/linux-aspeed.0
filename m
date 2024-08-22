From: Jinjie Ruan <ruanjinjie@huawei.com>
Date: Thu, 22 Aug 2024 14:29:54 +0800
Subject: [PATCH -next 6/8] hwmon: (npcm750-pwm-fan): Simplify with scoped for each OF child loop
In-Reply-To: <20240822062956.3490387-1-ruanjinjie@huawei.com>
References: <20240822062956.3490387-1-ruanjinjie@huawei.com>
Message-ID: <20240822062956.3490387-7-ruanjinjie@huawei.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use scoped for_each_child_of_node_scoped() when iterating over device
nodes to make code a bit simpler.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/hwmon/npcm750-pwm-fan.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/npcm750-pwm-fan.c b/drivers/hwmon/npcm750-pwm-fan.c
index bc8db1dc595d..db3b551828eb 100644
--- a/drivers/hwmon/npcm750-pwm-fan.c
+++ b/drivers/hwmon/npcm750-pwm-fan.c
@@ -927,7 +927,7 @@ static int npcm7xx_en_pwm_fan(struct device *dev,
 static int npcm7xx_pwm_fan_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *np, *child;
+	struct device_node *np;
 	struct npcm7xx_pwm_fan_data *data;
 	struct resource *res;
 	struct device *hwmon;
@@ -1004,11 +1004,10 @@ static int npcm7xx_pwm_fan_probe(struct platform_device *pdev)
 		}
 	}
 
-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		ret = npcm7xx_en_pwm_fan(dev, child, data);
 		if (ret) {
 			dev_err(dev, "enable pwm and fan failed\n");
-			of_node_put(child);
 			return ret;
 		}
 	}
-- 
2.34.1

