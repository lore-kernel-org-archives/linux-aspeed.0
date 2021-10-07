From: Zev Weiss <zev@bewilderbeest.net>
Date: Wed, 6 Oct 2021 22:44:03 -0700
Subject: [PATCH 0/9] Dynamic DT device nodes
In-Reply-To: <99b43bbf-b63e-d684-dd61-3087e9f22dc4@gmail.com>
References: <20211007000954.30621-1-zev@bewilderbeest.net>
 <99b43bbf-b63e-d684-dd61-3087e9f22dc4@gmail.com>
Message-ID: <YV6JIxh9TPrYNToQ@hatter.bewilderbeest.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Oct 06, 2021 at 07:46:08PM PDT, Florian Fainelli wrote:
>
>
>On 10/6/2021 5:09 PM, Zev Weiss wrote:
>>Hello,
>>
>>This patch series is in some ways kind of a v2 for the "Dynamic
>>aspeed-smc flash chips via 'reserved' DT status" series I posted
>>previously [0], but takes a fairly different approach suggested by Rob
>>Herring [1] and doesn't actually touch the aspeed-smc driver or
>>anything in the MTD subsystem, so I haven't marked it as such.
>>
>>To recap a bit of the context from that series, in OpenBMC there's a
>>need for certain devices (described by device-tree nodes) to be able
>>to be attached and detached at runtime (for example the SPI flash for
>>the host's firmware, which is shared between the BMC and the host but
>>can only be accessed by one or the other at a time).  To provide that
>>ability, this series adds support for a new common device-tree
>>property, a boolean "dynamic" that indicates that the device may come
>>and go at runtime.  When present on a node, the sysfs file for that
>>node's "status" property is made writable, allowing userspace to do
>>things like:
>>
>>   $ echo okay > /sys/firmware/devicetree/.../status
>>   $ echo reserved > /sys/firmware/devicetree/.../status
>>
>>to activate and deactivate a dynamic device.
>
>This is a completely drive by comment here, but cannot you already 
>achieve what you want today by making the SPI-NOR to be loaded as a 
>module, probe it when you need it from the BMC, and unbind or rmmod 
>the drive when you need it on the server/host attached to the BMC?
>
>Looking at [0] there appears to be enough signaling visible by the 
>BMC's user-space that it ought to be possible?
>
>Assuming that there may be multiple flash chips and you somehow need 
>to access one in order to complete the BMC device boot, but not the 
>other one(s), you could imagine unbinding the spi-nor driver from the 
>ones you don't want to drive and wait until you have appropriate 
>signaling made available to your or is there a risk of racing with the 
>host in doing so?

Hi Florian,

I sort of considered similar things at various points (in fact the 
bind/unbind technique is what I've been using as a stopgap so far), but 
I don't think it's ultimately a great solution.

In this particular case it happens that the driver for the host's BIOS 
flash (aspeed-smc) is the same driver used for the BMC's firmware flash 
and hence necessary for it to boot.  (OpenBMC also typically uses a 
non-modular kernel, for what it's worth.)

On BMC startup we don't know the state of the host, and while the mux 
that ultimately determines which processor has access to the BIOS flash 
defaults to connecting it to the host (so if we do attempt to attach it 
we'll simply fail clumsily and spew some errors to dmesg rather than 
causing catastrophic errors host-side), blindly starting to poke the 
BIOS flash without doing the proper coordination with the host first 
seems to me to be pretty squarely in the category of "things we 
shouldn't be doing" -- the desire to avoid that sort of clunkiness is a 
significant portion of what led me to pursue a better solution in the 
first place.

Additionally, while I don't know the details of the specific hardware 
involved, others in the OpenBMC community (or at least Andrew Jeffery) 
have indicated that pluggable DT devices would be useful for the systems 
they're working on as well, I suspect for things other than host 
firmware flashes.


Zev

