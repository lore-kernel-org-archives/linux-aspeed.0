From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 27 Jun 2018 09:20:56 +1000
Subject: [PATCH 01/14] devres: Add devm_of_iomap()
In-Reply-To: <20180626232109.10944-1-benh@kernel.crashing.org>
References: <20180626232109.10944-1-benh@kernel.crashing.org>
Message-ID: <20180626232109.10944-2-benh@kernel.crashing.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

There are still quite a few cases where a device might want
to get to a different node of the device-tree, obtain the
resources and map them.

We have of_iomap() and of_io_request_and_map() but they both
have shortcomings, such as not returning the size of the
resource found (which can be useful) and not being "managed".

This adds a devm_of_iomap() that provides all of these and
should probably replace uses of the above in most drivers.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 include/linux/device.h |  4 ++++
 lib/devres.c           | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index 477956990f5e..96249d790374 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -688,6 +688,10 @@ extern void devm_free_pages(struct device *dev, unsigned long addr);
 
 void __iomem *devm_ioremap_resource(struct device *dev, struct resource *res);
 
+void __iomem *devm_of_iomap(struct device *dev,
+			    struct device_node *node, int index,
+			    resource_size_t *size);
+
 /* allows to add/remove a custom action to devres stack */
 int devm_add_action(struct device *dev, void (*action)(void *), void *data);
 void devm_remove_action(struct device *dev, void (*action)(void *), void *data);
diff --git a/lib/devres.c b/lib/devres.c
index 5bec1120b392..faccf1a037d0 100644
--- a/lib/devres.c
+++ b/lib/devres.c
@@ -4,6 +4,7 @@
 #include <linux/io.h>
 #include <linux/gfp.h>
 #include <linux/export.h>
+#include <linux/of_address.h>
 
 enum devm_ioremap_type {
 	DEVM_IOREMAP = 0,
@@ -162,6 +163,41 @@ void __iomem *devm_ioremap_resource(struct device *dev, struct resource *res)
 }
 EXPORT_SYMBOL(devm_ioremap_resource);
 
+/*
+ * devm_of_iomap - Requests a resource and maps the memory mapped IO
+ *		   for a given device_node managed by a given device
+ *
+ * Checks that a resource is a valid memory region, requests the memory
+ * region and ioremaps it. All operations are managed and will be undone
+ * on driver detach of the device.
+ *
+ * This is to be used when a device requests/maps resources described
+ * by other device tree nodes (children or otherwise).
+ *
+ * @dev:	The device "managing" the resource
+ * @node:       The device-tree node where the resource resides
+ * @index:	index of the MMIO range in the "reg" property
+ * @size:	Returns the size of the resource (pass NULL if not needed)
+ * Returns a pointer to the requested and mapped memory or an ERR_PTR() encoded
+ * error code on failure. Usage example:
+ *
+ *	base = devm_of_iomap(&pdev->dev, node, 0, NULL);
+ *	if (IS_ERR(base))
+ *		return PTR_ERR(base);
+ */
+void __iomem *devm_of_iomap(struct device *dev, struct device_node *node, int index,
+			    resource_size_t *size)
+{
+	struct resource res;
+
+	if (of_address_to_resource(node, index, &res))
+		return IOMEM_ERR_PTR(-EINVAL);
+	if (size)
+		*size = resource_size(&res);
+	return devm_ioremap_resource(dev, &res);
+}
+EXPORT_SYMBOL(devm_of_iomap);
+
 #ifdef CONFIG_HAS_IOPORT_MAP
 /*
  * Generic iomap devres
-- 
2.17.1

