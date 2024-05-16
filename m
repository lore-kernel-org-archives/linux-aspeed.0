From: Eddie James <eajames@linux.ibm.com>
Date: Thu, 16 May 2024 13:18:56 -0500
Subject: [PATCH v3 29/40] i2c: fsi: Remove list structure of ports
In-Reply-To: <20240516181907.3468796-1-eajames@linux.ibm.com>
References: <20240516181907.3468796-1-eajames@linux.ibm.com>
Message-ID: <20240516181907.3468796-30-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Maintaining a list of ports is unnecessary since they can be managed
with the device resource framework.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/i2c/busses/i2c-fsi.c | 44 +++++++++---------------------------
 1 file changed, 11 insertions(+), 33 deletions(-)

diff --git a/drivers/i2c/busses/i2c-fsi.c b/drivers/i2c/busses/i2c-fsi.c
index 44aa750278100..f3b97bf88d0f9 100644
--- a/drivers/i2c/busses/i2c-fsi.c
+++ b/drivers/i2c/busses/i2c-fsi.c
@@ -19,7 +19,6 @@
 #include <linux/i2c.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
-#include <linux/list.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
@@ -148,14 +147,12 @@
 
 struct fsi_i2c_master {
 	struct fsi_device	*fsi;
-	struct list_head	ports;
 	struct mutex		lock;
 	u32			clock_div;
 	u8			fifo_size;
 };
 
 struct fsi_i2c_port {
-	struct list_head	list;
 	struct i2c_adapter	adapter;
 	struct fsi_i2c_master	*master;
 	u16			port;
@@ -327,7 +324,7 @@ static int fsi_i2c_read_fifo(struct fsi_i2c_port *port, struct i2c_msg *msg,
 
 static int fsi_i2c_get_scl(struct i2c_adapter *adap)
 {
-	struct fsi_i2c_port *port = adap->algo_data;
+	struct fsi_i2c_port *port = i2c_get_adapdata(adap);
 	u32 stat;
 
 	fsi_i2c_read_reg(port->master->fsi, I2C_FSI_STAT, &stat);
@@ -337,7 +334,7 @@ static int fsi_i2c_get_scl(struct i2c_adapter *adap)
 
 static void fsi_i2c_set_scl(struct i2c_adapter *adap, int val)
 {
-	struct fsi_i2c_port *port = adap->algo_data;
+	struct fsi_i2c_port *port = i2c_get_adapdata(adap);
 
 	if (val)
 		fsi_i2c_write_reg(port->master->fsi, I2C_FSI_SET_SCL, 0);
@@ -347,7 +344,7 @@ static void fsi_i2c_set_scl(struct i2c_adapter *adap, int val)
 
 static int fsi_i2c_get_sda(struct i2c_adapter *adap)
 {
-	struct fsi_i2c_port *port = adap->algo_data;
+	struct fsi_i2c_port *port = i2c_get_adapdata(adap);
 	u32 stat;
 
 	fsi_i2c_read_reg(port->master->fsi, I2C_FSI_STAT, &stat);
@@ -357,7 +354,7 @@ static int fsi_i2c_get_sda(struct i2c_adapter *adap)
 
 static void fsi_i2c_set_sda(struct i2c_adapter *adap, int val)
 {
-	struct fsi_i2c_port *port = adap->algo_data;
+	struct fsi_i2c_port *port = i2c_get_adapdata(adap);
 
 	if (val)
 		fsi_i2c_write_reg(port->master->fsi, I2C_FSI_SET_SDA, 0);
@@ -367,7 +364,7 @@ static void fsi_i2c_set_sda(struct i2c_adapter *adap, int val)
 
 static void fsi_i2c_prepare_recovery(struct i2c_adapter *adap)
 {
-	struct fsi_i2c_port *port = adap->algo_data;
+	struct fsi_i2c_port *port = i2c_get_adapdata(adap);
 	u32 mode;
 	int rc;
 
@@ -381,7 +378,7 @@ static void fsi_i2c_prepare_recovery(struct i2c_adapter *adap)
 
 static void fsi_i2c_unprepare_recovery(struct i2c_adapter *adap)
 {
-	struct fsi_i2c_port *port = adap->algo_data;
+	struct fsi_i2c_port *port = i2c_get_adapdata(adap);
 	u32 mode;
 	int rc;
 
@@ -594,7 +591,7 @@ static int fsi_i2c_wait(struct fsi_i2c_port *port, struct i2c_msg *msg,
 static int fsi_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 			int num)
 {
-	struct fsi_i2c_port *port = adap->algo_data;
+	struct fsi_i2c_port *port = i2c_get_adapdata(adap);
 	unsigned long start_time;
 	struct i2c_msg *msg;
 	int rc;
@@ -679,7 +676,6 @@ static int fsi_i2c_probe(struct device *dev)
 
 	mutex_init(&i2c->lock);
 	i2c->fsi = to_fsi_dev(dev);
-	INIT_LIST_HEAD(&i2c->ports);
 	i2c->clock_div = I2C_DEFAULT_CLK_DIV;
 
 	lbus = fsi_device_local_bus_frequency(i2c->fsi);
@@ -705,38 +701,30 @@ static int fsi_i2c_probe(struct device *dev)
 	ports = FIELD_GET(I2C_STAT_MAX_PORT, stat) + 1;
 	dev_dbg(dev, "I2C master has %d ports\n", ports);
 
-	for (port_no = 0; port_no < ports; port_no++) {
+	port = devm_kzalloc(dev, sizeof(*port) * ports, GFP_KERNEL);
+	for (port_no = 0; port_no < ports; port_no++, port++) {
 		np = fsi_i2c_find_port_of_node(dev->of_node, port_no);
 		if (!of_device_is_available(np))
 			continue;
 
-		port = kzalloc(sizeof(*port), GFP_KERNEL);
-		if (!port) {
-			of_node_put(np);
-			break;
-		}
-
 		port->master = i2c;
 		port->port = port_no;
 
+		i2c_set_adapdata(&port->adapter, port);
 		port->adapter.owner = THIS_MODULE;
 		port->adapter.dev.of_node = np;
 		port->adapter.dev.parent = dev;
 		port->adapter.algo = &fsi_i2c_algorithm;
 		port->adapter.bus_recovery_info = &fsi_i2c_bus_recovery_info;
-		port->adapter.algo_data = port;
 
 		snprintf(port->adapter.name, sizeof(port->adapter.name),
 			 "i2c_bus-%u", port_no);
 
-		rc = i2c_add_adapter(&port->adapter);
+		rc = devm_i2c_add_adapter(dev, &port->adapter);
 		if (rc < 0) {
 			dev_err(dev, "Failed to register adapter: %d\n", rc);
-			kfree(port);
 			continue;
 		}
-
-		list_add(&port->list, &i2c->ports);
 	}
 
 	dev_set_drvdata(dev, i2c);
@@ -745,16 +733,6 @@ static int fsi_i2c_probe(struct device *dev)
 
 static int fsi_i2c_remove(struct device *dev)
 {
-	struct fsi_i2c_master *i2c = dev_get_drvdata(dev);
-	struct fsi_i2c_port *port;
-	struct fsi_i2c_port *tmp;
-
-	list_for_each_entry_safe(port, tmp, &i2c->ports, list) {
-		list_del(&port->list);
-		i2c_del_adapter(&port->adapter);
-		kfree(port);
-	}
-
 	return 0;
 }
 
-- 
2.39.3

