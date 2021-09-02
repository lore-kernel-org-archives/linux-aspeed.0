From: ChiaWei Wang <chiawei_wang@aspeedtech.com>
Date: Thu, 2 Sep 2021 06:44:28 +0000
Subject: [PATCH v4 3/4] soc: aspeed: Add eSPI driver
In-Reply-To: <20c13b9bb023091758cac3a07fb4037b7d796578.camel@codeconstruct.com.au>
References: <20210901033015.910-1-chiawei_wang@aspeedtech.com>
 <20210901033015.910-4-chiawei_wang@aspeedtech.com>
 <20c13b9bb023091758cac3a07fb4037b7d796578.camel@codeconstruct.com.au>
Message-ID: <HK0PR06MB37792273A075533C2570002391CE9@HK0PR06MB3779.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Jeremy,

> From: Jeremy Kerr <jk@codeconstruct.com.au>
> Sent: Thursday, September 2, 2021 11:30 AM
> 
> Hi Chiawei,
> 
> > The Aspeed eSPI controller is slave device to communicate with the
> > master through the Enhanced Serial Peripheral Interface (eSPI).
> > All of the four eSPI channels, namely peripheral, virtual wire,
> > out-of-band, and flash are supported.
> 
> I'm still not confinced this raw packet user-ABI is the right approach for this.
> The four channels that you're exposing would be much more useful to use
> existing kernel subsystems.

The eSPI on BMC side is a slave device. Most of time it listen to the Host requests and then react.
This makes it not quite fit to interfaces that act as a master role.

> 
> Specifically:
> 
> 1) The VW channel is essentially a GPIO interface, and we have a kernel
>    subsystem to expose GPIOs. We might want to add additional support
>    for in-kernel system event handlers, but that's a minor addition that
>    can be done separately if we don't want that handled by a gpio
>    consumer in userspace.

eSPI VW channel can be used to forward a byte value to/from GPIO.
However, the targeted GPIO group and its direction are determined by the Host.
This is different from usual GPIO devices as it supports very limited operations.

> 
> 2) The out-of-band (OOB) channel provides a way to issue SMBus
>    transactions, so could well provide an i2c controller interface.
>    Additionally, the eSPI specs imply that this is intended to support
>    MCTP - in which case, you'll *need* a kernel i2c controller device to
>    be able to use the new kernel MCTP stack.

Could you share us more information about the i2c need of kernel MCTP kernel stack?
To our understanding, the MCTP is a bus agnostic protocol.
A generic raw packet interface makes it more flexible to adapt to different interfaces.

> 
> 3) The flash channel exposes read/write/erase operations, which would be
>    much more useful as an actual flash-type device, perhaps using the
>    existing mtd interface? Or is there additional functionality
>    expected for this?

The flash channel works in either the Master Attached Flash Sharing (MAFS) or Slave Attached Flash Sharing (SAFS) mode.

For MAFS, BMC issues eSPI flash R/W/E packets to the Host.
In this case, it may fit into the MTD interface.

For SAFS (mostly used), BMC needs to listen, parse and filter eSPI flash R/W/E packets from the Host.
And then send replies in the eSPI success/unsuccess completion packet format.
This behaves differently from MTD.

To support both the two scenario, the MTD interface might not be suitable.

> 
> 4) The peripheral channel is the only one that would seem to require
>    arbitrary cycle access, but we'll still need a proper uapi definition
>    to support that. At the minimum, your ioctl definitions should go
>    under include/uapi/ - you shouldn't need to duplicate the header into
>    each userspace repo, as you've done for the test examples.

In the first submission, I was told that the include/uapi patch is not going to be accepted.
Thereby, I refer to other existing driver implementation which places IOCTL codes in their own driver files.


In summary, considering the various applications that might be constructed upon eSPI transaction,
we thought that the raw packet paradigm might be the first step to start with.

Regards,
Chiawei
