From: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>
Date: Tue, 10 Sep 2024 08:20:57 +0000
Subject: [PATCH v1] ARM: dts: aspeed: yosemite4: Enable interrupt setting
 for pca9555
In-Reply-To: <42049344-fafb-4aee-8423-fe09a1a977f2@kernel.org>
References: <20240910063952.3006665-1-Delphine_CC_Chiu@wiwynn.com>
 <42049344-fafb-4aee-8423-fe09a1a977f2@kernel.org>
Message-ID: <TYZPR04MB5853795FDC6497F7E0114E43D69A2@TYZPR04MB5853.apcprd04.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



> -----Original Message-----
> From: Krzysztof Kozlowski <krzk@kernel.org>
> Sent: Tuesday, September 10, 2024 3:31 PM
> To: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>;
> patrick at stwcx.xyz; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski
> <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Joel Stanley
> <joel@jms.id.au>; Andrew Jeffery <andrew@codeconstruct.com.au>
> Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>;
> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> linux-aspeed at lists.ozlabs.org; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH v1] ARM: dts: aspeed: yosemite4: Enable interrupt setting
> for pca9555
> 
>  [External Sender]
> 
>  [External Sender]
> 
> On 10/09/2024 08:39, Delphine CC Chiu wrote:
> > From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> >
> > Enable interrupt setting and add GPIO line name for pca9555 for the
> > I/O expanders on Medusa board.
> >
> > Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> > Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> > ---
> >  .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 52
> > +++++++++++++++++--
> >  1 file changed, 48 insertions(+), 4 deletions(-)
> >
> > diff --git
> > a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> > b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> > index 98477792aa00..cb2436031181 100644
> > --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> > +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> > @@ -295,30 +295,74 @@ power-sensor at 12 {
> >
> >       gpio at 20 {
> >               compatible = "nxp,pca9555";
> > -             reg = <0x20>;
> >               gpio-controller;
> >               #gpio-cells = <2>;
> > +             reg = <0x20>;
> 
> Hm? Why? The placement is after compatible.
> 
I will revise in v2. Thanks!
> > +             interrupt-parent = <&gpio0>;
> > +             interrupts = <98 IRQ_TYPE_LEVEL_LOW>;
> > +             gpio-line-names =
> > +             "P48V_OCP_GPIO1","P48V_OCP_GPIO2",
> 
> Nothing improved here. I already commented about above and this.
> Implement feedback for all your patches, not only one.
> 
> Best regards,
> Krzysztof
Sorry about that.
I saw you say "Broken alignment" in v15 patch.
Would like to ask if the following format meets your expectations?
+			gpio-line-names =
+				"P48V_OCP_GPIO1", "P48V_OCP_GPIO2",
+				"P48V_OCP_GPIO3", "FAN_BOARD_0_REVISION_0_R",
