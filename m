From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 16 Jul 2021 14:50:04 -0700
Subject: [PATCH 06/14] peci: Add core infrastructure
In-Reply-To: <6807a14deb52956ad2fe390b1811dd98901a642a.camel@intel.com>
References: <20210712220447.957418-1-iwona.winiarska@intel.com>
 <20210712220447.957418-7-iwona.winiarska@intel.com>
 <59428599ef7efb2521bd62c49a3bc55c710f29de.camel@intel.com>
 <6807a14deb52956ad2fe390b1811dd98901a642a.camel@intel.com>
Message-ID: <CAPcyv4ifjCZSUuk5H5qw6sjt5vdAkTfNzd+4imu+9e_iOt74gQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jul 16, 2021 at 2:08 PM Winiarska, Iwona
<iwona.winiarska@intel.com> wrote:
[..]
> > > diff --git a/drivers/peci/Kconfig b/drivers/peci/Kconfig
> > > new file mode 100644
> > > index 000000000000..601cc3c3c852
> > > --- /dev/null
> > > +++ b/drivers/peci/Kconfig
> > > @@ -0,0 +1,14 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only
> > > +
> > > +menuconfig PECI
> > > +       tristate "PECI support"
> > > +       help
> > > +         The Platform Environment Control Interface (PECI) is an interface
> > > +         that provides a communication channel to Intel processors and
> > > +         chipset components from external monitoring or control devices.
> > > +
> > > +         If you want PECI support, you should say Y here and also to the
> > > +         specific driver for your bus adapter(s) below.
> >
> > The user is reading this help text to decide if they want PECI
> > support, so clarifying that if they want PECI support they should turn
> > it on is not all that helpful. I would say "If you are building a
> > kernel for a Board Management Controller (BMC) say Y. If unsure say
> > N".
>
> Since PECI is only available on Intel platforms, perhaps something
> like:
> "If you are building a Board Management Controller (BMC) kernel for
> Intel platform say Y"?
>

Looks good.

> >
> > > +
> > > +         This support is also available as a module. If so, the module
> > > +         will be called peci.
> > > diff --git a/drivers/peci/Makefile b/drivers/peci/Makefile
> > > new file mode 100644
> > > index 000000000000..2bb2f51bcda7
> > > --- /dev/null
> > > +++ b/drivers/peci/Makefile
> > > @@ -0,0 +1,5 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only
> > > +
> > > +# Core functionality
> > > +peci-y := core.o sysfs.o
> > > +obj-$(CONFIG_PECI) += peci.o
> > > diff --git a/drivers/peci/core.c b/drivers/peci/core.c
> > > new file mode 100644
> > > index 000000000000..0ad00110459d
> > > --- /dev/null
> > > +++ b/drivers/peci/core.c
> > > @@ -0,0 +1,166 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +// Copyright (c) 2018-2021 Intel Corporation
> > > +
> > > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > > +
> > > +#include <linux/bug.h>
> > > +#include <linux/device.h>
> > > +#include <linux/export.h>
> > > +#include <linux/idr.h>
> > > +#include <linux/module.h>
> > > +#include <linux/of.h>
> > > +#include <linux/peci.h>
> > > +#include <linux/pm_runtime.h>
> > > +#include <linux/property.h>
> > > +#include <linux/slab.h>
> > > +
> > > +#include "internal.h"
> > > +
> > > +static DEFINE_IDA(peci_controller_ida);
> > > +
> > > +static void peci_controller_dev_release(struct device *dev)
> > > +{
> > > +       struct peci_controller *controller = to_peci_controller(dev);
> > > +
> > > +       mutex_destroy(&controller->bus_lock);
> > > +}
> > > +
> > > +struct device_type peci_controller_type = {
> > > +       .release        = peci_controller_dev_release,
> > > +};
> >
> > I have not read further than patch 6 in this set, so I'm hoping there
> > is an explanation for this. As it stands it looks like a red flag that
> > the release function is not actually releasing anything?
> >
>
> Ok, that's related to other comments here and in patch 7. I'll try to
> refactor this. I'm thinking about splitting the "controller_add" into
> separate "alloc" and "add" (or init? register?). And perhaps integrate
> that into devm, so that controller can be allocated using devres, tying
> that into lifetime of underlying platform device.
>

