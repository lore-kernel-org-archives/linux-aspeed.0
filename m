From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Mon, 3 Jan 2022 17:17:21 +0100
Subject: [PATCH] mtd: aspeed-smc: improve probe resilience
In-Reply-To: <20211231102623.izaqlzjvracbbgmp@ti.com>
References: <20211229143334.297305-1-patrick@stwcx.xyz>
 <20211229173411.l2bipmi4x3arqjoo@ti.com>
 <Yc3Qav+ULNdF5zRT@heinlein>
 <20211231102623.izaqlzjvracbbgmp@ti.com>
Message-ID: <20220103171721.46c8e697@xps13>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

p.yadav at ti.com wrote on Fri, 31 Dec 2021 15:56:25 +0530:

> Hi Patrick,
> 
> On 30/12/21 09:29AM, Patrick Williams wrote:
> > On Wed, Dec 29, 2021 at 11:04:13PM +0530, Pratyush Yadav wrote:  
> > > Hi,
> > > 
> > > On 29/12/21 08:33AM, Patrick Williams wrote:  
> >    
> > > The patch itself looks fine to me but we no longer want to maintain 
> > > drivers under drivers/mtd/spi-nor/controllers/. They should be moved to 
> > > implement the SPI MEM API (under drivers/spi/).  
> > 
> > Is the linux-aspeed community aware of this?  Are you saying you don't want to
> > take fixes for their driver into the MTD tree?  Can it be pulled into the Aspeed
> > tree?  
> 
> I am fine with taking in bug fixes but no longer want to take in any new 
> features. My main intention was to nudge you to convert it to SPI MEM 
> regardless of whether this is a bug fix or a new feature, because 
> eventually we want to get rid of drivers/mtd/spi-nor/controllers/ and 
> the API that comes along with it.

I totally agree with Pratyush here, we no longer want to support the
spi-nor controller API so if, as you say, there are boards failing
in the field, it means there are still users and these users must be
warned that at some point we might discontinue the support of these
drivers if it becomes too painful.

> As for your patch, I certainly don't want it to go via the aspeed tree.

Definitely, no.

> It should go via the MTD tree or not at all. I am not quite sure if this 
> counts as a bug fix or a new feature though.
> 
> >   
> > > Could you please volunteer to do the conversion for this driver?  
> > 
> > I'm not personally going to be able to get to it for at least the next 3 months.
> > 
> > It looks like we don't have a dedicated maintainer for this driver other than
> > Joel by nature of him being listed as the maintainer of "ARM/ASPEED MACHINE
> > SUPPORT".  I'm not sure if Aspeed themselves are planning on doing the necessary
> > refactoring here.
> > 
> > 
> > Joel, are you aware of this driver using a deprecated implementation?  Were
> > there anyone planning to do the reworks that you are aware of?  I'd like to get
> > this fix at least into the OpenBMC kernel tree because I'm seeing this fail in
> > the real world.  
> 

Thanks,
Miqu?l
