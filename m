From: Eddie James <eajames@linux.ibm.com>
Date: Wed,  5 Jun 2024 16:22:57 -0500
Subject: [PATCH v4 25/40] fsi: hub: Add interrupt support
In-Reply-To: <20240605212312.349188-1-eajames@linux.ibm.com>
References: <20240605212312.349188-1-eajames@linux.ibm.com>
Message-ID: <20240605212312.349188-26-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The hub master receives it's interrupts from the local slave register
space, which is handled in the FSI core. Therefore, just route the remote
slave interrupts to the hub link device interrupts.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-master-hub.c | 119 ++++++++++++++++++++++++++++++++++-
 1 file changed, 116 insertions(+), 3 deletions(-)

diff --git a/drivers/fsi/fsi-master-hub.c b/drivers/fsi/fsi-master-hub.c
index 91ad6b7728fa2..4dbc542500bbd 100644
--- a/drivers/fsi/fsi-master-hub.c
+++ b/drivers/fsi/fsi-master-hub.c
@@ -7,8 +7,10 @@
 
 #include <linux/delay.h>
 #include <linux/fsi.h>
+#include <linux/irqchip/chained_irq.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_irq.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
@@ -35,9 +37,10 @@
  */
 struct fsi_master_hub {
 	struct fsi_master	master;
+	struct irq_domain	*irq_domain;
 	struct fsi_device	*upstream;
-	uint32_t		addr, size;	/* slave-relative addr of */
-						/* master address space */
+	uint32_t		addr;
+	uint32_t		size;
 };
 
 #define to_fsi_master_hub(m) container_of(m, struct fsi_master_hub, master)
@@ -77,10 +80,81 @@ static int hub_master_break(struct fsi_master *master, int link)
 	return hub_master_write(master, link, 0, addr, &cmd, sizeof(cmd));
 }
 
+static int hub_master_link_enable(struct fsi_master *master, int link,
+				  bool enable)
+{
+	struct fsi_master_hub *hub = to_fsi_master_hub(master);
+	u32 srsim = 0xff000000 >> (8 * (link % 4));
+	int slave_idx = 4 * (link / 4);
+	__be32 srsim_be;
+	int ret;
+
+	ret = fsi_slave_read(hub->upstream->slave, FSI_SLAVE_BASE + FSI_SRSIM0 + slave_idx,
+			     &srsim_be, sizeof(srsim_be));
+	if (ret)
+		return ret;
+
+	if (enable) {
+		ret = fsi_master_link_enable(master, link, enable);
+		if (ret)
+			return ret;
+
+		srsim |= be32_to_cpu(srsim_be);
+		srsim_be = cpu_to_be32(srsim);
+		ret = fsi_slave_write(hub->upstream->slave,
+				      FSI_SLAVE_BASE + FSI_SRSIM0 + slave_idx, &srsim_be,
+				      sizeof(srsim_be));
+	} else {
+		srsim = be32_to_cpu(srsim_be) & ~srsim;
+		srsim_be = cpu_to_be32(srsim);
+		ret = fsi_slave_write(hub->upstream->slave,
+				      FSI_SLAVE_BASE + FSI_SRSIM0 + slave_idx, &srsim_be,
+				      sizeof(srsim_be));
+		if (ret)
+			return ret;
+
+		ret = fsi_master_link_enable(master, link, enable);
+	}
+
+	return ret;
+}
+
+static irqreturn_t hub_master_irq(int irq, void *data)
+{
+	struct fsi_master_hub *hub = data;
+	struct fsi_master *parent = hub->upstream->slave->master;
+	unsigned int link = 0;
+
+	for (; link < FSI_HUB_MASTER_MAX_LINKS; ++link) {
+		if (parent->remote_interrupt_status & (1 << link))
+			fsi_master_irq(&hub->master, hub->irq_domain, link);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int hub_master_irqd_map(struct irq_domain *domain, unsigned int irq,
+			       irq_hw_number_t hwirq)
+{
+	struct fsi_master_hub *hub = domain->host_data;
+
+	irq_set_chip_and_handler(irq, &hub->master.irq_chip, handle_simple_irq);
+	irq_set_chip_data(irq, &hub->master);
+
+	return 0;
+}
+
+static const struct irq_domain_ops hub_master_irq_domain_ops = {
+	.map = hub_master_irqd_map,
+};
+
 static void hub_master_release(struct device *dev)
 {
 	struct fsi_master_hub *hub = to_fsi_master_hub(to_fsi_master(dev));
 
+	if (hub->irq_domain)
+		irq_domain_remove(hub->irq_domain);
+
 	regmap_exit(hub->master.map);
 	kfree(hub);
 }
@@ -135,6 +209,7 @@ static int hub_master_probe(struct device *dev)
 	hub->master.read = hub_master_read;
 	hub->master.write = hub_master_write;
 	hub->master.send_break = hub_master_break;
+	hub->master.link_enable = hub_master_link_enable;
 
 	dev_set_drvdata(dev, hub);
 
@@ -142,9 +217,44 @@ static int hub_master_probe(struct device *dev)
 	if (rc)
 		goto err_free;
 
+	if (of_property_read_bool(dev->of_node, "interrupt-controller")) {
+		struct device_node *parent = of_irq_find_parent(dev->of_node);
+
+		if (parent) {
+			struct irq_fwspec fwspec;
+			unsigned int irq;
+
+			fwspec.fwnode = of_node_to_fwnode(parent);
+			fwspec.param_count = 1;
+			fwspec.param[0] = (fsi_dev->slave->link * FSI_IRQ_COUNT) + 8;
+			irq = irq_create_fwspec_mapping(&fwspec);
+			if (irq) {
+				unsigned int size = links * FSI_IRQ_COUNT;
+
+				hub->irq_domain = irq_domain_add_linear(dev->of_node, size,
+									&hub_master_irq_domain_ops,
+									hub);
+
+				if (hub->irq_domain) {
+					rc = devm_request_irq(dev, irq, hub_master_irq, 0,
+							      dev_name(dev), hub);
+					if (rc) {
+						dev_warn(dev, "failed to request irq:%u\n", irq);
+						irq_domain_remove(hub->irq_domain);
+						hub->irq_domain = NULL;
+					} else {
+						dev_info(dev, "enabling interrupts irq:%u\n", irq);
+					}
+				} else {
+					dev_warn(dev, "failed to create irq domain\n");
+				}
+			}
+		}
+	}
+
 	rc = fsi_master_register(&hub->master);
 	if (rc)
-		goto err_free;
+		goto err_irq;
 
 	/* At this point, fsi_master_register performs the device_initialize(),
 	 * and holds the sole reference on master.dev. This means the device
@@ -156,6 +266,9 @@ static int hub_master_probe(struct device *dev)
 	get_device(&hub->master.dev);
 	return 0;
 
+err_irq:
+	if (hub->irq_domain)
+		irq_domain_remove(hub->irq_domain);
 err_free:
 	kfree(hub);
 err_release:
-- 
2.39.3

