From: Winiarska, Iwona <iwona.winiarska@intel.com>
Date: Fri, 16 Jul 2021 21:08:46 +0000
Subject: [PATCH 06/14] peci: Add core infrastructure
In-Reply-To: <59428599ef7efb2521bd62c49a3bc55c710f29de.camel@intel.com>
References: <20210712220447.957418-1-iwona.winiarska@intel.com>
 <20210712220447.957418-7-iwona.winiarska@intel.com>
 <59428599ef7efb2521bd62c49a3bc55c710f29de.camel@intel.com>
Message-ID: <6807a14deb52956ad2fe390b1811dd98901a642a.camel@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 2021-07-14 at 17:19 +0000, Williams, Dan J wrote:
> On Tue, 2021-07-13 at 00:04 +0200, Iwona Winiarska wrote:
> > Intel processors provide access for various services designed to support
> > processor and DRAM thermal management, platform manageability and
> > processor interface tuning and diagnostics.
> > Those services are available via the Platform Environment Control
> > Interface (PECI) that provides a communication channel between the
> > processor and the Baseboard Management Controller (BMC) or other
> > platform management device.
> > 
> > This change introduces PECI subsystem by adding the initial core module
> > and API for controller drivers.
> > 
> > Co-developed-by: Jason M Bills <jason.m.bills@linux.intel.com>
> > Signed-off-by: Jason M Bills <jason.m.bills@linux.intel.com>
> > Co-developed-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> > Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> > Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
> > Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > ---
> > ?MAINTAINERS???????????? |?? 9 +++
> > ?drivers/Kconfig???????? |?? 3 +
> > ?drivers/Makefile??????? |?? 1 +
> > ?drivers/peci/Kconfig??? |? 14 ++++
> > ?drivers/peci/Makefile?? |?? 5 ++
> > ?drivers/peci/core.c???? | 166 ++++++++++++++++++++++++++++++++++++++++
> > ?drivers/peci/internal.h |? 20 +++++
> > ?drivers/peci/sysfs.c??? |? 48 ++++++++++++
> > ?include/linux/peci.h??? |? 82 ++++++++++++++++++++
> > ?9 files changed, 348 insertions(+)
> > ?create mode 100644 drivers/peci/Kconfig
> > ?create mode 100644 drivers/peci/Makefile
> > ?create mode 100644 drivers/peci/core.c
> > ?create mode 100644 drivers/peci/internal.h
> > ?create mode 100644 drivers/peci/sysfs.c
> > ?create mode 100644 include/linux/peci.h
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 6f77aaca2a30..47411e2b6336 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -14495,6 +14495,15 @@ L:?????platform-driver-x86 at vger.kernel.org
> > ?S:?????Maintained
> > ?F:?????drivers/platform/x86/peaq-wmi.c
> > ?
> > +PECI SUBSYSTEM
> > +M:?????Iwona Winiarska <iwona.winiarska@intel.com>
> > +R:?????Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> > +L:?????openbmc at lists.ozlabs.org?(moderated for non-subscribers)
> > +S:?????Supported
> > +F:?????Documentation/devicetree/bindings/peci/
> > +F:?????drivers/peci/
> > +F:?????include/linux/peci.h
> > +
> > ?PENSANDO ETHERNET DRIVERS
> > ?M:?????Shannon Nelson <snelson@pensando.io>
> > ?M:?????drivers at pensando.io
> > diff --git a/drivers/Kconfig b/drivers/Kconfig
> > index 8bad63417a50..f472b3d972b3 100644
> > --- a/drivers/Kconfig
> > +++ b/drivers/Kconfig
> > @@ -236,4 +236,7 @@ source "drivers/interconnect/Kconfig"
> > ?source "drivers/counter/Kconfig"
> > ?
> > ?source "drivers/most/Kconfig"
> > +
> > +source "drivers/peci/Kconfig"
> > +
> > ?endmenu
> > diff --git a/drivers/Makefile b/drivers/Makefile
> > index 27c018bdf4de..8d96f0c3dde5 100644
> > --- a/drivers/Makefile
> > +++ b/drivers/Makefile
> > @@ -189,3 +189,4 @@ obj-$(CONFIG_GNSS)??????????+= gnss/
> > ?obj-$(CONFIG_INTERCONNECT)?????+= interconnect/
> > ?obj-$(CONFIG_COUNTER)??????????+= counter/
> > ?obj-$(CONFIG_MOST)?????????????+= most/
> > +obj-$(CONFIG_PECI)?????????????+= peci/
> > diff --git a/drivers/peci/Kconfig b/drivers/peci/Kconfig
> > new file mode 100644
> > index 000000000000..601cc3c3c852
> > --- /dev/null
> > +++ b/drivers/peci/Kconfig
> > @@ -0,0 +1,14 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +
> > +menuconfig PECI
> > +???????tristate "PECI support"
> > +???????help
> > +???????? The Platform Environment Control Interface (PECI) is an interface
> > +???????? that provides a communication channel to Intel processors and
> > +???????? chipset components from external monitoring or control devices.
> > +
> > +???????? If you want PECI support, you should say Y here and also to the
> > +???????? specific driver for your bus adapter(s) below.
> 
> The user is reading this help text to decide if they want PECI
> support, so clarifying that if they want PECI support they should turn
> it on is not all that helpful. I would say "If you are building a
> kernel for a Board Management Controller (BMC) say Y. If unsure say
> N".

