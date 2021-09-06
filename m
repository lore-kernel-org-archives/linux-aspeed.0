From: ChiaWei Wang <chiawei_wang@aspeedtech.com>
Date: Mon, 6 Sep 2021 01:19:21 +0000
Subject: [PATCH v4 3/4] soc: aspeed: Add eSPI driver
In-Reply-To: <513cb05f8d83d08a5c1e491dc0a9b6784195e7dd.camel@codeconstruct.com.au>
References: <20210901033015.910-1-chiawei_wang@aspeedtech.com>
 <20210901033015.910-4-chiawei_wang@aspeedtech.com>
 <20c13b9bb023091758cac3a07fb4037b7d796578.camel@codeconstruct.com.au>
 <HK0PR06MB37792273A075533C2570002391CE9@HK0PR06MB3779.apcprd06.prod.outlook.com>
 <513cb05f8d83d08a5c1e491dc0a9b6784195e7dd.camel@codeconstruct.com.au>
Message-ID: <HK0PR06MB37799C48533B084CF864E49D91D29@HK0PR06MB3779.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Jeremy,

> From: Jeremy Kerr <jk@codeconstruct.com.au>
> Sent: Thursday, September 2, 2021 3:05 PM
> 
> Hi Chiawei,
> 
> > The eSPI on BMC side is a slave device. Most of time it listen to the
> > Host requests and then react.
> > This makes it not quite fit to interfaces that act as a master role.
> 
> That's a good point, but I don't think it precludes using existing interfaces.

Agree.

> 
> > > 1) The VW channel is essentially a GPIO interface, and we have a
> > > kernel ?? subsystem to expose GPIOs. We might want to add additional
> > > support ?? for in-kernel system event handlers, but that's a minor
> > > addition that ?? can be done separately if we don't want that
> > > handled by a gpio ?? consumer in userspace.
> >
> > eSPI VW channel can be used to forward a byte value to/from GPIO.
> > However, the targeted GPIO group and its direction are determined by the Host.
> > This is different from usual GPIO devices as it supports very limited operations.
> 
> I'm not referring to the hardware GPIOs that can be connected here, rather the
> logic values represented over the VW channel. The eSPI master is transferring
> IO states over the channel, and we could represnt those on the BMC side as
> "virtual" GPIOs.
> 
> If that model doesn't fit though, that's OK, but I think we need some rationale
> there.

After an internal discussion, we found that our eSPI VW device may not fit into existing GPIO model.

The reason is that GPIO direction changes through VW channel has no interrupts triggered.
And the direction is controlled by the Host as aforementioned.
Thus a busy polling on GPIO direction register is inevitable to reflect the state timely.
Even though, there is still a chance that BMC will miss GPIO direction changes in the time span of two polling read.

Regarding the current implementation, I should add an additional IOCTL code to read the current GPIO direction.

> 
> > >
> > > 2) The out-of-band (OOB) channel provides a way to issue SMBus
> > > ?? transactions, so could well provide an i2c controller interface.
> > > ?? Additionally, the eSPI specs imply that this is intended to
> > > support
> > > ?? MCTP - in which case, you'll *need* a kernel i2c controller
> > > device to
> > > ?? be able to use the new kernel MCTP stack.
> >
> > Could you share us more information about the i2c need of kernel MCTP kernel stack?
> > To our understanding, the MCTP is a bus agnostic protocol.
> > A generic raw packet interface makes it more flexible to adapt to different interfaces.
> 
> The currently proposed mctp-i2c interface driver binds to a kernel i2c device.
> If you expose a kernel i2c device here, we can connect that as an MCTP
> interface.
> 
> With the packet interface proposed here, we can't do that, and would need a
> whole new driver for this, implemented in userspace. The same would apply to
> any other usage of the i2c bus (EEPROM access, etc).

Thanks for sharing the information.
However, as mentioned above, MCTP is bus agonistic.
A raw packet, primitive interface should have better flexibility to manage MCTP packets over the OOB channel.

If userspace implementation is reinventing the wheel, we could consider to refer to the IPMI KCS BMC driver of OpenBMC Linux.
The driver has both the RAW and IPMI interfaces supported.

But we think this should be the next step.

> 
> > > 3) The flash channel exposes read/write/erase operations, which
> > > would be
> > > ?? much more useful as an actual flash-type device, perhaps using
> > > the
> > > ?? existing mtd interface? Or is there additional functionality
> > > ?? expected for this?
> >
> > The flash channel works in either the Master Attached Flash Sharing
> > (MAFS) or Slave Attached Flash Sharing (SAFS) mode.
> >
> > For MAFS, BMC issues eSPI flash R/W/E packets to the Host.
> > In this case, it may fit into the MTD interface.
> >
> > For SAFS (mostly used), BMC needs to listen, parse and filter eSPI
> > flash R/W/E packets from the Host.
> > And then send replies in the eSPI success/unsuccess completion packet
> > format.
> > This behaves differently from MTD.
> >
> > To support both the two scenario, the MTD interface might not be
> > suitable.
> 
> OK, that makes sense. In this case the BMC is acting as the virtual flash device,
> right?
> 
> > > 4) The peripheral channel is the only one that would seem to require
> > > arbitrary cycle access, but we'll still need a proper uapi
> > > definition to support that. At the minimum, your ioctl definitions
> > > should go under include/uapi/ - you shouldn't need to duplicate the
> > > header into each userspace repo, as you've done for the test
> > > examples.
> >
> > In the first submission, I was told that the include/uapi patch is not
> > going to be accepted.
> 
> This is what you were told in the v1 submission:
> 
> > >  create mode 100644 include/uapi/linux/aspeed-espi.h
> >
> > This userspace interface is not going to be accepted upstream.
> 
> It sees like that was a comment about the API itself, not the location of the
> header (Rob, correct me if I'm wrong). Simply moving the header out of the
> uapi directory, while retaining the same API, is not a solution to this.
> 
> > In summary, considering the various applications that might be
> > constructed upon eSPI transaction, we thought that the raw packet
> > paradigm might be the first step to start with.
> 
> Keep in mind that you're creating a kernel ABI here, which has to stay in place
> forever - even if it's the first step to something else, we cannot break future
> compatibility.

Understood.
Thanks for giving us these feedback and suggestions.

Regards,
Chiawei
