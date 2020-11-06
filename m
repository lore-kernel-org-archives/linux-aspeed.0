From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Date: Fri, 6 Nov 2020 08:58:23 +0000
Subject: [v3 4/4] spi: aspeed: Add ASPEED FMC/SPI memory controller driver
In-Reply-To: <20201105161132.37eb3265@collabora.com>
References: <20201105120331.9853-1-chin-ting_kuo@aspeedtech.com>
 <20201105120331.9853-5-chin-ting_kuo@aspeedtech.com>
 <fd8fa472-53bb-c992-3dc2-5a984a439c07@kaod.org>
 <20201105161132.37eb3265@collabora.com>
Message-ID: <HK0PR06MB2786DAC99A56EA302EE969CAB2ED0@HK0PR06MB2786.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Boris,

Thanks for your quick reply.

> -----Original Message-----
> From: Boris Brezillon <boris.brezillon@collabora.com>
> Sent: Thursday, November 5, 2020 11:12 PM
> To: C?dric Le Goater <clg@kaod.org>; robh+dt at kernel.org
> Cc: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>; broonie at kernel.org;
> joel at jms.id.au; andrew at aj.id.au; bbrezillon at kernel.org;
> devicetree at vger.kernel.org; linux-kernel at vger.kernel.org;
> linux-aspeed at lists.ozlabs.org; linux-spi at vger.kernel.org; BMC-SW
> <BMC-SW@aspeedtech.com>
> Subject: Re: [v3 4/4] spi: aspeed: Add ASPEED FMC/SPI memory controller
> driver
> 
> Hi,
> 
> On Thu, 5 Nov 2020 15:09:11 +0100
> C?dric Le Goater <clg@kaod.org> wrote:
> 
> > Hello Chin-Ting,
> >
> > Thanks for this driver. It's much cleaner than the previous and we
> > should try adding support for the AST2500 SoC also. I guess we can
> > keep the old driver for the AST2400 which has a different register layout.
> >
> > On the patchset, I think we should split this patch in three :
> >
> >  - basic support
> >  - AHB window calculation depending on the flash size
> >  - read training support
> 
> I didn't look closely at the implementation, but if the read training tries to read
> a section of the NOR, I'd recommend exposing that feature through spi-mem
> and letting the SPI-NOR framework trigger the training instead of doing that at
> dirmap creation time (remember that spi-mem is also used for SPI NANDs
> which use the dirmap API too, and this training is unlikely to work there).
> 
> The SPI-NOR framework could pass a read op template and a reference pattern
> such that all the spi-mem driver has to do is execute the template op and
> compare the output to the reference buffer.
> 

I agree it. Before, I were not able to find a suitable location to implement read training feature.
I think that I can add a SPI timing training function in "spi_controller_mem_ops" struct and
call it by a wrapper function called at the bottom of spi_nor_probe() in spi-nor.c.
Maybe, SPI-NOR framework does not need to pass reference buffer since calibration
method depends on each SoC itself and buffer size may be variant.
The detail calibration method may be implemented in each SoC SPI driver.

Besides, I am thinking about the possibility for adding a "spi_mem_post_init" function in
spi-mem framework sine for some SoCs, SPI controller needs to adjust some settings
after getting SPI flash information.

> 
> >
> > We should avoid magic values when setting registers. This is confusing
> > and defines are much better.
> >
> > AST2500 support will be a bit challenging because HW does not allow
> > to configure a 128MB AHB window, max is 120MB This is a bug and the
> > work around is to use user mode for the remaining 8MB. Something to
> > keep in mind.
> 
> Most SPI-MEM controllers don't have such a big dirmap window anyway, and
> that shouldn't be a problem, because we don't expose the direct mapping
> directly (as would be done if we were trying to support something like XIP).
> That means that, assuming your controller allows controlling the base spi-mem
> address the direct mapping points to, you should be able to adjust the window
> at runtime and make it point where you requested.
> 
> Note that dirmap_{read,write}() are allowed to return less data than requested
> thus simplifying the case where a specific access requires a window
> adjustment in the middle of an read/write operation.

Thanks for your remainder.


Best Wishes,
Chin-Ting