The devres scheme cannot be used for allocating an object that
contains a 'struct device'. The devres lifetime is until
dev->driver.release(dev), 'struct device' lifetime is until last
put_device() where your driver has no idea what other agent in the
system might have taken a reference. That said, devres *can* be used
for triggering automatic device_del() you can see devm_cxl_add_port()
[1] as an example:

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/cxl/core.c#n333

> > > +
> > > +int peci_controller_scan_devices(struct peci_controller *controller)
> > > +{
> > > +       /* Just a stub, no support for actual devices yet */
> > > +       return 0;
> > > +}
> >
> > Move this to the patch where it is needed.
>
> It's used in this patch (in sysfs and controller add), but at this
> point we haven't introduced devices yet.
> I would have to move this to patch 8 - but I don't think it belongs
> there.

I would expect if patch8 fills this in then this and its caller belong
there so the mechanism can be reviewed together.

> Will it make more sense if I introduce sysfs documentation here?

The sysfs documentation should be in the same patch that adds the attribute.

> Or as a completely separate patch?

A new / separate "implement rescan" would work too...

> I wanted to avoid going too far with split granularity, and just go
> with high-level concepts starting with the controller.

Sure, I think this patchset has a reasonable split, but this rescan
feature seems unique enough to get its own patch.


>
> >
> > > +
> > > +/**
> > > + * peci_controller_add() - Add PECI controller
> > > + * @controller: the PECI controller to be added
> > > + * @parent: device object to be registered as a parent
> > > + *
> > > + * In final stage of its probe(), peci_controller driver should include calling
> >
> > s/should include calling/calls/
> >
>
> Ok.
>
> > > + * peci_controller_add() to register itself with the PECI bus.
> > > + * The caller is responsible for allocating the struct
> > > peci_controller and
> > > + * managing its lifetime, calling peci_controller_remove() prior
> > > to releasing
> > > + * the allocation.
> > > + *
> > > + * It returns zero on success, else a negative error code
> > > (dropping the
> > > + * controller's refcount). After a successful return, the caller
> > > is responsible
> > > + * for calling peci_controller_remove().
> > > + *
> > > + * Return: 0 if succeeded, other values in case errors.
> > > + */
> > > +int peci_controller_add(struct peci_controller *controller, struct
> > > device *parent)
> > > +{
> > > +       struct fwnode_handle *node =
> > > fwnode_handle_get(dev_fwnode(parent));
> > > +       int ret;
> > > +
> > > +       if (WARN_ON(!controller->xfer))
> >
> > Why WARN()? What is 'xfer', and what is likelihood the caller forgets
> > to set it? For something critical like this the WARN is likely
> > overkill.
> >
>
> Very unlikely - 'xfer' provides "connection" with hardware so it's
> rather mandatory.
> It indicates programmer error, so WARN() with all its consequences
> (taint and so on) seemed adequate.
>
> Do you suggest to downgrade it to pr_err()?

I'd say no report at all. It's not relevant to the user, and at worst
it's a liability for environments that want to audit and control all
kernel warnings. The chances that a future developer makes the
mistake, or does not figure out quickly that they forgot to set
->xfer() is low.

[..]
> > > +
> > > +       return ret;
> > > +}
> > > +EXPORT_SYMBOL_NS_GPL(peci_controller_add, PECI);
> >
> > I think it's cleaner to declare symbol namespaces in the Makefile. In
> > this case, add:
> >
> > cflags-y += -DDEFAULT_SYMBOL_NAMESPACE=PECI
> >
> > ...and just use EXPORT_SYMBOL_GPL as normal in the C file.
> >
>
> I kind of prefer the more verbose EXPORT_SYMBOL_NS_GPL - it also
> doesn't "hide" the fact that we're using namespaces (everything is in
> the C file rather than mixed into Makefile), but it's not a strong
> opinion, so sure - I can change this.
>

Perhaps as a tie breaker, the maintainer you are submitting this to,
Greg, uses the -DDEFAULT_SYMBOL_NAMESPACE scheme in his subsystem,
drivers/usb/.

