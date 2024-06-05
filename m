From: Eddie James <eajames@linux.ibm.com>
Date: Wed,  5 Jun 2024 16:22:46 -0500
Subject: [PATCH v4 14/40] fsi: hub: Use common initialization and link enable
In-Reply-To: <20240605212312.349188-1-eajames@linux.ibm.com>
References: <20240605212312.349188-1-eajames@linux.ibm.com>
Message-ID: <20240605212312.349188-15-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Set up an FSI regmap for the hub master to use the new common
master initialization and link enable procedures.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-master-hub.c | 142 ++++++-----------------------------
 1 file changed, 23 insertions(+), 119 deletions(-)

diff --git a/drivers/fsi/fsi-master-hub.c b/drivers/fsi/fsi-master-hub.c
index eea8649fee74d..91ad6b7728fa2 100644
--- a/drivers/fsi/fsi-master-hub.c
+++ b/drivers/fsi/fsi-master-hub.c
@@ -9,6 +9,7 @@
 #include <linux/fsi.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 
 #include "fsi-master.h"
@@ -16,8 +17,6 @@
 
 #define FSI_ENGID_HUB_MASTER		0x1c
 
-#define FSI_LINK_ENABLE_SETUP_TIME	10	/* in mS */
-
 /*
  * FSI hub master support
  *
@@ -78,134 +77,33 @@ static int hub_master_break(struct fsi_master *master, int link)
 	return hub_master_write(master, link, 0, addr, &cmd, sizeof(cmd));
 }
 
-static int hub_master_link_enable(struct fsi_master *master, int link,
-				  bool enable)
-{
-	struct fsi_master_hub *hub = to_fsi_master_hub(master);
-	int idx, bit;
-	__be32 reg;
-	int rc;
-
-	idx = link / 32;
-	bit = link % 32;
-
-	reg = cpu_to_be32(0x80000000 >> bit);
-
-	if (!enable)
-		return fsi_device_write(hub->upstream, FSI_MCENP0 + (4 * idx),
-					&reg, 4);
-
-	rc = fsi_device_write(hub->upstream, FSI_MSENP0 + (4 * idx), &reg, 4);
-	if (rc)
-		return rc;
-
-	mdelay(FSI_LINK_ENABLE_SETUP_TIME);
-
-	return 0;
-}
-
 static void hub_master_release(struct device *dev)
 {
 	struct fsi_master_hub *hub = to_fsi_master_hub(to_fsi_master(dev));
 
+	regmap_exit(hub->master.map);
 	kfree(hub);
 }
 
-/* mmode encoders */
-static inline u32 fsi_mmode_crs0(u32 x)
-{
-	return (x & FSI_MMODE_CRS0MASK) << FSI_MMODE_CRS0SHFT;
-}
-
-static inline u32 fsi_mmode_crs1(u32 x)
-{
-	return (x & FSI_MMODE_CRS1MASK) << FSI_MMODE_CRS1SHFT;
-}
-
-static int hub_master_init(struct fsi_master_hub *hub)
-{
-	struct fsi_device *dev = hub->upstream;
-	__be32 reg;
-	int rc;
-
-	reg = cpu_to_be32(FSI_MRESP_RST_ALL_MASTER | FSI_MRESP_RST_ALL_LINK
-			| FSI_MRESP_RST_MCR | FSI_MRESP_RST_PYE);
-	rc = fsi_device_write(dev, FSI_MRESP0, &reg, sizeof(reg));
-	if (rc)
-		return rc;
-
-	/* Initialize the MFSI (hub master) engine */
-	reg = cpu_to_be32(FSI_MRESP_RST_ALL_MASTER | FSI_MRESP_RST_ALL_LINK
-			| FSI_MRESP_RST_MCR | FSI_MRESP_RST_PYE);
-	rc = fsi_device_write(dev, FSI_MRESP0, &reg, sizeof(reg));
-	if (rc)
-		return rc;
-
-	reg = cpu_to_be32(FSI_MECTRL_EOAE | FSI_MECTRL_P8_AUTO_TERM);
-	rc = fsi_device_write(dev, FSI_MECTRL, &reg, sizeof(reg));
-	if (rc)
-		return rc;
-
-	reg = cpu_to_be32(FSI_MMODE_EIP | FSI_MMODE_ECRC | FSI_MMODE_EPC
-			| fsi_mmode_crs0(1) | fsi_mmode_crs1(1)
-			| FSI_MMODE_P8_TO_LSB);
-	rc = fsi_device_write(dev, FSI_MMODE, &reg, sizeof(reg));
-	if (rc)
-		return rc;
-
-	reg = cpu_to_be32(0xffff0000);
-	rc = fsi_device_write(dev, FSI_MDLYR, &reg, sizeof(reg));
-	if (rc)
-		return rc;
-
-	reg = cpu_to_be32(~0);
-	rc = fsi_device_write(dev, FSI_MSENP0, &reg, sizeof(reg));
-	if (rc)
-		return rc;
-
-	/* Leave enabled long enough for master logic to set up */
-	mdelay(FSI_LINK_ENABLE_SETUP_TIME);
-
-	rc = fsi_device_write(dev, FSI_MCENP0, &reg, sizeof(reg));
-	if (rc)
-		return rc;
-
-	rc = fsi_device_read(dev, FSI_MAEB, &reg, sizeof(reg));
-	if (rc)
-		return rc;
-
-	reg = cpu_to_be32(FSI_MRESP_RST_ALL_MASTER | FSI_MRESP_RST_ALL_LINK);
-	rc = fsi_device_write(dev, FSI_MRESP0, &reg, sizeof(reg));
-	if (rc)
-		return rc;
-
-	rc = fsi_device_read(dev, FSI_MLEVP0, &reg, sizeof(reg));
-	if (rc)
-		return rc;
-
-	/* Reset the master bridge */
-	reg = cpu_to_be32(FSI_MRESB_RST_GEN);
-	rc = fsi_device_write(dev, FSI_MRESB0, &reg, sizeof(reg));
-	if (rc)
-		return rc;
-
-	reg = cpu_to_be32(FSI_MRESB_RST_ERR);
-	return fsi_device_write(dev, FSI_MRESB0, &reg, sizeof(reg));
-}
-
 static int hub_master_probe(struct device *dev)
 {
+	struct regmap_config hub_master_regmap_config;
 	struct fsi_device *fsi_dev = to_fsi_dev(dev);
 	struct fsi_master_hub *hub;
+	struct regmap *map;
 	uint32_t reg, links;
-	__be32 __reg;
 	int rc;
 
-	rc = fsi_device_read(fsi_dev, FSI_MVER, &__reg, sizeof(__reg));
+	fsi_master_regmap_config(&hub_master_regmap_config);
+	hub_master_regmap_config.reg_base = fsi_dev->addr;
+	map = regmap_init_fsi(fsi_dev, &hub_master_regmap_config);
+	if (IS_ERR(map))
+		return PTR_ERR(map);
+
+	rc = regmap_read(map, FSI_MVER, &reg);
 	if (rc)
-		return rc;
+		goto err_regmap;
 
-	reg = be32_to_cpu(__reg);
 	links = (reg >> 8) & 0xff;
 	dev_dbg(dev, "hub version %08x (%d links)\n", reg, links);
 
@@ -213,7 +111,7 @@ static int hub_master_probe(struct device *dev)
 			FSI_HUB_LINK_SIZE * links);
 	if (rc) {
 		dev_err(dev, "can't claim slave address range for links");
-		return rc;
+		goto err_regmap;
 	}
 
 	hub = kzalloc(sizeof(*hub), GFP_KERNEL);