Since PECI is only available on Intel platforms, perhaps something
like:
"If you are building a Board Management Controller (BMC) kernel for
Intel platform say Y"?

> 
> > +
> > +???????? This support is also available as a module. If so, the module
> > +???????? will be called peci.
> > diff --git a/drivers/peci/Makefile b/drivers/peci/Makefile
> > new file mode 100644
> > index 000000000000..2bb2f51bcda7
> > --- /dev/null
> > +++ b/drivers/peci/Makefile
> > @@ -0,0 +1,5 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +
> > +# Core functionality
> > +peci-y := core.o sysfs.o
> > +obj-$(CONFIG_PECI) += peci.o
> > diff --git a/drivers/peci/core.c b/drivers/peci/core.c
> > new file mode 100644
> > index 000000000000..0ad00110459d
> > --- /dev/null
> > +++ b/drivers/peci/core.c
> > @@ -0,0 +1,166 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +// Copyright (c) 2018-2021 Intel Corporation
> > +
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > +
> > +#include <linux/bug.h>
> > +#include <linux/device.h>
> > +#include <linux/export.h>
> > +#include <linux/idr.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/peci.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/property.h>
> > +#include <linux/slab.h>
> > +
> > +#include "internal.h"
> > +
> > +static DEFINE_IDA(peci_controller_ida);
> > +
> > +static void peci_controller_dev_release(struct device *dev)
> > +{
> > +???????struct peci_controller *controller = to_peci_controller(dev);
> > +
> > +???????mutex_destroy(&controller->bus_lock);
> > +}
> > +
> > +struct device_type peci_controller_type = {
> > +???????.release????????= peci_controller_dev_release,
> > +};
> 
> I have not read further than patch 6 in this set, so I'm hoping there
> is an explanation for this. As it stands it looks like a red flag that
> the release function is not actually releasing anything?
> 

Ok, that's related to other comments here and in patch 7. I'll try to
refactor this. I'm thinking about splitting the "controller_add" into
separate "alloc" and "add" (or init? register?). And perhaps integrate
that into devm, so that controller can be allocated using devres, tying
that into lifetime of underlying platform device.

> > +
> > +int peci_controller_scan_devices(struct peci_controller *controller)
> > +{
> > +???????/* Just a stub, no support for actual devices yet */
> > +???????return 0;
> > +}
> 
> Move this to the patch where it is needed.

It's used in this patch (in sysfs and controller add), but at this
point we haven't introduced devices yet.
I would have to move this to patch 8 - but I don't think it belongs
there.
Will it make more sense if I introduce sysfs documentation here?
Or as a completely separate patch?
I wanted to avoid going too far with split granularity, and just go
with high-level concepts starting with the controller.

