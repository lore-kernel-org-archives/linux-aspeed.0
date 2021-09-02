From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Thu, 02 Sep 2021 11:29:35 +0800
Subject: [PATCH v4 3/4] soc: aspeed: Add eSPI driver
In-Reply-To: <20210901033015.910-4-chiawei_wang@aspeedtech.com>
References: <20210901033015.910-1-chiawei_wang@aspeedtech.com>
 <20210901033015.910-4-chiawei_wang@aspeedtech.com>
Message-ID: <20c13b9bb023091758cac3a07fb4037b7d796578.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Chiawei,

> The Aspeed eSPI controller is slave device to communicate with
> the master through the Enhanced Serial Peripheral Interface (eSPI).
> All of the four eSPI channels, namely peripheral, virtual wire,
> out-of-band, and flash are supported.

I'm still not confinced this raw packet user-ABI is the right approach
for this. The four channels that you're exposing would be much more
useful to use existing kernel subsystems.

Specifically:

1) The VW channel is essentially a GPIO interface, and we have a kernel
   subsystem to expose GPIOs. We might want to add additional support
   for in-kernel system event handlers, but that's a minor addition that
   can be done separately if we don't want that handled by a gpio
   consumer in userspace.

2) The out-of-band (OOB) channel provides a way to issue SMBus
   transactions, so could well provide an i2c controller interface.
   Additionally, the eSPI specs imply that this is intended to support
   MCTP - in which case, you'll *need* a kernel i2c controller device to
   be able to use the new kernel MCTP stack.

3) The flash channel exposes read/write/erase operations, which would be
   much more useful as an actual flash-type device, perhaps using the
   existing mtd interface? Or is there additional functionality
   expected for this?

4) The peripheral channel is the only one that would seem to require
   arbitrary cycle access, but we'll still need a proper uapi definition
   to support that. At the minimum, your ioctl definitions should go
   under include/uapi/ - you shouldn't need to duplicate the header into
   each userspace repo, as you've done for the test examples.

Cheers,


Jeremy

