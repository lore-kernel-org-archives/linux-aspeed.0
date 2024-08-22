From: Jinjie Ruan <ruanjinjie@huawei.com>
Date: Thu, 22 Aug 2024 14:29:56 +0800
Subject: [PATCH -next 8/8] hwmon: (tmp464): Simplify with scoped for each OF child loop
In-Reply-To: <20240822062956.3490387-1-ruanjinjie@huawei.com>
References: <20240822062956.3490387-1-ruanjinjie@huawei.com>
Message-ID: <20240822062956.3490387-9-ruanjinjie@huawei.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use scoped for_each_child_of_node_scoped() when iterating over device
nodes to make code a bit simpler.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/hwmon/tmp464.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/tmp464.c b/drivers/hwmon/tmp464.c
index 0a7c0448835b..0f629c6d7695 100644
--- a/drivers/hwmon/tmp464.c
+++ b/drivers/hwmon/tmp464.c
@@ -562,18 +562,15 @@ static int tmp464_probe_child_from_dt(struct device *dev,
 static int tmp464_probe_from_dt(struct device *dev, struct tmp464_data *data)
 {
 	const struct device_node *np = dev->of_node;
-	struct device_node *child;
 	int err;
 
-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		if (strcmp(child->name, "channel"))
 			continue;
 
 		err = tmp464_probe_child_from_dt(dev, child, data);
-		if (err) {
-			of_node_put(child);
+		if (err)
 			return err;
-		}
 	}
 
 	return 0;
-- 
2.34.1

