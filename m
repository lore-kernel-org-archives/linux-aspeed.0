From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Date: Fri, 6 Nov 2020 18:27:33 +0000
Subject: [v3 4/4] spi: aspeed: Add ASPEED FMC/SPI memory controller driver
In-Reply-To: <20201106123015.3248d478@collabora.com>
References: <20201105120331.9853-1-chin-ting_kuo@aspeedtech.com>
 <20201105120331.9853-5-chin-ting_kuo@aspeedtech.com>
 <fd8fa472-53bb-c992-3dc2-5a984a439c07@kaod.org>
 <20201105161132.37eb3265@collabora.com>
 <HK0PR06MB2786DAC99A56EA302EE969CAB2ED0@HK0PR06MB2786.apcprd06.prod.outlook.com>
 <20201106100539.62fc5249@collabora.com>
 <HK0PR06MB27865F0C5B2A4F680ED0D400B2ED0@HK0PR06MB2786.apcprd06.prod.outlook.com>
 <20201106123015.3248d478@collabora.com>
Message-ID: <HK0PR06MB2786AE097106FC322D625BBFB2ED0@HK0PR06MB2786.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Boris,

> -----Original Message-----
> From: Boris Brezillon <boris.brezillon@collabora.com>
> Sent: Friday, November 6, 2020 7:30 PM
> To: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> Subject: Re: [v3 4/4] spi: aspeed: Add ASPEED FMC/SPI memory controller
> driver
> 
> +Tudor and Vignesh
> 
> On Fri, 6 Nov 2020 10:21:06 +0000
> Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com> wrote:
> 
> > Hi Boris,
> >
> > Thanks for your comments and suggestions.
> >
> > > -----Original Message-----
> > > From: Boris Brezillon <boris.brezillon@collabora.com>
> > > Sent: Friday, November 6, 2020 5:06 PM
> > > To: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> > > Subject: Re: [v3 4/4] spi: aspeed: Add ASPEED FMC/SPI memory
> > > controller driver
> > >
> > > On Fri, 6 Nov 2020 08:58:23 +0000
> > > Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com> wrote:
> > >
> > > > Hi Boris,
> > > >
> > > > Thanks for your quick reply.
> > > >
> > > > > -----Original Message-----
> > > > > From: Boris Brezillon <boris.brezillon@collabora.com>
> > > > > Sent: Thursday, November 5, 2020 11:12 PM
> > > > > To: C?dric Le Goater <clg@kaod.org>; robh+dt at kernel.org
> > > > > Cc: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>;
> > > > > broonie at kernel.org; joel at jms.id.au; andrew at aj.id.au;
> > > > > bbrezillon at kernel.org; devicetree at vger.kernel.org;
> > > > > linux-kernel at vger.kernel.org; linux-aspeed at lists.ozlabs.org;
> > > > > linux-spi at vger.kernel.org; BMC-SW <BMC-SW@aspeedtech.com>
> > > > > Subject: Re: [v3 4/4] spi: aspeed: Add ASPEED FMC/SPI memory
> > > > > controller driver
> > > > >
> > > > > Hi,
> > > > >
> > > > > On Thu, 5 Nov 2020 15:09:11 +0100 C?dric Le Goater
> > > > > <clg@kaod.org> wrote:
> > > > >
> > > > > > Hello Chin-Ting,
> > > > > >
> > > > > > Thanks for this driver. It's much cleaner than the previous
> > > > > > and we should try adding support for the AST2500 SoC also. I
> > > > > > guess we can keep the old driver for the AST2400 which has a
> different register layout.
> > > > > >
> > > > > > On the patchset, I think we should split this patch in three :
> > > > > >
> > > > > >  - basic support
> > > > > >  - AHB window calculation depending on the flash size
> > > > > >  - read training support
> > > > >
> > > > > I didn't look closely at the implementation, but if the read
> > > > > training tries to read a section of the NOR, I'd recommend
> > > > > exposing that feature through spi-mem and letting the SPI-NOR
> > > > > framework trigger the training instead of doing that at dirmap
> > > > > creation time (remember that spi-mem is also used for SPI NANDs
> > > > > which use the dirmap
> > > API too, and this training is unlikely to work there).
> > > > >
> > > > > The SPI-NOR framework could pass a read op template and a
> > > > > reference pattern such that all the spi-mem driver has to do is
> > > > > execute the template op and compare the output to the reference
> buffer.
> > > > >
> > > >
> > > > I agree it. Before, I were not able to find a suitable location to
> > > > implement
> > > read training feature.
> > > > I think that I can add a SPI timing training function in
> > > > "spi_controller_mem_ops" struct and call it by a wrapper function
> > > > called at
> > > the bottom of spi_nor_probe() in spi-nor.c.
> > > > Maybe, SPI-NOR framework does not need to pass reference buffer
> > > > since calibration method depends on each SoC itself and buffer
> > > > size may be
> > > variant.
> > > > The detail calibration method may be implemented in each SoC SPI
> driver.
> > >
> > > That's a real problem IMO. What makes this pattern SoC specific? I
> > > can see why the location in flash could be *board* specific, but the
> > > pattern should be pretty common, right? As for the spi-mem operation
> > > to be executed, it's definitely memory specific (I can imagine some
> > > flash vendors providing a specific command returning a fixed pattern
> > > that's not actually stored on a visible portion of the flash).
> >
> > You are right, the pattern should be pretty common. The thing I was
> > worried about is the size of that buffer since, maybe, some
> > controllers need to read more data than others in order to get good training
> result.
> 
> It would be good to see how other controllers implement that. I know that the
> Cadence controller had something similar. Vignesh might be able to share his
> thoughts on this.

