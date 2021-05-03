From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 03 May 2021 13:49:38 +0930
Subject: =?UTF-8?Q?Re:_[PATCH_v2_1/3]_dt-bindings:_mmc:_sdhci-of-aspeed:_Add_desc?=
 =?UTF-8?Q?ription_for_AST2600_EVB.?=
In-Reply-To: <20210503014336.20256-2-steven_lee@aspeedtech.com>
References: <20210503014336.20256-1-steven_lee@aspeedtech.com>
 <20210503014336.20256-2-steven_lee@aspeedtech.com>
Message-ID: <75226402-503c-4e9b-96dc-e4bd74cf20ac@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Steven,

On Mon, 3 May 2021, at 11:13, Steven Lee wrote:
> Add the description for describing the AST 2600 EVB reference design of
> GPIO regulators and provide the example in the document.
> 
> AST2600-A2 EVB has the reference design for enabling SD bus
> power and toggling SD bus signal voltage by GPIO pins.
> 
> In the reference design, GPIOV0 of AST2600-A2 EVB is connected to
> power load switch that providing 3.3v to SD1 bus vdd. GPIOV1 is
> connected to a 1.8v and a 3.3v power load switch that providing
> signal voltage to
> SD1 bus.
> 
> If GPIOV0 is active high, SD1 bus is enabled. Otherwise, SD1 bus is
> disabled.
> If GPIOV1 is active high, 3.3v power load switch is enabled, SD1
> signal voltage is 3.3v. Otherwise, 1.8v power load switch will be
> enabled, SD1 signal voltage becomes 1.8v.
> 
> AST2600-A2 EVB also support toggling signal voltage for SD2 bus.
> The design is the same as SD1 bus. It uses GPIOV2 as power-gpio and
> GPIOV3 as power-switch-gpio.
> 
> Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> ---
>  .../devicetree/bindings/mmc/aspeed,sdhci.yaml | 99 +++++++++++++++++++
>  1 file changed, 99 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml 
> b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> index 987b287f3bff..dd894aba0bb7 100644
> --- a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> @@ -20,6 +20,19 @@ description: |+
>    the slots are dependent on the common configuration area, they are 
> described
>    as child nodes.
>  
> +  The signal voltage of SDHCIs on AST2600-A2 EVB is able to be toggled 
> by GPIO
> +  pins. In the reference design, GPIOV0 of AST2600-A2 EVB is connected 
> to the
> +  power load switch that providing 3.3v to SD1 bus vdd, GPIOV1 is 
> connected to
> +  a 1.8v and a 3.3v power load switch that providing signal voltage to
> +  SD1 bus.
> +  If GPIOV0 is active high, SD1 bus is enabled. Otherwise, SD1 bus is
> +  disabled. If GPIOV1 is active high, 3.3v power load switch is 
> enabled, SD1
> +  signal voltage is 3.3v. Otherwise, 1.8v power load switch will be 
> enabled, SD1
> +  signal voltage becomes 1.8v.
> +  AST2600-A2 EVB also support toggling signal voltage for SD2 bus.
> +  The design is the same as SD1 bus. It uses GPIOV2 as power-gpio and 
> GPIOV3
> +  as power-switch-gpio.

I don't think we should be describing design-specific details in the 
binding document. However, I think this would be a great comment in the 
AST2600 EVB devicetree. Can you please move it there?

> +
>  properties:
>    compatible:
>      enum:
> @@ -78,6 +91,7 @@ required:
>    - clocks
>  
>  examples:
> +  //Example 1
>    - |
>      #include <dt-bindings/clock/aspeed-clock.h>
>      sdc at 1e740000 {
> @@ -104,3 +118,88 @@ examples:
>                      clocks = <&syscon ASPEED_CLK_SDIO>;
>              };
>      };
> +
> +  //Example 2 (AST2600EVB with GPIO regulator)

