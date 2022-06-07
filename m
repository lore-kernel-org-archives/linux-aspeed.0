From: Neal Liu <neal_liu@aspeedtech.com>
Date: Tue, 7 Jun 2022 03:59:48 +0000
Subject: [PATCH v2 3/5] ARM: dts: aspeed: Add HACE device controller node
In-Reply-To: <bba832ec-ea64-71db-385a-ab9816e7239c@linux.microsoft.com>
References: <20220606064935.1458903-1-neal_liu@aspeedtech.com>
 <20220606064935.1458903-4-neal_liu@aspeedtech.com>
 <bba832ec-ea64-71db-385a-ab9816e7239c@linux.microsoft.com>
Message-ID: <HK0PR06MB3202698F2E93BE1CF2C9626380A59@HK0PR06MB3202.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> On 6/5/2022 11:49 PM, Neal Liu wrote:
> > diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi
> > b/arch/arm/boot/dts/aspeed-g6.dtsi
> > index 3d5ce9da42c3..371d2a6b56ef 100644
> > --- a/arch/arm/boot/dts/aspeed-g6.dtsi
> > +++ b/arch/arm/boot/dts/aspeed-g6.dtsi
> > @@ -304,6 +304,14 @@ apb {
> >   			#size-cells = <1>;
> >   			ranges;
> >
> > +			hace: crypto at 1e6d0000 {
> > +				compatible = "aspeed,ast2600-hace";
> > +				reg = <0x1e6d0000 0x200>;
> > +				interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks = <&syscon ASPEED_CLK_GATE_YCLK>;
> > +				resets = <&syscon ASPEED_RESET_HACE>;
> 
> Shouldn't the left side be also 'crypto', see existing crypto nodes in
> arch/arm64/dts for example.
> 
> 			crypto: crypto at 1e6d0000 {
> 				...
> 
> Regards,
> Dhananjay

It's a naming preference. "hace" is our hash & crypto hardware engine naming.
And we also have other crypto engines will be upstream soon.
So I prefer to keep this part, is that okay for you?

Thanks