Oh, maybe, I misunderstood your meaning and I did not describe clearly early.
As you mentioned before, for some SPI-NOR flashes, there indeed exists a command used for
read timing training with high SPI clock frequency.
When this specific command is sent, an almost common pattern with fixed length will be outputted to controller.
(This pattern is not stored on a normal read/write area.)

But, unfortunately, many flash parts we used did not support this feature. Thus, our read timing training strategy is:
Step 1: Use the lowest SPI clock frequency to read normal flash content with specific length as reference data.
Step 2: With a fixed high SPI clock frequency, adjust different timing delay cycle, then, read the same flash region for each timing delay.
Step 3: Compare each data read from step 2 to the reference data gotten from step 1. Then, we will get a suitable timing delay window.

> 
> >
> > > >
> > > > Besides, I am thinking about the possibility for adding a
> > > > "spi_mem_post_init" function in spi-mem framework sine for some
> > > > SoCs, SPI controller needs to adjust some settings after getting
> > > > SPI flash
> > > information.
> > >
> > > I don't think that's a good idea. The spi-mem interface should stay
> > > memory-type agnostic and doing that means we somehow pass NOR
> > > specific info. What is it that you need exactly, and why?
> >
> > Yes, as you mention, the spi-mem interface should stay memory-type
> agnostic. Thus, currently, I just think about this, not implementation.
> >
> > Why did I need this exactly?
> > Take ASPEED SPI controller for example, ASPEED SPI controller is designed
> for SPI NOR flash especially.
> > When ASPEED SoC powers on or reset, MCU ROM will fetch SPI NOR flash
> through SPI controller.
> > But, MCU ROM does not know the current address mode of SPI NOR flash
> when SoC was reset (SPI flash is not reset).
> > Therefore, SPI flash driver needs to set related flag to notify MCU ROM when
> flash is set to 4B address mode and 4B read opcode is used.
> 
> Oh, that's ugly! The SPI NOR framework tries hard to not change the
> addressing mode exactly for this reason. On most NORs there should now be
> READ/WRITE variants allowing you to address more than 2^24 bytes without
> changing the addressing mode. This being said, those problem exists on other
> platform which can't even let the boot ROM know that addressing mode
> changed. I don't have a proper solution for your use case, but I definitely don't
> like the idea of exposing such details to spi-mem controllers...
> 

Certainly, most of new SPI NOR flashes larger than 16MB support dedicated
4B command without change flash address mode. Originally, I want to take
all flashes into consideration. But, now, the number of flashes, larger than 16MB and
without 4B dedicated command, decreases. Perhaps, I can ignore them currently.

> We usually recommend to connect the NOR reset pin to the global reset to
> addressing mode gets back to known state when you reboot the board and
> need to go back to the boot ROM.

I agree with this.

> 
> >
> > Besides, for other SoCs connected to ASPEED SoC, they can read/write SPI
> NOR flash connected to ASPEED SoC by a pure HW channel without any
> interaction of SW driver.
> > But, before trigger this feature, flash read/write/erase opcode, dummy
> > cycle and other information should be filled in the related registers in
> advance because that HW channel does not know accurate information about
> connected SPI NOR flash.
> 
> While I can see a valid reason to allow that for READs (if we decide to support
> XIP), I really don't like the idea of allowing destructive operations
> (WRITE/ERASE) on the flash that don't go through the MTD layer. This sounds
> like risky business to me, so I'd just forget about that if I were you. Regarding
> the XIP use case, why not, but we'll need to extend the dirmap API to support it:
> mappings need to stay around and you need to return a pointer to the mapped
> memory region, which we don't allow right now (because we want to let
> controllers move their dirmap window if they have to).

Yes, for SPI(-flash) driver, I think I just needs to focus on the scenario where all flash operations go through MTD layer.
Other application may be implemented on the other driver, not here.


Best Wishes,
Chin-Ting


