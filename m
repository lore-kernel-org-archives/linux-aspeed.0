From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 09 Jun 2021 11:49:50 +0930
Subject: [PATCH v5 03/10] ARM: dts: aspeed-g6: Add SGPIO node.
In-Reply-To: <20210609015148.GA14839@aspeedtech.com>
References: <20210608102547.4880-1-steven_lee@aspeedtech.com>
 <20210608102547.4880-4-steven_lee@aspeedtech.com>
 <cef3e619-bd49-4318-bdcd-f844d2b80af7@www.fastmail.com>
 <20210609015148.GA14839@aspeedtech.com>
Message-ID: <1a15de23-4e02-45cc-aadd-088319244798@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Wed, 9 Jun 2021, at 11:21, Steven Lee wrote:
> The 06/09/2021 08:43, Andrew Jeffery wrote:
> > 
> > 
> > On Tue, 8 Jun 2021, at 19:55, Steven Lee wrote:
> > > AST2600 supports 2 SGPIO master interfaces one with 128 pins another one
> > > with 80 pins.
> > > 
> > > Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> > > ---
> > >  arch/arm/boot/dts/aspeed-g6.dtsi | 28 ++++++++++++++++++++++++++++
> > >  1 file changed, 28 insertions(+)
> > > 
> > > diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
> > > index f96607b7b4e2..c55baaf94314 100644
> > > --- a/arch/arm/boot/dts/aspeed-g6.dtsi
> > > +++ b/arch/arm/boot/dts/aspeed-g6.dtsi
> > > @@ -377,6 +377,34 @@
> > >  				#interrupt-cells = <2>;
> > >  			};
> > >  
> > > +			sgpiom0: sgpiom at 1e780500 {
> > > +				#gpio-cells = <2>;
> > > +				gpio-controller;
> > > +				compatible = "aspeed,ast2600-sgpiom-128";
> > > +				reg = <0x1e780500 0x100>;
> > > +				interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
> > > +				clocks = <&syscon ASPEED_CLK_APB2>;
> > 
> > The example in the binding document used ASPEED_CLK_APB. Which is correct? I assume ASPEED_CLK_APB2?
> > 
> 
> The example in the binding document is for aspeed-g5.
> aspeed-g5 and aspeed-g6 use different clocks.
> Should I add a new patch for adding an example for aspeed-g6?
> 

Oh, I missed that. Never mind then!

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
