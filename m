From: Eddie James <eajames@linux.ibm.com>
Date: Wed,  5 Jun 2024 16:22:44 -0500
Subject: [PATCH v4 12/40] fsi: core: Add common regmap master functions
In-Reply-To: <20240605212312.349188-1-eajames@linux.ibm.com>
References: <20240605212312.349188-1-eajames@linux.ibm.com>
Message-ID: <20240605212312.349188-13-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

For hardware FSI masters (Aspeed and hub at the moment), the
initialization, link enable, and error recovery procedures are
common. Add a regmap pointer to the master structure so that master
drivers can let the common code handle these procedures.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
Changes since v2:
 - Zero the regmap_config structure in the common FSI initialization
   function

 drivers/fsi/Kconfig        |   2 +
 drivers/fsi/fsi-core.c     | 162 ++++++++++++++++++++++++++++++++++++-
 drivers/fsi/fsi-master.h   |  16 ++++
 include/trace/events/fsi.h |  17 ++++
 4 files changed, 195 insertions(+), 2 deletions(-)

diff --git a/drivers/fsi/Kconfig b/drivers/fsi/Kconfig
index 79a31593618a6..a6760870538d3 100644
--- a/drivers/fsi/Kconfig
+++ b/drivers/fsi/Kconfig
@@ -7,6 +7,7 @@ menuconfig FSI
 	tristate "FSI support"
 	depends on OF
 	select CRC4
+	select REGMAP
 	help
 	  FSI - the FRU Support Interface - is a simple bus for low-level
 	  access to POWER-based hardware.
@@ -37,6 +38,7 @@ config FSI_MASTER_GPIO
 
 config FSI_MASTER_HUB
 	tristate "FSI hub master"
+	select REGMAP_FSI
 	help
 	This option enables a FSI hub master driver.  Hub is a type of FSI
 	master that is connected to the upstream master via a slave.  Hubs
diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index 36e31eafad3d0..bfb147de90efc 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -18,6 +18,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/bitops.h>
 #include <linux/cdev.h>
@@ -1155,18 +1156,50 @@ static int fsi_master_write(struct fsi_master *master, int link,
 	return rc;
 }
 
