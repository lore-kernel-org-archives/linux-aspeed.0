From: Yang Chen <yangchen.openbmc@gmail.com>
Date: Thu, 14 Sep 2023 15:06:39 +0800
Subject: [PATCH 2/2] ARM: dts: aspeed: Minerva: Add Facebook Minerva CMC board
In-Reply-To: <11c822f3-96f1-17d6-6c2a-feaa950aeea1@linaro.org>
References: <20230912140532.3797736-1-yangchen.openbmc@gmail.com>
 <20230912140532.3797736-3-yangchen.openbmc@gmail.com> <1bfdc230-e358-6aa4-7d60-03b5477a6be9@linaro.org>
 <CALFa7M_GvCgmEZxvo_ZSYoCPOe+9-tQt3KHn=_cu3n7psP+PTA@mail.gmail.com> <11c822f3-96f1-17d6-6c2a-feaa950aeea1@linaro.org>
Message-ID: <CALFa7M-9N=J-WKOU=ZbLsFfXvw7=Gmw28DXdKuvuQ7Kyf=5x9g@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Sep 13, 2023 at 6:04?PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 12/09/2023 16:05, yangchen.openbmc at gmail.com wrote:
> > From: Yang Chen <yangchen.openbmc@gmail.com>
> >
> > Add linux device tree entry related to the Minerva Chassis Management
> > Controller (CMC) specific devices connected to the Aspeed SoC (AST2600).
> >
> > Signed-off-by: Yang Chen <yangchen.openbmc@gmail.com>
> > ---
> >  arch/arm/boot/dts/aspeed/Makefile             |   1 +
> >  .../aspeed-bmc-facebook-minerva-cmc.dts       | 265 ++++++++++++++++++
> >  2 files changed, 266 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva-cmc.dts
> >
> > diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/
>
>
> > +
> > +&i2c15 {
> > +     status = "okay";
> > +
> > +     eeprom at 50 {
> > +             compatible = "atmel,24c128";
> > +             reg = <0x50>;
> > +     };
> > +};
> > +
> > +&adc0 {
> > +     ref_voltage = <2500>;
>
> There is no such property in the bindings.

Hi Krzysztof,

I will change this property to the "aspeed,int-vref-microvolt" which
is defined in the binding that can choose the ADC internal reference
voltage is 1200000 or 2500000 ?V, and will add these changes to the v2
patches.

>
> > +     status = "okay";
> > +     pinctrl-0 = <&pinctrl_adc0_default &pinctrl_adc1_default
> > +             &pinctrl_adc2_default &pinctrl_adc3_default
> > +             &pinctrl_adc4_default &pinctrl_adc5_default
> > +             &pinctrl_adc6_default &pinctrl_adc7_default>;
> > +};
> > +
> > +&adc1 {
> > +     ref_voltage = <2500>;
>
> NAK, there is no such property.

I will change this property to the "aspeed,int-vref-microvolt" which
is defined in the binding that can choose the ADC internal reference
voltage is 1200000 or 2500000 ?V, and will add these changes to the v2
patches.

Thanks,
Yang Chen