@@ -229,22 +127,24 @@ static int hub_master_probe(struct device *dev)
 	hub->master.dev.parent = dev;
 	hub->master.dev.release = hub_master_release;
 	hub->master.dev.of_node = of_node_get(dev_of_node(dev));
+	hub->master.map = map;
 
 	hub->master.idx = fsi_dev->slave->link + 1;
 	hub->master.n_links = links;
-	hub->master.flags = FSI_MASTER_FLAG_NO_BREAK_SID;
+	hub->master.flags = FSI_MASTER_FLAG_NO_BREAK_SID | FSI_MASTER_FLAG_INTERRUPT;
 	hub->master.read = hub_master_read;
 	hub->master.write = hub_master_write;
 	hub->master.send_break = hub_master_break;
-	hub->master.link_enable = hub_master_link_enable;
 
 	dev_set_drvdata(dev, hub);
 
-	hub_master_init(hub);
+	rc = fsi_master_init(&hub->master, fsi_dev->slave->master->clock_frequency);
+	if (rc)
+		goto err_free;
 
 	rc = fsi_master_register(&hub->master);
 	if (rc)
-		goto err_release;
+		goto err_free;
 
 	/* At this point, fsi_master_register performs the device_initialize(),
 	 * and holds the sole reference on master.dev. This means the device
@@ -256,9 +156,13 @@ static int hub_master_probe(struct device *dev)
 	get_device(&hub->master.dev);
 	return 0;
 
+err_free:
+	kfree(hub);
 err_release:
 	fsi_slave_release_range(fsi_dev->slave, FSI_HUB_LINK_OFFSET,
 			FSI_HUB_LINK_SIZE * links);
+err_regmap:
+	regmap_exit(map);
 	return rc;
 }
 
-- 
2.39.3

