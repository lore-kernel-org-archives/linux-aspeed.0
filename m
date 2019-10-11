From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Fri, 11 Oct 2019 08:45:22 +0200
Subject: [PATCH 00/16] mtd: spi-nor: aspeed: AST2600 support and extensions
In-Reply-To: <CACPK8Xe__AYvrh40vqjwoM=XKJfp5MeqrMARpFUDGWCyJK6jXQ@mail.gmail.com>
References: <20191004115919.20788-1-clg@kaod.org>
 <20191009225555.67622339@dhcp-172-31-174-146.wireless.concordia.ca>
 <CACPK8Xe__AYvrh40vqjwoM=XKJfp5MeqrMARpFUDGWCyJK6jXQ@mail.gmail.com>
Message-ID: <20191011084503.5b7a7c2c@dhcp-172-31-174-146.wireless.concordia.ca>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 10 Oct 2019 23:47:45 +0000
Joel Stanley <joel@jms.id.au> wrote:

> On Wed, 9 Oct 2019 at 20:56, Boris Brezillon
> <boris.brezillon@collabora.com> wrote:
> >
> > Hi Cedric,
> >
> > On Fri,  4 Oct 2019 13:59:03 +0200
> > C?dric Le Goater <clg@kaod.org> wrote:
> >  
> > > Hello,
> > >
> > > This series first extends the support for the Aspeed AST2500 and
> > > AST2400 SMC driver. It adds Dual Data support and read training giving
> > > the best read settings for a given chip. Support for the new AST2600
> > > SoC is added at the end.
> > >
> > > I understand that a new spi_mem framework exists and I do have an
> > > experimental driver using it. But unfortunately, it is difficult to
> > > integrate the read training. The Aspeed constraints are not compatible
> > > and i haven't had the time to extend the current framework.  
> >
> > Hm, I don't think that's a good reason to push new features to the
> > existing driver, especially since I asked others to migrate their
> > drivers to spi-mem in the past. I do understand your concerns, and I'll
> > let the SPI NOR/MTD maintainers make the final call, but I think it'd
> > be better for the SPI MEM ecosystem to think about this link-training
> > API (Vignesh needs it for the Cadence driver IIRC) rather than pushing
> > this kind of feature to spi-nor controller drivers.  
> 
> As Cedric mentioned, the OpenBMC project has been shipping the read
> training code for the ast2400/ast2400 for several years now. It would
> be great to see it in mainline.
> 
> I think it's reasonable to ask for the driver to be moved to the
> spi-mem subsystem once it has the required APIs.

Except it won't have the necessary APIs unless someone works on it, and
adding this feature to existing spi-nor drivers won't help achieving
this goal.
