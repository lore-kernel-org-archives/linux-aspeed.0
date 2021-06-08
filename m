From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue, 08 Jun 2021 10:07:03 +0930
Subject: [PATCH v3 11/16] ipmi: kcs_bmc: Add serio adaptor
In-Reply-To: <YKdfP6br29Te0VZ6@packtop>
References: <20210510054213.1610760-1-andrew@aj.id.au>
 <20210510054213.1610760-12-andrew@aj.id.au> <YKdfP6br29Te0VZ6@packtop>
Message-ID: <15bfe16d-a9a1-464b-bb23-c59ac91b41a8@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Fri, 21 May 2021, at 16:50, Zev Weiss wrote:
> On Mon, May 10, 2021 at 12:42:08AM CDT, Andrew Jeffery wrote:
> >kcs_bmc_serio acts as a bridge between the KCS drivers in the IPMI
> >subsystem and the existing userspace interfaces available through the
> >serio subsystem. This is useful when userspace would like to make use of
> >the BMC KCS devices for purposes that aren't IPMI.
> >
> >Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> >---
> > drivers/char/ipmi/Kconfig         |  14 +++
> > drivers/char/ipmi/Makefile        |   1 +
> > drivers/char/ipmi/kcs_bmc_serio.c | 151 ++++++++++++++++++++++++++++++
> > 3 files changed, 166 insertions(+)
> > create mode 100644 drivers/char/ipmi/kcs_bmc_serio.c
> >
> >diff --git a/drivers/char/ipmi/Kconfig b/drivers/char/ipmi/Kconfig
> >index bc5f81899b62..249b31197eea 100644
> >--- a/drivers/char/ipmi/Kconfig
> >+++ b/drivers/char/ipmi/Kconfig
> >@@ -137,6 +137,20 @@ config IPMI_KCS_BMC_CDEV_IPMI
> > 	  This support is also available as a module. The module will be
> > 	  called kcs_bmc_cdev_ipmi.
> >
> >+config IPMI_KCS_BMC_SERIO
> >+	depends on IPMI_KCS_BMC && SERIO
> >+	tristate "SerIO adaptor for BMC KCS devices"
> >+	help
> >+	  Adapts the BMC KCS device for the SerIO subsystem. This allows users
> >+	  to take advantage of userspace interfaces provided by SerIO where
> >+	  appropriate.
> >+
> >+	  Say YES if you wish to expose KCS devices on the BMC via SerIO
> >+	  interfaces.
> >+
> >+	  This support is also available as a module. The module will be
> >+	  called kcs_bmc_serio.
> >+
> > config ASPEED_BT_IPMI_BMC
> > 	depends on ARCH_ASPEED || COMPILE_TEST
> > 	depends on REGMAP && REGMAP_MMIO && MFD_SYSCON
> >diff --git a/drivers/char/ipmi/Makefile b/drivers/char/ipmi/Makefile
> >index fcfa676afddb..84f47d18007f 100644
> >--- a/drivers/char/ipmi/Makefile
> >+++ b/drivers/char/ipmi/Makefile
> >@@ -23,6 +23,7 @@ obj-$(CONFIG_IPMI_POWERNV) += ipmi_powernv.o
> > obj-$(CONFIG_IPMI_WATCHDOG) += ipmi_watchdog.o
> > obj-$(CONFIG_IPMI_POWEROFF) += ipmi_poweroff.o
> > obj-$(CONFIG_IPMI_KCS_BMC) += kcs_bmc.o
> >+obj-$(CONFIG_IPMI_KCS_BMC_SERIO) += kcs_bmc_serio.o
> > obj-$(CONFIG_IPMI_KCS_BMC_CDEV_IPMI) += kcs_bmc_cdev_ipmi.o
> > obj-$(CONFIG_ASPEED_BT_IPMI_BMC) += bt-bmc.o
> > obj-$(CONFIG_ASPEED_KCS_IPMI_BMC) += kcs_bmc_aspeed.o
> >diff --git a/drivers/char/ipmi/kcs_bmc_serio.c b/drivers/char/ipmi/kcs_bmc_serio.c
> >new file mode 100644
> >index 000000000000..30a2b7ab464b
> >--- /dev/null
> >+++ b/drivers/char/ipmi/kcs_bmc_serio.c
> >@@ -0,0 +1,151 @@
> >+// SPDX-License-Identifier: GPL-2.0-or-later
> >+/* Copyright (c) 2021 IBM Corp. */
> >+
> >+#include <linux/delay.h>
> >+#include <linux/device.h>
> >+#include <linux/errno.h>
> >+#include <linux/list.h>
> >+#include <linux/module.h>
> >+#include <linux/sched/signal.h>
> >+#include <linux/serio.h>
> >+#include <linux/slab.h>
> >+
> >+#include "kcs_bmc_client.h"
> >+
> >+struct kcs_bmc_serio {
> >+	struct list_head entry;
> >+
> >+	struct kcs_bmc_client client;
> >+	struct serio *port;
> >+
> >+	spinlock_t lock;
> >+};
> >+
> >+static inline struct kcs_bmc_serio *client_to_kcs_bmc_serio(struct kcs_bmc_client *client)
> >+{
> >+	return container_of(client, struct kcs_bmc_serio, client);
> >+}
> >+
> >+static irqreturn_t kcs_bmc_serio_event(struct kcs_bmc_client *client)
> >+{
> >+	struct kcs_bmc_serio *priv;
> >+	u8 handled = IRQ_NONE;
> >+	u8 status;
> >+
> >+	priv = client_to_kcs_bmc_serio(client);
> >+
> >+	spin_lock(&priv->lock);
> >+
> >+	status = kcs_bmc_read_status(client->dev);
> >+
> >+	if (status & KCS_BMC_STR_IBF)
> >+		handled = serio_interrupt(priv->port, kcs_bmc_read_data(client->dev), 0);
> >+
> >+	spin_unlock(&priv->lock);
> >+
> >+	return handled;
> >+}
> >+
> >+static const struct kcs_bmc_client_ops kcs_bmc_serio_client_ops = {
> >+	.event = kcs_bmc_serio_event,
> >+};
> >+
> >+static int kcs_bmc_serio_open(struct serio *port)
> >+{
> >+	struct kcs_bmc_serio *priv = port->port_data;
> >+
> >+	return kcs_bmc_enable_device(priv->client.dev, &priv->client);
> >+}
> >+
> >+static void kcs_bmc_serio_close(struct serio *port)
> >+{
> >+	struct kcs_bmc_serio *priv = port->port_data;
> >+
> >+	kcs_bmc_disable_device(priv->client.dev, &priv->client);
> >+}
> >+
> >+static DEFINE_SPINLOCK(kcs_bmc_serio_instances_lock);
> >+static LIST_HEAD(kcs_bmc_serio_instances);
> >+
> >+static int kcs_bmc_serio_add_device(struct kcs_bmc_device *kcs_bmc)
> >+{
> >+	struct kcs_bmc_serio *priv;
> >+	struct serio *port;
> >+
> >+	priv = devm_kzalloc(kcs_bmc->dev, sizeof(*priv), GFP_KERNEL);
> >+	port = kzalloc(sizeof(*port), GFP_KERNEL);
> 
> Is there a particular reason to allocate port with a raw kzalloc()
> instead of another devm_kzalloc()?

Yes, because it causes pointer confusion on remove. We get the following backtrace:

[   95.018845] Backtrace: 
[   95.019162] [<802e1fb0>] (___cache_free) from [<802e31cc>] (kfree+0xc0/0x1e8)
[   95.019658]  r10:00000081 r9:8667c000 r8:80100284 r7:81000b40 r6:a0000013 r5:80640bd4
[   95.020032]  r4:82a5ec40
[   95.020206] [<802e310c>] (kfree) from [<80640bd4>] (serio_release_port+0x1c/0x28)
[   95.020571]  r7:00000000 r6:819c1540 r5:86acf480 r4:82a5ed70
[   95.020818] [<80640bb8>] (serio_release_port) from [<80565e00>] (device_release+0x40/0xb4)
[   95.021387] [<80565dc0>] (device_release) from [<804a0bcc>] (kobject_put+0xc8/0x210)
[   95.021961]  r5:80c77c30 r4:82a5ed70
[   95.022141] [<804a0b04>] (kobject_put) from [<80566078>] (put_device+0x20/0x24)
[   95.022537]  r7:80c820cc r6:82a5ec40 r5:80c820e4 r4:82a5ed70
[   95.023017] [<80566058>] (put_device) from [<80640a58>] (serio_destroy_port+0x12c/0x140)
[   95.023719] [<8064092c>] (serio_destroy_port) from [<80640b3c>] (serio_unregister_port+0x34/0x44)
[   95.024326]  r7:7f0012b4 r6:7f002024 r5:80c820e4 r4:82a5ec40
[   95.024792] [<80640b08>] (serio_unregister_port) from [<7f0100b8>] (kcs_bmc_serio_remove_device+0x90/0xbc [kcs_bmc_serio])
[   95.026951]  r5:8668b7c0 r4:86acf0c0
[   95.027390] [<7f010028>] (kcs_bmc_serio_remove_device [kcs_bmc_serio]) from [<7f00048c>] (kcs_bmc_unregister_driver+0x60/0xbd4 [kcs_bmc])
[   95.028443]  r5:7f012018 r4:8668b7c0
[   95.028634] [<7f00042c>] (kcs_bmc_unregister_driver [kcs_bmc]) from [<7f0102c4>] (kcs_bmc_serio_exit+0x1c/0xd58 [kcs_bmc_serio])
[   95.029165]  r7:00000081 r6:80cd0dac r5:00000000 r4:7f012040
[   95.029397] [<7f0102a8>] (kcs_bmc_serio_exit [kcs_bmc_serio]) from [<801cbab0>] (sys_delete_module+0x140/0x280)
[   95.029875] [<801cb970>] (sys_delete_module) from [<80100080>] (ret_fast_syscall+0x0/0x58)

> 
> >+	if (!(priv && port))
> >+		return -ENOMEM;
> >+
> >+	port->id.type = SERIO_8042;
> >+	port->open = kcs_bmc_serio_open;
> >+	port->close = kcs_bmc_serio_close;
> >+	port->port_data = priv;
> >+	port->dev.parent = kcs_bmc->dev;
> >+
> >+	spin_lock_init(&priv->lock);
> >+	priv->port = port;
> >+	priv->client.dev = kcs_bmc;
> >+	priv->client.ops = &kcs_bmc_serio_client_ops;
> >+
> >+	spin_lock_irq(&kcs_bmc_serio_instances_lock);
> >+	list_add(&priv->entry, &kcs_bmc_serio_instances);
> >+	spin_unlock_irq(&kcs_bmc_serio_instances_lock);
> >+
> >+	serio_register_port(port);
> >+
> >+	dev_info(kcs_bmc->dev, "Initialised serio client for channel %d", kcs_bmc->channel);
> >+
> >+	return 0;
> >+}
> >+
> >+static int kcs_bmc_serio_remove_device(struct kcs_bmc_device *kcs_bmc)
> >+{
> >+	struct kcs_bmc_serio *priv = NULL, *pos;
> >+
> >+	spin_lock_irq(&kcs_bmc_serio_instances_lock);
> >+	list_for_each_entry(pos, &kcs_bmc_serio_instances, entry) {
> >+		if (pos->client.dev == kcs_bmc) {
> >+			priv = pos;
> >+			list_del(&pos->entry);
> >+			break;
> >+		}
> >+	}
> >+	spin_unlock_irq(&kcs_bmc_serio_instances_lock);
> >+
> >+	if (!priv)
> >+		return -ENODEV;
> >+
> >+	serio_unregister_port(priv->port);
> >+	kcs_bmc_disable_device(kcs_bmc, &priv->client);
> >+	devm_kfree(priv->client.dev->dev, priv);
> 
> Looks like the priv->port allocation would leak here I think?

No, because port's released through serio_unregister_port(). It's not super obvious though, so I'll add a comment next to the kzalloc().

> 
> Also, is the asymmetry of having kcs_bmc_disable_device() here but no
> corresponding kcs_bmc_enable_device() in kcs_bmc_serio_add_device()
> intentional?  If so, an explanatory comment of some sort might be nice
> to add.

It's intentional to make sure the device isn't left registered as enabled in the core. kcs_bmc_enable_device() is called in the open() path.

Andrew
