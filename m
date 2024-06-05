From: Eddie James <eajames@linux.ibm.com>
Date: Wed,  5 Jun 2024 16:22:33 -0500
Subject: [PATCH v4 01/40] fsi: hub: Set master index to link number plus one
In-Reply-To: <20240605212312.349188-1-eajames@linux.ibm.com>
References: <20240605212312.349188-1-eajames@linux.ibm.com>
Message-ID: <20240605212312.349188-2-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hub master indexing is problematic if a hub is rescanned while the root
master is being rescanned. Therefore, request a specific index in the hub
driver.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-master-hub.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/fsi/fsi-master-hub.c b/drivers/fsi/fsi-master-hub.c
index 6d8b6e8854e56..36da643b32018 100644
--- a/drivers/fsi/fsi-master-hub.c
+++ b/drivers/fsi/fsi-master-hub.c
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 
 #include "fsi-master.h"
+#include "fsi-slave.h"
 
 #define FSI_ENGID_HUB_MASTER		0x1c
 
@@ -229,6 +230,7 @@ static int hub_master_probe(struct device *dev)
 	hub->master.dev.release = hub_master_release;
 	hub->master.dev.of_node = of_node_get(dev_of_node(dev));
 
+	hub->master.idx = fsi_dev->slave->link + 1;
 	hub->master.n_links = links;
 	hub->master.read = hub_master_read;
 	hub->master.write = hub_master_write;
-- 
2.39.3

