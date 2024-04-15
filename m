From: Eddie James <eajames@linux.ibm.com>
Date: Mon, 15 Apr 2024 10:39:06 -0500
Subject: [PATCH v2 2/3] fsi: sbefifo: Prevent async FFDC collection for Odyssey SBEFIFOs
In-Reply-To: <20240415153907.10051-1-eajames@linux.ibm.com>
References: <20240415153907.10051-1-eajames@linux.ibm.com>
Message-ID: <20240415153907.10051-3-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

A new type of SBE on the Odyssey chip will return any async FFDC in the
next transaction, so collecting the FFDC is unnecessary and results in
unexpected behavior. Turn off the async collection for Odyssey SBEFIFOs.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
Changes since v1:
 - Change "ody" to "odyssey"

 drivers/fsi/fsi-sbefifo.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/fsi/fsi-sbefifo.c b/drivers/fsi/fsi-sbefifo.c
index 0385476bfb03..b8add20e05ec 100644
--- a/drivers/fsi/fsi-sbefifo.c
+++ b/drivers/fsi/fsi-sbefifo.c
@@ -125,6 +125,7 @@ struct sbefifo {
 	struct mutex		lock;
 	bool			broken;
 	bool			dead;
+	bool			need_async;
 	bool			async_ffdc;
 	bool			timed_out;
 	u32			timeout_in_cmd_ms;
@@ -141,6 +142,10 @@ struct sbefifo_user {
 	u32			read_timeout_ms;
 };
 
+struct sbefifo_data {
+	bool need_async;
+};
+
 static DEFINE_MUTEX(sbefifo_ffdc_mutex);
 
 static ssize_t timeout_show(struct device *dev, struct device_attribute *attr,
@@ -317,6 +322,10 @@ static int sbefifo_check_sbe_state(struct sbefifo *sbefifo)
 		return -ESHUTDOWN;
 	}
 
+	/* Newer SBEFIFOs don't need async FFDC collection */
+	if (!sbefifo->need_async)
+		return 0;
+
 	/* Is there async FFDC available ? Remember it */
 	if (sbm & CFAM_SBM_SBE_ASYNC_FFDC)
 		sbefifo->async_ffdc = true;
@@ -1031,6 +1040,7 @@ static void sbefifo_free(struct device *dev)
 
 static int sbefifo_probe(struct device *dev)
 {
+	const struct sbefifo_data *md = of_device_get_match_data(dev);
 	struct fsi_device *fsi_dev = to_fsi_dev(dev);
 	struct sbefifo *sbefifo;
 	struct device_node *np;
@@ -1044,6 +1054,11 @@ static int sbefifo_probe(struct device *dev)
 	if (!sbefifo)
 		return -ENOMEM;
 
+	if (md)
+		sbefifo->need_async = md->need_async;
+	else
+		sbefifo->need_async = true;
+
 	/* Grab a reference to the device (parent of our cdev), we'll drop it later */
 	if (!get_device(dev)) {
 		kfree(sbefifo);
@@ -1128,6 +1143,27 @@ static int sbefifo_remove(struct device *dev)
 	return 0;
 }
 
+static const struct sbefifo_data p9_sbefifo_data = {
+	.need_async = true,
+};
+
+static const struct sbefifo_data odyssey_sbefifo_data = {
+	.need_async = false,
+};
+
+static const struct of_device_id sbefifo_of_ids[] = {
+	{
+		.compatible = "ibm,p9-sbefifo",
+		.data = &p9_sbefifo_data,
+	},
+	{
+		.compatible = "ibm,odyssey-sbefifo",
+		.data = &odyssey_sbefifo_data,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sbefifo_of_ids);
+
 static const struct fsi_device_id sbefifo_ids[] = {
 	{
 		.engine_type = FSI_ENGID_SBE,
@@ -1141,6 +1177,7 @@ static struct fsi_driver sbefifo_drv = {
 	.drv = {
 		.name = DEVICE_NAME,
 		.bus = &fsi_bus_type,
+		.of_match_table = sbefifo_of_ids,
 		.probe = sbefifo_probe,
 		.remove = sbefifo_remove,
 	}
-- 
2.39.3

