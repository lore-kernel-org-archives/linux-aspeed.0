From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 26 Jun 2019 07:47:25 -0600
Subject: [PATCH 2/8] dt-bindings: pinctrl: aspeed: Convert AST2400
 bindings to json-schema
In-Reply-To: <20190626071430.28556-3-andrew@aj.id.au>
References: <20190626071430.28556-1-andrew@aj.id.au>
 <20190626071430.28556-3-andrew@aj.id.au>
Message-ID: <CAL_JsqKXPzFYTHos-uvCUtBj-bcsNfrzt5GjxQ=PmgeXpp5J-A@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jun 26, 2019 at 1:21 AM Andrew Jeffery <andrew@aj.id.au> wrote:
>
> Convert ASPEED pinctrl bindings to DT schema format using json-schema

BTW, ASPEED is one of the remaining platforms needing the top-level
board bindings converted.

>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
>  .../pinctrl/aspeed,ast2400-pinctrl.txt        | 80 -------------------
>  .../pinctrl/aspeed,ast2400-pinctrl.yaml       | 73 +++++++++++++++++
>  2 files changed, 73 insertions(+), 80 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.txt
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml

> diff --git a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml
> new file mode 100644
> index 000000000000..3b8cf3e51506
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml
> @@ -0,0 +1,73 @@
> +# SPDX-License-Identifier: GPL-2.0+

Do you have rights to change the license? If so, the preference is to
dual license with (GPL-2.0 OR BSD-2-Clause).

BTW, '-or-later' is the preferred form over '+'.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/aspeed,ast2400-pinctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ASPEED AST2400 Pin Controller
> +
> +maintainers:
> +  - Andrew Jeffery <andrew@aj.id.au>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +        - enum:
> +          - aspeed,ast2400-pinctrl
> +      - items:
> +        - enum:
> +          - aspeed,g4-pinctrl

This can be simplified to:

compatible:
  enum:
    - aspeed,ast2400-pinctrl
    - aspeed,g4-pinctrl

> +
> +required:
> +  - compatible
> +
> +description: |+

description goes before properties.

> +  The pin controller node should be the child of a syscon node with the
> +  required property:
> +
> +  - compatible:     Should be one of the following:
> +                    "aspeed,ast2400-scu", "syscon", "simple-mfd"
> +                    "aspeed,g4-scu", "syscon", "simple-mfd"
> +
> +  Refer to the the bindings described in
> +  Documentation/devicetree/bindings/mfd/syscon.txt
> +
> +  For the AST2400 pinmux, each mux function has only one associated pin group.
> +  Each group is named by its function. The following values for the function
> +  and groups properties are supported:
> +
> +  ACPI ADC0 ADC1 ADC10 ADC11 ADC12 ADC13 ADC14 ADC15 ADC2 ADC3 ADC4 ADC5 ADC6
> +  ADC7 ADC8 ADC9 BMCINT DDCCLK DDCDAT EXTRST FLACK FLBUSY FLWP GPID GPID0 GPID2
> +  GPID4 GPID6 GPIE0 GPIE2 GPIE4 GPIE6 I2C10 I2C11 I2C12 I2C13 I2C14 I2C3 I2C4
> +  I2C5 I2C6 I2C7 I2C8 I2C9 LPCPD LPCPME LPCRST LPCSMI MAC1LINK MAC2LINK MDIO1
> +  MDIO2 NCTS1 NCTS2 NCTS3 NCTS4 NDCD1 NDCD2 NDCD3 NDCD4 NDSR1 NDSR2 NDSR3 NDSR4
> +  NDTR1 NDTR2 NDTR3 NDTR4 NDTS4 NRI1 NRI2 NRI3 NRI4 NRTS1 NRTS2 NRTS3 OSCCLK
> +  PWM0 PWM1 PWM2 PWM3 PWM4 PWM5 PWM6 PWM7 RGMII1 RGMII2 RMII1 RMII2 ROM16 ROM8
> +  ROMCS1 ROMCS2 ROMCS3 ROMCS4 RXD1 RXD2 RXD3 RXD4 SALT1 SALT2 SALT3 SALT4 SD1
> +  SD2 SGPMCK SGPMI SGPMLD SGPMO SGPSCK SGPSI0 SGPSI1 SGPSLD SIOONCTRL SIOPBI
> +  SIOPBO SIOPWREQ SIOPWRGD SIOS3 SIOS5 SIOSCI SPI1 SPI1DEBUG SPI1PASSTHRU
> +  SPICS1 TIMER3 TIMER4 TIMER5 TIMER6 TIMER7 TIMER8 TXD1 TXD2 TXD3 TXD4 UART6
> +  USB11D1 USB11H2 USB2D1 USB2H1 USBCKI VGABIOS_ROM VGAHS VGAVS VPI18 VPI24
> +  VPI30 VPO12 VPO24 WDTRST1 WDTRST2

This should be a schema. You need to define child nodes and list these
as values for 'function' and 'group'. Ideally, the child nodes would
have some sort of pattern, but if not, you can just match on '^.*$'
under patternProperties.

BTW, You can put the names under a 'definitions' key and then use
'$ref' to reference them from function and group to avoid duplicating
the names. Or use patternProperties with '^(function|group)$'.

Similar comments apply to AST2500 binding.

Rob
