From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 29 Jul 2022 11:58:34 +0930
Subject: [PATCH v3 2/3] dt-bindings: i2c-ast2600: Add bindings for AST2600 i2C
 driver
In-Reply-To: <20220516064900.30517-3-ryan_chen@aspeedtech.com>
References: <20220516064900.30517-1-ryan_chen@aspeedtech.com>
 <20220516064900.30517-3-ryan_chen@aspeedtech.com>
Message-ID: <5d863bc1-4f27-48b6-89ab-c3f02bc09057@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Ryan,

On Mon, 16 May 2022, at 16:18, ryan_chen wrote:
> AST2600 support new register set for I2C controller, add bindings document
> to support driver of i2c new register mode controller
>
> Signed-off-by: ryan_chen <ryan_chen@aspeedtech.com>
> ---
>  .../bindings/i2c/aspeed,i2c-ast2600.ymal      | 78 +++++++++++++++++++
>  1 file changed, 78 insertions(+)
>  create mode 100644 
> Documentation/devicetree/bindings/i2c/aspeed,i2c-ast2600.ymal
>
> diff --git 
> a/Documentation/devicetree/bindings/i2c/aspeed,i2c-ast2600.ymal 
> b/Documentation/devicetree/bindings/i2c/aspeed,i2c-ast2600.ymal
> new file mode 100644
> index 000000000000..7c75f5bac24f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/aspeed,i2c-ast2600.ymal
> @@ -0,0 +1,78 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/i2c/aspeed,i2c-ast2600.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AST2600 I2C Controller on the AST26XX SoCs Device Tree Bindings
> +
> +maintainers:
> +  - Ryan Chen <ryan_chen@aspeedtech.com>
> +
> +allOf:
> +  - $ref: /schemas/i2c/i2c-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - aspeed,ast2600-i2c

The original driver uses e.g. aspeed,ast2500-i2c-bus for the 
subordinate controllers. While the register layout changes, I'd prefer 
we try to use the existing compatibles rather than introducing a new set
and causing some confusion.

Further, what you're proposing here is effectively being used to select 
the driver implementation, which isn't the purpose of the devicetree.

My preference would be to reuse the existing compatibles and instead 
select the driver implementation via Kconfig. Or, if we can figure out 
some way to do so, support both register interfaces in the one driver 
implementation and fall back to the old register interface where the 
new one isn't available (I don't think this is feasible though).

> +
> +  reg:
> +    minItems: 1
> +    items:
> +      - description: address offset and range of bus
> +      - description: address offset and range of bus buffer
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +    description:
> +      root clock of bus, should reference the APB
> +      clock in the second cell
> +
> +  resets:
> +    maxItems: 1
> +
> +  bus-frequency:
> +    minimum: 500
> +    maximum: 2000000
> +    default: 100000
> +    description: frequency of the bus clock in Hz defaults to 100 kHz 
> when not
> +      specified
> +
> +  multi-master:
> +    type: boolean
> +    description:
> +      states that there is another master active on this bus
> +
> +required:
> +  - reg
> +  - compatible
> +  - clocks
> +  - resets
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/ast2600-clock.h>
> +
> +    i2c_gr: i2c-global-regs at 0 {
> +      compatible = "aspeed,ast2600-i2c-global", "syscon";
> +      reg = <0x0 0x20>;
> +      resets = <&syscon ASPEED_RESET_I2C>;
> +    };
> +
> +    i2c0: i2c-bus at 80 {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      #interrupt-cells = <1>;
> +      compatible = "aspeed,ast2600-i2c-bus";

This isn't quite right with respect to your binding description above :)

Andrew
