From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Date: Fri, 6 Nov 2020 10:21:06 +0000
Subject: [v3 4/4] spi: aspeed: Add ASPEED FMC/SPI memory controller driver
In-Reply-To: <20201106100539.62fc5249@collabora.com>
References: <20201105120331.9853-1-chin-ting_kuo@aspeedtech.com>
 <20201105120331.9853-5-chin-ting_kuo@aspeedtech.com>
 <fd8fa472-53bb-c992-3dc2-5a984a439c07@kaod.org>
 <20201105161132.37eb3265@collabora.com>
 <HK0PR06MB2786DAC99A56EA302EE969CAB2ED0@HK0PR06MB2786.apcprd06.prod.outlook.com>
 <20201106100539.62fc5249@collabora.com>
Message-ID: <HK0PR06MB27865F0C5B2A4F680ED0D400B2ED0@HK0PR06MB2786.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Boris,

Thanks for your comments and suggestions.

> -----Original Message-----
> From: Boris Brezillon <boris.brezillon@collabora.com>
> Sent: Friday, November 6, 2020 5:06 PM
> To: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> Subject: Re: [v3 4/4] spi: aspeed: Add ASPEED FMC/SPI memory controller
> driver
> 
> On Fri, 6 Nov 2020 08:58:23 +0000
> Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com> wrote:
> 
> > Hi Boris,
> >
> > Thanks for your quick reply.
> >
> > > -----Original Message-----
> > > From: Boris Brezillon <boris.brezillon@collabora.com>
> > > Sent: Thursday, November 5, 2020 11:12 PM
> > > To: C?dric Le Goater <clg@kaod.org>; robh+dt at kernel.org
> > > Cc: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>;
> > > broonie at kernel.org; joel at jms.id.au; andrew at aj.id.au;
> > > bbrezillon at kernel.org; devicetree at vger.kernel.org;
> > > linux-kernel at vger.kernel.org; linux-aspeed at lists.ozlabs.org;
> > > linux-spi at vger.kernel.org; BMC-SW <BMC-SW@aspeedtech.com>
> > > Subject: Re: [v3 4/4] spi: aspeed: Add ASPEED FMC/SPI memory
> > > controller driver
> > >
> > > Hi,
> > >
> > > On Thu, 5 Nov 2020 15:09:11 +0100
> > > C?dric Le Goater <clg@kaod.org> wrote:
> > >
> > > > Hello Chin-Ting,
> > > >
> > > > Thanks for this driver. It's much cleaner than the previous and we
> > > > should try adding support for the AST2500 SoC also. I guess we can
> > > > keep the old driver for the AST2400 which has a different register layout.
> > > >
> > > > On the patchset, I think we should split this patch in three :
> > > >
> > > >  - basic support
> > > >  - AHB window calculation depending on the flash size
> > > >  - read training support
> > >
> > > I didn't look closely at the implementation, but if the read
> > > training tries to read a section of the NOR, I'd recommend exposing
> > > that feature through spi-mem and letting the SPI-NOR framework
> > > trigger the training instead of doing that at dirmap creation time
> > > (remember that spi-mem is also used for SPI NANDs which use the dirmap
> API too, and this training is unlikely to work there).
> > >
> > > The SPI-NOR framework could pass a read op template and a reference
> > > pattern such that all the spi-mem driver has to do is execute the
> > > template op and compare the output to the reference buffer.
> > >
> >
> > I agree it. Before, I were not able to find a suitable location to implement
> read training feature.
> > I think that I can add a SPI timing training function in
> > "spi_controller_mem_ops" struct and call it by a wrapper function called at
> the bottom of spi_nor_probe() in spi-nor.c.
> > Maybe, SPI-NOR framework does not need to pass reference buffer since
> > calibration method depends on each SoC itself and buffer size may be
> variant.
> > The detail calibration method may be implemented in each SoC SPI driver.
> 
> That's a real problem IMO. What makes this pattern SoC specific? I can see
> why the location in flash could be *board* specific, but the pattern should be
> pretty common, right? As for the spi-mem operation to be executed, it's
> definitely memory specific (I can imagine some flash vendors providing a
> specific command returning a fixed pattern that's not actually stored on a
> visible portion of the flash).

You are right, the pattern should be pretty common. The thing I was worried about is the size of
that buffer since, maybe, some controllers need to read more data than others in order to get good
training result.

> >
> > Besides, I am thinking about the possibility for adding a
> > "spi_mem_post_init" function in spi-mem framework sine for some SoCs,
> > SPI controller needs to adjust some settings after getting SPI flash
> information.
> 
> I don't think that's a good idea. The spi-mem interface should stay
> memory-type agnostic and doing that means we somehow pass NOR specific
> info. What is it that you need exactly, and why?

Yes, as you mention, the spi-mem interface should stay memory-type agnostic. Thus, currently, I just think about this, not implementation.

Why did I need this exactly?
Take ASPEED SPI controller for example, ASPEED SPI controller is designed for SPI NOR flash especially.
When ASPEED SoC powers on or reset, MCU ROM will fetch SPI NOR flash through SPI controller.
But, MCU ROM does not know the current address mode of SPI NOR flash when SoC was reset (SPI flash is not reset).
Therefore, SPI flash driver needs to set related flag to notify MCU ROM when flash is set to 4B address mode and 4B read opcode is used.

Besides, for other SoCs connected to ASPEED SoC, they can read/write SPI NOR flash connected to ASPEED SoC by a pure HW channel without any interaction of SW driver.
But, before trigger this feature, flash read/write/erase opcode, dummy cycle and other information should be filled in the related registers in advance because that HW channel
does not know accurate information about connected SPI NOR flash.


Best Wishes,
Chin-Ting




