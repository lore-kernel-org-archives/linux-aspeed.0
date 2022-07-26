From: logananth hcl <logananth13.hcl@gmail.com>
Date: Tue, 26 Jul 2022 18:36:56 +0530
Subject: [PATCH v2] ARM: dts: aspeed: Adding Facebook Yosemite V3.5 BMC
In-Reply-To: <Yqyu+y9ms/DmFCbJ@heinlein.stwcx.org.github.beta.tailscale.net>
References: <20220616120707.GA22590@logan-ThinkPad-T14-Gen-1> <Yqyu+y9ms/DmFCbJ@heinlein.stwcx.org.github.beta.tailscale.net>
Message-ID: <CAGpPFEFUKxRQSZtToysgeGXQquE4y2sx=3XJdCKfQfLfHEO0Xg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The comments have been addressed and the new patch has been added,

On Fri, Jun 17, 2022 at 10:12 PM Patrick Williams <patrick@stwcx.xyz> wrote:

> On Thu, Jun 16, 2022 at 05:37:07PM +0530, Logananth Sundararaj wrote:
> > The Yosemite V3.5 is a facebook multi-node server
> > platform that host four OCP server. The BMC
> > in the Yosemite V3.5 platform based on AST2600 SoC.
> >
> > This patch adds linux device tree entry related to
> > Yosemite V3.5 specific devices connected to BMC SoC.
> >
> > Signed-off-by: Logananth Sundararaj <logananth_s@hcl.com>
> >
> > ---
> > --- v2 - Enabled i2c drivers.
> > --- v1 - Initial draft.
> > ---
> >  arch/arm/boot/dts/Makefile                    |   1 +
> >  .../boot/dts/aspeed-bmc-facebook-fby35.dts    | 277 ++++++++++++++++++
> >  2 files changed, 278 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-fby35.dts
>
> A few comments below.
>
> ...
> > +&uart5 {
> > +     status = "okay";
> > +     /* Workaround for AST2600 A0 */
> > +     compatible = "snps,dw-apb-uart";
> > +};
>
> Is this comment accurate?  Are we using A0 hardware on this system?
>
>
Done.


> > +&fmc {
> > +     status = "okay";
> > +     reg = <0x1e620000 0xc4>, <0x20000000 0x8000000>;
> > +     flash at 0 {
> > +             status = "okay";
> > +             m25p,fast-read;
> > +             label = "spi0.1";
> > +             spi-max-frequency = <50000000>;
> > +             spi-tx-bus-width = <2>;
> > +             spi-rx-bus-width = <2>;
> > +             #include "openbmc-flash-layout-64.dtsi"
> > +     };
> > +};
>
> Aren't there two SPI flashes?  It seems like it based on:
>
> https://github.com/facebook/openbmc-linux/blob/dev-5.10/arch/arm/boot/dts/aspeed-bmc-facebook-fby35.dts#L162
>
>
yes, two flashes have been added.


> > +
> > +&spi1 {
> > +     status = "okay";
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&pinctrl_spi1_default>;
> > +
> > +     flash at 0 {
> > +             status = "okay";
> > +             m25p,fast-read;
> > +             label = "pnor";
> > +             spi-rx-bus-width = <4>;
> > +             spi-max-frequency = <100000000>;
> > +     };
> > +};
>
> What is SPI1 used for?  I don't see it in the facebook/openbmc-linux
> DTS.
>
>
Done.


> > --
> > 2.17.1
> >
>
> Are we missing the pwm/tach support?  Or is that still not upstream from
> Aspeed?
>
>
yes, pwm/tach support is haven't been upstream from the Aspeed for ast2600.


> --
> Patrick Williams
>

Sorry for the late reply Patrick, missed replying.
Thanks.
Logananth
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20220726/a638608a/attachment.htm>
