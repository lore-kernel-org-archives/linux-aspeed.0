From: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>
Date: Tue, 18 Jul 2023 05:19:40 +0000
Subject: [PATCH v2 2/2] ARM: dts: aspeed: yosemitev4: add Facebook
 Yosemite V4 BMC
In-Reply-To: <0e6e32db-40e1-aa9f-fc05-20f2c5bf544d@linaro.org>
References: <20230712073752.54624-3-Delphine_CC_Chiu@wiwynn.com>
 <20230714023502.3225096-1-Delphine_CC_Chiu@wiwynn.com>
 <20230714023502.3225096-3-Delphine_CC_Chiu@wiwynn.com>
 <0e6e32db-40e1-aa9f-fc05-20f2c5bf544d@linaro.org>
Message-ID: <PS2PR04MB3592631E9B38B642A3E38B38B738A@PS2PR04MB3592.apcprd04.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: Friday, July 14, 2023 12:13 PM
> To: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>;
> patrick at stwcx.xyz; Arnd Bergmann <arnd@arndb.de>; Olof Johansson
> <olof@lixom.net>; soc at kernel.org; Rob Herring <robh+dt@kernel.org>;
> Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
> <conor+dt@kernel.org>; Joel Stanley <joel@jms.id.au>; Andrew Jeffery
> <andrew@aj.id.au>
> Cc: devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> linux-aspeed at lists.ozlabs.org; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH v2 2/2] ARM: dts: aspeed: yosemitev4: add Facebook
> Yosemite V4 BMC
> 
>   Security Reminder: Please be aware that this email is sent by an external
> sender.
> 
> On 14/07/2023 04:35, Delphine CC Chiu wrote:
> > Add linux device tree entry related to Yosemite V4 specific devices
> > connected to BMC SoC.
> >
> > Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> > ---
> >  arch/arm/boot/dts/Makefile                    |   1 +
> >  .../dts/aspeed-bmc-facebook-yosemitev4.dts    | 577
> ++++++++++++++++++
> >  2 files changed, 578 insertions(+)
> >  create mode 100644
> > arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev4.dts
> >
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index 59829fc90315..871e6d271262 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -1631,6 +1631,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
> >       aspeed-bmc-facebook-galaxy100.dtb \
> >       aspeed-bmc-facebook-greatlakes.dtb \
> >       aspeed-bmc-facebook-minipack.dtb \
> > +     aspeed-bmc-facebook-yosemitev4.dtb \
> >       aspeed-bmc-facebook-tiogapass.dtb \
> >       aspeed-bmc-facebook-wedge40.dtb \
> >       aspeed-bmc-facebook-wedge100.dtb \ diff --git
> > a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev4.dts
> > b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev4.dts
> > new file mode 100644
> > index 000000000000..cfe4838fae5a
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev4.dts
> > @@ -0,0 +1,577 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later // Copyright 2022
> > +Facebook Inc.
> > +
> > +/dts-v1/;
> > +#include "aspeed-g6.dtsi"
> > +#include <dt-bindings/gpio/aspeed-gpio.h> #include
> > +<dt-bindings/leds/leds-pca955x.h>
> > +#include <dt-bindings/i2c/i2c.h>
> > +
> > +/ {
> > +     model = "Facebook Yosemite V4 BMC";
> > +     compatible = "facebook,yosemitev4-bmc", "aspeed,ast2600";
> > +
> > +     aliases {
> > +             serial4 = &uart5;
> > +             serial5 = &uart6;
> > +             serial6 = &uart7;
> > +             serial7 = &uart8;
> > +             serial8 = &uart9;
> > +     };
> > +
> > +     chosen {
> > +             bootargs = "console=ttyS4,57600n8";
> 
> Nothing improved, so you just ignored entire feedback and resent the same.
I lost stdout-path feedback, so I'll revise to following format in next version contribute:
chosen {
               stdout-path = "serial4:57600n8";
      };

As former feedback mentioned, I also revise the i2c device node names by referencing DT specification.
The only node name I used that not on the list is "power-sensor",
which is following the example under Documentation/devicetree/bindings.

Most of the other partition in DTS is same as the recent-contributed project.
Would you please to tell if there's still some omissions I made.
Thank you for reviewing.
> 
> Sorry, that's not how responding to feedback works.
> 
> NAK
> 
> Best regards,
> Krzysztof

