From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Date: Fri, 6 Nov 2020 09:01:42 +0000
Subject: [v3 4/4] spi: aspeed: Add ASPEED FMC/SPI memory controller driver
In-Reply-To: <20201105164312.GE4856@sirena.org.uk>
References: <20201105120331.9853-1-chin-ting_kuo@aspeedtech.com>
 <20201105120331.9853-5-chin-ting_kuo@aspeedtech.com>
 <fd8fa472-53bb-c992-3dc2-5a984a439c07@kaod.org>
 <20201105161132.37eb3265@collabora.com> <20201105164312.GE4856@sirena.org.uk>
Message-ID: <HK0PR06MB27865D494F91D29B61A5B15BB2ED0@HK0PR06MB2786.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Mark,

> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Friday, November 6, 2020 12:43 AM
> To: Boris Brezillon <boris.brezillon@collabora.com>
> Subject: Re: [v3 4/4] spi: aspeed: Add ASPEED FMC/SPI memory controller
> driver
> 
> On Thu, Nov 05, 2020 at 04:11:32PM +0100, Boris Brezillon wrote:
> > C?dric Le Goater <clg@kaod.org> wrote:
> 
> > > Thanks for this driver. It's much cleaner than the previous and we
> > > should try adding support for the AST2500 SoC also. I guess we can
> > > keep the old driver for the AST2400 which has a different register layout.
> > >
> > > On the patchset, I think we should split this patch in three :
> > >
> > >  - basic support
> > >  - AHB window calculation depending on the flash size
> > >  - read training support
> 
> > I didn't look closely at the implementation, but if the read training
> > tries to read a section of the NOR, I'd recommend exposing that
> > feature through spi-mem and letting the SPI-NOR framework trigger the
> > training instead of doing that at dirmap creation time (remember that
> > spi-mem is also used for SPI NANDs which use the dirmap API too, and
> > this training is unlikely to work there).
> 
> > The SPI-NOR framework could pass a read op template and a reference
> > pattern such that all the spi-mem driver has to do is execute the
> > template op and compare the output to the reference buffer.
> 
> That seems like a good idea.

Yes, this idea will be implemented on the next patch version.

> 
> > > We should avoid magic values when setting registers. This is
> > > confusing and defines are much better.
> 
> It does depend a bit on documentation though, it's not a hard requirement.

I will update it on the next patch version.



Thanks.

Best Wishes,
Chin-Ting
