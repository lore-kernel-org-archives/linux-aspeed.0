From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Fri, 27 Aug 2021 11:20:05 +0800
Subject: [PATCH v3 3/4] soc: aspeed: Add eSPI driver
In-Reply-To: <20210826061623.6352-4-chiawei_wang@aspeedtech.com>
References: <20210826061623.6352-1-chiawei_wang@aspeedtech.com>
 <20210826061623.6352-4-chiawei_wang@aspeedtech.com>
Message-ID: <7e7378c49ecfb21fef6a0640f92c1b3a7a5878d0.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Chia-Wei,

[apologies for the re-send, dropping HTML part...]

> The Aspeed eSPI controller is slave device to communicate with
> the master through the Enhanced Serial Peripheral Interface (eSPI).
> All of the four eSPI channels, namely peripheral, virtual wire,
> out-of-band, and flash are supported.

Great to have this added submitted upstream! A few comments though:

> ---
> ?drivers/soc/aspeed/Kconfig???????????? |? 11 +
> ?drivers/soc/aspeed/Makefile??????????? |?? 1 +
> ?drivers/soc/aspeed/aspeed-espi-ctrl.c? | 205 +++++++++
> ?drivers/soc/aspeed/aspeed-espi-ctrl.h? | 304 ++++++++++++
> ?drivers/soc/aspeed/aspeed-espi-flash.h | 380 +++++++++++++++
> ?drivers/soc/aspeed/aspeed-espi-ioc.h?? | 153 +++++++
> ?drivers/soc/aspeed/aspeed-espi-oob.h?? | 611 +++++++++++++++++++++++++
> ?drivers/soc/aspeed/aspeed-espi-perif.h | 539 ++++++++++++++++++++++
> ?drivers/soc/aspeed/aspeed-espi-vw.h??? | 142 ++++++

This structure is a bit odd - you have the one -crtl.c file, which
defines the actual driver, but then a bunch of headers that contain more
code than header-type definitions.

Is there any reason that -flash, -ioc, -oob, -perif and -vw components
can't be standard .c files?

Then, for the userspace ABI: it looks like you're exposing everything
through new device-specific ioctls. Would it not make more sense to use
existing interfaces? For example, the virtual wire bits could be regular
GPIOs; the flash interface could be a mtd or block device.

I understand that we'll likely still need some level of custom device
control, but the more we can use generic interfaces for, the less custom
code (and interfaces) we'll need on the userspace side.

Cheers,


Jeremy


