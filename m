From: Joel Stanley <joel@jms.id.au>
Date: Fri, 25 Sep 2020 04:49:22 +0000
Subject: [PATCH] soc: aspeed-lpc-ctrl: LPC to AHB mapping on ast2600
In-Reply-To: <2f51b12e-3651-48e4-b733-01f41ca44b92@www.fastmail.com>
References: <20200312121413.294384-1-joel@jms.id.au>
 <2f51b12e-3651-48e4-b733-01f41ca44b92@www.fastmail.com>
Message-ID: <CACPK8XcMiWP58vO39Fd_Qf9WZA43heMjx0eDktV3M8TGQC3HYA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 16 Mar 2020 at 01:58, Andrew Jeffery <andrew@aj.id.au> wrote:
>
>
>
> On Thu, 12 Mar 2020, at 22:44, Joel Stanley wrote:
> > The ast2600 disables the mapping of AHB memory regions by default,
> > only allowing the LPC window to point to SPI NOR. In order to point the
> > window to any AHB address, an ast2600 specific bit must be toggled.
> >
> > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > ---
> >  drivers/soc/aspeed/aspeed-lpc-ctrl.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/drivers/soc/aspeed/aspeed-lpc-ctrl.c
> > b/drivers/soc/aspeed/aspeed-lpc-ctrl.c
> > index f4ac14c40518..142cb4cc85e7 100644
> > --- a/drivers/soc/aspeed/aspeed-lpc-ctrl.c
> > +++ b/drivers/soc/aspeed/aspeed-lpc-ctrl.c
> > @@ -22,6 +22,9 @@
> >  #define HICR5_ENL2H  BIT(8)
> >  #define HICR5_ENFWH  BIT(10)
> >
> > +#define HICR6 0x4
>
> Given you introduced this I assume we don't have anything else touching
> the register, but if we ever do hopefully whoever it is that adds support is
> conscious that they need to be doing an read/modify/write to correctly
> clear the W1C registers without frobbing the bridge state.
>
> Looks like Aspeed should have introduced two bits to manage it :/

Yes, it would have been nice to have a separate register.

>
> > +#define SW_FWH2AHB   BIT(17)
> > +
> >  #define HICR7 0x8
> >  #define HICR8 0xc
> >
> > @@ -33,6 +36,7 @@ struct aspeed_lpc_ctrl {
> >       resource_size_t         mem_size;
> >       u32             pnor_size;
> >       u32             pnor_base;
> > +     bool                    fwh2ahb;
> >  };
> >
> >  static struct aspeed_lpc_ctrl *file_aspeed_lpc_ctrl(struct file *file)
> > @@ -177,6 +181,16 @@ static long aspeed_lpc_ctrl_ioctl(struct file
> > *file, unsigned int cmd,
> >               if (rc)
> >                       return rc;
> >
> > +             /*
> > +              * Switch to FWH2AHB mode, AST2600 only.
> > +              *
> > +              * The other bits in this register are interrupt status bits
> > +              * that are cleared by writing 1. As we don't want to clear
> > +              * them, set only the bit of interest.
> > +              */
> > +             if (lpc_ctrl->fwh2ahb)
> > +                     regmap_write(lpc_ctrl->regmap, HICR6, SW_FWH2AHB);
> > +
> >               /*
> >                * Enable LPC FHW cycles. This is required for the host to
> >                * access the regions specified.
> > @@ -274,6 +288,9 @@ static int aspeed_lpc_ctrl_probe(struct
> > platform_device *pdev)
> >               return rc;
> >       }
> >
> > +     if (of_device_is_compatible(dev->of_node, "aspeed,ast2600-lpc-ctrl"))
> > +             lpc_ctrl->fwh2ahb = true;
> > +
>
> This implies that we don't want the SPI-only behaviour by default, which is
> true for our platforms but doesn't really reflect the hardware. What are your
> thoughts on adding an explict devicetree property? use-fwh2ahb?

I chose to do it this way as userspace that is calling the ioctl to
set the mapping is probably expecting this behaviour. If someone in
the future wants to enhance the driver to separate out "lpc2spi" from
"lpc2ahb" then we could consider their patches.

The other upside of this is it maintains backwards compatibility with
the previous SoCs.

Cheers,

Joel
