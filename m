From: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>
Date: Tue, 1 Oct 2024 07:45:11 +0000
Subject: [PATCH v1 4/8] ARM: dts: aspeed: yosemite4: Revise address of
 i2c-mux for two fan boards
In-Reply-To: <9c0a5a8247622e094b927f2c26550d3ce9af5896.camel@codeconstruct.com.au>
References: <20240930070500.3174431-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240930070500.3174431-5-Delphine_CC_Chiu@wiwynn.com>
 <9c0a5a8247622e094b927f2c26550d3ce9af5896.camel@codeconstruct.com.au>
Message-ID: <TYZPR04MB58537972801CB54C46AF0C27D6772@TYZPR04MB5853.apcprd04.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



> -----Original Message-----
> From: Andrew Jeffery <andrew@codeconstruct.com.au>
> Sent: Tuesday, October 1, 2024 8:39 AM
> To: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>;
> patrick at stwcx.xyz; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski
> <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Joel Stanley
> <joel@jms.id.au>
> Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>;
> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> linux-aspeed at lists.ozlabs.org; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH v1 4/8] ARM: dts: aspeed: yosemite4: Revise address of
> i2c-mux for two fan boards
> 
>  [External Sender]
> 
>  [External Sender]
> 
> On Mon, 2024-09-30 at 15:04 +0800, Delphine CC Chiu wrote:
> > From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> >
> > Change the address of the I2C mux for two fan boards to 0x74 according
> > to schematic.
> >
> > Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> > Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> > ---
> >  .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 80
> > ++++++++++---------
> >  1 file changed, 43 insertions(+), 37 deletions(-)
> >
> > diff --git
> > a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> > b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> > index 26e0fcbed8d2..ecf012c9cbbc 100644
> > --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> > +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> > @@ -32,6 +32,8 @@ aliases {
> >               i2c27 = &imux27;
> >               i2c28 = &imux28;
> >               i2c29 = &imux29;
> > +             i2c30 = &imux30;
> > +             i2c31 = &imux31;
> >               i2c34 = &imux34;
> >               i2c35 = &imux35;
> >       };
> > @@ -1062,6 +1064,8 @@ gpio at 23 {
> >  };
> >
> >  &i2c14 {
> > +     #address-cells = <1>;
> > +     #size-cells = <0>;
> >       status = "okay";
> >       bus-frequency = <400000>;
> >       adc at 1d {
> > @@ -1122,20 +1126,50 @@ eeprom at 51 {
> >               reg = <0x51>;
> >       };
> >
> > -     i2c-mux at 71 {
> > -             compatible = "nxp,pca9846";
> > +     i2c-mux at 73 {
> > +             compatible = "nxp,pca9544";
> >               #address-cells = <1>;
> >               #size-cells = <0>;
> >
> >               idle-state = <0>;
> >               i2c-mux-idle-disconnect;
> > -             reg = <0x71>;
> > +             reg = <0x73>;
> >
> >               i2c at 0 {
> >                       #address-cells = <1>;
> >                       #size-cells = <0>;
> >                       reg = <0>;
> >
> > +                     adc at 35 {
> > +                             compatible = "maxim,max11617";
> > +                             reg = <0x35>;
> > +                     };
> > +             };
> > +
> > +             i2c at 1 {
> > +                     #address-cells = <1>;
> > +                     #size-cells = <0>;
> > +                     reg = <0>;
> > +
> > +                     adc at 35 {
> > +                             compatible = "maxim,max11617";
> > +                             reg = <0x35>;
> > +                     };
> > +             };
> > +     };
> > +
> > +     i2c-mux at 74 {
> > +             compatible = "nxp,pca9546";
> > +             reg = <0x74>;
> > +             #address-cells = <1>;
> > +             #size-cells = <0>;
> > +             i2c-mux-idle-disconnect;
> > +
> > +             imux30: i2c at 0 {
> > +                     reg = <0>;
> > +                     #address-cells = <1>;
> > +                     #size-cells = <0>;
> > +
> >                       adc at 1f {
> >                               compatible = "ti,adc128d818";
> >                               reg = <0x1f>; @@ -1152,6 +1186,8
> @@
> > pwm at 20{
> >                       gpio at 22{
> >                               compatible = "ti,tca6424";
> >                               reg = <0x22>;
> > +                             gpio-controller;
> > +                             #gpio-cells = <2>;
> 
> This seems unrelated. Such changes should be in their own patch with a `Fixes:`
> tag.
> 
> >                       };
> >
> >                       pwm at 23{
> > @@ -1181,10 +1217,10 @@ gpio at 61 {
> >                       };
> >               };
> >
> > -             i2c at 1 {
> > +             imux31: i2c at 1 {
> > +                     reg = <1>;
> >                       #address-cells = <1>;
> >                       #size-cells = <0>;
> > -                     reg = <0>;
> >
> >                       adc at 1f {
> >                               compatible = "ti,adc128d818"; @@
> -1202,6
> > +1238,8 @@ pwm at 20{
> >                       gpio at 22{
> >                               compatible = "ti,tca6424";
> >                               reg = <0x22>;
> > +                             gpio-controller;
> > +                             #gpio-cells = <2>;
> 
> This should go in the same patch as the instance above.
> 
Hi Andrew,
I'll split a fix patch for this in the next serial patches. Thanks.
