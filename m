From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Mon, 12 Oct 2020 04:53:12 +0000
Subject: [PATCH 2/3] Arm: dts: aspeed-g6: Add sgpio node
In-Reply-To: <CACPK8XdYvSmwdAkBzAO3kC8_PYa3CtPkNb0VxcOhmb2UYz5zDA@mail.gmail.com>
References: <20201012033150.21056-1-billy_tsai@aspeedtech.com>
 <20201012033150.21056-3-billy_tsai@aspeedtech.com>
 <CACPK8XdYvSmwdAkBzAO3kC8_PYa3CtPkNb0VxcOhmb2UYz5zDA@mail.gmail.com>
Message-ID: <E0B8BD13-86F6-486E-95DF-1038D7F59A8B@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Joel,

Thanks for the review.

On 2020/10/12, 12:35 PM, Joel Stanley wrote:

    > On Mon, 12 Oct 2020 at 03:32, Billy Tsai <billy_tsai@aspeedtech.com> wrote:
    > >
    > > This patch is used to add sgpiom and sgpios nodes and add compatible
    > > string for sgpiom.
    > 
    > You also need to add sgpios documentation to the bindings docs.
    > 
    > Whenever you add new device tree bindings to the kernel tree you
    > should add documentation for them.
    > 
    > When preparing patches for submission, use scripts/checkpatch.pl to
    > check for common issues. It will warn you if you are adding strings
    > that are not documented.
    > 
    > Cheers,
    > 
    > Joel
    > 
   Because the driver of sgpios doesn't be implemented, so I don't know how to describe it at sgpio-aspeed.txt. 
   Can I just add  compatible string " aspeed,ast2600-sgpios " to the document for bypassing the warning of checkpatch?
    > >
    > > Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
    > > ---
    > >  .../devicetree/bindings/gpio/sgpio-aspeed.txt |  8 +--
    > >  arch/arm/boot/dts/aspeed-g6.dtsi              | 52 +++++++++++++++++++
    > >  2 files changed, 57 insertions(+), 3 deletions(-)
    > >
    > > diff --git a/Documentation/devicetree/bindings/gpio/sgpio-aspeed.txt b/Documentation/devicetree/bindings/gpio/sgpio-aspeed.txt
    > > index d4d83916c09d..815d9b5167a5 100644
    > > --- a/Documentation/devicetree/bindings/gpio/sgpio-aspeed.txt
    > > +++ b/Documentation/devicetree/bindings/gpio/sgpio-aspeed.txt
    > > @@ -1,8 +1,10 @@
    > >  Aspeed SGPIO controller Device Tree Bindings
    > >  --------------------------------------------
    > >
    > > -This SGPIO controller is for ASPEED AST2500 SoC, it supports up to 80 full
    > > -featured Serial GPIOs. Each of the Serial GPIO pins can be programmed to
    > > +This SGPIO controller is for ASPEED AST2500/AST2600 SoC, it supports 2 master.
    > > +One is up to 128 SGPIO input ports and 128 output ports concurrently(after AST2600A1)
    > > +and Second one is up to 80.
    > > +Each of the Serial GPIO pins can be programmed to
    > >  support the following options:
    > >  - Support interrupt option for each input port and various interrupt
    > >    sensitivity option (level-high, level-low, edge-high, edge-low)
    > > @@ -14,7 +16,7 @@ support the following options:
    > >  Required properties:
    > >
    > >  - compatible : Should be one of
    > > -  "aspeed,ast2400-sgpio", "aspeed,ast2500-sgpio"
    > > +  "aspeed,ast2400-sgpio", "aspeed,ast2500-sgpio", "aspeed,ast2600-sgpiom"
    > 
    > I think we should add sgpiom strings for the ast2500 (and ast2400?)
    > too, as this is how they should have been named in the first place:
    > 
   If I change the document whether I also need to send the patch for sgpio driver and g5/g4.dtsi?
    > >  - compatible : Should be one of
    > >    "aspeed,ast2400-sgpio", "aspeed,ast2500-sgpio"
    > >   "aspeed,ast2400-sgpiom", "aspeed,ast2500-sgpiom", "aspeed,ast2600-sgpiom"
    > 
    > 
    > >  - #gpio-cells : Should be 2, see gpio.txt
    > >  - reg : Address and length of the register set for the device
    > >  - gpio-controller : Marks the device node as a GPIO controller
    > > diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
    > > index ad19dce038ea..cb053a996e87 100644
    > > --- a/arch/arm/boot/dts/aspeed-g6.dtsi
    > > +++ b/arch/arm/boot/dts/aspeed-g6.dtsi
    > > @@ -366,6 +366,58 @@
    > >                                 #interrupt-cells = <2>;
    > >                         };
    > >
    > > +                       sgpiom0: sgpiom at 1e780500 {
    > > +                               #gpio-cells = <2>;
    > > +                               gpio-controller;
    > > +                               compatible = "aspeed,ast2600-sgpiom";
    > > +                               reg = <0x1e780500 0x100>;
    > > +                               interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
    > > +                               ngpios = <128>;
    > > +                               clocks = <&syscon ASPEED_CLK_APB2>;
    > > +                               interrupt-controller;
    > > +                               bus-frequency = <12000000>;
    > > +
    > > +                               pinctrl-names = "default";
    > > +                               pinctrl-0 = <&pinctrl_sgpm1_default>;
    > > +                               status = "disabled";
    > > +                       };
    > > +
    > > +                       sgpiom1: sgpiom at 1e780600 {
    > > +                               #gpio-cells = <2>;
    > > +                               gpio-controller;
    > > +                               compatible = "aspeed,ast2600-sgpiom";
    > > +                               reg = <0x1e780600 0x100>;
    > > +                               interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
    > > +                               ngpios = <80>;
    > > +                               clocks = <&syscon ASPEED_CLK_APB2>;
    > > +                               interrupt-controller;
    > > +                               bus-frequency = <12000000>;
    > > +
    > > +                               pinctrl-names = "default";
    > > +                               pinctrl-0 = <&pinctrl_sgpm2_default>;
    > > +                               status = "disabled";
    > > +                       };
    > > +
    > > +                       sgpios0: sgpios at 1e780700 {
    > > +                               #gpio-cells = <2>;
    > > +                               gpio-controller;
    > > +                               compatible = "aspeed,ast2600-sgpios";
    > > +                               reg = <0x1e780700 0x40>;
    > > +                               interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
    > > +                               clocks = <&syscon ASPEED_CLK_APB2>;
    > > +                               status = "disabled";
    > > +                       };
    > > +
    > > +                       sgpios1: sgpios at 1e780740 {
    > > +                               #gpio-cells = <2>;
    > > +                               gpio-controller;
    > > +                               compatible = "aspeed,ast2600-sgpios";
    > > +                               reg = <0x1e780740 0x40>;
    > > +                               interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
    > > +                               clocks = <&syscon ASPEED_CLK_APB2>;
    > > +                               status = "disabled";
    > > +                       };
    > > +
    > >                         gpio1: gpio at 1e780800 {
    > >                                 #gpio-cells = <2>;
    > >                                 gpio-controller;
    > > --
    > > 2.17.1
    > >

