From: Eddie James <eajames@linux.ibm.com>
Date: Thu, 16 May 2024 13:18:38 -0500
Subject: [PATCH v3 11/40] fsi: core: Allow cfam device type aliases
In-Reply-To: <20240516181907.3468796-1-eajames@linux.ibm.com>
References: <20240516181907.3468796-1-eajames@linux.ibm.com>
Message-ID: <20240516181907.3468796-12-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Other FSI devices can uses aliases for the device numbering, so
modify the function to get a new minor to allow the cfam type
to use aliases too.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-core.c | 59 +++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 30 deletions(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index 660f89b743235..36e31eafad3d0 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -884,12 +884,37 @@ static int fsi_adjust_index(int index)
 #endif
 }
 
-static int __fsi_get_new_minor(struct fsi_slave *slave, enum fsi_dev_type type,
-			       dev_t *out_dev, int *out_index)
+static const char *const fsi_dev_type_names[] = {
+	"cfam",
+	"sbefifo",
+	"scom",
+	"occ",
+};
+
+static int __fsi_get_new_minor(struct fsi_slave *slave, struct device_node *np,
+			       enum fsi_dev_type type, dev_t *out_dev, int *out_index)
 {
 	int cid = slave->chip_id;
 	int id;
 
+	if (np && type < 4) {
+		int aid = of_alias_get_id(np, fsi_dev_type_names[type]);
+
+		if (aid >= 0) {
+			/* Use the same scheme as the legacy numbers. */
+			id = (aid << 2) | type;
+			id = ida_alloc_range(&fsi_minor_ida, id, id, GFP_KERNEL);
+			if (id >= 0) {
+				*out_index = aid;
+				*out_dev = fsi_base_dev + id;
+				return 0;
+			}
+
+			if (id != -ENOSPC)
+				return id;
+		}
+	}
+
 	/* Check if we qualify for legacy numbering */
 	if (cid >= 0 && cid < 16 && type < 4) {
 		/*
@@ -918,36 +943,10 @@ static int __fsi_get_new_minor(struct fsi_slave *slave, enum fsi_dev_type type,
 	return 0;
 }
 
-static const char *const fsi_dev_type_names[] = {
-	"cfam",
-	"sbefifo",
-	"scom",
-	"occ",
-};
-
 int fsi_get_new_minor(struct fsi_device *fdev, enum fsi_dev_type type,
 		      dev_t *out_dev, int *out_index)
 {
-	if (fdev->dev.of_node) {
-		int aid = of_alias_get_id(fdev->dev.of_node, fsi_dev_type_names[type]);
-
-		if (aid >= 0) {
-			/* Use the same scheme as the legacy numbers. */
-			int id = (aid << 2) | type;
-
-			id = ida_alloc_range(&fsi_minor_ida, id, id, GFP_KERNEL);
-			if (id >= 0) {
-				*out_index = aid;
-				*out_dev = fsi_base_dev + id;
-				return 0;
-			}
-
-			if (id != -ENOSPC)
-				return id;
-		}
-	}
-
-	return __fsi_get_new_minor(fdev->slave, type, out_dev, out_index);
+	return __fsi_get_new_minor(fdev->slave, fdev->dev.of_node, type, out_dev, out_index);
 }
 EXPORT_SYMBOL_GPL(fsi_get_new_minor);
 
@@ -1059,7 +1058,7 @@ static int fsi_slave_init(struct fsi_master *master, int link, uint8_t id)
 	}
 
 	/* Allocate a minor in the FSI space */
-	rc = __fsi_get_new_minor(slave, fsi_dev_cfam, &slave->dev.devt,
+	rc = __fsi_get_new_minor(slave, slave->dev.of_node, fsi_dev_cfam, &slave->dev.devt,
 				 &slave->cdev_idx);
 	if (rc)
 		goto err_free;
-- 
2.39.3

