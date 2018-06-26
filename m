From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 27 Jun 2018 09:25:54 +1000
Subject: [PATCH 03/14] fsi: Add mechanism to set the tSendDelay and tEchoDelay
 values
In-Reply-To: <20180626232605.13420-1-benh@kernel.crashing.org>
References: <20180626232605.13420-1-benh@kernel.crashing.org>
Message-ID: <20180626232605.13420-4-benh@kernel.crashing.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Those values control the amount of "dummy" clocks between commands and
between a command and its response.

This adds a way to configure them from sysfs (to be later extended to
defaults in the device-tree). The default remains 16 (the HW default).

This is only supported if the backend supports the new link_config()
callback to configure the generation of those delays.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
---
 drivers/fsi/fsi-core.c   | 109 ++++++++++++++++++++++++++++++++-------
 drivers/fsi/fsi-master.h |   2 +
 2 files changed, 93 insertions(+), 18 deletions(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index 2f6f9b8c75e4..1ae5be31b4bf 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -81,6 +81,8 @@ struct fsi_slave {
 	int			id;
 	int			link;
 	uint32_t		size;	/* size of slave address space */
+	u8			t_send_delay;
+	u8			t_echo_delay;
 };
 
 #define to_fsi_master(d) container_of(d, struct fsi_master, dev)
@@ -239,15 +241,15 @@ static inline uint32_t fsi_smode_sid(int x)
 	return (x & FSI_SMODE_SID_MASK) << FSI_SMODE_SID_SHIFT;
 }
 
-static uint32_t fsi_slave_smode(int id)
+static uint32_t fsi_slave_smode(int id, u8 t_senddly, u8 t_echodly)
 {
 	return FSI_SMODE_WSC | FSI_SMODE_ECRC
 		| fsi_smode_sid(id)
-		| fsi_smode_echodly(0xf) | fsi_smode_senddly(0xf)
+		| fsi_smode_echodly(t_echodly - 1) | fsi_smode_senddly(t_senddly - 1)
 		| fsi_smode_lbcrr(0x8);
 }
 
-static int fsi_slave_set_smode(struct fsi_master *master, int link, int id)
+static int fsi_slave_set_smode(struct fsi_slave *slave)
 {
 	uint32_t smode;
 	__be32 data;
@@ -255,11 +257,12 @@ static int fsi_slave_set_smode(struct fsi_master *master, int link, int id)
 	/* set our smode register with the slave ID field to 0; this enables
 	 * extended slave addressing
 	 */
-	smode = fsi_slave_smode(id);
+	smode = fsi_slave_smode(slave->id, slave->t_send_delay, slave->t_echo_delay);
 	data = cpu_to_be32(smode);
 
-	return fsi_master_write(master, link, id, FSI_SLAVE_BASE + FSI_SMODE,
-			&data, sizeof(data));
+	return fsi_master_write(slave->master, slave->link, slave->id,
+				FSI_SLAVE_BASE + FSI_SMODE,
+				&data, sizeof(data));
 }
 
 static int fsi_slave_handle_error(struct fsi_slave *slave, bool write,
@@ -268,7 +271,7 @@ static int fsi_slave_handle_error(struct fsi_slave *slave, bool write,
 	struct fsi_master *master = slave->master;
 	int rc, link;
 	uint32_t reg;
-	uint8_t id;
+	uint8_t id, send_delay, echo_delay;
 
 	if (discard_errors)
 		return -1;
@@ -299,15 +302,26 @@ static int fsi_slave_handle_error(struct fsi_slave *slave, bool write,
 		}
 	}
 
+	send_delay = slave->t_send_delay;
+	echo_delay = slave->t_echo_delay;
+
 	/* getting serious, reset the slave via BREAK */
 	rc = fsi_master_break(master, link);
 	if (rc)
 		return rc;
 
-	rc = fsi_slave_set_smode(master, link, id);
+	slave->t_send_delay = send_delay;
+	slave->t_echo_delay = echo_delay;
+
+	rc = fsi_slave_set_smode(slave);
 	if (rc)
 		return rc;
 
+	if (master->link_config)
+		master->link_config(master, link,
+				    slave->t_send_delay,
+				    slave->t_echo_delay);
+
 	return fsi_slave_report_and_clear_errors(slave);
 }
 
@@ -665,6 +679,50 @@ static struct device_node *fsi_slave_find_of_node(struct fsi_master *master,
 	return NULL;
 }
 
