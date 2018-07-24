From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 24 Jul 2018 15:05:19 +1000
Subject: [PATCH 5/5] fsi: Prevent multiple concurrent rescans
In-Reply-To: <20180724050519.31920-1-benh@kernel.crashing.org>
References: <20180724050519.31920-1-benh@kernel.crashing.org>
Message-ID: <20180724050519.31920-6-benh@kernel.crashing.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The bus scanning process isn't terribly good at parallel attempts
at rescanning the same bus. Let's have a per-master mutex protecting
the scanning process.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/fsi/fsi-core.c   | 16 ++++++++++++++--
 drivers/fsi/fsi-master.h |  2 ++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index dea5bd48acc5..2c31563fdcae 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -1203,8 +1203,14 @@ static void fsi_master_unscan(struct fsi_master *master)
 
 int fsi_master_rescan(struct fsi_master *master)
 {
+	int rc;
+
+	mutex_lock(&master->scan_lock);
 	fsi_master_unscan(master);
-	return fsi_master_scan(master);
+	rc = fsi_master_scan(master);
+	mutex_unlock(&master->scan_lock);
+
+	return rc;
 }
 EXPORT_SYMBOL_GPL(fsi_master_rescan);
 
@@ -1240,6 +1246,7 @@ int fsi_master_register(struct fsi_master *master)
 	int rc;
 	struct device_node *np;
 
+	mutex_init(&master->scan_lock);
 	master->idx = ida_simple_get(&master_ida, 0, INT_MAX, GFP_KERNEL);
 	dev_set_name(&master->dev, "fsi%d", master->idx);
 
@@ -1264,8 +1271,11 @@ int fsi_master_register(struct fsi_master *master)
 	}
 
 	np = dev_of_node(&master->dev);
-	if (!of_property_read_bool(np, "no-scan-on-init"))
+	if (!of_property_read_bool(np, "no-scan-on-init")) {
+		mutex_lock(&master->scan_lock);
 		fsi_master_scan(master);
+		mutex_unlock(&master->scan_lock);
+	}
 
 	return 0;
 }
@@ -1278,7 +1288,9 @@ void fsi_master_unregister(struct fsi_master *master)
 		master->idx = -1;
 	}
 
+	mutex_lock(&master->scan_lock);
 	fsi_master_unscan(master);
+	mutex_unlock(&master->scan_lock);
 	device_unregister(&master->dev);
 }
 EXPORT_SYMBOL_GPL(fsi_master_unregister);
diff --git a/drivers/fsi/fsi-master.h b/drivers/fsi/fsi-master.h
index f653f75da7be..040a7d4cf717 100644
--- a/drivers/fsi/fsi-master.h
+++ b/drivers/fsi/fsi-master.h
@@ -18,6 +18,7 @@
 #define DRIVERS_FSI_MASTER_H
 
 #include <linux/device.h>
+#include <linux/mutex.h>
 
 /* Various protocol delays */
 #define	FSI_ECHO_DELAY_CLOCKS	16	/* Number clocks for echo delay */
@@ -59,6 +60,7 @@ struct fsi_master {
 	int		idx;
 	int		n_links;
 	int		flags;
+	struct mutex	scan_lock;
 	int		(*read)(struct fsi_master *, int link, uint8_t id,
 				uint32_t addr, void *val, size_t size);
 	int		(*write)(struct fsi_master *, int link, uint8_t id,
-- 
2.17.1

