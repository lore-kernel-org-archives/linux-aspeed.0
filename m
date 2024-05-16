From: Eddie James <eajames@linux.ibm.com>
Date: Thu, 16 May 2024 13:19:04 -0500
Subject: [PATCH v3 37/40] fsi: core: Add different types of CFAM
In-Reply-To: <20240516181907.3468796-1-eajames@linux.ibm.com>
References: <20240516181907.3468796-1-eajames@linux.ibm.com>
Message-ID: <20240516181907.3468796-38-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Detect the CFAM type based on the chip id and set up the device
type based on the CFAM type.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-core.c | 84 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 83 insertions(+), 1 deletion(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index 3d2bedb3ad51b..2785812a7d4ad 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -1028,6 +1028,37 @@ static struct attribute *cfam_attrs[] = {
 
 ATTRIBUTE_GROUPS(cfam);
 
+static struct attribute *cfam_s_attrs[] = {
+	&dev_attr_send_echo_delays.attr,
+	&dev_attr_chip_id.attr,
+	&dev_attr_cfam_id.attr,
+	&dev_attr_send_term.attr,
+	&dev_attr_config_table.attr,
+	&dev_attr_smode.attr.attr,
+	&dev_attr_sdma.attr.attr,
+	&dev_attr_sisc.attr.attr,
+	&dev_attr_sism.attr.attr,
+	&dev_attr_siss.attr.attr,
+	&dev_attr_sstat.attr.attr,
+	&dev_attr_si1m.attr.attr,
+	&dev_attr_si1s.attr.attr,
+	&dev_attr_sic.attr.attr,
+	&dev_attr_si2m.attr.attr,
+	&dev_attr_si2s.attr.attr,
+	&dev_attr_scmdt.attr.attr,
+	&dev_attr_sdata.attr.attr,
+	&dev_attr_slastd.attr.attr,
+	&dev_attr_smbl.attr.attr,
+	&dev_attr_soml.attr.attr,
+	&dev_attr_snml.attr.attr,
+	&dev_attr_smbr.attr.attr,
+	&dev_attr_somr.attr.attr,
+	&dev_attr_snmr.attr.attr,
+	NULL,
+};
+
+ATTRIBUTE_GROUPS(cfam_s);
+
 static char *cfam_devnode(const struct device *dev, umode_t *mode,
 			  kuid_t *uid, kgid_t *gid)
 {
@@ -1046,6 +1077,57 @@ static const struct device_type cfam_type = {
 	.groups = cfam_groups
 };
 
+static char *cfam_ody_devnode(const struct device *dev, umode_t *mode, kuid_t *uid, kgid_t *gid)
+{
+	const struct fsi_slave *slave = to_fsi_slave(dev);
+
+#ifdef CONFIG_FSI_NEW_DEV_NODE
+	return kasprintf(GFP_KERNEL, "fsi/ody%d", slave->cdev_idx);
+#else
+	return kasprintf(GFP_KERNEL, "ody%d", slave->cdev_idx);
+#endif
+}
+
+static const struct device_type cfam_ody_type = {
+	.name = "ody",
+	.devnode = cfam_ody_devnode
+};
+
+static char *cfam_s_devnode(const struct device *dev, umode_t *mode, kuid_t *uid, kgid_t *gid)
+{
+	const struct fsi_slave *slave = to_fsi_slave(dev);
+
+#ifdef CONFIG_FSI_NEW_DEV_NODE
+	return kasprintf(GFP_KERNEL, "fsi/cfam-s%d", slave->cdev_idx);
+#else
+	return kasprintf(GFP_KERNEL, "cfam-s%d", slave->cdev_idx);
+#endif
+}
+
+static const struct device_type cfam_s_type = {
+	.name = "cfam-s",
+	.devnode = cfam_s_devnode,
+	.groups = cfam_s_groups,
+};
+
+const struct device_type *fsi_get_cfam_type(u32 id)
+{
+	u32 major = (id & 0xf00) >> 8;
+	u32 minor = (id & 0xf0) >> 4;
+
+	switch (major) {
+	case 0x9:
+		return &cfam_s_type;
+	case 0xc:
+		if (minor == 0)
+			return &cfam_ody_type;
+		fallthrough;
+	case 0xd:
+	default:
+		return &cfam_type;
+	}
+}
+
 static char *fsi_cdev_devnode(const struct device *dev, umode_t *mode,
 			      kuid_t *uid, kgid_t *gid)
 {
@@ -1202,7 +1284,7 @@ static int fsi_slave_init(struct fsi_master *master, int link, uint8_t id)
 
 	spin_lock_init(&slave->lock);
 	dev_set_name(&slave->dev, "slave@%02x:%02x", link, id);
-	slave->dev.type = &cfam_type;
+	slave->dev.type = fsi_get_cfam_type(cfam_id);
 	slave->dev.parent = &master->dev;
 	slave->dev.of_node = fsi_slave_find_of_node(master, link, id);
 	slave->dev.release = fsi_slave_release;
-- 
2.39.3

