From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Date: Sat, 6 Nov 2021 10:01:35 +0000
Subject: [PATCH 03/10] dts: aspeed: ast2600: Support SDR50 for SD device
In-Reply-To: <88c261c2-797a-4803-ac30-24f95a397496@www.fastmail.com>
References: <20210922103116.30652-1-chin-ting_kuo@aspeedtech.com>
 <20210922103116.30652-4-chin-ting_kuo@aspeedtech.com>
 <88c261c2-797a-4803-ac30-24f95a397496@www.fastmail.com>
Message-ID: <HK0PR06MB27862907BFE7C299AD78B926B28F9@HK0PR06MB2786.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Andrew Jeffery <andrew@aj.id.au>
> Sent: Tuesday, October 26, 2021 8:43 AM
> Subject: Re: [PATCH 03/10] dts: aspeed: ast2600: Support SDR50 for SD device
> 
> 
> 
> On Wed, 22 Sep 2021, at 20:01, Chin-Ting Kuo wrote:
> > The maximum frequency for SD controller on AST2600 EVB is 100MHz. In
> > order to achieve 100MHz, sd-uhs-sdr50 property should be added and the
> > driver will set the SDR50 supported bit in capability 2 register
> > during probing stage.
> >
> > Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> 
> As this is a limitation of the SoC it should be done in aspeed-g6.dtsi.
> Unless I've misunderstood?
> 

Okay, it will be updated in the next patch version.

> Andrew
> 
> > ---
> >  arch/arm/boot/dts/aspeed-ast2600-evb.dts | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/aspeed-ast2600-evb.dts
> > b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
> > index b7eb552640cb..4551dba499c2 100644
> > --- a/arch/arm/boot/dts/aspeed-ast2600-evb.dts
> > +++ b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
> > @@ -280,6 +280,7 @@
> >  &sdhci0 {
> >  	status = "okay";
> >  	bus-width = <4>;
> > +	sd-uhs-sdr50;
> >  	max-frequency = <100000000>;
> >  	sdhci-drive-type = /bits/ 8 <3>;
> >  	sdhci-caps-mask = <0x7 0x0>;
> > @@ -292,6 +293,7 @@
> >  &sdhci1 {
> >  	status = "okay";
> >  	bus-width = <4>;
> > +	sd-uhs-sdr50;
> >  	max-frequency = <100000000>;
> >  	sdhci-drive-type = /bits/ 8 <3>;
> >  	sdhci-caps-mask = <0x7 0x0>;
> > --
> > 2.17.1

Chin-Ting
