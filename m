From: Eddie James <eajames@linux.ibm.com>
Date: Wed, 22 Mar 2023 09:03:45 -0500
Subject: [PATCH v3 1/4] eeprom: ee1004: Enable devices on multiple busses
In-Reply-To: <20230322140348.569397-1-eajames@linux.ibm.com>
References: <20230322140348.569397-1-eajames@linux.ibm.com>
Message-ID: <20230322140348.569397-2-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The driver previously prevented probing devices on more than one
bus due to locking constraints with the special page addresses. This
constraint can be removed by allocating a reference-counted bus
structure containing the lock, rather than using global variables.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
Changes since v2:
 - Remove of_device.h include

 drivers/misc/eeprom/ee1004.c | 174 +++++++++++++++++++++--------------
 1 file changed, 105 insertions(+), 69 deletions(-)

diff --git a/drivers/misc/eeprom/ee1004.c b/drivers/misc/eeprom/ee1004.c
index c8c6deb7ed89..0aed5760e370 100644
--- a/drivers/misc/eeprom/ee1004.c
+++ b/drivers/misc/eeprom/ee1004.c
@@ -9,9 +9,11 @@
  * Copyright (C) 2008 Wolfram Sang, Pengutronix
  */
 
+#include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/list.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
@@ -31,20 +33,24 @@
  * over performance.
  */
 
-#define EE1004_ADDR_SET_PAGE		0x36
+#define EE1004_ADDR_SET_PAGE0		0x36
+#define EE1004_ADDR_SET_PAGE1		0x37
 #define EE1004_NUM_PAGES		2
 #define EE1004_PAGE_SIZE		256
 #define EE1004_PAGE_SHIFT		8
 #define EE1004_EEPROM_SIZE		(EE1004_PAGE_SIZE * EE1004_NUM_PAGES)
 
