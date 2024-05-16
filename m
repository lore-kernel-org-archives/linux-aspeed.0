From: Eddie James <eajames@linux.ibm.com>
Date: Thu, 16 May 2024 13:19:02 -0500
Subject: [PATCH v3 35/40] fsi: core: Add slave register read-only sysfs
In-Reply-To: <20240516181907.3468796-1-eajames@linux.ibm.com>
References: <20240516181907.3468796-1-eajames@linux.ibm.com>
Message-ID: <20240516181907.3468796-36-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The slave registers are commonly used for debugging or diagnosis
so provide them in sysfs files.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-core.c  | 144 +++++++++++++++++++++++++++++++++++++---
 drivers/fsi/fsi-slave.h |  21 ++++++
 2 files changed, 155 insertions(+), 10 deletions(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index 096b26c6421f2..3d2bedb3ad51b 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -887,22 +887,146 @@ static ssize_t cfam_id_show(struct device *dev,
 
 static DEVICE_ATTR_RO(cfam_id);
 
-static struct attribute *cfam_attr[] = {
+static ssize_t config_table_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	const unsigned int end = engine_page_size / sizeof(u32);
+	struct fsi_slave *slave = to_fsi_slave(dev);
+	__be32 data;
+	int len = 0;
+	u32 conf;
+	int rc;
+
+	for (unsigned int i = 0; i < end; ++i) {
+		rc = fsi_slave_read(slave, i * sizeof(data), &data, sizeof(data));
+		if (rc)
+			return rc;
+
+		conf = be32_to_cpu(data);
+		if (crc4(0, conf, 32))
+			return -EBADMSG;
+
+		len += sysfs_emit_at(buf, len, "%08x\n", conf);
+		if (!(conf & FSI_SLAVE_CONF_NEXT_MASK))
+			break;
+	}
+
+	return len;
+}
+
+static DEVICE_ATTR_RO(config_table);
+
+struct fsi_slave_attribute {
+	struct device_attribute attr;
+	int reg;
+};
+
+static ssize_t slave_reg_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct fsi_slave_attribute *fattr = container_of(attr, struct fsi_slave_attribute, attr);
+	struct fsi_slave *slave = to_fsi_slave(dev);
+	__be32 data;
+	int rc;
+
+	rc = fsi_slave_read(slave, FSI_SLAVE_BASE + fattr->reg, &data, sizeof(data));
+	if (rc)
+		return rc;
+
+	return sysfs_emit(buf, "%08x\n", be32_to_cpu(data));
+}
+
+static ssize_t slave_reg_8bpp_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct fsi_slave_attribute *fattr = container_of(attr, struct fsi_slave_attribute, attr);
+	struct fsi_slave *slave = to_fsi_slave(dev);
+	__be32 data;
+	int len = 0;
+	int rc;
+	int i;
+
+	for (i = 0; i < 2; ++i) {
+		rc = fsi_slave_read(slave, FSI_SLAVE_BASE + fattr->reg + (i * 4), &data,
+				    sizeof(data));
+		if (rc)
+			return rc;
+
+		len += sysfs_emit_at(buf, len, "%08x\n", be32_to_cpu(data));
+	}
+
+	return len;
+}
+
+#define FSI_SLAVE_ATTR(name, reg) \
+	struct fsi_slave_attribute dev_attr_##name = { __ATTR(name, 0444, slave_reg_show, NULL), reg }
+#define FSI_SLAVE_ATTR_8BPP(name, reg) \
+	struct fsi_slave_attribute dev_attr_##name = { __ATTR(name, 0444, slave_reg_8bpp_show, NULL), reg }
+
+static FSI_SLAVE_ATTR(smode, FSI_SMODE);
+static FSI_SLAVE_ATTR(sdma, FSI_SDMA);
+static FSI_SLAVE_ATTR(sisc, FSI_SISC);
+static FSI_SLAVE_ATTR(sism, FSI_SISM);
+static FSI_SLAVE_ATTR(siss, FSI_SISS);
+static FSI_SLAVE_ATTR(sstat, FSI_SSTAT);
+static FSI_SLAVE_ATTR(si1m, FSI_SI1M);
+static FSI_SLAVE_ATTR(si1s, FSI_SI1S);
+static FSI_SLAVE_ATTR(sic, FSI_SIC);
+static FSI_SLAVE_ATTR(si2m, FSI_SI2M);
+static FSI_SLAVE_ATTR(si2s, FSI_SI2S);
+static FSI_SLAVE_ATTR(scmdt, FSI_SCMDT);
+static FSI_SLAVE_ATTR(sdata, FSI_SDATA);
+static FSI_SLAVE_ATTR(slastd, FSI_SLASTD);
+static FSI_SLAVE_ATTR(smbl, FSI_SMBL);
+static FSI_SLAVE_ATTR(soml, FSI_SOML);
+static FSI_SLAVE_ATTR(snml, FSI_SNML);
+static FSI_SLAVE_ATTR(smbr, FSI_SMBR);
+static FSI_SLAVE_ATTR(somr, FSI_SOMR);
+static FSI_SLAVE_ATTR(snmr, FSI_SNMR);
+static FSI_SLAVE_ATTR_8BPP(scrsic, FSI_ScRSIC0);
+static FSI_SLAVE_ATTR_8BPP(scrsim, FSI_ScRSIM0);
+static FSI_SLAVE_ATTR_8BPP(scrsis, FSI_ScRSIS0);
+static FSI_SLAVE_ATTR_8BPP(srsic, FSI_SRSIC0);
+static FSI_SLAVE_ATTR_8BPP(srsim, FSI_SRSIM0);
+static FSI_SLAVE_ATTR_8BPP(srsis, FSI_SRSIS0);
+static FSI_SLAVE_ATTR(llmode, FSI_LLMODE);
+static FSI_SLAVE_ATTR(llstat, FSI_LLSTAT);
+
+static struct attribute *cfam_attrs[] = {
 	&dev_attr_send_echo_delays.attr,
 	&dev_attr_chip_id.attr,
 	&dev_attr_cfam_id.attr,
 	&dev_attr_send_term.attr,
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
+	&dev_attr_scrsic.attr.attr,
+	&dev_attr_scrsim.attr.attr,
+	&dev_attr_scrsis.attr.attr,
+	&dev_attr_srsic.attr.attr,
+	&dev_attr_srsim.attr.attr,
+	&dev_attr_srsis.attr.attr,
+	&dev_attr_llmode.attr.attr,
+	&dev_attr_llstat.attr.attr,
 	NULL,
 };
 
