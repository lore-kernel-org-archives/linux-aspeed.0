From: ChiaWei Wang <chiawei_wang@aspeedtech.com>
Date: Fri, 27 Aug 2021 03:48:39 +0000
Subject: [PATCH v3 3/4] soc: aspeed: Add eSPI driver
In-Reply-To: <7e7378c49ecfb21fef6a0640f92c1b3a7a5878d0.camel@codeconstruct.com.au>
References: <20210826061623.6352-1-chiawei_wang@aspeedtech.com>
 <20210826061623.6352-4-chiawei_wang@aspeedtech.com>
 <7e7378c49ecfb21fef6a0640f92c1b3a7a5878d0.camel@codeconstruct.com.au>
Message-ID: <HK0PR06MB377997422D9508894936E39691C89@HK0PR06MB3779.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Jeremy,

Thanks for reviewing the patch.

> From: Jeremy Kerr <jk@codeconstruct.com.au>
> Sent: Friday, August 27, 2021 11:20 AM
> 
> Hi Chia-Wei,
> 
> [apologies for the re-send, dropping HTML part...]
> 
> > The Aspeed eSPI controller is slave device to communicate with the
> > master through the Enhanced Serial Peripheral Interface (eSPI).
> > All of the four eSPI channels, namely peripheral, virtual wire,
> > out-of-band, and flash are supported.
> 
> Great to have this added submitted upstream! A few comments though:
> 
> > ---
> > ?drivers/soc/aspeed/Kconfig???????????? |? 11 +
> > ?drivers/soc/aspeed/Makefile??????????? |?? 1 +
> > ?drivers/soc/aspeed/aspeed-espi-ctrl.c? | 205 +++++++++
> > ?drivers/soc/aspeed/aspeed-espi-ctrl.h? | 304 ++++++++++++
> > ?drivers/soc/aspeed/aspeed-espi-flash.h | 380 +++++++++++++++
> > ?drivers/soc/aspeed/aspeed-espi-ioc.h?? | 153 +++++++
> > ?drivers/soc/aspeed/aspeed-espi-oob.h?? | 611
> > +++++++++++++++++++++++++
> > ?drivers/soc/aspeed/aspeed-espi-perif.h | 539 ++++++++++++++++++++++
> > ?drivers/soc/aspeed/aspeed-espi-vw.h??? | 142 ++++++
> 
> This structure is a bit odd - you have the one -crtl.c file, which defines the
> actual driver, but then a bunch of headers that contain more code than
> header-type definitions.
> 
> Is there any reason that -flash, -ioc, -oob, -perif and -vw components can't be
> standard .c files?

The eSPI slave device comprises four channels, where each of them has individual functionality.
Putting the four channels driver code into a single file makes it hard to maintain and trace.

We did consider to make them standard .c files.
But it requires to export channel functions into kernel space although they are dedicated only to this eSPI driver.
As espi-ctrl needs to invoke corresponding channel functions when it is interrupted by eSPI events.

To avoid polluting kernel space, we decided to put driver code in header files and make the channel functions 'static'.

BTW, I once encountered .c file inclusion in other projects. Is it proper for Linux driver development?

> 
> Then, for the userspace ABI: it looks like you're exposing everything through
> new device-specific ioctls. Would it not make more sense to use existing
> interfaces? For example, the virtual wire bits could be regular GPIOs; the flash
> interface could be a mtd or block device.
> 
> I understand that we'll likely still need some level of custom device control, but
> the more we can use generic interfaces for, the less custom code (and
> interfaces) we'll need on the userspace side.
> 

eSPI communication is based on the its cycle packet format.
We intended to let userspace decided how to interpret and compose TX/RX packets including header, tag, length (encoded), and data.
IOCTL comes to our first mind as it also works in the 'packet' like paradigm.

Chiawei
