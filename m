From: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>
Date: Tue, 24 Sep 2024 09:44:23 +0000
Subject: [PATCH v1] ARM: dts: aspeed: yosemite4: Revise quad mode to dual
 mode
In-Reply-To: <215e32abc38011a5e265d91340292234ca157ec8.camel@codeconstruct.com.au>
References: <20240910051350.2580971-1-Delphine_CC_Chiu@wiwynn.com>
 <215e32abc38011a5e265d91340292234ca157ec8.camel@codeconstruct.com.au>
Message-ID: <TYZPR04MB5853E0C06B8A019CF1115166D6682@TYZPR04MB5853.apcprd04.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



> -----Original Message-----
> From: Andrew Jeffery <andrew@codeconstruct.com.au>
> Sent: Thursday, September 12, 2024 10:17 AM
> To: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>;
> patrick at stwcx.xyz; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski
> <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Joel Stanley
> <joel@jms.id.au>
> Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>;
> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> linux-aspeed at lists.ozlabs.org; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH v1] ARM: dts: aspeed: yosemite4: Revise quad mode to
> dual mode
> 
>  [External Sender]
> 
>  [External Sender]
> 
> On Tue, 2024-09-10 at 13:13 +0800, Delphine CC Chiu wrote:
> > From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> >
> > Revise quad mode to dual mode to avoid WP pin influnece the SPI.
> >
> > Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> > Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> > ---
> >  .../arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 8
> > +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git
> > a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> > b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> > index 98477792aa00..3073ade6d77c 100644
> > --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> > +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> > @@ -105,15 +105,17 @@ flash at 0 {
> >               status = "okay";
> >               m25p,fast-read;
> >               label = "bmc";
> > -             spi-rx-bus-width = <4>;
> > +             spi-tx-bus-width = <2>;
> > +             spi-rx-bus-width = <2>;
> >               spi-max-frequency = <50000000>; -#include
> > "openbmc-flash-layout-64.dtsi"
> > +#include "openbmc-flash-layout-128.dtsi"
> 
> This is a bit more drastic than changing the bus mode.
> 
> Can you please split that out to a separate change with some justification in
> the commit message? For instance, was the chip changed too? Or were you
> using the 64M layout or a 128M chip the whole time?
> 
> Andrew
I'll split the patch in v2. Thanks!
