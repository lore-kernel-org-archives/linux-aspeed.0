From: Eddie James <eajames@linux.ibm.com>
Date: Thu, 16 May 2024 13:18:50 -0500
Subject: [PATCH v3 23/40] fsi: core: Add interrupt support
In-Reply-To: <20240516181907.3468796-1-eajames@linux.ibm.com>
References: <20240516181907.3468796-1-eajames@linux.ibm.com>
Message-ID: <20240516181907.3468796-24-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add an irq chip to the FSI master structure to control slave interrupt
masking. Add a function to request an IRQ from the FSI device.
The FSI master IRQ mapping is based on the FSI device engine type and
slave link.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
Changes since v2:
 - Remove slave interrupt handler since it's not used yet

 drivers/fsi/fsi-core.c     | 159 +++++++++++++++++++++++++++++++++++++
 drivers/fsi/fsi-master.h   |   9 +++
 include/linux/fsi.h        |   2 +
 include/trace/events/fsi.h |  60 ++++++++++++++
 4 files changed, 230 insertions(+)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index 8b402149acbe9..ae65d87d4b13e 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -14,10 +14,12 @@
 #include <linux/device.h>
 #include <linux/fsi.h>
 #include <linux/idr.h>
+#include <linux/irqdomain.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
+#include <linux/of_irq.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/bitops.h>
@@ -109,6 +111,67 @@ int fsi_device_peek(struct fsi_device *dev, void *val)
 
 	return fsi_slave_read(dev->slave, addr, val, sizeof(uint32_t));
 }
