From: Rob Herring <robh@kernel.org>
Date: Thu, 24 Jun 2021 15:28:53 -0600
Subject: [PATCH 2/3] dt-bindings: i2c-new: Add bindings for AST2600 I2C
In-Reply-To: <20210617094424.27123-3-jamin_lin@aspeedtech.com>
References: <20210617094424.27123-1-jamin_lin@aspeedtech.com>
 <20210617094424.27123-3-jamin_lin@aspeedtech.com>
Message-ID: <20210624212853.GA2013136@robh.at.kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jun 17, 2021 at 05:43:39PM +0800, Jamin Lin wrote:
> AST2600 support the new register set of I2C controller
> Add bindings document to support the new driver of I2C
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>  .../bindings/i2c/aspeed,new-i2c.yaml          | 107 ++++++++++++++++++
>  1 file changed, 107 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/aspeed,new-i2c.yaml
> 
> diff --git a/Documentation/devicetree/bindings/i2c/aspeed,new-i2c.yaml b/Documentation/devicetree/bindings/i2c/aspeed,new-i2c.yaml
> new file mode 100644
> index 000000000000..2c264596b138
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/aspeed,new-i2c.yaml
> @@ -0,0 +1,107 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/i2c/aspeed,new-i2c.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ASPEED I2C on the AST26XX SoCs Device Tree Bindings
> +
> +description: |
> +  ASPEED I2C controller support the new register set since AST26XX
> +  The i2c-global-regs device is used to enable new register set
> +
> +maintainers:
> +  - Ryan Chen <ryan_chen@aspeedtech.com>
> +
> +allOf:
> +  - $ref: /schemas/i2c/i2c-controller.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - aspeed,ast2600-i2c-bus
> +      - items:
> +          - enum:
> +              - aspeed,ast2600-i2c-global

This is not an i2c controller and a separate block, so it belongs in 
its own binding doc.

> +          - const: syscon
> +
> +  reg:
> +    minItems: 1
> +    maxItems: 2

Drop maxItems. 2 is implied by items length.

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
> +    minimum: 100
> +    maximum: 5000000
> +    default: 100000
> +    description: frequency of the bus clock in Hz defaults to 100 kHz when not
> +      specified
> +
> +  multi-master:
> +    type: boolean
> +    description:
> +      states that there is another master active on this bus
> +
> +  buff-mode:
> +    type: boolean
> +    description:
> +      buffer mode data transfer
> +
> +  byte-mode:
> +    type: boolean
> +    description:
> +      byte mode tata transfer
> +
> +  smbus-alert:
> +    type: boolean
> +    description:
> +      smbus alert protocol
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
> +    #include <dt-bindings/interrupt-controller/aspeed-scu-ic.h>
> +    #include <dt-bindings/clock/ast2600-clock.h>
> +
> +    i2c_gr: i2c-global-regs at 0 {
> +      compatible = "aspeed,ast2600-i2c-global", "syscon";
> +      reg = <0x0 0x20>;
> +      clocks = <&syscon ASPEED_CLK_APB2>;
> +      resets = <&syscon ASPEED_RESET_I2C>;
> +    };
> +
> +    i2c0: i2c-bus at 80 {
> +      compatible = "aspeed,ast2600-i2c-bus";
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      #interrupt-cells = <1>;
> +      reg = <0x80 0x80>, <0xC00 0x20>;
> +      clocks = <&syscon ASPEED_CLK_APB2>;
> +      resets = <&syscon ASPEED_RESET_I2C>;
> +      interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
> +      bus-frequency = <100000>;
> +    };
> -- 
> 2.17.1
> 
> 
