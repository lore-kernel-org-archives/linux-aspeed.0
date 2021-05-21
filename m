From: Zev Weiss <zweiss@equinix.com>
Date: Fri, 21 May 2021 07:20:32 +0000
Subject: [PATCH v3 11/16] ipmi: kcs_bmc: Add serio adaptor
In-Reply-To: <20210510054213.1610760-12-andrew@aj.id.au>
References: <20210510054213.1610760-1-andrew@aj.id.au>
 <20210510054213.1610760-12-andrew@aj.id.au>
Message-ID: <YKdfP6br29Te0VZ6@packtop>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, May 10, 2021 at 12:42:08AM CDT, Andrew Jeffery wrote:
>kcs_bmc_serio acts as a bridge between the KCS drivers in the IPMI
>subsystem and the existing userspace interfaces available through the
>serio subsystem. This is useful when userspace would like to make use of
>the BMC KCS devices for purposes that aren't IPMI.
>
>Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
>---
> drivers/char/ipmi/Kconfig         |  14 +++
> drivers/char/ipmi/Makefile        |   1 +
> drivers/char/ipmi/kcs_bmc_serio.c | 151 ++++++++++++++++++++++++++++++
> 3 files changed, 166 insertions(+)
> create mode 100644 drivers/char/ipmi/kcs_bmc_serio.c
>
>diff --git a/drivers/char/ipmi/Kconfig b/drivers/char/ipmi/Kconfig
>index bc5f81899b62..249b31197eea 100644
>--- a/drivers/char/ipmi/Kconfig
>+++ b/drivers/char/ipmi/Kconfig
>@@ -137,6 +137,20 @@ config IPMI_KCS_BMC_CDEV_IPMI
> 	  This support is also available as a module. The module will be
> 	  called kcs_bmc_cdev_ipmi.
>
>+config IPMI_KCS_BMC_SERIO
>+	depends on IPMI_KCS_BMC && SERIO
>+	tristate "SerIO adaptor for BMC KCS devices"
>+	help
>+	  Adapts the BMC KCS device for the SerIO subsystem. This allows users
>+	  to take advantage of userspace interfaces provided by SerIO where
>+	  appropriate.
>+
>+	  Say YES if you wish to expose KCS devices on the BMC via SerIO
>+	  interfaces.
>+
>+	  This support is also available as a module. The module will be
>+	  called kcs_bmc_serio.
>+
> config ASPEED_BT_IPMI_BMC
> 	depends on ARCH_ASPEED || COMPILE_TEST
> 	depends on REGMAP && REGMAP_MMIO && MFD_SYSCON
>diff --git a/drivers/char/ipmi/Makefile b/drivers/char/ipmi/Makefile
>index fcfa676afddb..84f47d18007f 100644
>--- a/drivers/char/ipmi/Makefile
>+++ b/drivers/char/ipmi/Makefile
>@@ -23,6 +23,7 @@ obj-$(CONFIG_IPMI_POWERNV) += ipmi_powernv.o
> obj-$(CONFIG_IPMI_WATCHDOG) += ipmi_watchdog.o
> obj-$(CONFIG_IPMI_POWEROFF) += ipmi_poweroff.o
> obj-$(CONFIG_IPMI_KCS_BMC) += kcs_bmc.o
>+obj-$(CONFIG_IPMI_KCS_BMC_SERIO) += kcs_bmc_serio.o
> obj-$(CONFIG_IPMI_KCS_BMC_CDEV_IPMI) += kcs_bmc_cdev_ipmi.o
> obj-$(CONFIG_ASPEED_BT_IPMI_BMC) += bt-bmc.o
> obj-$(CONFIG_ASPEED_KCS_IPMI_BMC) += kcs_bmc_aspeed.o
>diff --git a/drivers/char/ipmi/kcs_bmc_serio.c b/drivers/char/ipmi/kcs_bmc_serio.c
>new file mode 100644
>index 000000000000..30a2b7ab464b
>--- /dev/null
>+++ b/drivers/char/ipmi/kcs_bmc_serio.c
>@@ -0,0 +1,151 @@
>+// SPDX-License-Identifier: GPL-2.0-or-later
>+/* Copyright (c) 2021 IBM Corp. */
>+
>+#include <linux/delay.h>
>+#include <linux/device.h>
>+#include <linux/errno.h>
>+#include <linux/list.h>
>+#include <linux/module.h>
>+#include <linux/sched/signal.h>
>+#include <linux/serio.h>
>+#include <linux/slab.h>
>+
>+#include "kcs_bmc_client.h"
>+
>+struct kcs_bmc_serio {
>+	struct list_head entry;
>+
>+	struct kcs_bmc_client client;
>+	struct serio *port;
>+
>+	spinlock_t lock;
>+};
>+
>+static inline struct kcs_bmc_serio *client_to_kcs_bmc_serio(struct kcs_bmc_client *client)
>+{
>+	return container_of(client, struct kcs_bmc_serio, client);
>+}
>+
>+static irqreturn_t kcs_bmc_serio_event(struct kcs_bmc_client *client)
>+{
>+	struct kcs_bmc_serio *priv;
>+	u8 handled = IRQ_NONE;
>+	u8 status;
>+
>+	priv = client_to_kcs_bmc_serio(client);
>+
>+	spin_lock(&priv->lock);
>+
>+	status = kcs_bmc_read_status(client->dev);
>+
>+	if (status & KCS_BMC_STR_IBF)
>+		handled = serio_interrupt(priv->port, kcs_bmc_read_data(client->dev), 0);
>+
>+	spin_unlock(&priv->lock);
>+
>+	return handled;
>+}
>+
>+static const struct kcs_bmc_client_ops kcs_bmc_serio_client_ops = {
>+	.event = kcs_bmc_serio_event,
>+};
>+
>+static int kcs_bmc_serio_open(struct serio *port)
>+{
>+	struct kcs_bmc_serio *priv = port->port_data;
>+
>+	return kcs_bmc_enable_device(priv->client.dev, &priv->client);
>+}
>+
>+static void kcs_bmc_serio_close(struct serio *port)
>+{
>+	struct kcs_bmc_serio *priv = port->port_data;
>+
>+	kcs_bmc_disable_device(priv->client.dev, &priv->client);
>+}
>+
>+static DEFINE_SPINLOCK(kcs_bmc_serio_instances_lock);
>+static LIST_HEAD(kcs_bmc_serio_instances);
>+
>+static int kcs_bmc_serio_add_device(struct kcs_bmc_device *kcs_bmc)
>+{
>+	struct kcs_bmc_serio *priv;
>+	struct serio *port;
>+
>+	priv = devm_kzalloc(kcs_bmc->dev, sizeof(*priv), GFP_KERNEL);
>+	port = kzalloc(sizeof(*port), GFP_KERNEL);

Is there a particular reason to allocate port with a raw kzalloc()
instead of another devm_kzalloc()?

>+	if (!(priv && port))
>+		return -ENOMEM;
>+
>+	port->id.type = SERIO_8042;
>+	port->open = kcs_bmc_serio_open;
>+	port->close = kcs_bmc_serio_close;
>+	port->port_data = priv;
>+	port->dev.parent = kcs_bmc->dev;
>+
>+	spin_lock_init(&priv->lock);
>+	priv->port = port;
>+	priv->client.dev = kcs_bmc;
>+	priv->client.ops = &kcs_bmc_serio_client_ops;
>+
>+	spin_lock_irq(&kcs_bmc_serio_instances_lock);
>+	list_add(&priv->entry, &kcs_bmc_serio_instances);
>+	spin_unlock_irq(&kcs_bmc_serio_instances_lock);
>+
>+	serio_register_port(port);
>+
>+	dev_info(kcs_bmc->dev, "Initialised serio client for channel %d", kcs_bmc->channel);
>+
>+	return 0;
>+}
>+
>+static int kcs_bmc_serio_remove_device(struct kcs_bmc_device *kcs_bmc)
>+{
>+	struct kcs_bmc_serio *priv = NULL, *pos;
>+
>+	spin_lock_irq(&kcs_bmc_serio_instances_lock);
>+	list_for_each_entry(pos, &kcs_bmc_serio_instances, entry) {
>+		if (pos->client.dev == kcs_bmc) {
>+			priv = pos;
>+			list_del(&pos->entry);
>+			break;
>+		}
>+	}
>+	spin_unlock_irq(&kcs_bmc_serio_instances_lock);
>+
>+	if (!priv)
>+		return -ENODEV;
>+
>+	serio_unregister_port(priv->port);
>+	kcs_bmc_disable_device(kcs_bmc, &priv->client);
>+	devm_kfree(priv->client.dev->dev, priv);

Looks like the priv->port allocation would leak here I think?

Also, is the asymmetry of having kcs_bmc_disable_device() here but no
corresponding kcs_bmc_enable_device() in kcs_bmc_serio_add_device()
intentional?  If so, an explanatory comment of some sort might be nice
to add.

>+
>+	return 0;
>+}
>+
>+static const struct kcs_bmc_driver_ops kcs_bmc_serio_driver_ops = {
>+	.add_device = kcs_bmc_serio_add_device,
>+	.remove_device = kcs_bmc_serio_remove_device,
>+};
>+
>+static struct kcs_bmc_driver kcs_bmc_serio_driver = {
>+	.ops = &kcs_bmc_serio_driver_ops,
>+};
>+
>+static int kcs_bmc_serio_init(void)
>+{
>+	kcs_bmc_register_driver(&kcs_bmc_serio_driver);
>+
>+	return 0;
>+}
>+module_init(kcs_bmc_serio_init);
>+
>+static void kcs_bmc_serio_exit(void)
>+{
>+	kcs_bmc_unregister_driver(&kcs_bmc_serio_driver);
>+}
>+module_exit(kcs_bmc_serio_exit);
>+
>+MODULE_LICENSE("GPL v2");
>+MODULE_AUTHOR("Andrew Jeffery <andrew@aj.id.au>");
>+MODULE_DESCRIPTION("Adapter driver for serio access to BMC KCS devices");
>-- 
>2.27.0
>
