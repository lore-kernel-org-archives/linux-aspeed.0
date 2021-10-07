From: Florian Fainelli <f.fainelli@gmail.com>
Date: Wed, 6 Oct 2021 19:46:08 -0700
Subject: [PATCH 0/9] Dynamic DT device nodes
In-Reply-To: <20211007000954.30621-1-zev@bewilderbeest.net>
References: <20211007000954.30621-1-zev@bewilderbeest.net>
Message-ID: <99b43bbf-b63e-d684-dd61-3087e9f22dc4@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 10/6/2021 5:09 PM, Zev Weiss wrote:
> Hello,
> 
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
> can only be accessed by one or the other at a time).  To provide that
> ability, this series adds support for a new common device-tree
> property, a boolean "dynamic" that indicates that the device may come
> and go at runtime.  When present on a node, the sysfs file for that
> node's "status" property is made writable, allowing userspace to do
> things like:
> 
>    $ echo okay > /sys/firmware/devicetree/.../status
>    $ echo reserved > /sys/firmware/devicetree/.../status
> 
> to activate and deactivate a dynamic device.

This is a completely drive by comment here, but cannot you already 
achieve what you want today by making the SPI-NOR to be loaded as a 
module, probe it when you need it from the BMC, and unbind or rmmod the 
drive when you need it on the server/host attached to the BMC?

Looking at [0] there appears to be enough signaling visible by the BMC's 
user-space that it ought to be possible?

Assuming that there may be multiple flash chips and you somehow need to 
access one in order to complete the BMC device boot, but not the other 
one(s), you could imagine unbinding the spi-nor driver from the ones you 
don't want to drive and wait until you have appropriate signaling made 
available to your or is there a risk of racing with the host in doing so?
-- 
Florian
