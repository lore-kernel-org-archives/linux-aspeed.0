From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Fri, 11 Oct 2019 14:07:26 +0200
Subject: [PATCH 00/16] mtd: spi-nor: aspeed: AST2600 support and extensions
In-Reply-To: <026b5c55-194c-934f-e039-7c4d28861d53@kaod.org>
References: <20191004115919.20788-1-clg@kaod.org>
 <20191009225555.67622339@dhcp-172-31-174-146.wireless.concordia.ca>
 <CACPK8Xe__AYvrh40vqjwoM=XKJfp5MeqrMARpFUDGWCyJK6jXQ@mail.gmail.com>
 <20191011084503.5b7a7c2c@dhcp-172-31-174-146.wireless.concordia.ca>
 <3836fcc4-c8b0-ed04-0c52-7c642794ecb8@kaod.org>
 <20191011115129.3897cd17@dhcp-172-31-174-146.wireless.concordia.ca>
 <026b5c55-194c-934f-e039-7c4d28861d53@kaod.org>
Message-ID: <20191011140611.5a34e1fb@dhcp-172-31-174-146.wireless.concordia.ca>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 11 Oct 2019 13:47:53 +0200
C?dric Le Goater <clg@kaod.org> wrote:

> On 11/10/2019 11:51, Boris Brezillon wrote:
> > On Fri, 11 Oct 2019 11:29:49 +0200
> > C?dric Le Goater <clg@kaod.org> wrote:
> >   
> >> On 11/10/2019 08:45, Boris Brezillon wrote:  
> >>> On Thu, 10 Oct 2019 23:47:45 +0000
> >>> Joel Stanley <joel@jms.id.au> wrote:
> >>>     
> >>>> On Wed, 9 Oct 2019 at 20:56, Boris Brezillon
> >>>> <boris.brezillon@collabora.com> wrote:    
> >>>>>
> >>>>> Hi Cedric,
> >>>>>
> >>>>> On Fri,  4 Oct 2019 13:59:03 +0200
> >>>>> C?dric Le Goater <clg@kaod.org> wrote:
> >>>>>      
> >>>>>> Hello,
> >>>>>>
> >>>>>> This series first extends the support for the Aspeed AST2500 and
> >>>>>> AST2400 SMC driver. It adds Dual Data support and read training giving
> >>>>>> the best read settings for a given chip. Support for the new AST2600
> >>>>>> SoC is added at the end.
> >>>>>>
> >>>>>> I understand that a new spi_mem framework exists and I do have an
> >>>>>> experimental driver using it. But unfortunately, it is difficult to
> >>>>>> integrate the read training. The Aspeed constraints are not compatible
> >>>>>> and i haven't had the time to extend the current framework.      
> >>>>>
> >>>>> Hm, I don't think that's a good reason to push new features to the
> >>>>> existing driver, especially since I asked others to migrate their
> >>>>> drivers to spi-mem in the past. I do understand your concerns, and I'll
> >>>>> let the SPI NOR/MTD maintainers make the final call, but I think it'd
> >>>>> be better for the SPI MEM ecosystem to think about this link-training
> >>>>> API (Vignesh needs it for the Cadence driver IIRC) rather than pushing
> >>>>> this kind of feature to spi-nor controller drivers.      
> >>>>
> >>>> As Cedric mentioned, the OpenBMC project has been shipping the read
> >>>> training code for the ast2400/ast2400 for several years now. It would
> >>>> be great to see it in mainline.
> >>>>
> >>>> I think it's reasonable to ask for the driver to be moved to the
> >>>> spi-mem subsystem once it has the required APIs.    
> >>>
> >>> Except it won't have the necessary APIs unless someone works on it, and
> >>> adding this feature to existing spi-nor drivers won't help achieving
> >>> this goal.    
> >>
> >>
> >> What would you suggest ? Something like the patch below which would
> >> call a 'train' operation at the end of spi_add_device().  
> > 
> > This has been discussed in the past with Vignesh, but I can't find the
> > thread where this discussion happened. My understanding was that link
> > training would use a command with well-known output (is there a
> > dedicated SPI NOR command for that?) and test different clk settings
> > until it finds one that works.  
> 
> The read training on Aspeed consists of finding the appropriate read
> timing delays for well-known HCLK dividers and store the results in 
> the Read Timing Compensation register. 
> 
> We first read a golden buffer at low speed and then perform reads with 
> different clocks and delay cycle settings to find a breaking point.

Where does this golden buffer come from? Do you have a specific command
to access it? Is it a NOR section with well-known data?

> This 
> selects the default clock frequency for the CEx control register. 
> 
>  
> >> Also, when doing read training, we might need to know some lowlevel 
> >> characteristics of the chip being trained. Should we offer a way 
> >> to grab the probed m25p80 device and give access to the underlying 
> >> 'struct spi_nor' ? 
> >>
> >>   static struct spi_nor *spi_get_pnor(struct spi_device *spi)
> >>   {
> >> 	struct spi_mem *spimem = spi_get_drvdata(spi);
> >> 	struct m25p *flash = spi_mem_get_drvdata(spimem);
> >>
> >> 	return flash ? &flash->spi_nor : NULL;
> >>   }
> >>
> >> Yeah, it's hideous. I just want to raise the issue.  
> > 
> > Oh no. We definitely don't want to expose the spi_nor chip to the
> > spi_mem layer, but, if needed, we can add more fields to spi_mem and
> > let the spi_mem driver fill them. We just need to figure out what's
> > really needed.  
> 
> We need the SPI/NOR flash characteristics for link training and its 
> size to configure the controller to access the CS on the AHB window. 

We managed to deal with direct mapping without having to explicitly pass
the NOR size (we just pass the size of the direct mapping we want to
create). What do you need the size for? Is it just to configure the AHB
window for the link-training stuff? If that's the case, I guess this
can be part of the op_template I was talking about, or maybe passed as
extra parameters.

> 
> [ ... ]
> 
> >>  	int (*fw_translate_cs)(struct spi_controller *ctlr, unsigned cs);
> >> +
> >> +	int			(*train)(struct spi_device *spi);  
> > 
> > Was more thinking of something like:
> > 
> > 	int (*link_setup)(struct spi_mem *mem,
> > 			  struct spi_mem_op *op_template,
> > 			  ...);
> > 
> > where the op_template would potentially differ depending on the type of
> > memory (NOR, NAND, SRAM?). I also don't know what other params would be
> > needed to do the link training.  
> 
> The Aspeed controller needs to set read delay timings at different HCLK
> settings. It's doing read operations with the default IO mode.

So you need information about the theoretical read delay so you can
adjust them, right. I guess that's something we can pass to the
->link_setup() hook.

>  
> > BTW, this hook should be in the spi_mem_controller_ops struct not in
> > spi_controller.  
> 
> ok. Let's wait for feedback from Vinesh.

Thanks for starting this discussion.

Boris

