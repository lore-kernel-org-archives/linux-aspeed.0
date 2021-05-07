From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 07 May 2021 13:12:33 +0930
Subject: =?UTF-8?Q?Re:_[PATCH_v3_2/5]_ARM:_dts:_aspeed:_ast2600evb:_Add_comment_f?=
 =?UTF-8?Q?or_gpio_regulator_of_sdhci?=
In-Reply-To: <20210507033021.GB23749@aspeedtech.com>
References: <20210506100312.1638-1-steven_lee@aspeedtech.com>
 <20210506100312.1638-3-steven_lee@aspeedtech.com>
 <8611c4a7-8c65-4d7d-90d5-37c80faa3142@www.fastmail.com>
 <20210507033021.GB23749@aspeedtech.com>
Message-ID: <d581f7b9-dd08-4690-ba3e-f38662dcb587@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Fri, 7 May 2021, at 13:00, Steven Lee wrote:
> The 05/07/2021 09:40, Andrew Jeffery wrote:
> > 
> > 
> > On Thu, 6 May 2021, at 19:33, Steven Lee wrote:
> > > Add the description for describing the AST2600-A2 EVB reference design of
> > > GPIO regulators.
> > > 
> > > Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> > > ---
> > >  arch/arm/boot/dts/aspeed-ast2600-evb.dts | 15 +++++++++++++++
> > >  1 file changed, 15 insertions(+)
> > > 
> > > diff --git a/arch/arm/boot/dts/aspeed-ast2600-evb.dts 
> > > b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
> > > index 2772796e215e..1ae0facc3d5f 100644
> > > --- a/arch/arm/boot/dts/aspeed-ast2600-evb.dts
> > > +++ b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
> > > @@ -104,6 +104,21 @@
> > >  	status = "okay";
> > >  };
> > >  
> > > +/*
> > > + * The signal voltage of sdhci0 and sdhci1 on AST2600-A2 EVB is able to be
> > > + * toggled by GPIO pins.
> > > + * In the reference design, GPIOV0 of AST2600-A2 EVB is connected to the
> > > + * power load switch that providing 3.3v to sdhci0 vdd, GPIOV1 is connected to
> > > + * a 1.8v and a 3.3v power load switch that providing signal voltage to
> > > + * sdhci0 bus.
> > > + * If GPIOV0 is active high, sdhci0 is enabled, otherwise, sdhci0 is disabled.
> > > + * If GPIOV1 is active high, 3.3v power load switch is enabled, sdhci0 signal
> > > + * voltage is 3.3v, otherwise, 1.8v power load switch will be enabled,
> > > + * sdhci0 signal voltage becomes 1.8v.
> > > + * AST2600-A2 EVB also support toggling signal voltage for sdhci1.
> > > + * The design is the same as sdhci0, it uses GPIOV2 as power-gpio and GPIOV3
> > > + * as power-switch-gpio.
> > > + */
> > 
> > Okay, I think the comment is in the right place, but I feel this patch 
> > should also add the regulator nodes and hook them up to the SDHCIs.
> > 
> > Given Rob isn't super keen on a second example in the binding document 
> > I think you can just cut the example out and paste it in here.
> > 
> 
> Hi Andrew,
> 
> Since AST2600-A0 and AST2600-A1 don't have regulators, do you mean cut
> the example from dt-binding and paste it to aspeed-ast2600-evb.dts but
> comment out the example?

If the board design varies with the silicon revision we should probably 
have devicetrees that are appropriate for each, so an 
aspeed-ast2600-evb-a2.dts

#include "aspeed-ast2600-evb.dts" at the top and go from there.

Cheers,

Andrew
