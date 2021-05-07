From: Steven Lee <steven_lee@aspeedtech.com>
Date: Fri, 7 May 2021 11:13:48 +0800
Subject: [PATCH v3 1/5] dt-bindings: mmc: sdhci-of-aspeed: Add an example
 for AST2600-A2 EVB
In-Reply-To: <20210507011324.GA1119409@robh.at.kernel.org>
References: <20210506100312.1638-1-steven_lee@aspeedtech.com>
 <20210506100312.1638-2-steven_lee@aspeedtech.com>
 <20210507011324.GA1119409@robh.at.kernel.org>
Message-ID: <20210507031348.GA23749@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The 05/07/2021 09:13, Rob Herring wrote:
> On Thu, May 06, 2021 at 06:03:08PM +0800, Steven Lee wrote:
> > AST2600-A2 EVB has the reference design for enabling SD bus
> > power and toggling SD bus signal voltage by GPIO pins.
> > 
> > In the reference design, GPIOV0 of AST2600-A2 EVB is connected to
> > power load switch that providing 3.3v to SD1 bus vdd. GPIOV1 is
> > connected to a 1.8v and a 3.3v power load switch that providing
> > signal voltage to
> > SD1 bus.
> > 
> > If GPIOV0 is active high, SD1 bus is enabled. Otherwise, SD1 bus is
> > disabled.
> > If GPIOV1 is active high, 3.3v power load switch is enabled, SD1
> > signal voltage is 3.3v. Otherwise, 1.8v power load switch will be
> > enabled, SD1 signal voltage becomes 1.8v.
> > 
> > AST2600-A2 EVB also support toggling signal voltage for SD2 bus.
> > The design is the same as SD1 bus. It uses GPIOV2 as power-gpio and
> > GPIOV3 as power-switch-gpio.
> > 
> > Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> > ---
> >  .../devicetree/bindings/mmc/aspeed,sdhci.yaml | 101 +++++++++++++++++-
> >  1 file changed, 97 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> > index 987b287f3bff..de7e61b3d37a 100644
> > --- a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> > @@ -45,10 +45,16 @@ patternProperties:
> >  
> >      properties:
> >        compatible:
> > -        enum:
> > -          - aspeed,ast2400-sdhci
> > -          - aspeed,ast2500-sdhci
> > -          - aspeed,ast2600-sdhci
> > +        oneOf:
> > +          - items:
> > +              - enum:
> > +                  - aspeed,ast2400-sdhci
> > +                  - aspeed,ast2500-sdhci
> > +                  - aspeed,ast2600-sdhci
> > +          - items:
> > +              - enum:
> > +                  - aspeed,ast2600-sdhci
> > +              - const: sdhci
> 
> Why are you adding 'sdhci'. That's not useful as a compatible given how 
> many quirks different implementations have.
> 
> 

It is for passing the dtbs_check of the second example.
Without this definition, many device trees have the following
error:

['aspeed,ast2600-sdhci', 'sdhci'] is too long
Additional items are not allowed ('sdhci' was unexpected)

Regardless, I will remove it, and move the new example to device
tree.

Thanks.

> >        reg:
> >          maxItems: 1
> >          description: The SDHCI registers
> > @@ -104,3 +110,90 @@ examples:
> >                      clocks = <&syscon ASPEED_CLK_SDIO>;
> >              };
> >      };
> > +
> > +  - |
> 
> Why do we need another example?
> 

The original example is for AST2500 which doesn't support UHS mode.
The new example teaches users how to enable sdhci with UHS mode, add
gpio regulators, and adjust clock phase for AST2600-A2.

I will move the new example to ast2600 device tree per the
review comment.
https://lkml.org/lkml/2021/5/6/968

> > +    #include <dt-bindings/gpio/gpio.h>
> > +    #include <dt-bindings/clock/aspeed-clock.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    vcc_sdhci0: regulator-vcc-sdhci0 {
> > +            compatible = "regulator-fixed";
> > +            regulator-name = "SDHCI0 Vcc";
> > +            regulator-min-microvolt = <3300000>;
> > +            regulator-max-microvolt = <3300000>;
> > +            gpios = <&gpio0 168
> > +                            GPIO_ACTIVE_HIGH>;
> > +            enable-active-high;
> > +    };
> > +
> > +    vccq_sdhci0: regulator-vccq-sdhci0 {
> > +            compatible = "regulator-gpio";
> > +
> > +            regulator-name = "SDHCI0 VccQ";
> > +            regulator-min-microvolt = <1800000>;
> > +            regulator-max-microvolt = <3300000>;
> > +            gpios = <&gpio0 169
> > +                            GPIO_ACTIVE_HIGH>;
> > +            gpios-states = <1>;
> > +            states = <3300000 1>,
> > +                     <1800000 0>;
> > +    };
> > +
> > +    vcc_sdhci1: regulator-vcc-sdhci1 {
> > +            compatible = "regulator-fixed";
> > +
> > +            regulator-name = "SDHCI1 Vcc";
> > +            regulator-min-microvolt = <3300000>;
> > +            regulator-max-microvolt = <3300000>;
> > +            gpios = <&gpio0 170
> > +                            GPIO_ACTIVE_HIGH>;
> > +            enable-active-high;
> > +    };
> > +
> > +    vccq_sdhci1: regulator-vccq-sdhci1 {
> > +            compatible = "regulator-gpio";
> > +
> > +            regulator-name = "SDHCI1 VccQ";
> > +            regulator-min-microvolt = <1800000>;
> > +            regulator-max-microvolt = <3300000>;
> > +            gpios = <&gpio0 171
> > +                            GPIO_ACTIVE_HIGH>;
> > +            gpios-states = <1>;
> > +            states = <3300000 1>,
> > +                     <1800000 0>;
> > +    };
> > +
> > +    sdc at 1e740000 {
> > +            compatible = "aspeed,ast2600-sd-controller";
> > +            reg = <0x1e740000 0x100>;
> > +            #address-cells = <1>;
> > +            #size-cells = <1>;
> > +            ranges = <0 0x1e740000 0x20000>;
> > +            clocks = <&syscon ASPEED_CLK_GATE_SDCLK>;
> > +
> > +            sdhci at 1e740100 {
> > +                    compatible = "aspeed,ast2600-sdhci","sdhci";
> > +                    reg = <0x100 0x100>;
> > +                    interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
> > +                    sdhci,auto-cmd12;
> > +                    clocks = <&syscon ASPEED_CLK_SDIO>;
> > +                    vmmc-supply = <&vcc_sdhci0>;
> > +                    vqmmc-supply = <&vccq_sdhci0>;
> > +                    sd-uhs-sdr104;
> > +                    clk-phase-uhs-sdr104 = <180>, <180>;
> > +            };
> > +
> > +            sdhci at 1e740200 {
> > +                    compatible = "aspeed,ast2600-sdhci","sdhci";
> > +                    reg = <0x200 0x100>;
> > +                    interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
> > +                    sdhci,auto-cmd12;
> > +                    clocks = <&syscon ASPEED_CLK_SDIO>;
> > +                    vmmc-supply = <&vcc_sdhci1>;
> > +                    vqmmc-supply = <&vccq_sdhci1>;
> > +                    sd-uhs-sdr104;
> > +                    clk-phase-uhs-sdr104 = <0>, <0>;
> > +            };
> > +    };
> > +
> > +...
> > -- 
> > 2.17.1
> > 
