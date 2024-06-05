From: Eddie James <eajames@linux.ibm.com>
Date: Wed,  5 Jun 2024 16:22:42 -0500
Subject: [PATCH v4 10/40] fsi: core: Add slave spinlock
In-Reply-To: <20240605212312.349188-1-eajames@linux.ibm.com>
References: <20240605212312.349188-1-eajames@linux.ibm.com>
Message-ID: <20240605212312.349188-11-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

FSI slave operations were not locked, meaning that during slave
error recovery operations, other slave accesses may take place,
resulting in incorrect recovery and additional errors. Make the
slave access and error recovery atomic with a spinlock. Don't
use a mutex for future interrupt handling support.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-core.c  | 7 +++++++
 drivers/fsi/fsi-slave.h | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index ce9762d1bd8b0..660f89b743235 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -304,6 +304,7 @@ static int fsi_slave_handle_error(struct fsi_slave *slave, bool write,
 int fsi_slave_read(struct fsi_slave *slave, uint32_t addr,
 			void *val, size_t size)
 {
+	unsigned long flags;
 	uint8_t id = slave->id;
 	int rc, err_rc, i;
 
@@ -311,6 +312,7 @@ int fsi_slave_read(struct fsi_slave *slave, uint32_t addr,
 	if (rc)
 		return rc;
 
+	spin_lock_irqsave(&slave->lock, flags);
 	for (i = 0; i < slave_retries; i++) {
 		rc = fsi_master_read(slave->master, slave->link,
 				id, addr, val, size);
@@ -321,6 +323,7 @@ int fsi_slave_read(struct fsi_slave *slave, uint32_t addr,
 		if (err_rc)
 			break;
 	}
+	spin_unlock_irqrestore(&slave->lock, flags);
 
 	return rc;
 }
@@ -329,6 +332,7 @@ EXPORT_SYMBOL_GPL(fsi_slave_read);
 int fsi_slave_write(struct fsi_slave *slave, uint32_t addr,
 			const void *val, size_t size)
 {
+	unsigned long flags;
 	uint8_t id = slave->id;
 	int rc, err_rc, i;
 
@@ -336,6 +340,7 @@ int fsi_slave_write(struct fsi_slave *slave, uint32_t addr,
 	if (rc)
 		return rc;
 
+	spin_lock_irqsave(&slave->lock, flags);
 	for (i = 0; i < slave_retries; i++) {
 		rc = fsi_master_write(slave->master, slave->link,
 				id, addr, val, size);
@@ -346,6 +351,7 @@ int fsi_slave_write(struct fsi_slave *slave, uint32_t addr,
 		if (err_rc)
 			break;
 	}
+	spin_unlock_irqrestore(&slave->lock, flags);
 
 	return rc;
 }
@@ -1007,6 +1013,7 @@ static int fsi_slave_init(struct fsi_master *master, int link, uint8_t id)
 	if (!slave)
 		return -ENOMEM;
 
+	spin_lock_init(&slave->lock);
 	dev_set_name(&slave->dev, "slave@%02x:%02x", link, id);
 	slave->dev.type = &cfam_type;
 	slave->dev.parent = &master->dev;
diff --git a/drivers/fsi/fsi-slave.h b/drivers/fsi/fsi-slave.h
index e9fd4be6f3760..0468ec1c60db2 100644
--- a/drivers/fsi/fsi-slave.h
+++ b/drivers/fsi/fsi-slave.h
@@ -6,6 +6,7 @@
 
 #include <linux/cdev.h>
 #include <linux/device.h>
+#include <linux/spinlock.h>
 
 #define FSI_SLAVE_BASE			0x800
 
@@ -107,6 +108,7 @@ struct fsi_slave {
 	struct device		dev;
 	struct fsi_master	*master;
 	struct cdev		cdev;
+	spinlock_t		lock;	/* atomic access and error recovery */
 	int			cdev_idx;
 	int			id;	/* FSI address */
 	int			link;	/* FSI link# */
-- 
2.39.3