[..]
> > > +static BUS_ATTR_WO(rescan);
> >
> > No Documentation/ABI entry for this attribute, which means I'm not
> > sure if it's suitable because it's unreviewable what it actually does
> > reviewing this patch as a standalone.
> >
>
> We're expecting to use "rescan" in the similar way as it is used for
> PCIe or USB.
> BMC can boot up when the system is still in S5 (without any guarantee
> that it will ever change this state - the user can never turn the
> platform on :) ). If the controller is loaded and the platform allows
> it to discover devices - great (the scan happens as last step of
> controller_add), if not - userspace can use rescan.

There's no interrupt or notification to the BMC that the power-on
event happened? Seems fragile to leave this responsibility to
userspace.

I had assumed rescan for those other buses is an exceptional mechanism
for platform debug, not a typical usage flow for userspace.

>
> I'll add documentation in v2.
>
> > > +
> > > +static struct attribute *peci_bus_attrs[] = {
> > > +       &bus_attr_rescan.attr,
> > > +       NULL
> > > +};
> > > +
> > > +static const struct attribute_group peci_bus_group = {
> > > +       .attrs = peci_bus_attrs,
> > > +};
> > > +
> > > +const struct attribute_group *peci_bus_groups[] = {
> > > +       &peci_bus_group,
> > > +       NULL
> > > +};
> > > diff --git a/include/linux/peci.h b/include/linux/peci.h
> > > new file mode 100644
> > > index 000000000000..cdf3008321fd
> > > --- /dev/null
> > > +++ b/include/linux/peci.h
> > > @@ -0,0 +1,82 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > > +/* Copyright (c) 2018-2021 Intel Corporation */
> > > +
> > > +#ifndef __LINUX_PECI_H
> > > +#define __LINUX_PECI_H
> > > +
> > > +#include <linux/device.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/mutex.h>
> > > +#include <linux/types.h>
> > > +
> > > +struct peci_request;
> > > +
> > > +/**
> > > + * struct peci_controller - PECI controller
> > > + * @dev: device object to register PECI controller to the device
> > > model
> > > + * @xfer: PECI transfer function
> > > + * @bus_lock: lock used to protect multiple callers
> > > + * @id: PECI controller ID
> > > + *
> > > + * PECI controllers usually connect to their drivers using non-
> > > PECI bus,
> > > + * such as the platform bus.
> > > + * Each PECI controller can communicate with one or more PECI
> > > devices.
> > > + */
> > > +struct peci_controller {
> > > +       struct device dev;
> > > +       int (*xfer)(struct peci_controller *controller, u8 addr,
> > > struct peci_request *req);
> >
> > Each device will have a different way to do a PECI transfer?
> >
> > I thought PECI was a standard...
> >
>
> The "standard" part only applies to the connection between the
> controller and the devices - not the connection between controller and
> the rest of the system on which the controller resides in.
> xfer is vendor specific.

...all PECI controllers implement different MMIO register layouts?

>
> > > +       struct mutex bus_lock; /* held for the duration of xfer */
> >
> > What is it actually locking? For example, there is a mantra that goes
> > "lock data, not code", and this comment seems to imply that no
> > specific
> > data is being locked.
> >
>
> PECI-wire interface requires that the response follows the request -
> and that should hold for all devices behind a given controller.
> In other words, assuming that we have two devices, d1 and d2, we need
> to have: d1.req, d1.resp, d2.req, d2.resp. Single xfer takes care of
> both request and response.
>
> I would like to eventually move that lock into individual controllers,
> but before that happens - I'd like to have a reasoning behind it.
> If we have interfaces that allow us to decouple requests from responses
> or devices that can handle servicing more than one requests at a time,
> the lock will go away from peci-core.

Another way to handle a "single request/response at a time" protocol
scheme is to use a single-threaded workqueue, then no lock is needed.
Requests are posted to the queue, responses are handled in the same
thread. This way callers have the option to either post work and
asynchronously poll for completion, or synchronously wait. The SCSI
libsas driver uses such a scheme.

>
> >
> > > +       u8 id;
> >
> > No possible way to have more than 256 controllers per system?
> >
>
> For real world scenarios - I expect single digit number of controllers
> per system. The boards with HW compatible with "aspeed,ast2xxx-peci"
> contain just one instance of this controller.
> I expect more in the future (e.g. different "physical" transport), but
> definitely not more than 256 per system.
>

Ok.
