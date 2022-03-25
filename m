From: Howard Chiu <howard_chiu@aspeedtech.com>
Date: Fri, 25 Mar 2022 01:56:59 +0000
Subject: [PATCH v1 1/3] ARM: dts: aspeed: Add video engine
In-Reply-To: <0419edf0-89ba-7db8-7f8f-7682d2af3e7c@quicinc.com>
References: <SG2PR06MB2315C9F4348D39DA1A448852E6199@SG2PR06MB2315.apcprd06.prod.outlook.com>
 <0419edf0-89ba-7db8-7f8f-7682d2af3e7c@quicinc.com>
Message-ID: <HK0PR06MB23070E27C9104B3726CC245EE61A9@HK0PR06MB2307.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Jae

> -----Original Message-----
> From: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
> Sent: Thursday, March 24, 2022 9:49 PM
> To: Howard Chiu <howard_chiu@aspeedtech.com>; robh+dt at kernel.org; Joel
> Stanley <joel@jms.id.au>; andrew at aj.id.au; devicetree at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; linux-aspeed at lists.ozlabs.org;
> linux-kernel at vger.kernel.org
> Subject: Re: [PATCH v1 1/3] ARM: dts: aspeed: Add video engine
> 
> Hi Howard,
> 
> On 3/24/2022 12:27 AM, Howard Chiu wrote:
> > The ast2600 SoC has an embedded video engine
> >
> > Signed-off-by: Howard Chiu <howard_chiu@aspeedtech.com>
> > ---
> >   arch/arm/boot/dts/aspeed-g6.dtsi | 11 +++++++++++
> >   1 file changed, 11 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi
> > b/arch/arm/boot/dts/aspeed-g6.dtsi
> > index c32e87fad4dc..41d5087f7d92 100644
> > --- a/arch/arm/boot/dts/aspeed-g6.dtsi
> > +++ b/arch/arm/boot/dts/aspeed-g6.dtsi
> > @@ -389,6 +389,17 @@ sbc: secure-boot-controller at 1e6f2000 {
> >   				reg = <0x1e6f2000 0x1000>;
> >   			};
> >
> > +			video: video at 1e700000 {
> > +				compatible = "aspeed,ast2600-video-engine";
> > +				reg = <0x1e700000 0x1000>;
> > +				clocks = <&syscon ASPEED_CLK_GATE_VCLK>,
> > +					 <&syscon ASPEED_CLK_GATE_ECLK>;
> > +				clock-names = "vclk", "eclk";
> > +				interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> > +				resets = <&syscon ASPEED_RESET_VIDEO>;
> 
> Video engine reset is handled by clk-ast2600.c so you don't need to add
> 'resets'.
> 
> > +				status = "disabled";
> > +			};
> > +
> 
> This node was already added back by this change.
> https://lore.kernel.org/all/CACPK8XfPPLoS=mhwbAHY4EfVad=1_dnhB+gaHBjPj
> 1wWbWE4gg at mail.gmail.com/
> 
Thanks for info, the next patchset won't include this.
> Cheers,
> 
> -Jae
> 
> >   			gpio0: gpio at 1e780000 {
> >   				#gpio-cells = <2>;
> >   				gpio-controller;
