From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 2 Feb 2023 09:55:47 +0100
Subject: [PATCH v4 2/3] dt-bindings: i2c-ast2600: Add support for AST2600
 i2C driver
In-Reply-To: <20230201103359.1742140-3-ryan_chen@aspeedtech.com>
References: <20230201103359.1742140-1-ryan_chen@aspeedtech.com>
 <20230201103359.1742140-3-ryan_chen@aspeedtech.com>
Message-ID: <a3c63ebd-540b-40a0-6caf-bf2a8e629538@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 01/02/2023 11:33, Ryan Chen wrote:
> AST2600 support new register set for I2C controller, add bindings document
> to support driver of i2c new register mode controller.

Subject: drop "driver". You are not adding here driver.

Use subject prefixes matching the subsystem (which you can get for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching).

> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  .../bindings/i2c/aspeed,i2c-ast2600.yaml      | 78 +++++++++++++++++++
>  1 file changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/aspeed,i2c-ast2600.yaml
> 
> diff --git a/Documentation/devicetree/bindings/i2c/aspeed,i2c-ast2600.yaml b/Documentation/devicetree/bindings/i2c/aspeed,i2c-ast2600.yaml
> new file mode 100644
> index 000000000000..b7d7bc303e77
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/aspeed,i2c-ast2600.yaml

Filename based on compatible.

> @@ -0,0 +1,78 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/i2c/aspeed,i2c-ast2600.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AST2600 I2C Controller on the AST26XX SoCs Device Tree Bindings

Drop "Device Tree Bindings"

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
> +
> +  reg:
> +    minItems: 1

Why second item is optional?

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

Either this is root clock or APB clock. Decide and describe the clock
(hardware), not the DT syntax (drop "cell").

> +
> +  resets:
> +    maxItems: 1
> +
> +  bus-frequency:
> +    minimum: 500
> +    maximum: 2000000
> +    default: 100000
> +    description: frequency of the bus clock in Hz defaults to 100 kHz when not
> +      specified

Don't repeat constraints in free form text.

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

Drop. not related.

> +    };
> +
> +    i2c0: i2c-bus at 80 {

Drop label.
Node name: i2c

I guess this wasn't tested, right?

> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      #interrupt-cells = <1>;
> +      compatible = "aspeed,ast2600-i2c";
> +      reg = <0x80 0x80>, <0xC00 0x20>;

Compatible is first, reg is second.

Use lowercase hex.

> +      clocks = <&syscon ASPEED_CLK_APB2>;
> +      resets = <&syscon ASPEED_RESET_I2C>;
> +      bus-frequency = <100000>;
> +    };

Best regards,
Krzysztof