I feel you didn't test this with `make dt_binding_check` as `//` isn't
a valid YAML comment token. You need to use `#` for comments (
https://yaml.org/spec/1.2/spec.html#id2780069 ).

> +  - |
> +    #include <dt-bindings/clock/aspeed-clock.h>
> +    #include <dt-bindings/gpio/aspeed-gpio.h>
> +    vcc_sdhci0: regulator-vcc-sdhci0 {
> +            compatible = "regulator-fixed";
> +
> +            regulator-name = "SDHCI0 Vcc";
> +            regulator-min-microvolt = <3300000>;
> +            regulator-max-microvolt = <3300000>;
> +            gpios = <&gpio0 ASPEED_GPIO(V, 0)
> +                            GPIO_ACTIVE_HIGH>;
> +            enable-active-high;
> +    };
> +
> +    vccq_sdhci0: regulator-vccq-sdhci0 {
> +            compatible = "regulator-gpio";
> +
> +            regulator-name = "SDHCI0 VccQ";
> +            regulator-min-microvolt = <1800000>;
> +            regulator-max-microvolt = <3300000>;
> +            gpios = <&gpio0 ASPEED_GPIO(V, 1)
> +                            GPIO_ACTIVE_HIGH>;
> +            gpios-states = <1>;
> +            states = <3300000 1
> +                      1800000 0>;
> +    };
> +
> +    vcc_sdhci1: regulator-vcc-sdhci1 {
> +            compatible = "regulator-fixed";
> +
> +            regulator-name = "SDHCI1 Vcc";
> +            regulator-min-microvolt = <3300000>;
> +            regulator-max-microvolt = <3300000>;
> +            gpios = <&gpio0 ASPEED_GPIO(V, 2)
> +                            GPIO_ACTIVE_HIGH>;
> +            enable-active-high;
> +    };
> +
> +    vccq_sdhci1: regulator-vccq-sdhci1 {
> +            compatible = "regulator-gpio";
> +
> +            regulator-name = "SDHCI1 VccQ";
> +            regulator-min-microvolt = <1800000>;
> +            regulator-max-microvolt = <3300000>;
> +            gpios = <&gpio0 ASPEED_GPIO(V, 3)
> +                            GPIO_ACTIVE_HIGH>;
> +            gpios-states = <1>;
> +            states = <3300000 1
> +                      1800000 0>;
> +    };
> +
> +    sdc at 1e740000 {
> +            compatible = "aspeed,ast2600-sd-controller";
> +            reg = <0x1e740000 0x100>;
> +            #address-cells = <1>;
> +            #size-cells = <1>;
> +            ranges = <0 0x1e740000 0x20000>;
> +            clocks = <&syscon ASPEED_CLK_GATE_SDCLK>;
> +
> +            sdhci0: sdhci at 100 {
> +                    compatible = "aspeed,ast2600-sdhci", "sdhci";
> +                    reg = <0x100 0x100>;
> +                    interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
> +                    sdhci,auto-cmd12;
> +                    clocks = <&syscon ASPEED_CLK_SDIO>;
> +                    vmmc-supply = <&vcc_sdhci0>;
> +                    vqmmc-supply = <&vccq_sdhci0>;
> +                    sd-uhs-sdr104;
> +                    clk-phase-uhs-sdr104 = <180>, <180>;
> +            };
> +
> +            sdhci1: sdhci at 200 {
> +                    compatible = "aspeed,ast2600-sdhci", "sdhci";
> +                    reg = <0x200 0x100>;
> +                    interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
> +                    sdhci,auto-cmd12;
> +                    clocks = <&syscon ASPEED_CLK_SDIO>;
> +                    vmmc-supply = <&vcc_sdhci1>;
> +                    vqmmc-supply = <&vccq_sdhci1>;
> +                    sd-uhs-sdr104;
> +                    clk-phase-uhs-sdr104 = <0>, <0>;
> +            };
> +    };

This is a good example, so can we keep this and just drop the comment 
from the binding document?

Cheers,

Andrew