+int fsi_master_link_enable(struct fsi_master *master, int link, bool enable)
+{
+	u32 msiep = 0x80000000 >> (4 * (link % 8));
+	u32 menp = 0x80000000 >> (link % 32);
+	int enable_idx = 4 * (link / 32);
+	int irq_idx = 4 * (link / 8);
+	int rc;
+
+	if (enable) {
+		rc = regmap_write(master->map, FSI_MSENP0 + enable_idx, menp);
+		if (rc)
+			return rc;
+
+		mdelay(FSI_LINK_ENABLE_SETUP_TIME);
+
+		rc = regmap_write(master->map, FSI_MSSIEP0 + irq_idx, msiep);
+	} else {
+		rc = regmap_write(master->map, FSI_MCSIEP0 + irq_idx, msiep);
+		if (rc)
+			return rc;
+
+		rc = regmap_write(master->map, FSI_MCENP0 + enable_idx, menp);
+	}
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(fsi_master_link_enable);
+
 static int fsi_master_link_disable(struct fsi_master *master, int link)
 {
 	if (master->link_enable)
 		return master->link_enable(master, link, false);
+	else if (master->map)
+		return fsi_master_link_enable(master, link, false);
 
 	return 0;
 }
 
-static int fsi_master_link_enable(struct fsi_master *master, int link)
+static int _fsi_master_link_enable(struct fsi_master *master, int link)
 {
 	if (master->link_enable)
 		return master->link_enable(master, link, true);
+	else if (master->map)
+		return fsi_master_link_enable(master, link, true);
 
 	return 0;
 }
@@ -1194,7 +1227,7 @@ static int fsi_master_scan(struct fsi_master *master)
 
 	trace_fsi_master_scan(master, true);
 	for (link = 0; link < master->n_links; link++) {
-		rc = fsi_master_link_enable(master, link);
+		rc = _fsi_master_link_enable(master, link);
 		if (rc) {
 			dev_dbg(&master->dev,
 				"enable link %d failed: %d\n", link, rc);
@@ -1291,6 +1324,131 @@ static struct class fsi_master_class = {
 	.dev_groups = master_groups,
 };
 
+void fsi_master_error(struct fsi_master *master, int link)
+{
+	u32 bits = FSI_MMODE_EIP | FSI_MMODE_RELA;
+	bool mmode = master->mmode & bits;
+
+	if (trace_fsi_master_error_regs_enabled()) {
+		unsigned int mesrb = 0xffffffff;
+		unsigned int mstap = 0xffffffff;
+
+		regmap_read(master->map, FSI_MESRB0, &mesrb);
+		regmap_read(master->map, FSI_MSTAP0 + (link * 4), &mstap);
+
+		trace_fsi_master_error_regs(master->idx, mesrb, mstap);
+	}
+
+	if (mmode)
+		regmap_write(master->map, FSI_MMODE, master->mmode & ~bits);
+
+	regmap_write(master->map, FSI_MRESP0, FSI_MRESP_RST_ALL_MASTER);
+
+	if (mmode)
+		regmap_write(master->map, FSI_MMODE, master->mmode);
+}
+EXPORT_SYMBOL_GPL(fsi_master_error);
+
+static inline u32 fsi_mmode_crs0(u32 x)
+{
+	return (x & FSI_MMODE_CRS0MASK) << FSI_MMODE_CRS0SHFT;
+}
+
+static inline u32 fsi_mmode_crs1(u32 x)
+{
+	return (x & FSI_MMODE_CRS1MASK) << FSI_MMODE_CRS1SHFT;
+}
+
+int fsi_master_init(struct fsi_master *master, unsigned long parent_clock_frequency)
+{
+	unsigned int mlevp;
+	unsigned int maeb;
+	int div = 1;
+	int rc;
+
+	if (parent_clock_frequency) {
+		u32 clock_frequency;
+
+		if (device_property_read_u32(&master->dev, "clock-frequency", &clock_frequency) ||
+		    !clock_frequency)
+			clock_frequency = parent_clock_frequency;
+
+		div = DIV_ROUND_UP(parent_clock_frequency, clock_frequency);
+		master->clock_frequency = parent_clock_frequency / div;
+	}
+
+	rc = regmap_write(master->map, FSI_MRESP0, FSI_MRESP_RST_ALL_MASTER |
+			  FSI_MRESP_RST_ALL_LINK | FSI_MRESP_RST_MCR | FSI_MRESP_RST_PYE);
+	if (rc)
+		return rc;
+
+	rc = regmap_write(master->map, FSI_MECTRL, FSI_MECTRL_EOAE | FSI_MECTRL_P8_AUTO_TERM);
+	if (rc)
+		return rc;
+
+	master->mmode = FSI_MMODE_ECRC | FSI_MMODE_EPC | fsi_mmode_crs0(div) |
+		fsi_mmode_crs1(div) | FSI_MMODE_P8_TO_LSB;
+	rc = regmap_write(master->map, FSI_MMODE, master->mmode);
+	if (rc)
+		return rc;
+
+	rc = regmap_write(master->map, FSI_MDLYR, 0xffff0000);
+	if (rc)
+		return rc;
+
+	rc = regmap_write(master->map, FSI_MSENP0, 0xffffffff);
+	if (rc)
+		return rc;
+
+	mdelay(FSI_LINK_ENABLE_SETUP_TIME);
+
+	rc = regmap_write(master->map, FSI_MCENP0, 0xffffffff);
+	if (rc)
+		return rc;
+
+	rc = regmap_read(master->map, FSI_MAEB, &maeb);
+	if (rc)
+		return rc;
+
+	rc = regmap_write(master->map, FSI_MRESP0, FSI_MRESP_RST_ALL_MASTER |
+			  FSI_MRESP_RST_ALL_LINK);
+	if (rc)
+		return rc;
+
+	rc = regmap_read(master->map, FSI_MLEVP0, &mlevp);
+	if (rc)
+		return rc;
+
+	rc = regmap_write(master->map, FSI_MRESB0, FSI_MRESB_RST_GEN);
+	if (rc)
+		return rc;
+
+	rc = regmap_write(master->map, FSI_MRESB0, FSI_MRESB_RST_ERR);
+	if (rc)
+		return rc;
+
+	if (master->flags & FSI_MASTER_FLAG_INTERRUPT)
+		master->mmode |= FSI_MMODE_EIP;
+	if (master->flags & FSI_MASTER_FLAG_RELA)
+		master->mmode |= FSI_MMODE_RELA;
+	return regmap_write(master->map, FSI_MMODE, master->mmode);
+}
+EXPORT_SYMBOL_GPL(fsi_master_init);
+
+void fsi_master_regmap_config(struct regmap_config *config)
+{
+	memset(config, 0, sizeof(*config));
+
+	config->reg_bits = 32;
+	config->val_bits = 32;
+	config->disable_locking = true;	// master driver will lock
+	config->fast_io = true;
+	config->cache_type = REGCACHE_NONE;
+	config->val_format_endian = REGMAP_ENDIAN_NATIVE;
+	config->can_sleep = false;
+}
+EXPORT_SYMBOL_GPL(fsi_master_regmap_config);
+
 int fsi_master_register(struct fsi_master *master)
 {
 	int rc;
diff --git a/drivers/fsi/fsi-master.h b/drivers/fsi/fsi-master.h
index ff23983ea84c8..8ea2f69ec4922 100644
--- a/drivers/fsi/fsi-master.h
+++ b/drivers/fsi/fsi-master.h
@@ -27,6 +27,9 @@
 #define FSI_MLEVP0		0x18		/* R: plug detect */
 #define FSI_MSENP0		0x18		/* S: Set enable */
 #define FSI_MCENP0		0x20		/* C: Clear enable */
+#define FSI_MSIEP0		0x30		/* R/W: interrupt enable */
+#define FSI_MSSIEP0		0x50		/* S: Set interrupt enable */
+#define FSI_MCSIEP0		0x70		/* C: Clear interrupt enable */
 #define FSI_MAEB		0x70		/* R: Error address */
 #define FSI_MVER		0x74		/* R: master version/type */
 #define FSI_MSTAP0		0xd0		/* R: Port status */
@@ -108,10 +111,16 @@
 
 /* Misc */
 #define	FSI_CRC_SIZE		4
+#define FSI_LINK_ENABLE_SETUP_TIME	10	/* in mS */
 
 /* fsi-master definition and flags */
 #define FSI_MASTER_FLAG_SWCLOCK		0x1
 #define FSI_MASTER_FLAG_NO_BREAK_SID	0x2
+#define FSI_MASTER_FLAG_INTERRUPT	0x4
+#define FSI_MASTER_FLAG_RELA		0x8
+
+struct regmap;
+struct regmap_config;
 
 /*
  * Structures and function prototypes
@@ -121,6 +130,8 @@
 
 struct fsi_master {
 	struct device	dev;
+	struct regmap	*map;
+	u32		mmode;
 	unsigned long	clock_frequency;
 	int		idx;
 	int		n_links;
@@ -140,6 +151,11 @@ struct fsi_master {
 
 #define to_fsi_master(d) container_of(d, struct fsi_master, dev)
 
+void fsi_master_error(struct fsi_master *master, int link);
+int fsi_master_init(struct fsi_master *master, unsigned long parent_clock_frequency);
+int fsi_master_link_enable(struct fsi_master *master, int link, bool enable);
+void fsi_master_regmap_config(struct regmap_config *config);
+
 /**
  * fsi_master registration & lifetime: the fsi_master_register() and
  * fsi_master_unregister() functions will take ownership of the master, and
diff --git a/include/trace/events/fsi.h b/include/trace/events/fsi.h
index 5509afc98ee8b..da977d59e163e 100644
--- a/include/trace/events/fsi.h
+++ b/include/trace/events/fsi.h
@@ -67,6 +67,23 @@ TRACE_EVENT(fsi_master_error,
 		  &__entry->data, __entry->ret)
 );
 
+TRACE_EVENT(fsi_master_error_regs,
+	TP_PROTO(int master_idx, uint32_t mesrb, uint32_t mstap),
+	TP_ARGS(master_idx, mesrb, mstap),
+	TP_STRUCT__entry(
+		__field(int, master_idx)
+		__field(uint32_t, mesrb)
+		__field(uint32_t, mstap)
+	),
+	TP_fast_assign(
+		__entry->master_idx = master_idx;
+		__entry->mesrb = mesrb;
+		__entry->mstap = mstap;
+	),
+	TP_printk("fsi%d mesrb:%08x mstap:%08x", __entry->master_idx, __entry->mesrb,
+		  __entry->mstap)
+);
+
 TRACE_EVENT(fsi_master_break,
 	TP_PROTO(const struct fsi_master *master, int link),
 	TP_ARGS(master, link),
-- 
2.39.3

