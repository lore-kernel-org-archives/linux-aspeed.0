From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Fri, 8 Jan 2021 03:09:40 +0000
Subject: [PATCH 5/6] soc: aspeed: Add eSPI driver
In-Reply-To: <CACPK8XfCpUDXi-e1Sh1t+wm_-vXNihRchkmQby7fUXi0mCdMwA@mail.gmail.com>
References: <20210106055939.19386-1-chiawei_wang@aspeedtech.com>
 <20210106055939.19386-6-chiawei_wang@aspeedtech.com>
 <20210106153202.GA2258036@robh.at.kernel.org>
 <HK0PR06MB377987E19F57E53CC4F32FF991AF0@HK0PR06MB3779.apcprd06.prod.outlook.com>
 <CACPK8XfCpUDXi-e1Sh1t+wm_-vXNihRchkmQby7fUXi0mCdMwA@mail.gmail.com>
Message-ID: <HK0PR06MB3380BD8A5BB1B1E7CB466C9BF2AE0@HK0PR06MB3380.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Joel Stanley <joel@jms.id.au>
> Sent: Friday, January 8, 2021 10:59 AM
> To: ChiaWei Wang <chiawei_wang@aspeedtech.com>; Jeremy Kerr
> <jk@codeconstruct.com.au>
> Cc: Rob Herring <robh@kernel.org>; andrew at aj.id.au; tglx at linutronix.de;
> maz at kernel.org; p.zabel at pengutronix.de; linux-aspeed at lists.ozlabs.org;
> openbmc at lists.ozlabs.org; devicetree at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org; BMC-SW
> <BMC-SW@aspeedtech.com>
> Subject: Re: [PATCH 5/6] soc: aspeed: Add eSPI driver
> 
> On Thu, 7 Jan 2021 at 02:39, ChiaWei Wang
> <chiawei_wang@aspeedtech.com> wrote:
> >
> > Hi Rob,
> >
> > > -----Original Message-----
> > > From: Rob Herring <robh@kernel.org>
> > > Sent: Wednesday, January 6, 2021 11:32 PM
> > > To: ChiaWei Wang <chiawei_wang@aspeedtech.com>
> > > Subject: Re: [PATCH 5/6] soc: aspeed: Add eSPI driver
> > >
> > > On Wed, Jan 06, 2021 at 01:59:38PM +0800, Chia-Wei, Wang wrote:
> > > > The Aspeed eSPI controller is slave device to communicate with the
> > > > master through the Enhanced Serial Peripheral Interface (eSPI).
> > > > All of the four eSPI channels, namely peripheral, virtual wire,
> > > > out-of-band, and flash are supported.
> > > >
> > > > Signed-off-by: Chia-Wei, Wang <chiawei_wang@aspeedtech.com>
> > > > ---
> > > >  drivers/soc/aspeed/Kconfig                  |  49 ++
> > > >  drivers/soc/aspeed/Makefile                 |   5 +
> > > >  drivers/soc/aspeed/aspeed-espi-ctrl.c       | 197 ++++++
> > > >  drivers/soc/aspeed/aspeed-espi-flash.c      | 490 ++++++++++++++
> > > >  drivers/soc/aspeed/aspeed-espi-oob.c        | 706
> > > ++++++++++++++++++++
> > > >  drivers/soc/aspeed/aspeed-espi-peripheral.c | 613
> +++++++++++++++++
> > > >  drivers/soc/aspeed/aspeed-espi-vw.c         | 211 ++++++
> > > >  include/uapi/linux/aspeed-espi.h            | 160 +++++
> > > >  8 files changed, 2431 insertions(+)  create mode 100644
> > > > drivers/soc/aspeed/aspeed-espi-ctrl.c
> > > >  create mode 100644 drivers/soc/aspeed/aspeed-espi-flash.c
> > > >  create mode 100644 drivers/soc/aspeed/aspeed-espi-oob.c
> > > >  create mode 100644 drivers/soc/aspeed/aspeed-espi-peripheral.c
> > > >  create mode 100644 drivers/soc/aspeed/aspeed-espi-vw.c
> > >
> > > drivers/spi/ is the correct location for a SPI controller.
> > >
> > > >  create mode 100644 include/uapi/linux/aspeed-espi.h
> > >
> > > This userspace interface is not going to be accepted upstream.
> > >
> > > I'd suggest you look at similar SPI flash capable SPI controller
> > > drivers upstream and model your driver after them. This looks like it needs
> major reworking.
> > >
> > eSPI resues the timing and electrical specification of SPI but runs completely
> different protocol.
> > Only the flash channel is related to SPI and the other 3 channels are for
> EC/BMC/SIO.
> > Therefore, an eSPI driver might not fit into the SPI model.
> 
> I agree, the naming is confusing but eSPI doesn't belong in drivers/spi.
> 
> As it is a bus that is common to more than just the Aspeed BMC, we may want
> to implement it as a new bus type that has devices hanging off it, similar to
> FSI.
> 
The ASPEED eSPI controller driver is slave side device, not master side. I think it will be stay soc/aspeed first. 
Because is most SoC Chip related. 

Cheers,

Ryan
