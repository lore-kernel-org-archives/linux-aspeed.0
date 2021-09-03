From: Eddie James <eajames@linux.ibm.com>
Date: Fri, 03 Sep 2021 16:40:47 -0500
Subject: [PATCH 1/2] ARM: dts: aspeed: rainier: Add system LEDs
In-Reply-To: <CACPK8XcR-=ThNZy6sFtr1kNiEx2BKCNH2gfZKZaFXqQ0_-26uQ@mail.gmail.com>
References: <20210830214644.58539-1-eajames@linux.ibm.com>
 <CACPK8XcR-=ThNZy6sFtr1kNiEx2BKCNH2gfZKZaFXqQ0_-26uQ@mail.gmail.com>
Message-ID: <296479c5c662a18a6625358714605649697a0c59.camel@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 2021-09-03 at 00:08 +0000, Joel Stanley wrote:
> On Mon, 30 Aug 2021 at 21:46, Eddie James <eajames@linux.ibm.com>
> wrote:
> > Add all the missing system LEDs. These are all connected by GPIO
> > expanders.
> > 
> > Signed-off-by: Eddie James <eajames@linux.ibm.com>
> 
> Can you resend this with --minimal added to your git-format-patch
> line? It creates a much better diff that is easier to review.
> 
> Please cc linux-arm-kernel so it ends up on lore.kernel.org.
> 
> It would be good if you could cc some of the people involved in LEDs
> so they can review the patch for us. Andrew J and Ravindra perhaps?

Thanks for the tip, I will do so... was wondering why it was so bad.

Thanks,
Eddie

