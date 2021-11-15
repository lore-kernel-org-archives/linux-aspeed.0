From: Iwona Winiarska <iwona.winiarska@intel.com>
Date: Mon, 15 Nov 2021 19:25:45 +0100
Subject: [PATCH v3 06/13] peci: Add device detection
In-Reply-To: <20211115182552.3830849-1-iwona.winiarska@intel.com>
References: <20211115182552.3830849-1-iwona.winiarska@intel.com>
Message-ID: <20211115182552.3830849-7-iwona.winiarska@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Since PECI devices are discoverable, we can dynamically detect devices
that are actually available in the system.

This change complements the earlier implementation by rescanning PECI
bus to detect available devices. For this purpose, it also introduces the
minimal API for PECI requests.

Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/peci/Makefile   |   2 +-
 drivers/peci/core.c     |  33 ++++++++++++
 drivers/peci/device.c   | 117 ++++++++++++++++++++++++++++++++++++++++
 drivers/peci/internal.h |  14 +++++
 drivers/peci/request.c  |  55 +++++++++++++++++++
 5 files changed, 220 insertions(+), 1 deletion(-)
 create mode 100644 drivers/peci/device.c
 create mode 100644 drivers/peci/request.c

diff --git a/drivers/peci/Makefile b/drivers/peci/Makefile
index 926d8df15cbd..c5f9d3fe21bb 100644
--- a/drivers/peci/Makefile
+++ b/drivers/peci/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 # Core functionality
-peci-y := core.o
+peci-y := core.o request.o device.o
 obj-$(CONFIG_PECI) += peci.o
 
 # Hardware specific bus drivers
diff --git a/drivers/peci/core.c b/drivers/peci/core.c
index 73ad0a47fa9d..c3361e6e043a 100644
--- a/drivers/peci/core.c
+++ b/drivers/peci/core.c
@@ -29,6 +29,20 @@ struct device_type peci_controller_type = {
 	.release	= peci_controller_dev_release,
 };
 
