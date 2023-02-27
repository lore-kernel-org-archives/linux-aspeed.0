From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 27 Feb 2023 09:25:28 +0100
Subject: [PATCH v6 1/2] dt-bindings: i2c: aspeed: support for
 AST2600-i2cv2
In-Reply-To: <20230226031321.3126756-2-ryan_chen@aspeedtech.com>
References: <20230226031321.3126756-1-ryan_chen@aspeedtech.com>
 <20230226031321.3126756-2-ryan_chen@aspeedtech.com>
Message-ID: <53090449-58c9-bc03-56df-aa8ae93c0c26@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 26/02/2023 04:13, Ryan Chen wrote:
> Add ast2600-i2cv2 compatible and aspeed,global-regs, aspeed,timeout
> aspeed,xfer-mode description for ast2600-i2cv2.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  .../devicetree/bindings/i2c/aspeed,i2c.yaml   | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml b/Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml
> index f597f73ccd87..75de3ce41cf5 100644
> --- a/Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml
> +++ b/Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml
> @@ -49,6 +49,25 @@ properties:
>      description:
>        states that there is another master active on this bus
>  
> +  aspeed,timeout:
> +    type: boolean
> +    description: I2C bus timeout enable for master/slave mode

Nothing improved here in regards to my last comment.

> +
> +  aspeed,xfer-mode:
> +    description: |
> +      I2C bus transfer mode selection.
> +      - "byte": I2C bus byte transfer mode.
> +      - "buffered": I2C bus buffer register transfer mode.
> +      - "dma": I2C bus dma transfer mode (default)
> +    items:
> +      enum: [byte, buffered, dma]
> +    maxItems: 1

Drop, not an array.

> +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array

Wrong ref. This is not an array, but one string.

> +
> +  aspeed,global-regs:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: The phandle of i2c global register node.
> +
>  required:
>    - reg
>    - compatible
> @@ -57,6 +76,19 @@ required:
>  
>  unevaluatedProperties: false
>  
> +if:

This should be under allOf (in this location)

> +  properties:
> +    compatible:
> +      contains:
> +        const: aspeed,ast2600-i2cv2
> +
> +then:
> +  properties:
> +    reg:
> +      minItems: 2
> +  required:
> +    - aspeed,global-regs

else:
  aspeed,global-regs: false
and the same for other v2 properties

> +
>  examples:
>    - |
>      #include <dt-bindings/clock/aspeed-clock.h>
> @@ -71,3 +103,15 @@ examples:
>        interrupts = <0>;
>        interrupt-parent = <&i2c_ic>;
>      };
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    i2c1: i2c at 80 {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      compatible = "aspeed,ast2600-i2cv2";
> +      reg = <0x80 0x80>, <0xc00 0x20>;
> +      interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
> +      aspeed,global-regs = <&i2c_global>;
> +      clocks = <&syscon ASPEED_CLK_APB>;
> +      resets = <&syscon ASPEED_RESET_I2C>;
> +    };

Best regards,
Krzysztof

