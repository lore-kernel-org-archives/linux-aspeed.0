From: Jinjie Ruan <ruanjinjie@huawei.com>
Date: Thu, 22 Aug 2024 14:29:53 +0800
Subject: [PATCH -next 5/8] hwmon: (nct7802): Simplify with scoped for each OF child loop
In-Reply-To: <20240822062956.3490387-1-ruanjinjie@huawei.com>
References: <20240822062956.3490387-1-ruanjinjie@huawei.com>
Message-ID: <20240822062956.3490387-6-ruanjinjie@huawei.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use scoped for_each_child_of_node_scoped() when iterating over device
nodes to make code a bit simpler.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/hwmon/nct7802.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/nct7802.c b/drivers/hwmon/nct7802.c
index 5e83504800a3..8c9351da12c6 100644
--- a/drivers/hwmon/nct7802.c
+++ b/drivers/hwmon/nct7802.c
@@ -1129,17 +1129,14 @@ static int nct7802_configure_channels(struct device *dev,
 {
 	/* Enable local temperature sensor by default */
 	u8 mode_mask = MODE_LTD_EN, mode_val = MODE_LTD_EN;
-	struct device_node *node;
 	int err;
 
 	if (dev->of_node) {
-		for_each_child_of_node(dev->of_node, node) {
+		for_each_child_of_node_scoped(dev->of_node, node) {
 			err = nct7802_get_channel_config(dev, node, &mode_mask,
 							 &mode_val);
-			if (err) {
-				of_node_put(node);
+			if (err)
 				return err;
-			}
 		}
 	}
 
-- 
2.34.1

