From: Joel Stanley <joel@jms.id.au>
Date: Thu, 27 Feb 2020 05:54:19 +0000
Subject: [PATCH v4 4/7] ARM: dts: aspeed-g6: add usb functions
In-Reply-To: <7a210c19a7793b925275dbd8392e3c1ef538b229.camel@kernel.crashing.org>
References: <20200226230346.672-1-rentao.bupt@gmail.com>
 <20200226230346.672-5-rentao.bupt@gmail.com>
 <7a210c19a7793b925275dbd8392e3c1ef538b229.camel@kernel.crashing.org>
Message-ID: <CACPK8XeDBeU+c=Fgcj_CYo3AG02+JX9eD4ABkwO64uMXh+hTtQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 27 Feb 2020 at 04:10, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> On Wed, 2020-02-26 at 15:03 -0800, rentao.bupt at gmail.com wrote:
> > From: Tao Ren <rentao.bupt@gmail.com>
> >
> > Add USB components and according pin groups in aspeed-g6 dtsi.
> >
> > Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> > Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
>
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>

I will take this patch through the aspeed tree for 5.7.

Cheers,

Joel


>
> > ---
> >  No change in v3/v4.
> >  Changes in v2:
> >    - added port/endpoint properties for vhub dt node.
> >
> >  arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi | 25 +++++++++++++
> >  arch/arm/boot/dts/aspeed-g6.dtsi         | 45
> > ++++++++++++++++++++++++
> >  2 files changed, 70 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi
> > b/arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi
> > index 045ce66ca876..7028e21bdd98 100644
> > --- a/arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi
> > +++ b/arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi
> > @@ -1112,6 +1112,31 @@
> >               groups = "UART9";
> >       };
> >
> > +     pinctrl_usb2ah_default: usb2ah_default {
> > +             function = "USB2AH";
> > +             groups = "USBA";
> > +     };
> > +
> > +     pinctrl_usb2ad_default: usb2ad_default {
> > +             function = "USB2AD";
> > +             groups = "USBA";
> > +     };
> > +
> > +     pinctrl_usb2bh_default: usb2bh_default {
> > +             function = "USB2BH";
> > +             groups = "USBB";
> > +     };
> > +
> > +     pinctrl_usb2bd_default: usb2bd_default {
> > +             function = "USB2BD";
> > +             groups = "USBB";
> > +     };
> > +
> > +     pinctrl_usb11bhid_default: usb11bhid_default {
> > +             function = "USB11BHID";
> > +             groups = "USBB";
> > +     };
> > +
> >       pinctrl_vb_default: vb_default {
> >               function = "VB";
> >               groups = "VB";
> > diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi
> > b/arch/arm/boot/dts/aspeed-g6.dtsi
> > index 796976d275e1..0a29b3b57a9d 100644
> > --- a/arch/arm/boot/dts/aspeed-g6.dtsi
> > +++ b/arch/arm/boot/dts/aspeed-g6.dtsi
> > @@ -245,6 +245,51 @@
> >                       status = "disabled";
> >               };
> >
> > +             ehci0: usb at 1e6a1000 {
> > +                     compatible = "aspeed,ast2600-ehci", "generic-
> > ehci";
> > +                     reg = <0x1e6a1000 0x100>;
> > +                     interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
> > +                     clocks = <&syscon ASPEED_CLK_GATE_USBPORT1CLK>;
> > +                     pinctrl-names = "default";
> > +                     pinctrl-0 = <&pinctrl_usb2ah_default>;
> > +                     status = "disabled";
> > +             };
> > +
> > +             ehci1: usb at 1e6a3000 {
> > +                     compatible = "aspeed,ast2600-ehci", "generic-
> > ehci";
> > +                     reg = <0x1e6a3000 0x100>;
> > +                     interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
> > +                     clocks = <&syscon ASPEED_CLK_GATE_USBPORT2CLK>;
> > +                     pinctrl-names = "default";
> > +                     pinctrl-0 = <&pinctrl_usb2bh_default>;
> > +                     status = "disabled";
> > +             };
> > +
> > +             uhci: usb at 1e6b0000 {
> > +                     compatible = "aspeed,ast2600-uhci", "generic-
> > uhci";
> > +                     reg = <0x1e6b0000 0x100>;
> > +                     interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
> > +                     #ports = <2>;
> > +                     clocks = <&syscon ASPEED_CLK_GATE_USBUHCICLK>;
> > +                     status = "disabled";
> > +                     /*
> > +                      * No default pinmux, it will follow EHCI, use
> > an
> > +                      * explicit pinmux override if EHCI is not
> > enabled.
> > +                      */
> > +             };
> > +
> > +             vhub: usb-vhub at 1e6a0000 {
> > +                     compatible = "aspeed,ast2600-usb-vhub";
> > +                     reg = <0x1e6a0000 0x350>;
> > +                     interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
> > +                     clocks = <&syscon ASPEED_CLK_GATE_USBPORT1CLK>;
> > +                     aspeed,vhub-downstream-ports = <7>;
> > +                     aspeed,vhub-generic-endpoints = <21>;
> > +                     pinctrl-names = "default";
> > +                     pinctrl-0 = <&pinctrl_usb2ad_default>;
> > +                     status = "disabled";
> > +             };
> > +
> >               apb {
> >                       compatible = "simple-bus";
> >                       #address-cells = <1>;
>
