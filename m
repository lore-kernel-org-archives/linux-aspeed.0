From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 31 Mar 2023 10:20:48 +0200
Subject: [PATCH v8 1/2] dt-bindings: i2c: aspeed: support for
 AST2600-i2cv2
In-Reply-To: <20230330073259.485606-2-ryan_chen@aspeedtech.com>
References: <20230330073259.485606-1-ryan_chen@aspeedtech.com>
 <20230330073259.485606-2-ryan_chen@aspeedtech.com>
Message-ID: <a4f12cc9-d9d2-2805-f9fa-58eafe0b976c@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 30/03/2023 09:32, Ryan Chen wrote:
> Fix typo in maintainer's name and email.
> Remove ddress-cells, size-cells.

Typo: address?

> Use Compatible and reg are always first properties.

I don't understand this at all - what does it explain here? It looks
unrelated, just random sentence in the middle of commit msg.

> Add ast2600-i2cv2 compatible and aspeed,global-regs,
> aspeed,enable-dma and description for ast2600-i2cv2.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  .../devicetree/bindings/i2c/aspeed,i2c.yaml   | 56 +++++++++++++++++--
>  1 file changed, 50 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml b/Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml
> index f597f73ccd87..81e8ced64900 100644
> --- a/Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml
> +++ b/Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml
> @@ -7,10 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: ASPEED I2C on the AST24XX, AST25XX, and AST26XX SoCs Device Tree Bindings
>  
>  maintainers:
> -  - Rayn Chen <rayn_chen@aspeedtech.com>
> -
> -allOf:
> -  - $ref: /schemas/i2c/i2c-controller.yaml#
> +  - Ryan Chen <ryan_chen@aspeedtech.com>
>  
>  properties:
>    compatible:
> @@ -49,6 +46,25 @@ properties:
>      description:
>        states that there is another master active on this bus
>  
> +  aspeed,enable-dma:
> +    type: boolean
> +    description: |
> +      I2C bus enable dma mode transfer.
> +
> +      ASPEED ast2600 platform equipped with 16 I2C controllers that share a
> +      single DMA engine. DTS files can specify the data transfer mode to/from
> +      the device, either DMA or programmed I/O. However, hardware limitations
> +      may require a DTS to manually allocate which controller can use DMA mode.
> +      The "aspeed,enable-dma" property allows control of this.
> +
> +      In cases where one the hardware design results in a specific
> +      controller handling a larger amount of data, a DTS would likely
> +      enable DMA mode for that one controller.
> +
> +  aspeed,global-regs:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: The phandle of i2c global register node.
> +
>  required:
>    - reg
>    - compatible
> @@ -57,12 +73,30 @@ required:
>  
>  unevaluatedProperties: false
>  
> +allOf:
> +  - $ref: /schemas/i2c/i2c-controller.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: aspeed,ast2600-i2cv2
> +
> +    then:
> +      properties:
> +        reg:
> +          minItems: 2
> +      required:
> +        - aspeed,global-regs
> +    else:
> +      properties:
> +        aspeed,global-regs: false
> +        aspeed,enable-dma: false
> +
> +
>  examples:
>    - |
>      #include <dt-bindings/clock/aspeed-clock.h>
>      i2c0: i2c-bus at 40 {
> -      #address-cells = <1>;
> -      #size-cells = <0>;

Why? Indeed without children this is not really needed, but it points to
the fact that your example without children is not entirely complete.

Anyway you are doing now way too many things in one patch.

https://elixir.bootlin.com/linux/v5.19-rc5/source/Documentation/process/submitting-patches.rst


>        compatible = "aspeed,ast2500-i2c-bus";
>        reg = <0x40 0x40>;
>        clocks = <&syscon ASPEED_CLK_APB>;
> @@ -71,3 +105,13 @@ examples:
>        interrupts = <0>;
>        interrupt-parent = <&i2c_ic>;
>      };
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    i2c1: i2c at 80 {
> +      compatible = "aspeed,ast2600-i2cv2";
> +      reg = <0x80 0x80>, <0xc00 0x20>;
> +      aspeed,global-regs = <&i2c_global>;
> +      clocks = <&syscon ASPEED_CLK_APB>;
> +      resets = <&syscon ASPEED_RESET_I2C>;
> +      interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
> +    };

Best regards,
Krzysztof

