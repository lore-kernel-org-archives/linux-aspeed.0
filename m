From: Jinjie Ruan <ruanjinjie@huawei.com>
Date: Thu, 22 Aug 2024 14:29:51 +0800
Subject: [PATCH -next 3/8] hwmon: (ina3221): Simplify with scoped for each OF child loop
In-Reply-To: <20240822062956.3490387-1-ruanjinjie@huawei.com>
References: <20240822062956.3490387-1-ruanjinjie@huawei.com>
Message-ID: <20240822062956.3490387-4-ruanjinjie@huawei.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use scoped for_each_child_of_node_scoped() when iterating over device
nodes to make code a bit simpler.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/hwmon/ina3221.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
index f0053f87e3e6..1bf479a0f793 100644
--- a/drivers/hwmon/ina3221.c
+++ b/drivers/hwmon/ina3221.c
@@ -813,7 +813,6 @@ static int ina3221_probe_child_from_dt(struct device *dev,
 static int ina3221_probe_from_dt(struct device *dev, struct ina3221_data *ina)
 {
 	const struct device_node *np = dev->of_node;
-	struct device_node *child;
 	int ret;
 
 	/* Compatible with non-DT platforms */
@@ -822,12 +821,10 @@ static int ina3221_probe_from_dt(struct device *dev, struct ina3221_data *ina)
 
 	ina->single_shot = of_property_read_bool(np, "ti,single-shot");
 
-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		ret = ina3221_probe_child_from_dt(dev, child, ina);
-		if (ret) {
-			of_node_put(child);
+		if (ret)
 			return ret;
-		}
 	}
 
 	return 0;
-- 
2.34.1