-static const struct attribute_group cfam_attr_group = {
-	.attrs = cfam_attr,
-};
-
-static const struct attribute_group *cfam_attr_groups[] = {
-	&cfam_attr_group,
-	NULL,
-};
+ATTRIBUTE_GROUPS(cfam);
 
 static char *cfam_devnode(const struct device *dev, umode_t *mode,
 			  kuid_t *uid, kgid_t *gid)
@@ -919,7 +1043,7 @@ static char *cfam_devnode(const struct device *dev, umode_t *mode,
 static const struct device_type cfam_type = {
 	.name = "cfam",
 	.devnode = cfam_devnode,
-	.groups = cfam_attr_groups
+	.groups = cfam_groups
 };
 
 static char *fsi_cdev_devnode(const struct device *dev, umode_t *mode,
diff --git a/drivers/fsi/fsi-slave.h b/drivers/fsi/fsi-slave.h
index 0468ec1c60db2..1478ee561b85c 100644
--- a/drivers/fsi/fsi-slave.h
+++ b/drivers/fsi/fsi-slave.h
@@ -14,6 +14,7 @@
  * FSI slave engine control register offsets
  */
 #define FSI_SMODE		0x0	/* R/W: Mode register */
+#define FSI_SDMA		0x4	/* R/W: DMA control */
 #define FSI_SISC		0x8	/* R  : Interrupt condition */
 #define FSI_SCISC		0x8	/* C  : Clear interrupt condition */
 #define FSI_SISM		0xc	/* R/W: Interrupt mask */
@@ -21,11 +22,30 @@
 #define FSI_SSISM		0x10	/* S  : Set interrupt mask */
 #define FSI_SCISM		0x14	/* C  : Clear interrupt mask */
 #define FSI_SSTAT		0x14	/* R  : Slave status */
+#define FSI_SI1M		0x18	/* R/W: Interrupt 1 mask */
 #define FSI_SI1S		0x1c	/* R  : Slave interrupt 1 status */
 #define FSI_SSI1M		0x1c	/* S  : Set slave interrupt 1 mask */
+#define FSI_SIC			0x20	/* R  : Interrupt 1 condition */
 #define FSI_SCI1M		0x20	/* C  : Clear slave interrupt 1 mask */
+#define FSI_SI2M		0x24	/* R/W: Interrupt 2 mask */
+#define FSI_SI2S		0x28	/* R  : Interrupt 2 status */
+#define FSI_SCMDT		0x2c	/* R  : Last command trace */
+#define FSI_SDATA		0x30	/* R  : Last data trace */
 #define FSI_SLBUS		0x30	/* W  : LBUS Ownership */
+#define FSI_SLASTD		0x34	/* R  : Last data sent */
 #define FSI_SRES		0x34	/* W  : Reset */
+#define FSI_SMBL		0x38
+#define FSI_SOML		0x3c
+#define FSI_SNML		0x40
+#define FSI_SMBR		0x44
+#define FSI_SOMR		0x48
+#define FSI_SNMR		0x4c
+#define FSI_ScRSIC0		0x50
+#define FSI_ScRSIC4		0x54
+#define FSI_ScRSIM0		0x58
+#define FSI_ScRSIM4		0x5c
+#define FSI_ScRSIS0		0x60
+#define FSI_ScRSIS4		0x64
 #define FSI_SRSIC0		0x68	/* C  : Clear remote interrupt condition */
 #define FSI_SRSIC4		0x6c	/* C  : Clear remote interrupt condition */
 #define FSI_SRSIM0		0x70	/* R/W: Remote interrupt mask */
@@ -33,6 +53,7 @@
 #define FSI_SRSIS0		0x78	/* R  : Remote interrupt status */
 #define FSI_SRSIS4		0x7c	/* R  : Remote interrupt status */
 #define FSI_LLMODE		0x100	/* R/W: Link layer mode register */
+#define FSI_LLSTAT		0x104
 
 /*
  * SMODE fields
-- 
2.39.3