+static int peci_controller_scan_devices(struct peci_controller *controller)
+{
+	int ret;
+	u8 addr;
+
+	for (addr = PECI_BASE_ADDR; addr < PECI_BASE_ADDR + PECI_DEVICE_NUM_MAX; addr++) {
+		ret = peci_device_create(controller, addr);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static struct peci_controller *peci_controller_alloc(struct device *dev,
 						     struct peci_controller_ops *ops)
 {
@@ -64,10 +78,23 @@ static struct peci_controller *peci_controller_alloc(struct device *dev,
 	return ERR_PTR(ret);
 }
 
+static int unregister_child(struct device *dev, void *dummy)
+{
+	peci_device_destroy(to_peci_device(dev));
+
+	return 0;
+}
+
 static void unregister_controller(void *_controller)
 {
 	struct peci_controller *controller = _controller;
 
+	/*
+	 * Detach any active PECI devices. This can't fail, thus we do not
+	 * check the returned value.
+	 */
+	device_for_each_child_reverse(&controller->dev, NULL, unregister_child);
+
 	device_unregister(&controller->dev);
 
 	fwnode_handle_put(controller->dev.fwnode);
@@ -113,6 +140,12 @@ struct peci_controller *devm_peci_controller_add(struct device *dev,
 	if (ret)
 		return ERR_PTR(ret);
 
+	/*
+	 * Ignoring retval since failures during scan are non-critical for
+	 * controller itself.
+	 */
+	peci_controller_scan_devices(controller);
+
 	return controller;
 
 err_fwnode:
diff --git a/drivers/peci/device.c b/drivers/peci/device.c
new file mode 100644
index 000000000000..39f7f6409391
--- /dev/null
+++ b/drivers/peci/device.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (c) 2018-2021 Intel Corporation
+
+#include <linux/peci.h>
+#include <linux/slab.h>
+
+#include "internal.h"
+
+static int peci_detect(struct peci_controller *controller, u8 addr)
+{
+	/*
+	 * PECI Ping is a command encoded by tx_len = 0, rx_len = 0.
+	 * We expect correct Write FCS if the device at the target address
+	 * is able to respond.
+	 */
+	struct peci_request req = { 0 };
+	int ret;
+
+	mutex_lock(&controller->bus_lock);
+	ret = controller->ops->xfer(controller, addr, &req);
+	mutex_unlock(&controller->bus_lock);
+
+	return ret;
+}
+
+static bool peci_addr_valid(u8 addr)
+{
+	return addr >= PECI_BASE_ADDR && addr < PECI_BASE_ADDR + PECI_DEVICE_NUM_MAX;
+}
+
+static int peci_dev_exists(struct device *dev, void *data)
+{
+	struct peci_device *device = to_peci_device(dev);
+	u8 *addr = data;
+
+	if (device->addr == *addr)
+		return -EBUSY;
+
+	return 0;
+}
+
+int peci_device_create(struct peci_controller *controller, u8 addr)
+{
+	struct peci_device *device;
+	int ret;
+
+	if (!peci_addr_valid(addr))
+		return -EINVAL;
+
+	/* Check if we have already detected this device before. */
+	ret = device_for_each_child(&controller->dev, &addr, peci_dev_exists);
+	if (ret)
+		return 0;
+
+	ret = peci_detect(controller, addr);
+	if (ret) {
+		/*
+		 * Device not present or host state doesn't allow successful
+		 * detection at this time.
+		 */
+		if (ret == -EIO || ret == -ETIMEDOUT)
+			return 0;
+
+		return ret;
+	}
+
+	device = kzalloc(sizeof(*device), GFP_KERNEL);
+	if (!device)
+		return -ENOMEM;
+
+	device_initialize(&device->dev);
+
+	device->addr = addr;
+	device->dev.parent = &controller->dev;
+	device->dev.bus = &peci_bus_type;
+	device->dev.type = &peci_device_type;
+
+	ret = dev_set_name(&device->dev, "%d-%02x", controller->id, device->addr);
+	if (ret)
+		goto err_put;
+
+	ret = device_add(&device->dev);
+	if (ret)
+		goto err_put;
+
+	return 0;
+
+err_put:
+	put_device(&device->dev);
+
+	return ret;
+}
+
+void peci_device_destroy(struct peci_device *device)
+{
+	bool killed;
+
+	device_lock(&device->dev);
+	killed = kill_device(&device->dev);
+	device_unlock(&device->dev);
+
+	if (!killed)
+		return;
+
+	device_unregister(&device->dev);
+}
+
+static void peci_device_release(struct device *dev)
+{
+	struct peci_device *device = to_peci_device(dev);
+
+	kfree(device);
+}
+
+struct device_type peci_device_type = {
+	.release	= peci_device_release,
+};
diff --git a/drivers/peci/internal.h b/drivers/peci/internal.h
index 918dea745a86..57d11a902c5d 100644
--- a/drivers/peci/internal.h
+++ b/drivers/peci/internal.h
@@ -8,6 +8,20 @@
 #include <linux/types.h>
 
 struct peci_controller;
+struct peci_device;
+struct peci_request;
+
+/* PECI CPU address range 0x30-0x37 */
+#define PECI_BASE_ADDR		0x30
+#define PECI_DEVICE_NUM_MAX	8
+
+struct peci_request *peci_request_alloc(struct peci_device *device, u8 tx_len, u8 rx_len);
+void peci_request_free(struct peci_request *req);
+
+extern struct device_type peci_device_type;
+
+int peci_device_create(struct peci_controller *controller, u8 addr);
+void peci_device_destroy(struct peci_device *device);
 
 extern struct bus_type peci_bus_type;
 
diff --git a/drivers/peci/request.c b/drivers/peci/request.c
new file mode 100644
index 000000000000..7dee51c50dd2
--- /dev/null
+++ b/drivers/peci/request.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (c) 2021 Intel Corporation
+
+#include <linux/export.h>
+#include <linux/peci.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+#include "internal.h"
+
+/**
+ * peci_request_alloc() - allocate &struct peci_requests
+ * @device: PECI device to which request is going to be sent
+ * @tx_len: TX length
+ * @rx_len: RX length
+ *
+ * Return: A pointer to a newly allocated &struct peci_request on success or NULL otherwise.
+ */
+struct peci_request *peci_request_alloc(struct peci_device *device, u8 tx_len, u8 rx_len)
+{
+	struct peci_request *req;
+
+	/*
+	 * TX and RX buffers are fixed length members of peci_request, this is
+	 * just a warn for developers to make sure to expand the buffers (or
+	 * change the allocation method) if we go over the current limit.
+	 */
+	if (WARN_ON_ONCE(tx_len > PECI_REQUEST_MAX_BUF_SIZE || rx_len > PECI_REQUEST_MAX_BUF_SIZE))
+		return NULL;
+	/*
+	 * PECI controllers that we are using now don't support DMA, this
+	 * should be converted to DMA API once support for controllers that do
+	 * allow it is added to avoid an extra copy.
+	 */
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return NULL;
+
+	req->device = device;
+	req->tx.len = tx_len;
+	req->rx.len = rx_len;
+
+	return req;
+}
+EXPORT_SYMBOL_NS_GPL(peci_request_alloc, PECI);
+
+/**
+ * peci_request_free() - free peci_request
+ * @req: the PECI request to be freed
+ */
+void peci_request_free(struct peci_request *req)
+{
+	kfree(req);
+}
+EXPORT_SYMBOL_NS_GPL(peci_request_free, PECI);
-- 
2.31.1

