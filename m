From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 22 Jun 2018 14:37:56 +1000
Subject: [PATCH 2/2] fsi: Add support for device-tree provided chip IDs
In-Reply-To: <20180622043756.21158-1-benh@kernel.crashing.org>
References: <20180622043756.21158-1-benh@kernel.crashing.org>
Message-ID: <20180622043756.21158-2-benh@kernel.crashing.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

They get retrieved from the device-tree and exposed
as an attribute in sysfs

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/fsi/fsi-core.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index 1ae5be31b4bf..3fe36673cb21 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -80,6 +80,7 @@ struct fsi_slave {
 	struct fsi_master	*master;
 	int			id;
 	int			link;
+	int			chip_id;
 	uint32_t		size;	/* size of slave address space */
 	u8			t_send_delay;
 	u8			t_echo_delay;
@@ -723,6 +724,17 @@ static ssize_t slave_send_echo_store(struct device *dev,
 static DEVICE_ATTR(send_echo_delays, 0600,
 		   slave_send_echo_show, slave_send_echo_store);
 
+static ssize_t chip_id_show(struct device *dev,
+			    struct device_attribute *attr,
+			    char *buf)
+{
+	struct fsi_slave *slave = to_fsi_slave(dev);
+
+	return sprintf(buf, "%d\n", slave->chip_id);
+}
+
+static DEVICE_ATTR_RO(chip_id);
+
 static int fsi_slave_init(struct fsi_master *master, int link, uint8_t id)
 {
 	uint32_t chip_id;
@@ -786,6 +798,14 @@ static int fsi_slave_init(struct fsi_master *master, int link, uint8_t id)
 	slave->t_send_delay = 16;
 	slave->t_echo_delay = 16;
 
+	/* Get chip ID if any */
+	slave->chip_id = -1;
+	if (slave->dev.of_node) {
+		uint32_t prop;
+		if (!of_property_read_u32(slave->dev.of_node, "chip-id", &prop))
+			slave->chip_id = prop;
+
+	}
 	rc = fsi_slave_set_smode(slave);
 	if (rc) {
 		dev_warn(&master->dev,
@@ -820,6 +840,10 @@ static int fsi_slave_init(struct fsi_master *master, int link, uint8_t id)
 	if (rc)
 		dev_warn(&slave->dev, "failed to create delay attr: %d\n", rc);
 
+	rc = device_create_file(&slave->dev, &dev_attr_chip_id);
+	if (rc)
+		dev_warn(&slave->dev, "failed to create chip id: %d\n", rc);
+
 	rc = fsi_slave_scan(slave);
 	if (rc)
 		dev_dbg(&master->dev, "failed during slave scan with: %d\n",
-- 
2.17.1