> 
> > +
> > +/**
> > + * peci_controller_add() - Add PECI controller
> > + * @controller: the PECI controller to be added
> > + * @parent: device object to be registered as a parent
> > + *
> > + * In final stage of its probe(), peci_controller driver should include calling
> 
> s/should include calling/calls/
> 

Ok.

> > + * peci_controller_add() to register itself with the PECI bus.
> > + * The caller is responsible for allocating the struct
> > peci_controller and
> > + * managing its lifetime, calling peci_controller_remove() prior
> > to releasing
> > + * the allocation.
> > + *
> > + * It returns zero on success, else a negative error code
> > (dropping the
> > + * controller's refcount). After a successful return, the caller
> > is responsible
> > + * for calling peci_controller_remove().
> > + *
> > + * Return: 0 if succeeded, other values in case errors.
> > + */
> > +int peci_controller_add(struct peci_controller *controller, struct
> > device *parent)
> > +{
> > +???????struct fwnode_handle *node =
> > fwnode_handle_get(dev_fwnode(parent));
> > +???????int ret;
> > +
> > +???????if (WARN_ON(!controller->xfer))
> 
> Why WARN()? What is 'xfer', and what is likelihood the caller forgets
> to set it? For something critical like this the WARN is likely
> overkill.
> 

Very unlikely - 'xfer' provides "connection" with hardware so it's
rather mandatory.
It indicates programmer error, so WARN() with all its consequences
(taint and so on) seemed adequate.

Do you suggest to downgrade it to pr_err()?

> > +???????????????return -EINVAL;
> > +
> > +???????ret = ida_alloc_max(&peci_controller_ida, U8_MAX,
> > GFP_KERNEL);
> 
> An '_add' function should just add, this seems to be doing more
> "alloc". Speaking of which is there a peci_controller_alloc()?
> 

Please see my previous comment (I'll try to refactor this).

> 
> > +???????if (ret < 0)
> > +???????????????return ret;
> > +
> > +???????controller->id = ret;
> > +
> > +???????mutex_init(&controller->bus_lock);
> > +
> > +???????controller->dev.parent = parent;
> > +???????controller->dev.bus = &peci_bus_type;
> > +???????controller->dev.type = &peci_controller_type;
> > +???????controller->dev.fwnode = node;
> > +???????controller->dev.of_node = to_of_node(node);
> > +
> > +???????ret = dev_set_name(&controller->dev, "peci-%d", controller-
> > >id);
> > +???????if (ret)
> > +???????????????goto err_id;
> > +
> > +???????ret = device_register(&controller->dev);
> > +???????if (ret)
> > +???????????????goto err_put;
> > +
> > +???????pm_runtime_no_callbacks(&controller->dev);
> > +???????pm_suspend_ignore_children(&controller->dev, true);
> > +???????pm_runtime_enable(&controller->dev);
> > +
> > +???????/*
> > +??????? * Ignoring retval since failures during scan are non-
> > critical for
> > +??????? * controller itself.
> > +??????? */
> > +???????peci_controller_scan_devices(controller);
> > +
> > +???????return 0;
> > +
> > +err_put:
> > +???????put_device(&controller->dev);
> > +err_id:
> > +???????fwnode_handle_put(controller->dev.fwnode);
> > +???????ida_free(&peci_controller_ida, controller->id);
> 
> I'd expect these to be released by ->release().
> 

Ack.

> > +
> > +???????return ret;
> > +}
> > +EXPORT_SYMBOL_NS_GPL(peci_controller_add, PECI);
> 
> I think it's cleaner to declare symbol namespaces in the Makefile. In
> this case, add:
> 
> cflags-y += -DDEFAULT_SYMBOL_NAMESPACE=PECI
> 
> ...and just use EXPORT_SYMBOL_GPL as normal in the C file.
> 
  
I kind of prefer the more verbose EXPORT_SYMBOL_NS_GPL - it also
doesn't "hide" the fact that we're using namespaces (everything is in
the C file rather than mixed into Makefile), but it's not a strong
opinion, so sure - I can change this.

> > +
> > +static int _unregister(struct device *dev, void *dummy)
> > +{
> > +???????/* Just a stub, no support for actual devices yet */
> 
> At least for me, I think it wastes review time to consider empty
> stubs. Just add the
> whole thing back when it's actually used so it can be reviewed
> properly for suitability.

Just like with peci_controller_scan_devices - logically it belongs to
the controller, and is used by the controller, it's just that the
devices will be added later in the series.

> 
> > +???????return 0;
> > +}
> > +
> > +/**
> > + * peci_controller_remove - Delete PECI controller
> > + * @controller: the PECI controller to be removed
> > + *
> > + * This call is used only by PECI controller drivers, which are
> > the only ones
> > + * directly touching chip registers.
> > + *
> > + * Note that this function also drops a reference to the
> > controller.
> > + */
> > +void peci_controller_remove(struct peci_controller *controller)
> > +{
> > +???????pm_runtime_disable(&controller->dev);
> > +???????/*
> > +??????? * Detach any active PECI devices. This can't fail, thus we
> > do not
> > +??????? * check the returned value.
> > +??????? */
> > +???????device_for_each_child_reverse(&controller->dev, NULL,
> > _unregister);
> 
> How does the peci_controller_remove() get called with children still
> beneath it? Can that possibility be precluded by arranging for
> children to be removed first?

When we're unbinding the controller driver from its backing device (or
just removing the module) with children devices still present in the
system.

Yes, it could be precluded, but I don't think we should prevent this
(forcing the user to manually remove all the children devices first).

> 
> For example, given peci_controller_add is called from another's
> driver
> probe routine, this unregistration could be handled by a devm action.
> 

Ok, I think this should just fall into place naturally after alloc/init
gets split.

> 
> > +
> > +???????device_unregister(&controller->dev);
> > +???????fwnode_handle_put(controller->dev.fwnode);
> > +???????ida_free(&peci_controller_ida, controller->id);
> 
> Another open coded copy of release code that belongs in ->release()?
> 

Ack.

> > +}
> > +EXPORT_SYMBOL_NS_GPL(peci_controller_remove, PECI);
> > +
> > +struct bus_type peci_bus_type = {
> > +???????.name???????????= "peci",
> > +???????.bus_groups?????= peci_bus_groups,
> > +};
> > +
> > +static int __init peci_init(void)
> > +{
> > +???????int ret;
> > +
> > +???????ret = bus_register(&peci_bus_type);
> > +???????if (ret < 0) {
> > +???????????????pr_err("failed to register PECI bus type!\n");
> > +???????????????return ret;
> > +???????}
> > +
> > +???????return 0;
> > +}
> > +subsys_initcall(peci_init);
> 
> You can't have subsys_initcall in a module. If you actually need
> subsys_initcall then this can't be a module. Are you sure this can't
> be module_init()?
> 

