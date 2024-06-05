From: Eddie James <eajames@linux.ibm.com>
Date: Wed,  5 Jun 2024 16:22:35 -0500
Subject: [PATCH v4 03/40] fsi: Fix slave addressing after break command
In-Reply-To: <20240605212312.349188-1-eajames@linux.ibm.com>
References: <20240605212312.349188-1-eajames@linux.ibm.com>
Message-ID: <20240605212312.349188-4-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

After a break command, the slave ID is set to 0x3, which means the
FSI driver should use that ID when communicating with the slave, until
SMODE is programmed with the new ID (forced to 0 for 23 bit addressing in
the current implementation). This worked previously due to a feature of
newer FSI slaves that don't enforce this requirement. Since hub masters
cannot address non-zero slave IDs, disable this behavior for slaves off
hub masters.

Fixes: 2b545cd8e1b2 ("drivers/fsi: Implement slave initialisation")
Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-core.c       | 20 ++++++++++----------
 drivers/fsi/fsi-master-hub.c |  1 +
 drivers/fsi/fsi-master.h     |  1 +
 drivers/fsi/fsi-slave.h      |  1 +
 4 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index 7bf0c96fc0172..e8dbf5e95c234 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -217,7 +217,7 @@ static uint32_t fsi_slave_smode(int id, u8 t_senddly, u8 t_echodly)
 		| fsi_smode_lbcrr(0x8);
 }
 
-static int fsi_slave_set_smode(struct fsi_slave *slave)
+static int fsi_slave_set_smode(struct fsi_slave *slave, uint8_t id)
 {
 	uint32_t smode;
 	__be32 data;
@@ -228,8 +228,7 @@ static int fsi_slave_set_smode(struct fsi_slave *slave)
 	smode = fsi_slave_smode(slave->id, slave->t_send_delay, slave->t_echo_delay);
 	data = cpu_to_be32(smode);
 
-	return fsi_master_write(slave->master, slave->link, slave->id,
-				FSI_SLAVE_BASE + FSI_SMODE,
+	return fsi_master_write(slave->master, slave->link, id, FSI_SLAVE_BASE + FSI_SMODE,
 				&data, sizeof(data));
 }
 
@@ -281,7 +280,7 @@ static int fsi_slave_handle_error(struct fsi_slave *slave, bool write,
 	slave->t_send_delay = send_delay;
 	slave->t_echo_delay = echo_delay;
 
-	rc = fsi_slave_set_smode(slave);
+	rc = fsi_slave_set_smode(slave, FSI_SMODE_SID_BREAK);
 	if (rc)
 		return rc;
 
@@ -773,7 +772,7 @@ static ssize_t slave_send_echo_store(struct device *dev,
 	slave->t_send_delay = val;
 	slave->t_echo_delay = val;
 
-	rc = fsi_slave_set_smode(slave);
+	rc = fsi_slave_set_smode(slave, slave->id);
 	if (rc < 0)
 		return rc;
 	if (master->link_config)
@@ -945,6 +944,8 @@ EXPORT_SYMBOL_GPL(fsi_free_minor);
 
 static int fsi_slave_init(struct fsi_master *master, int link, uint8_t id)
 {
+	const uint8_t break_id = (master->flags & FSI_MASTER_FLAG_NO_BREAK_SID) ? 0 :
+		FSI_SMODE_SID_BREAK;
 	uint32_t cfam_id;
 	struct fsi_slave *slave;
 	uint8_t crc;
@@ -957,7 +958,7 @@ static int fsi_slave_init(struct fsi_master *master, int link, uint8_t id)
 	if (id != 0)
 		return -EINVAL;
 
-	rc = fsi_master_read(master, link, id, 0, &data, sizeof(data));
+	rc = fsi_master_read(master, link, break_id, 0, &data, sizeof(data));
 	if (rc) {
 		dev_dbg(&master->dev, "can't read slave %02x:%02x %d\n",
 				link, id, rc);
@@ -981,9 +982,8 @@ static int fsi_slave_init(struct fsi_master *master, int link, uint8_t id)
 	 */
 	if (master->flags & FSI_MASTER_FLAG_SWCLOCK) {
 		llmode = cpu_to_be32(FSI_LLMODE_ASYNC);
-		rc = fsi_master_write(master, link, id,
-				FSI_SLAVE_BASE + FSI_LLMODE,
-				&llmode, sizeof(llmode));
+		rc = fsi_master_write(master, link, break_id, FSI_SLAVE_BASE + FSI_LLMODE, &llmode,
+				      sizeof(llmode));
 		if (rc)
 			dev_warn(&master->dev,
 				"can't set llmode on slave:%02x:%02x %d\n",
@@ -1028,7 +1028,7 @@ static int fsi_slave_init(struct fsi_master *master, int link, uint8_t id)
 			 "can't set slbus on slave:%02x:%02x %d\n", link, id,
 			 rc);
 
-	rc = fsi_slave_set_smode(slave);
+	rc = fsi_slave_set_smode(slave, break_id);
 	if (rc) {
 		dev_warn(&master->dev,
 				"can't set smode on slave:%02x:%02x %d\n",
diff --git a/drivers/fsi/fsi-master-hub.c b/drivers/fsi/fsi-master-hub.c
index 36da643b32018..eea8649fee74d 100644
--- a/drivers/fsi/fsi-master-hub.c
+++ b/drivers/fsi/fsi-master-hub.c
@@ -232,6 +232,7 @@ static int hub_master_probe(struct device *dev)
 
 	hub->master.idx = fsi_dev->slave->link + 1;
 	hub->master.n_links = links;
+	hub->master.flags = FSI_MASTER_FLAG_NO_BREAK_SID;
 	hub->master.read = hub_master_read;
 	hub->master.write = hub_master_write;
 	hub->master.send_break = hub_master_break;
diff --git a/drivers/fsi/fsi-master.h b/drivers/fsi/fsi-master.h
index 967622c1cabf7..a0d7ad0f0f7cc 100644
--- a/drivers/fsi/fsi-master.h
+++ b/drivers/fsi/fsi-master.h
@@ -111,6 +111,7 @@
 
 /* fsi-master definition and flags */
 #define FSI_MASTER_FLAG_SWCLOCK		0x1
+#define FSI_MASTER_FLAG_NO_BREAK_SID	0x2
 
 /*
  * Structures and function prototypes
diff --git a/drivers/fsi/fsi-slave.h b/drivers/fsi/fsi-slave.h
index dba65bd4e083f..f6cca04131a92 100644
--- a/drivers/fsi/fsi-slave.h
+++ b/drivers/fsi/fsi-slave.h
@@ -39,6 +39,7 @@
 #define FSI_SMODE_ECRC		0x20000000	/* Hw CRC check */
 #define FSI_SMODE_SID_SHIFT	24		/* ID shift */
 #define FSI_SMODE_SID_MASK	3		/* ID Mask */
+#define FSI_SMODE_SID_BREAK	3		/* ID after break command */
 #define FSI_SMODE_ED_SHIFT	20		/* Echo delay shift */
 #define FSI_SMODE_ED_MASK	0xf		/* Echo delay mask */
 #define FSI_SMODE_SD_SHIFT	16		/* Send delay shift */
-- 
2.39.3

