From: Eddie James <eajames@linux.ibm.com>
Date: Mon, 29 Apr 2024 16:01:29 -0500
Subject: [PATCH v4 15/17] fsi: occ: Get device number from FSI minor number API
In-Reply-To: <20240429210131.373487-1-eajames@linux.ibm.com>
References: <20240429210131.373487-1-eajames@linux.ibm.com>
Message-ID: <20240429210131.373487-16-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Remove the IDA indexing for OCC devices and instead use the FSI
minor number API. This will make the OCC numbering consistent
with other FSI engines and make the "reg" device tree property
unnecessary.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-occ.c | 47 +++++++++----------------------------------
 1 file changed, 9 insertions(+), 38 deletions(-)

diff --git a/drivers/fsi/fsi-occ.c b/drivers/fsi/fsi-occ.c
index da35ca9e84a6..2023355b3980 100644
--- a/drivers/fsi/fsi-occ.c
+++ b/drivers/fsi/fsi-occ.c
@@ -4,9 +4,9 @@
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
+#include <linux/fsi.h>
 #include <linux/fsi-sbefifo.h>
 #include <linux/gfp.h>
-#include <linux/idr.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/miscdevice.h>
@@ -44,6 +44,7 @@ struct occ {
 	struct device *sbefifo;
 	char name[32];
 	int idx;
+	dev_t devt;
 	bool platform_hwmon;
 	u8 sequence_number;
 	void *buffer;
@@ -75,8 +76,6 @@ struct occ_client {
 
 #define to_client(x)	container_of((x), struct occ_client, xfr)
 
-static DEFINE_IDA(occ_ida);
-
 static int occ_open(struct inode *inode, struct file *file)
 {
 	struct occ_client *client = kzalloc(sizeof(*client), GFP_KERNEL);
@@ -622,7 +621,6 @@ static int occ_unregister_of_child(struct device *dev, void *data)
 static int occ_probe(struct platform_device *pdev)
 {
 	int rc;
-	u32 reg;
 	char child_name[32];
 	struct occ *occ;
 	struct platform_device *hwmon_dev = NULL;
@@ -637,6 +635,10 @@ static int occ_probe(struct platform_device *pdev)
 	if (!occ)
 		return -ENOMEM;
 
+	rc = fsi_get_new_minor(to_fsi_dev(dev->parent), fsi_dev_occ, &occ->devt, &occ->idx);
+	if (rc)
+		return rc;
+
 	/* SBE words are always four bytes */
 	occ->buffer = kvmalloc(OCC_MAX_RESP_WORDS * 4, GFP_KERNEL);
 	if (!occ->buffer)
@@ -651,24 +653,6 @@ static int occ_probe(struct platform_device *pdev)
 	 */
 	occ->sequence_number = (u8)((jiffies % 0xff) + 1);
 	mutex_init(&occ->occ_lock);
-
-	if (dev->of_node) {
-		rc = of_property_read_u32(dev->of_node, "reg", &reg);
-		if (!rc) {
-			/* make sure we don't have a duplicate from dts */
-			occ->idx = ida_simple_get(&occ_ida, reg, reg + 1,
-						  GFP_KERNEL);
-			if (occ->idx < 0)
-				occ->idx = ida_simple_get(&occ_ida, 1, INT_MAX,
-							  GFP_KERNEL);
-		} else {
-			occ->idx = ida_simple_get(&occ_ida, 1, INT_MAX,
-						  GFP_KERNEL);
-		}
-	} else {
-		occ->idx = ida_simple_get(&occ_ida, 1, INT_MAX, GFP_KERNEL);
-	}
-
 	platform_set_drvdata(pdev, occ);
 
 	snprintf(occ->name, sizeof(occ->name), "occ%d", occ->idx);
@@ -680,7 +664,7 @@ static int occ_probe(struct platform_device *pdev)
 	rc = misc_register(&occ->mdev);
 	if (rc) {
 		dev_err(dev, "failed to register miscdevice: %d\n", rc);
-		ida_simple_remove(&occ_ida, occ->idx);
+		fsi_free_minor(occ->devt);
 		kvfree(occ->buffer);
 		return rc;
 	}
@@ -719,7 +703,7 @@ static int occ_remove(struct platform_device *pdev)
 	else
 		device_for_each_child(&pdev->dev, NULL, occ_unregister_of_child);
 
-	ida_simple_remove(&occ_ida, occ->idx);
+	fsi_free_minor(occ->devt);
 
 	return 0;
 }
@@ -746,20 +730,7 @@ static struct platform_driver occ_driver = {
 	.remove = occ_remove,
 };
 
-static int occ_init(void)
-{
-	return platform_driver_register(&occ_driver);
-}
-
-static void occ_exit(void)
-{
-	platform_driver_unregister(&occ_driver);
-
-	ida_destroy(&occ_ida);
-}
-
-module_init(occ_init);
-module_exit(occ_exit);
+module_platform_driver(occ_driver);
 
 MODULE_AUTHOR("Eddie James <eajames@linux.ibm.com>");
 MODULE_DESCRIPTION("BMC P9 OCC driver");
-- 
2.39.3