Sure, I'll fix this in v2.

> > +
> > +static void __exit peci_exit(void)
> > +{
> > +???????bus_unregister(&peci_bus_type);
> > +}
> > +module_exit(peci_exit);
> > +
> > +MODULE_AUTHOR("Jason M Bills <jason.m.bills@linux.intel.com>");
> > +MODULE_AUTHOR("Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>");
> > +MODULE_AUTHOR("Iwona Winiarska <iwona.winiarska@intel.com>");
> 
> Is MAINTAINERS sufficient? Do you all want to be contacted by end
> users, or just kernel developers. If it's the former then keep this,
> if it's the latter then MAINTAINERS is sufficient.
> 

It's the former.

> > +MODULE_DESCRIPTION("PECI bus core module");
> > +MODULE_LICENSE("GPL");
> > diff --git a/drivers/peci/internal.h b/drivers/peci/internal.h
> > new file mode 100644
> > index 000000000000..80c61bcdfc6b
> > --- /dev/null
> > +++ b/drivers/peci/internal.h
> > @@ -0,0 +1,20 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/* Copyright (c) 2018-2021 Intel Corporation */
> > +
> > +#ifndef __PECI_INTERNAL_H
> > +#define __PECI_INTERNAL_H
> > +
> > +#include <linux/device.h>
> > +#include <linux/types.h>
> > +
> > +struct peci_controller;
> > +struct attribute_group;
> > +
> > +extern struct bus_type peci_bus_type;
> > +extern const struct attribute_group *peci_bus_groups[];
> > +
> > +extern struct device_type peci_controller_type;
> > +
> > +int peci_controller_scan_devices(struct peci_controller
> > *controller);
> > +
> > +#endif /* __PECI_INTERNAL_H */
> > diff --git a/drivers/peci/sysfs.c b/drivers/peci/sysfs.c
> > new file mode 100644
> > index 000000000000..36c5e2a18a92
> > --- /dev/null
> > +++ b/drivers/peci/sysfs.c
> > @@ -0,0 +1,48 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +// Copyright (c) 2021 Intel Corporation
> > +
> > +#include <linux/peci.h>
> > +
> > +#include "internal.h"
> > +
> > +static int rescan_controller(struct device *dev, void *data)
> > +{
> > +???????if (dev->type != &peci_controller_type)
> > +???????????????return 0;
> > +
> > +???????return
> > peci_controller_scan_devices(to_peci_controller(dev));
> > +}
> > +
> > +static ssize_t rescan_store(struct bus_type *bus, const char *buf,
> > size_t count)
> > +{
> > +???????bool res;
> > +???????int ret;
> > +
> > +???????ret = kstrtobool(buf, &res);
> > +???????if (ret)
> > +???????????????return ret;
> > +
> > +???????if (!res)
> > +???????????????return count;
> > +
> > +???????ret = bus_for_each_dev(&peci_bus_type, NULL, NULL,
> > rescan_controller);
> > +???????if (ret)
> > +???????????????return ret;
> > +
> > +???????return count;
> > +}
> > +static BUS_ATTR_WO(rescan);
> 
> No Documentation/ABI entry for this attribute, which means I'm not
> sure if it's suitable because it's unreviewable what it actually does
> reviewing this patch as a standalone.
> 

