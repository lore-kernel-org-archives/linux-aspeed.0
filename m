From: Steven Lee <steven_lee@aspeedtech.com>
Date: Wed, 9 Jun 2021 09:51:49 +0800
Subject: [PATCH v5 03/10] ARM: dts: aspeed-g6: Add SGPIO node.
In-Reply-To: <cef3e619-bd49-4318-bdcd-f844d2b80af7@www.fastmail.com>
References: <20210608102547.4880-1-steven_lee@aspeedtech.com>
 <20210608102547.4880-4-steven_lee@aspeedtech.com>
 <cef3e619-bd49-4318-bdcd-f844d2b80af7@www.fastmail.com>
Message-ID: <20210609015148.GA14839@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The 06/09/2021 08:43, Andrew Jeffery wrote:
> 
> 
> On Tue, 8 Jun 2021, at 19:55, Steven Lee wrote:
> > AST2600 supports 2 SGPIO master interfaces one with 128 pins another one
> > with 80 pins.
> > 
> > Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> > ---
> >  arch/arm/boot/dts/aspeed-g6.dtsi | 28 ++++++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
> > index f96607b7b4e2..c55baaf94314 100644
> > --- a/arch/arm/boot/dts/aspeed-g6.dtsi
> > +++ b/arch/arm/boot/dts/aspeed-g6.dtsi
> > @@ -377,6 +377,34 @@
> >  				#interrupt-cells = <2>;
> >  			};
> >  
> > +			sgpiom0: sgpiom at 1e780500 {
> > +				#gpio-cells = <2>;
> > +				gpio-controller;
> > +				compatible = "aspeed,ast2600-sgpiom-128";
> > +				reg = <0x1e780500 0x100>;
> > +				interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks = <&syscon ASPEED_CLK_APB2>;
> 
> The example in the binding document used ASPEED_CLK_APB. Which is correct? I assume ASPEED_CLK_APB2?
> 

The example in the binding document is for aspeed-g5.
aspeed-g5 and aspeed-g6 use different clocks.
Should I add a new patch for adding an example for aspeed-g6?

> > +				interrupt-controller;
> > +				bus-frequency = <12000000>;
> > +				pinctrl-names = "default";
> > +				pinctrl-0 = <&pinctrl_sgpm1_default>;
> > +				status = "disabled";
> > +			};
> > +
> > +			sgpiom1: sgpiom at 1e780600 {
> > +				#gpio-cells = <2>;
> > +				gpio-controller;
> > +				compatible = "aspeed,ast2600-sgpiom-80";
> > +				reg = <0x1e780600 0x100>;
> > +				interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks = <&syscon ASPEED_CLK_APB2>;
> > +				interrupt-controller;
> > +				bus-frequency = <12000000>;
> > +				pinctrl-names = "default";
> > +				pinctrl-0 = <&pinctrl_sgpm2_default>;
> > +				status = "disabled";
> > +			};
> > +
> >  			gpio1: gpio at 1e780800 {
> >  				#gpio-cells = <2>;
> >  				gpio-controller;
> > -- 
> > 2.17.1
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > 
