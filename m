From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 7 Oct 2021 10:04:41 +0300
Subject: [PATCH 0/9] Dynamic DT device nodes
In-Reply-To: <20211007000954.30621-1-zev@bewilderbeest.net>
References: <20211007000954.30621-1-zev@bewilderbeest.net>
Message-ID: <CAHp75VdYBB_FaMr-uKswdvDBdobTYZkiE6ncoALuG+YYVoMwyw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Oct 7, 2021 at 3:10 AM Zev Weiss <zev@bewilderbeest.net> wrote:
> This patch series is in some ways kind of a v2 for the "Dynamic
> aspeed-smc flash chips via 'reserved' DT status" series I posted
> previously [0], but takes a fairly different approach suggested by Rob
> Herring [1] and doesn't actually touch the aspeed-smc driver or
> anything in the MTD subsystem, so I haven't marked it as such.
>
> To recap a bit of the context from that series, in OpenBMC there's a
> need for certain devices (described by device-tree nodes) to be able
> to be attached and detached at runtime (for example the SPI flash for
> the host's firmware, which is shared between the BMC and the host but
> can only be accessed by one or the other at a time).

This seems quite dangerous. Why do you need that? Why can't device
tree overlays be used?

> To provide that
> ability, this series adds support for a new common device-tree
> property, a boolean "dynamic" that indicates that the device may come
> and go at runtime.  When present on a node, the sysfs file for that
> node's "status" property is made writable, allowing userspace to do
> things like:
>
>   $ echo okay > /sys/firmware/devicetree/.../status
>   $ echo reserved > /sys/firmware/devicetree/.../status
>
> to activate and deactivate a dynamic device.
>
> Because it leans on the OF_DYNAMIC machinery internally, this
> functionality will only work on busses that register for OF reconfig
> notifications and handle them appropriately (presently platform, i2c,
> and spi).  This series does not attempt to solve the "dynamic devices
> further down the tree" problem [2]; my hope is that handling for OF
> reconfig notifications can be extended to other families of devices
> (e.g. individual MTD spi-nor flash chips) in the future.

What about ACPI and software nodes?
How will all this affect the host?

> [0] https://lore.kernel.org/openbmc/20210929115409.21254-1-zev at bewilderbeest.net/
> [1] https://lore.kernel.org/openbmc/CAL_JsqJH+b5oFuSP+KBLBsN5QTA6xASuqXJWXUaDkHhugXPpnQ at mail.gmail.com/
> [2] https://lore.kernel.org/openbmc/20210929220038.GS17315 at packtop/
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git/commit/?id=6663ae07d995f5fbe2988a19858b2f87e68cf929


-- 
With Best Regards,
Andy Shevchenko