We're expecting to use "rescan" in the similar way as it is used for
PCIe or USB.
BMC can boot up when the system is still in S5 (without any guarantee
that it will ever change this state - the user can never turn the
platform on :) ). If the controller is loaded and the platform allows
it to discover devices - great (the scan happens as last step of
controller_add), if not - userspace can use rescan.

I'll add documentation in v2.

> > +
> > +static struct attribute *peci_bus_attrs[] = {
> > +???????&bus_attr_rescan.attr,
> > +???????NULL
> > +};
> > +
> > +static const struct attribute_group peci_bus_group = {
> > +???????.attrs = peci_bus_attrs,
> > +};
> > +
> > +const struct attribute_group *peci_bus_groups[] = {
> > +???????&peci_bus_group,
> > +???????NULL
> > +};
> > diff --git a/include/linux/peci.h b/include/linux/peci.h
> > new file mode 100644
> > index 000000000000..cdf3008321fd
> > --- /dev/null
> > +++ b/include/linux/peci.h
> > @@ -0,0 +1,82 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/* Copyright (c) 2018-2021 Intel Corporation */
> > +
> > +#ifndef __LINUX_PECI_H
> > +#define __LINUX_PECI_H
> > +
> > +#include <linux/device.h>
> > +#include <linux/kernel.h>
> > +#include <linux/mutex.h>
> > +#include <linux/types.h>
> > +
> > +struct peci_request;
> > +
> > +/**
> > + * struct peci_controller - PECI controller
> > + * @dev: device object to register PECI controller to the device
> > model
> > + * @xfer: PECI transfer function
> > + * @bus_lock: lock used to protect multiple callers
> > + * @id: PECI controller ID
> > + *
> > + * PECI controllers usually connect to their drivers using non-
> > PECI bus,
> > + * such as the platform bus.
> > + * Each PECI controller can communicate with one or more PECI
> > devices.
> > + */
> > +struct peci_controller {
> > +???????struct device dev;
> > +???????int (*xfer)(struct peci_controller *controller, u8 addr,
> > struct peci_request *req);
> 
> Each device will have a different way to do a PECI transfer?
> 
> I thought PECI was a standard...
> 

The "standard" part only applies to the connection between the
controller and the devices - not the connection between controller and
the rest of the system on which the controller resides in.
xfer is vendor specific. 

> > +???????struct mutex bus_lock; /* held for the duration of xfer */
> 
> What is it actually locking? For example, there is a mantra that goes
> "lock data, not code", and this comment seems to imply that no
> specific
> data is being locked.
> 

PECI-wire interface requires that the response follows the request -
and that should hold for all devices behind a given controller.
In other words, assuming that we have two devices, d1 and d2, we need
to have: d1.req, d1.resp, d2.req, d2.resp. Single xfer takes care of
both request and response.

I would like to eventually move that lock into individual controllers,
but before that happens - I'd like to have a reasoning behind it.
If we have interfaces that allow us to decouple requests from responses
or devices that can handle servicing more than one requests at a time,
the lock will go away from peci-core.

> 
> > +???????u8 id;
> 
> No possible way to have more than 256 controllers per system?
> 

For real world scenarios - I expect single digit number of controllers
per system. The boards with HW compatible with "aspeed,ast2xxx-peci"
contain just one instance of this controller.
I expect more in the future (e.g. different "physical" transport), but
definitely not more than 256 per system.

> > +};
> > +
> > +int peci_controller_add(struct peci_controller *controller, struct
> > device *parent);
> > +void peci_controller_remove(struct peci_controller *controller);
> > +
> > +static inline struct peci_controller *to_peci_controller(void *d)
> > +{
> > +???????return container_of(d, struct peci_controller, dev);
> > +}
> > +
> > +/**
> > + * struct peci_device - PECI device
> > + * @dev: device object to register PECI device to the device model
> > + * @controller: manages the bus segment hosting this PECI device
> > + * @addr: address used on the PECI bus connected to the parent
> > controller
> > + *
> > + * A peci_device identifies a single device (i.e. CPU) connected
> > to a PECI bus.
> > + * The behaviour exposed to the rest of the system is defined by
> > the PECI driver
> > + * managing the device.
> > + */
> > +struct peci_device {
> > +???????struct device dev;
> > +???????struct peci_controller *controller;
> 
> Is the device a child of the controller? If yes, then no need for a a
> separate pointer vs "to_peci_controller(peci_dev->parent)"
> 

Yeah, it's redundant - I'll remove it.

Thank you
-Iwona