-/*
- * Mutex protects ee1004_set_page and ee1004_dev_count, and must be held
- * from page selection to end of read.
- */
-static DEFINE_MUTEX(ee1004_bus_lock);
-static struct i2c_client *ee1004_set_page[EE1004_NUM_PAGES];
-static unsigned int ee1004_dev_count;
-static int ee1004_current_page;
+struct ee1004_bus {
+	struct kref kref;
+	struct list_head list;
+	struct mutex lock;
+	struct i2c_adapter *adapter;
+	struct i2c_client *set_page_clients[EE1004_NUM_PAGES];
+	int page;
+};
+
+static LIST_HEAD(ee1004_busses);
+static DEFINE_MUTEX(ee1004_busses_lock);
 
 static const struct i2c_device_id ee1004_ids[] = {
 	{ "ee1004", 0 },
@@ -54,11 +60,11 @@ MODULE_DEVICE_TABLE(i2c, ee1004_ids);
 
 /*-------------------------------------------------------------------------*/
 
-static int ee1004_get_current_page(void)
+static int ee1004_get_current_page(struct ee1004_bus *bus)
 {
 	int err;
 
-	err = i2c_smbus_read_byte(ee1004_set_page[0]);
+	err = i2c_smbus_read_byte(bus->set_page_clients[0]);
 	if (err == -ENXIO) {
 		/* Nack means page 1 is selected */
 		return 1;
@@ -72,33 +78,30 @@ static int ee1004_get_current_page(void)
 	return 0;
 }
 
-static int ee1004_set_current_page(struct device *dev, int page)
+static int ee1004_set_current_page(struct ee1004_bus *bus, int page)
 {
 	int ret;
 
-	if (page == ee1004_current_page)
+	if (page == bus->page)
 		return 0;
 
 	/* Data is ignored */
-	ret = i2c_smbus_write_byte(ee1004_set_page[page], 0x00);
+	ret = i2c_smbus_write_byte(bus->set_page_clients[page], 0x00);
+
 	/*
 	 * Don't give up just yet. Some memory modules will select the page
 	 * but not ack the command. Check which page is selected now.
 	 */
-	if (ret == -ENXIO && ee1004_get_current_page() == page)
+	if (ret == -ENXIO && ee1004_get_current_page(bus) == page)
 		ret = 0;
-	if (ret < 0) {
-		dev_err(dev, "Failed to select page %d (%d)\n", page, ret);
+	if (ret < 0)
 		return ret;
-	}
-
-	dev_dbg(dev, "Selected page %d\n", page);
-	ee1004_current_page = page;
 
+	bus->page = page;
 	return 0;
 }
 
-static ssize_t ee1004_eeprom_read(struct i2c_client *client, char *buf,
+static ssize_t ee1004_eeprom_read(struct i2c_client *client, struct ee1004_bus *bus, char *buf,
 				  unsigned int offset, size_t count)
 {
 	int status, page;
@@ -106,9 +109,11 @@ static ssize_t ee1004_eeprom_read(struct i2c_client *client, char *buf,
 	page = offset >> EE1004_PAGE_SHIFT;
 	offset &= (1 << EE1004_PAGE_SHIFT) - 1;
 
-	status = ee1004_set_current_page(&client->dev, page);
-	if (status)
+	status = ee1004_set_current_page(bus, page);
+	if (status) {
+		dev_err(&client->dev, "Failed to select page %d (%d)\n", page, status);
 		return status;
+	}
 
 	/* Can't cross page boundaries */
 	if (offset + count > EE1004_PAGE_SIZE)
@@ -125,6 +130,7 @@ static ssize_t eeprom_read(struct file *filp, struct kobject *kobj,
 			   char *buf, loff_t off, size_t count)
 {
 	struct i2c_client *client = kobj_to_i2c_client(kobj);
+	struct ee1004_bus *bus = i2c_get_clientdata(client);
 	size_t requested = count;
 	int ret = 0;
 
@@ -132,10 +138,10 @@ static ssize_t eeprom_read(struct file *filp, struct kobject *kobj,
 	 * Read data from chip, protecting against concurrent access to
 	 * other EE1004 SPD EEPROMs on the same adapter.
 	 */
-	mutex_lock(&ee1004_bus_lock);
+	mutex_lock(&bus->lock);
 
 	while (count) {
-		ret = ee1004_eeprom_read(client, buf, off, count);
+		ret = ee1004_eeprom_read(client, bus, buf, off, count);
 		if (ret < 0)
 			goto out;
 
@@ -144,7 +150,7 @@ static ssize_t eeprom_read(struct file *filp, struct kobject *kobj,
 		count -= ret;
 	}
 out:
-	mutex_unlock(&ee1004_bus_lock);
+	mutex_unlock(&bus->lock);
 
 	return ret < 0 ? ret : requested;
 }
@@ -158,18 +164,56 @@ static struct bin_attribute *ee1004_attrs[] = {
 
 BIN_ATTRIBUTE_GROUPS(ee1004);
 
-static void ee1004_cleanup(int idx)
+static void ee1004_bus_unregister(struct ee1004_bus *bus)
 {
-	if (--ee1004_dev_count == 0)
-		while (--idx >= 0) {
-			i2c_unregister_device(ee1004_set_page[idx]);
-			ee1004_set_page[idx] = NULL;
-		}
+	i2c_unregister_device(bus->set_page_clients[1]);
+	i2c_unregister_device(bus->set_page_clients[0]);
+}
+
+static void ee1004_bus_release(struct kref *kref)
+{
+	struct ee1004_bus *bus = container_of(kref, struct ee1004_bus, kref);
+
+	ee1004_bus_unregister(bus);
+
+	mutex_lock(&ee1004_busses_lock);
+	list_del(&bus->list);
+	mutex_unlock(&ee1004_busses_lock);
+
+	kfree(bus);
+}
+
+static int ee1004_bus_initialize(struct ee1004_bus *bus, struct i2c_adapter *adapter)
+{
+	bus->set_page_clients[0] = i2c_new_dummy_device(adapter, EE1004_ADDR_SET_PAGE0);
+	if (IS_ERR(bus->set_page_clients[0]))
+		return PTR_ERR(bus->set_page_clients[0]);
+
+	bus->set_page_clients[1] = i2c_new_dummy_device(adapter, EE1004_ADDR_SET_PAGE1);
+	if (IS_ERR(bus->set_page_clients[1])) {
+		i2c_unregister_device(bus->set_page_clients[0]);
+		return PTR_ERR(bus->set_page_clients[1]);
+	}
+
+	bus->page = ee1004_get_current_page(bus);
+	if (bus->page < 0) {
+		ee1004_bus_unregister(bus);
+		return bus->page;
+	}
+
+	kref_init(&bus->kref);
+	list_add(&bus->list, &ee1004_busses);
+	mutex_init(&bus->lock);
+	bus->adapter = adapter;
+
+	return 0;
 }
 
 static int ee1004_probe(struct i2c_client *client)
 {
-	int err, cnr = 0;
+	struct ee1004_bus *bus;
+	bool found = false;
+	int rc = 0;
 
 	/* Make sure we can operate on this adapter */
 	if (!i2c_check_functionality(client->adapter,
@@ -178,53 +222,45 @@ static int ee1004_probe(struct i2c_client *client)
 				     I2C_FUNC_SMBUS_BYTE | I2C_FUNC_SMBUS_READ_BYTE_DATA))
 		return -EPFNOSUPPORT;
 
-	/* Use 2 dummy devices for page select command */
-	mutex_lock(&ee1004_bus_lock);
-	if (++ee1004_dev_count == 1) {
-		for (cnr = 0; cnr < EE1004_NUM_PAGES; cnr++) {
-			struct i2c_client *cl;
-
-			cl = i2c_new_dummy_device(client->adapter, EE1004_ADDR_SET_PAGE + cnr);
-			if (IS_ERR(cl)) {
-				err = PTR_ERR(cl);
-				goto err_clients;
-			}
-			ee1004_set_page[cnr] = cl;
+	mutex_lock(&ee1004_busses_lock);
+	list_for_each_entry(bus, &ee1004_busses, list) {
+		if (bus->adapter == client->adapter) {
+			kref_get(&bus->kref);
+			found = true;
+			break;
+		}
+	}
+
+	if (!found) {
+		bus = kzalloc(sizeof(*bus), GFP_KERNEL);
+		if (!bus) {
+			rc = -ENOMEM;
+			goto unlock;
 		}
 
-		/* Remember current page to avoid unneeded page select */
-		err = ee1004_get_current_page();
-		if (err < 0)
-			goto err_clients;
-		dev_dbg(&client->dev, "Currently selected page: %d\n", err);
-		ee1004_current_page = err;
-	} else if (client->adapter != ee1004_set_page[0]->adapter) {
-		dev_err(&client->dev,
-			"Driver only supports devices on a single I2C bus\n");
-		err = -EOPNOTSUPP;
-		goto err_clients;
+		rc = ee1004_bus_initialize(bus, client->adapter);
+		if (rc) {
+			kfree(bus);
+			goto unlock;
+		}
 	}
-	mutex_unlock(&ee1004_bus_lock);
+
+	i2c_set_clientdata(client, bus);
 
 	dev_info(&client->dev,
 		 "%u byte EE1004-compliant SPD EEPROM, read-only\n",
 		 EE1004_EEPROM_SIZE);
 
-	return 0;
-
- err_clients:
-	ee1004_cleanup(cnr);
-	mutex_unlock(&ee1004_bus_lock);
-
-	return err;
+unlock:
+	mutex_unlock(&ee1004_busses_lock);
+	return rc;
 }
 
 static void ee1004_remove(struct i2c_client *client)
 {
-	/* Remove page select clients if this is the last device */
-	mutex_lock(&ee1004_bus_lock);
-	ee1004_cleanup(EE1004_NUM_PAGES);
-	mutex_unlock(&ee1004_bus_lock);
+	struct ee1004_bus *bus = i2c_get_clientdata(client);
+
+	kref_put(&bus->kref, ee1004_bus_release);
 }
 
 /*-------------------------------------------------------------------------*/
-- 
2.31.1

