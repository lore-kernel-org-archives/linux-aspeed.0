From: Eddie James <eajames@linux.ibm.com>
Date: Mon, 29 Apr 2024 16:01:30 -0500
Subject: [PATCH v4 16/17] fsi: occ: Find next available child rather than node name match
In-Reply-To: <20240429210131.373487-1-eajames@linux.ibm.com>
References: <20240429210131.373487-1-eajames@linux.ibm.com>
Message-ID: <20240429210131.373487-17-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

There's no reason to restrict the creation of the hwmon device to
a matching child node name. Just get the first available one. There
should only be one child node anyway.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-occ.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fsi/fsi-occ.c b/drivers/fsi/fsi-occ.c
index 2023355b3980..9a3658d86379 100644
--- a/drivers/fsi/fsi-occ.c
+++ b/drivers/fsi/fsi-occ.c
@@ -669,7 +669,7 @@ static int occ_probe(struct platform_device *pdev)
 		return rc;
 	}
 
-	hwmon_node = of_get_child_by_name(dev->of_node, hwmon_dev_info.name);
+	hwmon_node = of_get_next_available_child(dev->of_node, NULL);
 	if (hwmon_node) {
 		snprintf(child_name, sizeof(child_name), "%s.%d", hwmon_dev_info.name, occ->idx);
 		hwmon_dev = of_platform_device_create(hwmon_node, child_name, dev);
-- 
2.39.3