+static ssize_t slave_send_echo_show(struct device *dev,
+				    struct device_attribute *attr,
+				    char *buf)
+{
+	struct fsi_slave *slave = to_fsi_slave(dev);
+
+	return sprintf(buf, "%u\n", slave->t_send_delay);
+}
+
+static ssize_t slave_send_echo_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct fsi_slave *slave = to_fsi_slave(dev);
+	struct fsi_master *master = slave->master;
+	unsigned long val;
+	int rc;
+
+	if (kstrtoul(buf, 0, &val) < 0)
+		return -EINVAL;
+
+	if (val < 1 || val > 16)
+		return -EINVAL;
+
+	if (!master->link_config)
+		return -ENXIO;
+
+	/* Current HW mandates that send and echo delay are identical */
+	slave->t_send_delay = val;
+	slave->t_echo_delay = val;
+
+	rc = fsi_slave_set_smode(slave);
+	if (rc < 0)
+		return rc;
+	if (master->link_config)
+		master->link_config(master, slave->link,
+				    slave->t_send_delay,
+				    slave->t_echo_delay);
+
+	return count;
+}
+
+static DEVICE_ATTR(send_echo_delays, 0600,
+		   slave_send_echo_show, slave_send_echo_store);
+
 static int fsi_slave_init(struct fsi_master *master, int link, uint8_t id)
 {
 	uint32_t chip_id;
@@ -697,14 +755,6 @@ static int fsi_slave_init(struct fsi_master *master, int link, uint8_t id)
 	dev_dbg(&master->dev, "fsi: found chip %08x at %02x:%02x:%02x\n",
 			chip_id, master->idx, link, id);
 
-	rc = fsi_slave_set_smode(master, link, id);
-	if (rc) {
-		dev_warn(&master->dev,
-				"can't set smode on slave:%02x:%02x %d\n",
-				link, id, rc);
-		return -ENODEV;
-	}
-
 	/* If we're behind a master that doesn't provide a self-running bus
 	 * clock, put the slave into async mode
 	 */
@@ -733,6 +783,21 @@ static int fsi_slave_init(struct fsi_master *master, int link, uint8_t id)
 	slave->link = link;
 	slave->id = id;
 	slave->size = FSI_SLAVE_SIZE_23b;
+	slave->t_send_delay = 16;
+	slave->t_echo_delay = 16;
+
+	rc = fsi_slave_set_smode(slave);
+	if (rc) {
+		dev_warn(&master->dev,
+				"can't set smode on slave:%02x:%02x %d\n",
+				link, id, rc);
+		kfree(slave);
+		return -ENODEV;
+	}
+	if (master->link_config)
+		master->link_config(master, link,
+				    slave->t_send_delay,
+				    slave->t_echo_delay);
 
 	dev_set_name(&slave->dev, "slave@%02x:%02x", link, id);
 	rc = device_register(&slave->dev);
@@ -751,6 +816,10 @@ static int fsi_slave_init(struct fsi_master *master, int link, uint8_t id)
 	if (rc)
 		dev_warn(&slave->dev, "failed to create term attr: %d\n", rc);
 
+	rc = device_create_file(&slave->dev, &dev_attr_send_echo_delays);
+	if (rc)
+		dev_warn(&slave->dev, "failed to create delay attr: %d\n", rc);
+
 	rc = fsi_slave_scan(slave);
 	if (rc)
 		dev_dbg(&master->dev, "failed during slave scan with: %d\n",
@@ -821,12 +890,16 @@ static int fsi_master_link_enable(struct fsi_master *master, int link)
  */
 static int fsi_master_break(struct fsi_master *master, int link)
 {
+	int rc = 0;
+
 	trace_fsi_master_break(master, link);
 
 	if (master->send_break)
-		return master->send_break(master, link);
+		rc = master->send_break(master, link);
+	if (master->link_config)
+		master->link_config(master, link, 16, 16);
 
-	return 0;
+	return rc;
 }
 
 static int fsi_master_scan(struct fsi_master *master)
diff --git a/drivers/fsi/fsi-master.h b/drivers/fsi/fsi-master.h
index ee0b46086026..7d619c68ab9b 100644
--- a/drivers/fsi/fsi-master.h
+++ b/drivers/fsi/fsi-master.h
@@ -33,6 +33,8 @@ struct fsi_master {
 	int		(*term)(struct fsi_master *, int link, uint8_t id);
 	int		(*send_break)(struct fsi_master *, int link);
 	int		(*link_enable)(struct fsi_master *, int link);
+	int		(*link_config)(struct fsi_master *, int link,
+				       u8 t_send_delay, u8 t_echo_delay);
 };
 
 #define dev_to_fsi_master(d) container_of(d, struct fsi_master, dev)
-- 
2.17.1