> 
> Cheers,
> 
> Joel
> 
> 
> > ---
> >  arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 1541
> > +++++++++++++++---
> >  1 file changed, 1325 insertions(+), 216 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
> > b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
> > index d1467d5163f2..f222aea91b2e 100644
> > --- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
> > +++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
> > @@ -1126,6 +1126,62 @@ tmp275 at 4a {
> >                 reg = <0x4a>;
> >         };
> > 
> > +       pca9551 at 60 {
> > +               compatible = "nxp,pca9551";
> > +               reg = <0x60>;
> > +               #address-cells = <1>;
> > +               #size-cells = <0>;
> > +
> > +               gpio-controller;
> > +               #gpio-cells = <2>;
> > +
> > +               led at 0 {
> > +                       label = "cablecard0-cxp-top";
> > +                       reg = <0>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > +
> > +               led at 1 {
> > +                       label = "cablecard0-cxp-bot";
> > +                       reg = <1>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > +
> > +               gpio at 2 {
> > +                       reg = <2>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> > +
> > +               gpio at 3 {
> > +                       reg = <3>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> > +
> > +               gpio at 4 {
> > +                       reg = <4>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> > +
> > +               gpio at 5 {
> > +                       reg = <5>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> > +
> > +               gpio at 6 {
> > +                       reg = <6>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> > +
> > +               gpio at 7 {
> > +                       reg = <7>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> > +       };
> > +
> >         pca9546 at 70 {
> >                 compatible = "nxp,pca9546";
> >                 reg = <0x70>;
> > @@ -1182,6 +1238,118 @@ tmp275 at 49 {
> >                 reg = <0x49>;
> >         };
> > 
> > +       pca9551 at 60 {
> > +               compatible = "nxp,pca9551";
> > +               reg = <0x60>;
> > +               #address-cells = <1>;
> > +               #size-cells = <0>;
> > +
> > +               gpio-controller;
> > +               #gpio-cells = <2>;
> > +
> > +               led at 0 {
> > +                       label = "cablecard3-cxp-top";
> > +                       reg = <0>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > +
> > +               led at 1 {
> > +                       label = "cablecard3-cxp-bot";
> > +                       reg = <1>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > +
> > +               gpio at 2 {
> > +                       reg = <2>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> > +
> > +               gpio at 3 {
> > +                       reg = <3>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> > +
> > +               gpio at 4 {
> > +                       reg = <4>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> > +
> > +               gpio at 5 {
> > +                       reg = <5>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> > +
> > +               gpio at 6 {
> > +                       reg = <6>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> > +
> > +               gpio at 7 {
> > +                       reg = <7>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> > +       };
> > +
> > +       pca9551 at 61 {
> > +               compatible = "nxp,pca9551";
> > +               reg = <0x61>;
> > +               #address-cells = <1>;
> > +               #size-cells = <0>;
> > +
> > +               gpio-controller;
> > +               #gpio-cells = <2>;
> > +
> > +               led at 0 {
> > +                       label = "cablecard4-cxp-top";
> > +                       reg = <0>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > +
> > +               led at 1 {
> > +                       label = "cablecard4-cxp-bot";
> > +                       reg = <1>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > +
> > +               gpio at 2 {
> > +                       reg = <2>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> > +
> > +               gpio at 3 {
> > +                       reg = <3>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> > +
> > +               gpio at 4 {
> > +                       reg = <4>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> > +
> > +               gpio at 5 {
> > +                       reg = <5>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> > +
> > +               gpio at 6 {
> > +                       reg = <6>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> > +
> > +               gpio at 7 {
> > +                       reg = <7>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> > +       };
> > +
> >         pca9546 at 70 {
> >                 compatible = "nxp,pca9546";
> >                 reg = <0x70>;
> > @@ -1290,101 +1458,69 @@ &i2c7 {
> >         multi-master;
> >         status = "okay";
> > 
> > -       si7021-a20 at 40 {
> > -               compatible = "silabs,si7020";
> > -               reg = <0x40>;
> > -       };
> > -
> > -       tmp275 at 48 {
> > -               compatible = "ti,tmp275";
> > -               reg = <0x48>;
> > -       };
> > -
> > -       max: max31785 at 52 {
> > -               compatible = "maxim,max31785a";
> > -               reg = <0x52>;
> > -               #address-cells = <1>;
> > -               #size-cells = <0>;
> > -
> > -               fan0: fan at 0 {
> > -                       compatible = "pmbus-fan";
> > -                       reg = <0>;
> > -                       tach-pulses = <2>;
> > -               };
> > -
> > -               fan1: fan at 1 {
> > -                       compatible = "pmbus-fan";
> > -                       reg = <1>;
> > -                       tach-pulses = <2>;
> > -               };
> > -
> > -               fan2: fan at 2 {
> > -                       compatible = "pmbus-fan";
> > -                       reg = <2>;
> > -                       tach-pulses = <2>;
> > -               };
> > -
> > -               fan3: fan at 3 {
> > -                       compatible = "pmbus-fan";
> > -                       reg = <3>;
> > -                       tach-pulses = <2>;
> > -               };
> > -
> > -               fan4: fan at 4 {
> > -                       compatible = "pmbus-fan";
> > -                       reg = <4>;
> > -                       tach-pulses = <2>;
> > -               };
> > -
> > -               fan5: fan at 5 {
> > -                       compatible = "pmbus-fan";
> > -                       reg = <5>;
> > -                       tach-pulses = <2>;
> > -               };
> > -       };
> > -
> > -       pca0: pca9552 at 61 {
> > -               compatible = "nxp,pca9552";
> > -               reg = <0x61>;
> > +       pca9552 at 30 {
> > +               compatible = "ibm,pca9552";
> > +               reg = <0x30>;
> >                 #address-cells = <1>;
> >                 #size-cells = <0>;
> > 
> >                 gpio-controller;
> >                 #gpio-cells = <2>;
> > 
> > -               gpio at 0 {
> > +               led at 0 {
> > +                       label = "pcieslot0";
> >                         reg = <0>;
> > -                       type = <PCA955X_TYPE_GPIO>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> >                 };
> > 
> > -               gpio at 1 {
> > +               led at 1 {
> > +                       label = "pcieslot1";
> >                         reg = <1>;
> > -                       type = <PCA955X_TYPE_GPIO>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> >                 };
> > 
> > -               gpio at 2 {
> > +               led at 2 {
> > +                       label = "pcieslot2";
> >                         reg = <2>;
> > -                       type = <PCA955X_TYPE_GPIO>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> >                 };
> > 
> > -               gpio at 3 {
> > +               led at 3 {
> > +                       label = "pcieslot3";
> >                         reg = <3>;
> > -                       type = <PCA955X_TYPE_GPIO>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> >                 };
> > 
> > -               gpio at 4 {
> > +               led at 4 {
> > +                       label = "pcieslot4";
> >                         reg = <4>;
> > -                       type = <PCA955X_TYPE_GPIO>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> >                 };
> > 
> > -               gpio at 5 {
> > +               led at 5 {
> > +                       label = "cpu1";
> >                         reg = <5>;
> > -                       type = <PCA955X_TYPE_GPIO>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> >                 };
> > 
> > -               gpio at 6 {
> > +               led at 6 {
> > +                       label = "cpu-vrm1";
> >                         reg = <6>;
> > -                       type = <PCA955X_TYPE_GPIO>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> >                 };
> > 
> >                 gpio at 7 {
> > @@ -1392,9 +1528,12 @@ gpio at 7 {
> >                         type = <PCA955X_TYPE_GPIO>;
> >                 };
> > 
> > -               gpio at 8 {
> > +               led at 8 {
> > +                       label = "lcd-russel";
> >                         reg = <8>;
> > -                       type = <PCA955X_TYPE_GPIO>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> >                 };
> > 
> >                 gpio at 9 {
> > @@ -1433,116 +1572,955 @@ gpio at 15 {
> >                 };
> >         };
> > 
> > -       ibm-panel at 62 {
> > -               compatible = "ibm,op-panel";
> > -               reg = <(0x62 | I2C_OWN_SLAVE_ADDRESS)>;
> > -       };
> > +       pca9552 at 31 {
> > +               compatible = "ibm,pca9552";
> > +               reg = <0x31>;
> > +               #address-cells = <1>;
> > +               #size-cells = <0>;
> > 
> > -       dps: dps310 at 76 {
> > -               compatible = "infineon,dps310";
> > -               reg = <0x76>;
> > -               #io-channel-cells = <0>;
> > -       };
> > +               gpio-controller;
> > +               #gpio-cells = <2>;
> > 
> > -       eeprom at 50 {
> > -               compatible = "atmel,24c64";
> > -               reg = <0x50>;
> > -       };
> > +               led at 0 {
> > +                       label = "ddimm0";
> > +                       reg = <0>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > 
> > -       eeprom at 51 {
> > -               compatible = "atmel,24c64";
> > -               reg = <0x51>;
> > -       };
> > -};
> > +               led at 1 {
> > +                       label = "ddimm1";
> > +                       reg = <1>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > 
> > -&i2c8 {
> > -       status = "okay";
> > +               led at 2 {
> > +                       label = "ddimm2";
> > +                       reg = <2>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > 
> > -       ucd90320 at 11 {
> > -               compatible = "ti,ucd90320";
> > -               reg = <0x11>;
> > -       };
> > +               led at 3 {
> > +                       label = "ddimm3";
> > +                       reg = <3>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > 
> > -       rtc at 32 {
> > -               compatible = "epson,rx8900";
> > -               reg = <0x32>;
> > -       };
> > +               led at 4 {
> > +                       label = "ddimm4";
> > +                       reg = <4>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > 
> > -       tmp275 at 48 {
> > -               compatible = "ti,tmp275";
> > -               reg = <0x48>;
> > -       };
> > +               led at 5 {
> > +                       label = "ddimm5";
> > +                       reg = <5>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > 
> > -       tmp275 at 4a {
> > -               compatible = "ti,tmp275";
> > -               reg = <0x4a>;
> > -       };
> > +               led at 6 {
> > +                       label = "ddimm6";
> > +                       reg = <6>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > +
> > +               led at 7 {
> > +                       label = "ddimm7";
> > +                       reg = <7>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > +
> > +               led at 8 {
> > +                       label = "ddimm8";
> > +                       reg = <8>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > +
> > +               led at 9 {
> > +                       label = "ddimm9";
> > +                       reg = <9>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > +
> > +               led at 10 {
> > +                       label = "ddimm10";
> > +                       reg = <10>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > +
> > +               led at 11 {
> > +                       label = "ddimm11";
> > +                       reg = <11>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > +
> > +               led at 12 {
> > +                       label = "ddimm12";
> > +                       reg = <12>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > +
> > +               led at 13 {
> > +                       label = "ddimm13";
> > +                       reg = <13>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > +
> > +               led at 14 {
> > +                       label = "ddimm14";
> > +                       reg = <14>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > +
> > +               led at 15 {
> > +                       label = "ddimm15";
> > +                       reg = <15>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > +       };
> > +
> > +       pca9552 at 32 {
> > +               compatible = "ibm,pca9552";
> > +               reg = <0x32>;
> > +               #address-cells = <1>;
> > +               #size-cells = <0>;
> > +
> > +               gpio-controller;
> > +               #gpio-cells = <2>;
> > +
> > +               led at 0 {
> > +                       label = "ddimm16";
> > +                       reg = <0>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > +
> > +               led at 1 {
> > +                       label = "ddimm17";
> > +                       reg = <1>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > +
> > +               led at 2 {
> > +                       label = "ddimm18";
> > +                       reg = <2>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > +
> > +               led at 3 {
> > +                       label = "ddimm19";
> > +                       reg = <3>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > +
> > +               led at 4 {
> > +                       label = "ddimm20";
> > +                       reg = <4>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > +
> > +               led at 5 {
> > +                       label = "ddimm21";
> > +                       reg = <5>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > +
> > +               led at 6 {
> > +                       label = "ddimm22";
> > +                       reg = <6>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > +
> > +               led at 7 {
> > +                       label = "ddimm23";
> > +                       reg = <7>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > +
> > +               led at 8 {
> > +                       label = "ddimm24";
> > +                       reg = <8>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > +
> > +               led at 9 {
> > +                       label = "ddimm25";
> > +                       reg = <9>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > +
> > +               led at 10 {
> > +                       label = "ddimm26";
> > +                       reg = <10>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > +
> > +               led at 11 {
> > +                       label = "ddimm27";
> > +                       reg = <11>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > +
> > +               led at 12 {
> > +                       label = "ddimm28";
> > +                       reg = <12>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > +
> > +               led at 13 {
> > +                       label = "ddimm29";
> > +                       reg = <13>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > +
> > +               led at 14 {
> > +                       label = "ddimm30";
> > +                       reg = <14>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > +
> > +               led at 15 {
> > +                       label = "ddimm31";
> > +                       reg = <15>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > +       };
> > +
> > +       pca9552 at 33 {
> > +               compatible = "ibm,pca9552";
> > +               reg = <0x33>;
> > +               #address-cells = <1>;
> > +               #size-cells = <0>;
> > +
> > +               gpio-controller;
> > +               #gpio-cells = <2>;
> > +
> > +               led at 0 {
> > +                       label = "planar";
> > +                       reg = <0>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > +
> > +               led at 1 {
> > +                       label = "cpu0";
> > +                       reg = <1>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > +
> > +               gpio at 2 {
> > +                       reg = <2>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> > +
> > +               led at 3 {
> > +                       label = "dasd-pyramid0";
> > +                       reg = <3>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > +
> > +               led at 4 {
> > +                       label = "dasd-pyramid1";
> > +                       reg = <4>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > +
> > +               led at 5 {
> > +                       label = "dasd-pyramid2";
> > +                       reg = <5>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > +
> > +               led at 6 {
> > +                       label = "cpu0-vrm0";
> > +                       reg = <6>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > +
> > +               led at 7 {
> > +                       label = "rtc-battery";
> > +                       reg = <7>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > +
> > +               led at 8 {
> > +                       label = "base-blyth";
> > +                       reg = <8>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > +
> > +               led at 9 {
> > +                       label = "pcieslot6";
> > +                       reg = <9>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > +
> > +               led at 10 {
> > +                       label = "pcieslot7";
> > +                       reg = <10>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > +
> > +               led at 11 {
> > +                       label = "pcieslot8";
> > +                       reg = <11>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > +
> > +               led at 12 {
> > +                       label = "pcieslot9";
> > +                       reg = <12>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > +
> > +               led at 13 {
> > +                       label = "pcieslot10";
> > +                       reg = <13>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > +
> > +               led at 14 {
> > +                       label = "pcieslot11";
> > +                       reg = <14>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > +
> > +               led at 15 {
> > +                       label = "tpm-wilson";
> > +                       reg = <15>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > +       };
> > +
> > +       si7021-a20 at 40 {
> > +               compatible = "silabs,si7020";
> > +               reg = <0x40>;
> > +       };
> > +
> > +       tmp275 at 48 {
> > +               compatible = "ti,tmp275";
> > +               reg = <0x48>;
> > +       };
> > +
> > +       max: max31785 at 52 {
> > +               compatible = "maxim,max31785a";
> > +               reg = <0x52>;
> > +               #address-cells = <1>;
> > +               #size-cells = <0>;
> > +
> > +               fan0: fan at 0 {
> > +                       compatible = "pmbus-fan";
> > +                       reg = <0>;
> > +                       tach-pulses = <2>;
> > +               };
> > +
> > +               fan1: fan at 1 {
> > +                       compatible = "pmbus-fan";
> > +                       reg = <1>;
> > +                       tach-pulses = <2>;
> > +               };
> > +
> > +               fan2: fan at 2 {
> > +                       compatible = "pmbus-fan";
> > +                       reg = <2>;
> > +                       tach-pulses = <2>;
> > +               };
> > +
> > +               fan3: fan at 3 {
> > +                       compatible = "pmbus-fan";
> > +                       reg = <3>;
> > +                       tach-pulses = <2>;
> > +               };
> > +
> > +               fan4: fan at 4 {
> > +                       compatible = "pmbus-fan";
> > +                       reg = <4>;
> > +                       tach-pulses = <2>;
> > +               };
> > +
> > +               fan5: fan at 5 {
> > +                       compatible = "pmbus-fan";
> > +                       reg = <5>;
> > +                       tach-pulses = <2>;
> > +               };
> > +       };
> > +
> > +       pca0: pca9552 at 61 {
> > +               compatible = "nxp,pca9552";
> > +               reg = <0x61>;
> > +               #address-cells = <1>;
> > +               #size-cells = <0>;
> > +
> > +               gpio-controller;
> > +               #gpio-cells = <2>;
> > +
> > +               led at 0 {
> > +                       label = "fan0";
> > +                       reg = <0>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > +
> > +               led at 1 {
> > +                       label = "fan1";
> > +                       reg = <1>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > +
> > +               led at 2 {
> > +                       label = "fan2";
> > +                       reg = <2>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > +
> > +               led at 3 {
> > +                       label = "fan3";
> > +                       reg = <3>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > +
> > +               led at 4 {
> > +                       label = "fan4";
> > +                       reg = <4>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > +
> > +               led at 5 {
> > +                       label = "fan5";
> > +                       reg = <5>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > +
> > +               gpio at 6 {
> > +                       reg = <6>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> > +
> > +               gpio at 7 {
> > +                       reg = <7>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> > +
> > +               gpio at 8 {
> > +                       reg = <8>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> > +
> > +               gpio at 9 {
> > +                       reg = <9>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> > +
> > +               gpio at 10 {
> > +                       reg = <10>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> > +
> > +               gpio at 11 {
> > +                       reg = <11>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> > +
> > +               gpio at 12 {
> > +                       reg = <12>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> > +
> > +               gpio at 13 {
> > +                       reg = <13>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> > +
> > +               gpio at 14 {
> > +                       reg = <14>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> > +
> > +               gpio at 15 {
> > +                       reg = <15>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> > +       };
> > +
> > +       ibm-panel at 62 {
> > +               compatible = "ibm,op-panel";
> > +               reg = <(0x62 | I2C_OWN_SLAVE_ADDRESS)>;
> > +       };
> > +
> > +       dps: dps310 at 76 {
> > +               compatible = "infineon,dps310";
> > +               reg = <0x76>;
> > +               #io-channel-cells = <0>;
> > +       };
> > +
> > +       eeprom at 50 {
> > +               compatible = "atmel,24c64";
> > +               reg = <0x50>;
> > +       };
> > +
> > +       eeprom at 51 {
> > +               compatible = "atmel,24c64";
> > +               reg = <0x51>;
> > +       };
> > +};
> > +
> > +&i2c8 {
> > +       status = "okay";
> > +
> > +       ucd90320 at 11 {
> > +               compatible = "ti,ucd90320";
> > +               reg = <0x11>;
> > +       };
> > +
> > +       rtc at 32 {
> > +               compatible = "epson,rx8900";
> > +               reg = <0x32>;
> > +       };
> > +
> > +       tmp275 at 48 {
> > +               compatible = "ti,tmp275";
> > +               reg = <0x48>;
> > +       };
> > +
> > +       tmp275 at 4a {
> > +               compatible = "ti,tmp275";
> > +               reg = <0x4a>;
> > +       };
> > 
> >         eeprom at 50 {
> >                 compatible = "atmel,24c64";
> >                 reg = <0x50>;
> >         };
> > 
> > -       eeprom at 51 {
> > +       eeprom at 51 {
> > +               compatible = "atmel,24c64";
> > +               reg = <0x51>;
> > +       };
> > +
> > +       pca_pres2: pca9552 at 61 {
> > +               compatible = "nxp,pca9552";
> > +               reg = <0x61>;
> > +               #address-cells = <1>;
> > +               #size-cells = <0>;
> > +               gpio-controller;
> > +               #gpio-cells = <2>;
> > +
> > +               gpio-line-names =
> > +                       "SLOT6_PRSNT_EN_RSVD",
> > "SLOT7_PRSNT_EN_RSVD",
> > +                       "SLOT8_PRSNT_EN_RSVD",
> > "SLOT9_PRSNT_EN_RSVD",
> > +                       "SLOT10_PRSNT_EN_RSVD",
> > "SLOT11_PRSNT_EN_RSVD",
> > +                       "SLOT6_EXPANDER_PRSNT_N",
> > "SLOT7_EXPANDER_PRSNT_N",
> > +                       "SLOT8_EXPANDER_PRSNT_N",
> > "SLOT9_EXPANDER_PRSNT_N",
> > +                       "SLOT10_EXPANDER_PRSNT_N",
> > "SLOT11_EXPANDER_PRSNT_N",
> > +                       "", "", "", "";
> > +
> > +               gpio at 0 {
> > +                       reg = <0>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> > +
> > +               gpio at 1 {
> > +                       reg = <1>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> > +
> > +               gpio at 2 {
> > +                       reg = <2>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> > +
> > +               gpio at 3 {
> > +                       reg = <3>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> > +
> > +               gpio at 4 {
> > +                       reg = <4>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> > +
> > +               gpio at 5 {
> > +                       reg = <5>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> > +
> > +               gpio at 6 {
> > +                       reg = <6>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> > +
> > +               gpio at 7 {
> > +                       reg = <7>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> > +
> > +               gpio at 8 {
> > +                       reg = <8>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> > +
> > +               gpio at 9 {
> > +                       reg = <9>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> > +
> > +               gpio at 10 {
> > +                       reg = <10>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> > +
> > +               gpio at 11 {
> > +                       reg = <11>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> > +
> > +               gpio at 12 {
> > +                       reg = <12>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> > +
> > +               gpio at 13 {
> > +                       reg = <13>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> > +
> > +               gpio at 14 {
> > +                       reg = <14>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> > +
> > +               gpio at 15 {
> > +                       reg = <15>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> > +       };
> > +
> > +};
> > +
> > +&i2c9 {
> > +       status = "okay";
> > +
> > +       tmp423a at 4c {
> > +               compatible = "ti,tmp423";
> > +               reg = <0x4c>;
> > +       };
> > +
> > +       tmp423b at 4d {
> > +               compatible = "ti,tmp423";
> > +               reg = <0x4d>;
> > +       };
> > +
> > +       eeprom at 50 {
> > +               compatible = "atmel,24c128";
> > +               reg = <0x50>;
> > +       };
> > +};
> > +
> > +&i2c10 {
> > +       status = "okay";
> > +
> > +       tmp423a at 4c {
> > +               compatible = "ti,tmp423";
> > +               reg = <0x4c>;
> > +       };
> > +
> > +       tmp423b at 4d {
> > +               compatible = "ti,tmp423";
> > +               reg = <0x4d>;
> > +       };
> > +
> > +       eeprom at 50 {
> > +               compatible = "atmel,24c128";
> > +               reg = <0x50>;
> > +       };
> > +};
> > +
> > +&i2c11 {
> > +       status = "okay";
> > +
> > +       tmp275 at 48 {
> > +               compatible = "ti,tmp275";
> > +               reg = <0x48>;
> > +       };
> > +
> > +       tmp275 at 49 {
> > +               compatible = "ti,tmp275";
> > +               reg = <0x49>;
> > +       };
> > +
> > +       pca9551 at 60 {
> > +               compatible = "nxp,pca9551";
> > +               reg = <0x60>;
> > +               #address-cells = <1>;
> > +               #size-cells = <0>;
> > +
> > +               gpio-controller;
> > +               #gpio-cells = <2>;
> > +
> > +               led at 0 {
> > +                       label = "cablecard10-cxp-top";
> > +                       reg = <0>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > +
> > +               led at 1 {
> > +                       label = "cablecard10-cxp-bot";
> > +                       reg = <1>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > +
> > +               gpio at 2 {
> > +                       reg = <2>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> > +
> > +               gpio at 3 {
> > +                       reg = <3>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> > +
> > +               gpio at 4 {
> > +                       reg = <4>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> > +
> > +               gpio at 5 {
> > +                       reg = <5>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> > +
> > +               gpio at 6 {
> > +                       reg = <6>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> > +
> > +               gpio at 7 {
> > +                       reg = <7>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> > +       };
> > +
> > +       pca9546 at 70 {
> > +               compatible = "nxp,pca9546";
> > +               reg = <0x70>;
> > +               #address-cells = <1>;
> > +               #size-cells = <0>;
> > +               status = "okay";
> > +               i2c-mux-idle-disconnect;
> > +
> > +               i2c11mux0chn0: i2c at 0 {
> > +                       #address-cells = <1>;
> > +                       #size-cells = <0>;
> > +                       reg = <0>;
> > +
> > +                       eeprom at 50 {
> > +                               compatible = "atmel,24c64";
> > +                               reg = <0x50>;
> > +                       };
> > +               };
> > +
> > +               i2c11mux0chn1: i2c at 1 {
> > +                       #address-cells = <1>;
> > +                       #size-cells = <0>;
> > +                       reg = <1>;
> > +
> > +                       eeprom at 51 {
> > +                               compatible = "atmel,24c64";
> > +                               reg = <0x51>;
> > +                       };
> > +               };
> > +       };
> > +};
> > +
> > +&i2c12 {
> > +       status = "okay";
> > +};
> > +
> > +&i2c13 {
> > +       status = "okay";
> > +
> > +       eeprom at 50 {
> >                 compatible = "atmel,24c64";
> > -               reg = <0x51>;
> > +               reg = <0x50>;
> >         };
> > 
> > -       pca_pres2: pca9552 at 61 {
> > +       pca9552 at 60 {
> >                 compatible = "nxp,pca9552";
> > -               reg = <0x61>;
> > +               reg = <0x60>;
> >                 #address-cells = <1>;
> >                 #size-cells = <0>;
> > +
> >                 gpio-controller;
> >                 #gpio-cells = <2>;
> > 
> > -               gpio-line-names =
> > -                       "SLOT6_PRSNT_EN_RSVD",
> > "SLOT7_PRSNT_EN_RSVD",
> > -                       "SLOT8_PRSNT_EN_RSVD",
> > "SLOT9_PRSNT_EN_RSVD",
> > -                       "SLOT10_PRSNT_EN_RSVD",
> > "SLOT11_PRSNT_EN_RSVD",
> > -                       "SLOT6_EXPANDER_PRSNT_N",
> > "SLOT7_EXPANDER_PRSNT_N",
> > -                       "SLOT8_EXPANDER_PRSNT_N",
> > "SLOT9_EXPANDER_PRSNT_N",
> > -                       "SLOT10_EXPANDER_PRSNT_N",
> > "SLOT11_EXPANDER_PRSNT_N",
> > -                       "", "", "", "";
> > -
> > -               gpio at 0 {
> > +               led at 0 {
> > +                       label = "nvme0";
> >                         reg = <0>;
> > -                       type = <PCA955X_TYPE_GPIO>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> >                 };
> > 
> > -               gpio at 1 {
> > +               led at 1 {
> > +                       label = "nvme1";
> >                         reg = <1>;
> > -                       type = <PCA955X_TYPE_GPIO>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> >                 };
> > 
> > -               gpio at 2 {
> > +               led at 2 {
> > +                       label = "nvme2";
> >                         reg = <2>;
> > -                       type = <PCA955X_TYPE_GPIO>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> >                 };
> > 
> > -               gpio at 3 {
> > +               led at 3 {
> > +                       label = "nvme3";
> >                         reg = <3>;
> > -                       type = <PCA955X_TYPE_GPIO>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> >                 };
> > 
> > -               gpio at 4 {
> > +               led at 4 {
> > +                       label = "nvme4";
> >                         reg = <4>;
> > -                       type = <PCA955X_TYPE_GPIO>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> >                 };
> > 
> > -               gpio at 5 {
> > +               led at 5 {
> > +                       label = "nvme5";
> >                         reg = <5>;
> > -                       type = <PCA955X_TYPE_GPIO>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> >                 };
> > 
> > -               gpio at 6 {
> > +               led at 6 {
> > +                       label = "nvme6";
> >                         reg = <6>;
> > -                       type = <PCA955X_TYPE_GPIO>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> >                 };
> > 
> > -               gpio at 7 {
> > +               led at 7 {
> > +                       label = "nvme7";
> >                         reg = <7>;
> > -                       type = <PCA955X_TYPE_GPIO>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> >                 };
> > 
> >                 gpio at 8 {
> > @@ -1585,111 +2563,128 @@ gpio at 15 {
> >                         type = <PCA955X_TYPE_GPIO>;
> >                 };
> >         };
> > -
> >  };
> > 
> > -&i2c9 {
> > +&i2c14 {
> >         status = "okay";
> > 
> > -       tmp423a at 4c {
> > -               compatible = "ti,tmp423";
> > -               reg = <0x4c>;
> > -       };
> > -
> > -       tmp423b at 4d {
> > -               compatible = "ti,tmp423";
> > -               reg = <0x4d>;
> > -       };
> > -
> >         eeprom at 50 {
> > -               compatible = "atmel,24c128";
> > +               compatible = "atmel,24c64";
> >                 reg = <0x50>;
> >         };
> > -};
> > 
> > -&i2c10 {
> > -       status = "okay";
> > +       pca9552 at 60 {
> > +               compatible = "nxp,pca9552";
> > +               reg = <0x60>;
> > +               #address-cells = <1>;
> > +               #size-cells = <0>;
> > 
> > -       tmp423a at 4c {
> > -               compatible = "ti,tmp423";
> > -               reg = <0x4c>;
> > -       };
> > +               gpio-controller;
> > +               #gpio-cells = <2>;
> > 
> > -       tmp423b at 4d {
> > -               compatible = "ti,tmp423";
> > -               reg = <0x4d>;
> > -       };
> > +               led at 0 {
> > +                       label = "nvme8";
> > +                       reg = <0>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > 
> > -       eeprom at 50 {
> > -               compatible = "atmel,24c128";
> > -               reg = <0x50>;
> > -       };
> > -};
> > +               led at 1 {
> > +                       label = "nvme9";
> > +                       reg = <1>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > 
> > -&i2c11 {
> > -       status = "okay";
> > +               led at 2 {
> > +                       label = "nvme10";
> > +                       reg = <2>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > 
> > -       tmp275 at 48 {
> > -               compatible = "ti,tmp275";
> > -               reg = <0x48>;
> > -       };
> > +               led at 3 {
> > +                       label = "nvme11";
> > +                       reg = <3>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > 
> > -       tmp275 at 49 {
> > -               compatible = "ti,tmp275";
> > -               reg = <0x49>;
> > -       };
> > +               led at 4 {
> > +                       label = "nvme12";
> > +                       reg = <4>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > 
> > -       pca9546 at 70 {
> > -               compatible = "nxp,pca9546";
> > -               reg = <0x70>;
> > -               #address-cells = <1>;
> > -               #size-cells = <0>;
> > -               status = "okay";
> > -               i2c-mux-idle-disconnect;
> > +               led at 5 {
> > +                       label = "nvme13";
> > +                       reg = <5>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > 
> > -               i2c11mux0chn0: i2c at 0 {
> > -                       #address-cells = <1>;
> > -                       #size-cells = <0>;
> > -                       reg = <0>;
> > +               led at 6 {
> > +                       label = "nvme14";
> > +                       reg = <6>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > 
> > -                       eeprom at 50 {
> > -                               compatible = "atmel,24c64";
> > -                               reg = <0x50>;
> > -                       };
> > +               led at 7 {
> > +                       label = "nvme15";
> > +                       reg = <7>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> >                 };
> > 
> > -               i2c11mux0chn1: i2c at 1 {
> > -                       #address-cells = <1>;
> > -                       #size-cells = <0>;
> > -                       reg = <1>;
> > +               gpio at 8 {
> > +                       reg = <8>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> > 
> > -                       eeprom at 51 {
> > -                               compatible = "atmel,24c64";
> > -                               reg = <0x51>;
> > -                       };
> > +               gpio at 9 {
> > +                       reg = <9>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> >                 };
> > -       };
> > -};
> > 
> > -&i2c12 {
> > -       status = "okay";
> > -};
> > +               gpio at 10 {
> > +                       reg = <10>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> > 
> > -&i2c13 {
> > -       status = "okay";
> > +               gpio at 11 {
> > +                       reg = <11>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> > 
> > -       eeprom at 50 {
> > -               compatible = "atmel,24c64";
> > -               reg = <0x50>;
> > -       };
> > -};
> > +               gpio at 12 {
> > +                       reg = <12>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> > 
> > -&i2c14 {
> > -       status = "okay";
> > +               gpio at 13 {
> > +                       reg = <13>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> > 
> > -       eeprom at 50 {
> > -               compatible = "atmel,24c64";
> > -               reg = <0x50>;
> > +               gpio at 14 {
> > +                       reg = <14>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> > +
> > +               gpio at 15 {
> > +                       reg = <15>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> >         };
> >  };
> > 
> > @@ -1700,6 +2695,120 @@ eeprom at 50 {
> >                 compatible = "atmel,24c64";
> >                 reg = <0x50>;
> >         };
> > +
> > +       pca9552 at 60 {
> > +               compatible = "nxp,pca9552";
> > +               reg = <0x60>;
> > +               #address-cells = <1>;
> > +               #size-cells = <0>;
> > +
> > +               gpio-controller;
> > +               #gpio-cells = <2>;
> > +
> > +               led at 0 {
> > +                       label = "nvme16";
> > +                       reg = <0>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > +
> > +               led at 1 {
> > +                       label = "nvme17";
> > +                       reg = <1>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > +
> > +               led at 2 {
> > +                       label = "nvme18";
> > +                       reg = <2>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > +
> > +               led at 3 {
> > +                       label = "nvme19";
> > +                       reg = <3>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > +
> > +               led at 4 {
> > +                       label = "nvme20";
> > +                       reg = <4>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > +
> > +               led at 5 {
> > +                       label = "nvme21";
> > +                       reg = <5>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > +
> > +               led at 6 {
> > +                       label = "nvme22";
> > +                       reg = <6>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > +
> > +               led at 7 {
> > +                       label = "nvme23";
> > +                       reg = <7>;
> > +                       retain-state-shutdown;
> > +                       default-state = "keep";
> > +                       type = <PCA955X_TYPE_LED>;
> > +               };
> > +
> > +               gpio at 8 {
> > +                       reg = <8>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> > +
> > +               gpio at 9 {
> > +                       reg = <9>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> > +
> > +               gpio at 10 {
> > +                       reg = <10>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> > +
> > +               gpio at 11 {
> > +                       reg = <11>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> > +
> > +               gpio at 12 {
> > +                       reg = <12>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> > +
> > +               gpio at 13 {
> > +                       reg = <13>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> > +
> > +               gpio at 14 {
> > +                       reg = <14>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> > +
> > +               gpio at 15 {
> > +                       reg = <15>;
> > +                       type = <PCA955X_TYPE_GPIO>;
> > +               };
> > +       };
> >  };
> > 
> >  &vuart1 {
> > --
> > 2.27.0
> > 

