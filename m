From: Zev Weiss <zev@bewilderbeest.net>
Date: Thu, 7 Oct 2021 02:05:41 -0700
Subject: [PATCH 0/9] Dynamic DT device nodes
In-Reply-To: <CAHp75VdYBB_FaMr-uKswdvDBdobTYZkiE6ncoALuG+YYVoMwyw@mail.gmail.com>
References: <20211007000954.30621-1-zev@bewilderbeest.net>
 <CAHp75VdYBB_FaMr-uKswdvDBdobTYZkiE6ncoALuG+YYVoMwyw@mail.gmail.com>
Message-ID: <YV64ZbcsHvBObH2j@hatter.bewilderbeest.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Oct 07, 2021 at 12:04:41AM PDT, Andy Shevchenko wrote:
>On Thu, Oct 7, 2021 at 3:10 AM Zev Weiss <zev@bewilderbeest.net> wrote:
>> This patch series is in some ways kind of a v2 for the "Dynamic
>> aspeed-smc flash chips via 'reserved' DT status" series I posted
>> previously [0], but takes a fairly different approach suggested by Rob
>> Herring [1] and doesn't actually touch the aspeed-smc driver or
>> anything in the MTD subsystem, so I haven't marked it as such.
>>
>> To recap a bit of the context from that series, in OpenBMC there's a
>> need for certain devices (described by device-tree nodes) to be able
>> to be attached and detached at runtime (for example the SPI flash for
>> the host's firmware, which is shared between the BMC and the host but
>> can only be accessed by one or the other at a time).
>
>This seems quite dangerous. Why do you need that? 

Sometimes the host needs access to the flash (it's the host's firmware, 
after all), sometimes the BMC needs access to it (e.g. to perform an 
out-of-band update to the host's firmware).  To achieve the latter, the 
flash needs to be attached to the BMC, but that requires some careful 
coordination with the host to arbitrate which one actually has access to 
it (that coordination is handled by userspace, which then tells the 
kernel explicitly when the flash should be attached and detached).

What seems dangerous?

>Why can't device tree overlays be used?

I'm hoping to stay closer to mainline.  The OpenBMC kernel has a 
documented policy strongly encouraging upstream-first development: 
https://github.com/openbmc/docs/blob/master/kernel-development.md

I doubt Joel (the OpenBMC kernel maintainer) would be eager to start 
carrying the DT overlay patches; I'd likewise strongly prefer to avoid 
carrying them myself as additional downstream patches.  Hence the 
attempt at getting a solution to the problem upstream.

>
>> To provide that
>> ability, this series adds support for a new common device-tree
>> property, a boolean "dynamic" that indicates that the device may come
>> and go at runtime.  When present on a node, the sysfs file for that
>> node's "status" property is made writable, allowing userspace to do
>> things like:
>>
>>   $ echo okay > /sys/firmware/devicetree/.../status
>>   $ echo reserved > /sys/firmware/devicetree/.../status
>>
>> to activate and deactivate a dynamic device.
>>
>> Because it leans on the OF_DYNAMIC machinery internally, this
>> functionality will only work on busses that register for OF reconfig
>> notifications and handle them appropriately (presently platform, i2c,
>> and spi).  This series does not attempt to solve the "dynamic devices
>> further down the tree" problem [2]; my hope is that handling for OF
>> reconfig notifications can be extended to other families of devices
>> (e.g. individual MTD spi-nor flash chips) in the future.
>
>What about ACPI and software nodes?

I'm afraid I don't understand the question, can you elaborate on what 
you mean?

>How will all this affect the host?

Assuming the coordination mentioned above is done properly, the host 
will be in a quiesced state whenever the BMC is accessing the flash and 
hence won't notice much of anything at all (the BMC will detach the 
flash and relinquish control of it back to the host before the host is 
reactivated).


Zev