+EXPORT_SYMBOL_GPL(fsi_device_peek);
+
+static int fsi_request_irq(struct fsi_slave *slave, irq_handler_t handler, void *data,
+			   unsigned int engine_irq, struct device *dev)
+{
+	struct device_node *parent = of_node_get(slave->master->dev.of_node);
+	struct irq_fwspec fwspec;
+	unsigned int irq;
+
+	/*
+	 * FSI devices can only report interrupts to their own master, so if the master
+	 * isn't an interrupt controller, don't try and map an irq.
+	 */
+	if (!of_get_property(parent, "#interrupt-cells", NULL)) {
+		of_node_put(parent);
+		return -EINVAL;
+	}
+
+	fwspec.fwnode = of_node_to_fwnode(parent);
+	fwspec.param_count = 1;
+	fwspec.param[0] = engine_irq + (slave->link * FSI_IRQ_COUNT);
+	irq = irq_create_fwspec_mapping(&fwspec);
+	if (!irq)
+		return -EINVAL;
+
+	return devm_request_irq(dev, irq, handler, 0, dev_name(dev), data);
+}
+
+int fsi_device_request_irq(struct fsi_device *dev, irq_handler_t handler, void *data)
+{
+	unsigned int engine_irq;
+
+	switch (dev->engine_type) {
+	case 0x4:	// shift
+		engine_irq = 1;
+		break;
+	case 0x5:	// scom
+		engine_irq = 2;
+		break;
+	case 0x6:	// scratchpad
+		engine_irq = 3;
+		break;
+	case 0x7:	// i2cm
+		engine_irq = 4;
+		break;
+	case 0x20:	// mbox
+		engine_irq = 7;
+		break;
+	case 0x22:	// sbefifo
+		engine_irq = 6;
+		break;
+	case 0x23:	// spim
+		engine_irq = 5;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return fsi_request_irq(dev->slave, handler, data, engine_irq, &dev->dev);
+}
+EXPORT_SYMBOL_GPL(fsi_device_request_irq);
 
 unsigned long fsi_device_local_bus_frequency(struct fsi_device *dev)
 {
@@ -1467,6 +1530,99 @@ void fsi_master_regmap_config(struct regmap_config *config)
 }
 EXPORT_SYMBOL_GPL(fsi_master_regmap_config);
 
+int fsi_master_irq(struct fsi_master *master, struct irq_domain *irq_domain, unsigned int link)
+{
+	struct irq_desc *downstream = irq_resolve_mapping(irq_domain, (link * FSI_IRQ_COUNT) + 8);
+	unsigned long size = FSI_SI1S_SLAVE_BIT + 1;
+	unsigned long bit = FSI_SI1S_MBOX_BIT;
+	unsigned long srsis0 = 0;
+	unsigned long srsis4 = 0;
+	unsigned long si1s;
+	__be32 reg;
+	int rc;
+
+	rc = fsi_master_read(master, link, 0, FSI_SLAVE_BASE + FSI_SI1S, &reg, sizeof(reg));
+	if (rc)
+		return rc;
+
+	si1s = (unsigned long)be32_to_cpu(reg);
+	for_each_set_bit_from(bit, &si1s, size)
+		generic_handle_domain_irq(irq_domain, (link * FSI_IRQ_COUNT) + (31 - bit));
+
+	if (downstream) {
+		int i;
+
+		master->remote_interrupt_status = 0;
+
+		rc = fsi_master_read(master, link, 0, FSI_SLAVE_BASE + FSI_SRSIS0, &reg,
+				     sizeof(reg));
+		if (rc)
+			return rc;
+
+		srsis0 = (unsigned long)be32_to_cpu(reg);
+		for (i = 0; i < 4; ++i) {
+			if (srsis0 & (0xff000000 >> (8 * i)))
+				master->remote_interrupt_status |= (1 << i);
+		}
+
+		rc = fsi_master_read(master, link, 0, FSI_SLAVE_BASE + FSI_SRSIS4, &reg,
+				     sizeof(reg));
+		if (rc)
+			return rc;
+
+		srsis4 = (unsigned long)be32_to_cpu(reg);
+		for (i = 0; i < 4; ++i) {
+			if (srsis4 & (0xff000000 >> (8 * i)))
+				master->remote_interrupt_status |= (16 << i);
+		}
+
+		if (master->remote_interrupt_status) {
+			handle_irq_desc(downstream);
+
+			reg = cpu_to_be32(0xffffffff);
+			if (master->remote_interrupt_status & 0xf)
+				fsi_master_write(master, link, 0, FSI_SLAVE_BASE + FSI_SRSIC0,
+						 &reg, sizeof(reg));
+
+			if (master->remote_interrupt_status & 0xf0)
+				fsi_master_write(master, link, 0, FSI_SLAVE_BASE + FSI_SRSIC4,
+						 &reg, sizeof(reg));
+		}
+	}
+
+	trace_fsi_master_irq(master, link, si1s, srsis0, srsis4);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(fsi_master_irq);
+
+static void fsi_master_irq_mask(struct irq_data *data)
+{
+	unsigned int bit = 31 - (data->hwirq % FSI_IRQ_COUNT);
+
+	if (bit >= FSI_SI1S_MBOX_BIT) {
+		struct fsi_master *master = irq_data_get_irq_chip_data(data);
+		int link = data->hwirq / FSI_IRQ_COUNT;
+		__be32 mask = cpu_to_be32(BIT(bit));
+
+		trace_fsi_master_irq_mask(master, link, data->hwirq % FSI_IRQ_COUNT, true);
+		fsi_master_write(master, link, 0, FSI_SLAVE_BASE + FSI_SCI1M, &mask, sizeof(mask));
+	}
+}
+
+static void fsi_master_irq_unmask(struct irq_data *data)
+{
+	unsigned int bit = 31 - (data->hwirq % FSI_IRQ_COUNT);
+
+	if (bit >= FSI_SI1S_MBOX_BIT) {
+		struct fsi_master *master = irq_data_get_irq_chip_data(data);
+		int link = data->hwirq / FSI_IRQ_COUNT;
+		__be32 mask = cpu_to_be32(BIT(bit));
+
+		trace_fsi_master_irq_mask(master, link, data->hwirq % FSI_IRQ_COUNT, false);
+		fsi_master_write(master, link, 0, FSI_SLAVE_BASE + FSI_SSI1M, &mask, sizeof(mask));
+	}
+}
+
 int fsi_master_register(struct fsi_master *master)
 {
 	int rc;
@@ -1491,6 +1647,9 @@ int fsi_master_register(struct fsi_master *master)
 	if (master->flags & FSI_MASTER_FLAG_SWCLOCK)
 		master->clock_frequency = 100000000; // POWER reference clock
 
+	master->irq_chip.name = dev_name(&master->dev);
+	master->irq_chip.irq_mask = fsi_master_irq_mask;
+	master->irq_chip.irq_unmask = fsi_master_irq_unmask;
 	master->dev.class = &fsi_master_class;
 
 	mutex_lock(&master->scan_lock);
diff --git a/drivers/fsi/fsi-master.h b/drivers/fsi/fsi-master.h
index 8ea2f69ec4922..2104902091e05 100644
--- a/drivers/fsi/fsi-master.h
+++ b/drivers/fsi/fsi-master.h
@@ -10,6 +10,7 @@
 #define DRIVERS_FSI_MASTER_H
 
 #include <linux/device.h>
+#include <linux/irq.h>
 #include <linux/mutex.h>
 
 /*
@@ -112,6 +113,7 @@
 /* Misc */
 #define	FSI_CRC_SIZE		4
 #define FSI_LINK_ENABLE_SETUP_TIME	10	/* in mS */
+#define FSI_IRQ_COUNT		9
 
 /* fsi-master definition and flags */
 #define FSI_MASTER_FLAG_SWCLOCK		0x1
@@ -137,6 +139,7 @@ struct fsi_master {
 	int		n_links;
 	int		flags;
 	struct mutex	scan_lock;
+	struct irq_chip	irq_chip;
 	int		(*read)(struct fsi_master *, int link, uint8_t id,
 				uint32_t addr, void *val, size_t size);
 	int		(*write)(struct fsi_master *, int link, uint8_t id,
@@ -147,6 +150,7 @@ struct fsi_master {
 				       bool enable);
 	int		(*link_config)(struct fsi_master *, int link,
 				       u8 t_send_delay, u8 t_echo_delay);
+	u8		remote_interrupt_status;
 };
 
 #define to_fsi_master(d) container_of(d, struct fsi_master, dev)
@@ -176,4 +180,9 @@ extern void fsi_master_unregister(struct fsi_master *master);
 
 extern int fsi_master_rescan(struct fsi_master *master);
 
+struct irq_domain;
+
+extern int fsi_master_irq(struct fsi_master *master, struct irq_domain *irq_domain,
+			  unsigned int link);
+
 #endif /* DRIVERS_FSI_MASTER_H */
diff --git a/include/linux/fsi.h b/include/linux/fsi.h
index e0309bf0ae072..c249a95b7ff84 100644
--- a/include/linux/fsi.h
+++ b/include/linux/fsi.h
@@ -8,6 +8,7 @@
 #define LINUX_FSI_H
 
 #include <linux/device.h>
+#include <linux/interrupt.h>
 
 struct fsi_device {
 	struct device		dev;
@@ -25,6 +26,7 @@ extern int fsi_device_write(struct fsi_device *dev, uint32_t addr,
 		const void *val, size_t size);
 extern int fsi_device_peek(struct fsi_device *dev, void *val);
 extern unsigned long fsi_device_local_bus_frequency(struct fsi_device *dev);
+extern int fsi_device_request_irq(struct fsi_device *dev, irq_handler_t handler, void *data);
 
 struct fsi_device_id {
 	u8	engine_type;
diff --git a/include/trace/events/fsi.h b/include/trace/events/fsi.h
index da977d59e163e..0e4d717ee0adb 100644
--- a/include/trace/events/fsi.h
+++ b/include/trace/events/fsi.h
@@ -8,6 +8,47 @@
 
 #include <linux/tracepoint.h>
 
+TRACE_EVENT(fsi_master_irq,
+	TP_PROTO(const struct fsi_master *master, unsigned int link, uint32_t si1s,
+		 uint32_t srsis0, uint32_t srsis4),
+	TP_ARGS(master, link, si1s, srsis0, srsis4),
+	TP_STRUCT__entry(
+		__field(int, master_idx)
+		__field(unsigned int, link)
+		__field(uint32_t, si1s)
+		__field(uint32_t, srsis0)
+		__field(uint32_t, srsis4)
+	),
+	TP_fast_assign(
+		__entry->master_idx = master->idx;
+		__entry->link = link;
+		__entry->si1s = si1s;
+		__entry->srsis0 = srsis0;
+		__entry->srsis4 = srsis4;
+	),
+	TP_printk("fsi%d:%02d si1s:%08x srsis0:%08x srsis4:%08x", __entry->master_idx,
+		  __entry->link, __entry->si1s, __entry->srsis0, __entry->srsis4)
+);
+
+TRACE_EVENT(fsi_master_irq_mask,
+	TP_PROTO(const struct fsi_master *master, unsigned int link, unsigned int bit, bool mask),
+	TP_ARGS(master, link, bit, mask),
+	TP_STRUCT__entry(
+		__field(int, master_idx)
+		__field(unsigned int, link)
+		__field(unsigned int, bit)
+		__field(bool, mask)
+	),
+	TP_fast_assign(
+		__entry->master_idx = master->idx;
+		__entry->link = link;
+		__entry->bit = bit;
+		__entry->mask = mask;
+	),
+	TP_printk("fsi%d:%02d %s bit:%d", __entry->master_idx, __entry->link,
+		  __entry->mask ? "mask" : "unmask", __entry->bit)
+);
+
 TRACE_EVENT(fsi_master_xfer,
 	TP_PROTO(int master_idx, int link, int id, uint32_t addr, size_t size, const void *data,
 		 bool read),
-- 
2.39.3

