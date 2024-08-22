From: Jinjie Ruan <ruanjinjie@huawei.com>
Date: Thu, 22 Aug 2024 14:29:55 +0800
Subject: [PATCH -next 7/8] hwmon: (tmp421): Simplify with scoped for each OF child loop
In-Reply-To: <20240822062956.3490387-1-ruanjinjie@huawei.com>
References: <20240822062956.3490387-1-ruanjinjie@huawei.com>
Message-ID: <20240822062956.3490387-8-ruanjinjie@huawei.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use scoped for_each_child_of_node_scoped() when iterating over device
nodes to make code a bit simpler.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/hwmon/tmp421.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/tmp421.c b/drivers/hwmon/tmp421.c
index 7a6f9532e594..9537727aad9a 100644
--- a/drivers/hwmon/tmp421.c
+++ b/drivers/hwmon/tmp421.c
@@ -410,18 +410,15 @@ static int tmp421_probe_from_dt(struct i2c_client *client, struct tmp421_data *d
 {
 	struct device *dev = &client->dev;
 	const struct device_node *np = dev->of_node;
-	struct device_node *child;
 	int err;
 
-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		if (strcmp(child->name, "channel"))
 			continue;
 
 		err = tmp421_probe_child_from_dt(client, child, data);
-		if (err) {
-			of_node_put(child);
+		if (err)
 			return err;
-		}
 	}
 
 	return 0;
-- 
2.34.1

