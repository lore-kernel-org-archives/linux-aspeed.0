From: Zev Weiss <zweiss@equinix.com>
Date: Thu, 29 Jul 2021 20:50:13 +0000
Subject: [PATCH 08/14] peci: Add device detection
In-Reply-To: <47440a8329ce06c41ca9746db42cb1d66154ea46.camel@intel.com>
References: <20210712220447.957418-1-iwona.winiarska@intel.com>
 <20210712220447.957418-9-iwona.winiarska@intel.com>
 <20210727174900.GR8018@packtop>
 <47440a8329ce06c41ca9746db42cb1d66154ea46.camel@intel.com>
Message-ID: <20210729205013.GW8018@packtop>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jul 29, 2021 at 01:55:19PM CDT, Winiarska, Iwona wrote:
>On Tue, 2021-07-27 at 17:49 +0000, Zev Weiss wrote:
>> On Mon, Jul 12, 2021 at 05:04:41PM CDT, Iwona Winiarska wrote:
>> > Since PECI devices are discoverable, we can dynamically detect devices
>> > that are actually available in the system.
>> >
>> > This change complements the earlier implementation by rescanning PECI
>> > bus to detect available devices. For this purpose, it also introduces the
>> > minimal API for PECI requests.
>> >
>> > Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
>> > Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> > ---
>> > drivers/peci/Makefile?? |?? 2 +-
>> > drivers/peci/core.c???? |? 13 ++++-
>> > drivers/peci/device.c?? | 111 ++++++++++++++++++++++++++++++++++++++++
>> > drivers/peci/internal.h |? 15 ++++++
>> > drivers/peci/request.c? |? 74 +++++++++++++++++++++++++++
>> > drivers/peci/sysfs.c??? |? 34 ++++++++++++
>> > 6 files changed, 246 insertions(+), 3 deletions(-)
>> > create mode 100644 drivers/peci/device.c
>> > create mode 100644 drivers/peci/request.c
>> >
>> > diff --git a/drivers/peci/Makefile b/drivers/peci/Makefile
>> > index 621a993e306a..917f689e147a 100644
>> > --- a/drivers/peci/Makefile
>> > +++ b/drivers/peci/Makefile
>> > @@ -1,7 +1,7 @@
>> > # SPDX-License-Identifier: GPL-2.0-only
>> >
>> > # Core functionality
>> > -peci-y := core.o sysfs.o
>> > +peci-y := core.o request.o device.o sysfs.o
>> > obj-$(CONFIG_PECI) += peci.o
>> >
>> > # Hardware specific bus drivers
>> > diff --git a/drivers/peci/core.c b/drivers/peci/core.c
>> > index 0ad00110459d..ae7a9572cdf3 100644
>> > --- a/drivers/peci/core.c
>> > +++ b/drivers/peci/core.c
>> > @@ -31,7 +31,15 @@ struct device_type peci_controller_type = {
>> >
>> > int peci_controller_scan_devices(struct peci_controller *controller)
>> > {
>> > -???????/* Just a stub, no support for actual devices yet */
>> > +???????int ret;
>> > +???????u8 addr;
>> > +
>> > +???????for (addr = PECI_BASE_ADDR; addr < PECI_BASE_ADDR +
>> > PECI_DEVICE_NUM_MAX; addr++) {
>> > +???????????????ret = peci_device_create(controller, addr);
>> > +???????????????if (ret)
>> > +???????????????????????return ret;
>> > +???????}
>> > +
>> > ????????return 0;
>> > }
>> >
>> > @@ -106,7 +114,8 @@ EXPORT_SYMBOL_NS_GPL(peci_controller_add, PECI);
>> >
>> > static int _unregister(struct device *dev, void *dummy)
>> > {
>> > -???????/* Just a stub, no support for actual devices yet */
>> > +???????peci_device_destroy(to_peci_device(dev));
>> > +
>> > ????????return 0;
>> > }
>> >
>> > diff --git a/drivers/peci/device.c b/drivers/peci/device.c
>> > new file mode 100644
>> > index 000000000000..1124862211e2
>> > --- /dev/null
>> > +++ b/drivers/peci/device.c
>> > @@ -0,0 +1,111 @@
>> > +// SPDX-License-Identifier: GPL-2.0-only
>> > +// Copyright (c) 2018-2021 Intel Corporation
>> > +
>> > +#include <linux/peci.h>
>> > +#include <linux/slab.h>
>> > +
>> > +#include "internal.h"
>> > +
>> > +static int peci_detect(struct peci_controller *controller, u8 addr)
>> > +{
>> > +???????struct peci_request *req;
>> > +???????int ret;
>> > +
>> > +???????req = peci_request_alloc(NULL, 0, 0);
>> > +???????if (!req)
>> > +???????????????return -ENOMEM;
>> > +
>>
>> Might be worth a brief comment here noting that an empty request happens
>> to be the format of a PECI ping command (and/or change the name of the
>> function to peci_ping()).
>
>I'll add a comment:
>"We are using PECI Ping command to detect presence of PECI devices."
>

Well, what I was more aiming to get at was that to someone not
intimately familiar with the PECI protocol it's not immediately obvious
from the code that it in fact implements a ping (there's no 'msg->cmd =
PECI_CMD_PING' or anything), so I was hoping for something that would
just make that slightly more explicit.

>>
>> > +???????mutex_lock(&controller->bus_lock);
>> > +???????ret = controller->xfer(controller, addr, req);
>> > +???????mutex_unlock(&controller->bus_lock);
>> > +
>> > +???????peci_request_free(req);
>> > +
>> > +???????return ret;
>> > +}
>> > +
>> > +static bool peci_addr_valid(u8 addr)
>> > +{
>> > +???????return addr >= PECI_BASE_ADDR && addr < PECI_BASE_ADDR +
>> > PECI_DEVICE_NUM_MAX;
>> > +}
>> > +
>> > +static int peci_dev_exists(struct device *dev, void *data)
>> > +{
>> > +???????struct peci_device *device = to_peci_device(dev);
>> > +???????u8 *addr = data;
>> > +
>> > +???????if (device->addr == *addr)
>> > +???????????????return -EBUSY;
>> > +
>> > +???????return 0;
>> > +}
>> > +
>> > +int peci_device_create(struct peci_controller *controller, u8 addr)
>> > +{
>> > +???????struct peci_device *device;
>> > +???????int ret;
>> > +
>> > +???????if (WARN_ON(!peci_addr_valid(addr)))
>> > +???????????????return -EINVAL;
>>
>> Wondering about the necessity of this check (and the peci_addr_valid()
>> function) -- as of the end of this patch series, there's only one caller
>> of peci_device_create(), and it's peci_controller_scan_devices() looping
>> from PECI_BASE_ADDR to PECI_BASE_ADDR + PECI_DEVICE_NUM_MAX, so
>> checking that the address is in that range seems a bit redundant.? Do we
>> anticipate that we might gain additional callers in the future that
>> could run a non-zero risk of passing a bad address?
>
>It's just a sanity check to avoid any surprises if the code changes in the
>future.
>
>>
>> > +
>> > +???????/* Check if we have already detected this device before. */
>> > +???????ret = device_for_each_child(&controller->dev, &addr,
>> > peci_dev_exists);
>> > +???????if (ret)
>> > +???????????????return 0;
>> > +
>> > +???????ret = peci_detect(controller, addr);
>> > +???????if (ret) {
>> > +???????????????/*
>> > +??????????????? * Device not present or host state doesn't allow successful
>> > +??????????????? * detection at this time.
>> > +??????????????? */
>> > +???????????????if (ret == -EIO || ret == -ETIMEDOUT)
>> > +???????????????????????return 0;
>>
>> Do we really want to be ignoring EIO here?? From a look at
>> aspeed_peci_xfer(), it looks like the only path that would produce that
>> is the non-timeout, non-CMD_DONE case, which I guess happens on
>> contention or FCS errors and such.? Should we maybe have some automatic
>> (limited) retry loop for cases like those?
>
>Yes, we want to ignore EIO here.
>It may be returned when we get "Bad Write FCS", after we try to ping non-
>existing PECI device.
>
>>
>> > +
>> > +???????????????return ret;
>> > +???????}
>> > +
>> > +???????device = kzalloc(sizeof(*device), GFP_KERNEL);
>> > +???????if (!device)
>> > +???????????????return -ENOMEM;
>> > +
>> > +???????device->controller = controller;
>> > +???????device->addr = addr;
>> > +???????device->dev.parent = &device->controller->dev;
>> > +???????device->dev.bus = &peci_bus_type;
>> > +???????device->dev.type = &peci_device_type;
>> > +
>> > +???????ret = dev_set_name(&device->dev, "%d-%02x", controller->id, device-
>> > >addr);
>> > +???????if (ret)
>> > +???????????????goto err_free;
>> > +
>> > +???????ret = device_register(&device->dev);
>> > +???????if (ret)
>> > +???????????????goto err_put;
>> > +
>> > +???????return 0;
>> > +
>> > +err_put:
>> > +???????put_device(&device->dev);
>> > +err_free:
>> > +???????kfree(device);
>> > +
>> > +???????return ret;
>> > +}
>> > +
>> > +void peci_device_destroy(struct peci_device *device)
>> > +{
>> > +???????device_unregister(&device->dev);
>> > +}
>> > +
>> > +static void peci_device_release(struct device *dev)
>> > +{
>> > +???????struct peci_device *device = to_peci_device(dev);
>> > +
>> > +???????kfree(device);
>> > +}
>> > +
>> > +struct device_type peci_device_type = {
>> > +???????.groups?????????= peci_device_groups,
>> > +???????.release????????= peci_device_release,
>> > +};
>> > diff --git a/drivers/peci/internal.h b/drivers/peci/internal.h
>> > index 80c61bcdfc6b..6b139adaf6b8 100644
>> > --- a/drivers/peci/internal.h
>> > +++ b/drivers/peci/internal.h
>> > @@ -9,6 +9,21 @@
>> >
>> > struct peci_controller;
>> > struct attribute_group;
>> > +struct peci_device;
>> > +struct peci_request;
>> > +
>> > +/* PECI CPU address range 0x30-0x37 */
>> > +#define PECI_BASE_ADDR?????????0x30
>> > +#define PECI_DEVICE_NUM_MAX????????????8
>> > +
>> > +struct peci_request *peci_request_alloc(struct peci_device *device, u8
>> > tx_len, u8 rx_len);
>> > +void peci_request_free(struct peci_request *req);
>> > +
>> > +extern struct device_type peci_device_type;
>> > +extern const struct attribute_group *peci_device_groups[];
>> > +
>> > +int peci_device_create(struct peci_controller *controller, u8 addr);
>> > +void peci_device_destroy(struct peci_device *device);
>> >
>> > extern struct bus_type peci_bus_type;
>> > extern const struct attribute_group *peci_bus_groups[];
>> > diff --git a/drivers/peci/request.c b/drivers/peci/request.c
>> > new file mode 100644
>> > index 000000000000..78cee51dfae1
>> > --- /dev/null
>> > +++ b/drivers/peci/request.c
>> > @@ -0,0 +1,74 @@
>> > +// SPDX-License-Identifier: GPL-2.0-only
>> > +// Copyright (c) 2021 Intel Corporation
>> > +
>> > +#include <linux/export.h>
>> > +#include <linux/peci.h>
>> > +#include <linux/slab.h>
>> > +#include <linux/types.h>
>> > +
>> > +#include "internal.h"
>> > +
>> > +/**
>> > + * peci_request_alloc() - allocate &struct peci_request with buffers with
>> > given lengths
>> > + * @device: PECI device to which request is going to be sent
>> > + * @tx_len: requested TX buffer length
>> > + * @rx_len: requested RX buffer length
>> > + *
>> > + * Return: A pointer to a newly allocated &struct peci_request on success
>> > or NULL otherwise.
>> > + */
>> > +struct peci_request *peci_request_alloc(struct peci_device *device, u8
>> > tx_len, u8 rx_len)
>> > +{
>> > +???????struct peci_request *req;
>> > +???????u8 *tx_buf, *rx_buf;
>> > +
>> > +???????req = kzalloc(sizeof(*req), GFP_KERNEL);
>> > +???????if (!req)
>> > +???????????????return NULL;
>> > +
>> > +???????req->device = device;
>> > +
>> > +???????/*
>> > +??????? * PECI controllers that we are using now don't support DMA, this
>> > +??????? * should be converted to DMA API once support for controllers that
>> > do
>> > +??????? * allow it is added to avoid an extra copy.
>> > +??????? */
>> > +???????if (tx_len) {
>> > +???????????????tx_buf = kzalloc(tx_len, GFP_KERNEL);
>> > +???????????????if (!tx_buf)
>> > +???????????????????????goto err_free_req;
>> > +
>> > +???????????????req->tx.buf = tx_buf;
>> > +???????????????req->tx.len = tx_len;
>> > +???????}
>> > +
>> > +???????if (rx_len) {
>> > +???????????????rx_buf = kzalloc(rx_len, GFP_KERNEL);
>> > +???????????????if (!rx_buf)
>> > +???????????????????????goto err_free_tx;
>> > +
>> > +???????????????req->rx.buf = rx_buf;
>> > +???????????????req->rx.len = rx_len;
>> > +???????}
>> > +
>>
>> As long as we're punting on DMA support, could we do the whole thing in
>> a single allocation instead of three?? It'd add some pointer arithmetic,
>> but would also simplify the error-handling/deallocation paths a bit.
>>
>> Or, given that the one controller we're currently supporting has a
>> hardware limit of 32 bytes per transfer anyway, maybe just inline
>> fixed-size rx/tx buffers into struct peci_request and have callers keep
>> them on the stack instead of kmalloc()-ing them?
>
>I disagree on error handling (it's not complicated) - however, one argument for
>doing a single alloc (or moving the buffers as fixed-size arrays inside struct
>peci_request) is that single kzalloc is going to be faster than 3. But I don't
>expect it to show up on any perf profiles for now (since peci-wire interface is
>not a speed demon).
>
>I wanted to avoid defining max size for TX and RX in peci-core.
>Do you have a strong opinion against multiple alloc? If yes, I can go with
>fixed-size arrays inside struct peci_request.
>

As is it's certainly not terribly complicated in an absolute sense, but
comparatively speaking the cleanup path for a single allocation is still
simpler, no?

Making it more efficient would definitely be a nice benefit too (perhaps
a more significant one) -- in a typical deployment I'd guess this code
path will see roughly socket_count + total_core_count executions per
second?  On a big multi-socket system that could end up being a
reasonably large number (>100), so while it may not end up as a major
hot spot in a system-wide profile, it seems like it might be worth
having it do 1/3 as many allocations if it's reasonably easy to do.
(And while I don't think the kernel is generally at fault for this, from
what I've seen of OpenBMC as a whole I think it might benefit from a bit
more overall frugality with CPU cycles.)

As for a fixed max request size and inlined buffers, I definitely
understand not wanting to put a cap on that in the generic PECI core --
and actually, looking at the peci-npcm code from previous iterations of
the PECI patchset, it looks like the Nuvoton hardware has significantly
larger size limits (127 bytes if I'm reading things right) that might be
a bit bulky for on-stack allocation.  So while that's appealing
efficiency-wise and (IMO) aesthetically, perhaps it's not ultimately
real viable.

Hmm, though (thinking out loud) I suppose we could also get down to a
zero-allocation common case by having the driver hold on to a request
struct and reuse it across transfers, given that they're all serialized
by a mutex anyway?

>Thanks
>-Iwona
>
>>
>> > +???????return req;
>> > +
>> > +err_free_tx:
>> > +???????kfree(req->tx.buf);
>> > +err_free_req:
>> > +???????kfree(req);
>> > +
>> > +???????return NULL;
>> > +}
>> > +EXPORT_SYMBOL_NS_GPL(peci_request_alloc, PECI);
>> > +
>> > +/**
>> > + * peci_request_free() - free peci_request
>> > + * @req: the PECI request to be freed
>> > + */
>> > +void peci_request_free(struct peci_request *req)
>> > +{
>> > +???????kfree(req->rx.buf);
>> > +???????kfree(req->tx.buf);
>> > +???????kfree(req);
>> > +}
>> > +EXPORT_SYMBOL_NS_GPL(peci_request_free, PECI);
>> > diff --git a/drivers/peci/sysfs.c b/drivers/peci/sysfs.c
>> > index 36c5e2a18a92..db9ef05776e3 100644
>> > --- a/drivers/peci/sysfs.c
>> > +++ b/drivers/peci/sysfs.c
>> > @@ -1,6 +1,8 @@
>> > // SPDX-License-Identifier: GPL-2.0-only
>> > // Copyright (c) 2021 Intel Corporation
>> >
>> > +#include <linux/device.h>
>> > +#include <linux/kernel.h>
>> > #include <linux/peci.h>
>> >
>> > #include "internal.h"
>> > @@ -46,3 +48,35 @@ const struct attribute_group *peci_bus_groups[] = {
>> > ????????&peci_bus_group,
>> > ????????NULL
>> > };
>> > +
>> > +static ssize_t remove_store(struct device *dev, struct device_attribute
>> > *attr,
>> > +?????????????????????????? const char *buf, size_t count)
>> > +{
>> > +???????struct peci_device *device = to_peci_device(dev);
>> > +???????bool res;
>> > +???????int ret;
>> > +
>> > +???????ret = kstrtobool(buf, &res);
>> > +???????if (ret)
>> > +???????????????return ret;
>> > +
>> > +???????if (res && device_remove_file_self(dev, attr))
>> > +???????????????peci_device_destroy(device);
>> > +
>> > +???????return count;
>> > +}
>> > +static DEVICE_ATTR_IGNORE_LOCKDEP(remove, 0200, NULL, remove_store);
>> > +
>> > +static struct attribute *peci_device_attrs[] = {
>> > +???????&dev_attr_remove.attr,
>> > +???????NULL
>> > +};
>> > +
>> > +static const struct attribute_group peci_device_group = {
>> > +???????.attrs = peci_device_attrs,
>> > +};
>> > +
>> > +const struct attribute_group *peci_device_groups[] = {
>> > +???????&peci_device_group,
>> > +???????NULL
>> > +};
>> > --
>> > 2.31.1
>
