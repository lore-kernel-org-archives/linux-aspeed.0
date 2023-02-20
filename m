From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 20 Feb 2023 09:35:04 +0100
Subject: [PATCH v5 1/2] dt-bindings: i2c: Add support for ASPEED i2Cv2
In-Reply-To: <20230220061745.1973981-2-ryan_chen@aspeedtech.com>
References: <20230220061745.1973981-1-ryan_chen@aspeedtech.com>
 <20230220061745.1973981-2-ryan_chen@aspeedtech.com>
Message-ID: <676c7777-635c-cc1f-b919-d33e84a45442@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 20/02/2023 07:17, Ryan Chen wrote:
> AST2600 support new register set for I2Cv2 controller, add bindings
> document to support driver of i2cv2 new register mode controller.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  .../devicetree/bindings/i2c/aspeed,i2cv2.yaml | 83 +++++++++++++++++++
>  1 file changed, 83 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/aspeed,i2cv2.yaml

New compatible is okay, but as this is the same controller as old one,
this should go to old binding.

There are several issues anyway here, but I won't reviewing it except
few obvious cases.

> 
> diff --git a/Documentation/devicetree/bindings/i2c/aspeed,i2cv2.yaml b/Documentation/devicetree/bindings/i2c/aspeed,i2cv2.yaml
> new file mode 100644
> index 000000000000..913fb45d5fbe
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/aspeed,i2cv2.yaml
> @@ -0,0 +1,83 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/i2c/aspeed,i2cv2.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ASPEED I2Cv2 Controller on the AST26XX SoCs
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
> +      - aspeed,ast2600-i2cv2
> +
> +  reg:
> +    minItems: 1
> +    items:
> +      - description: address offset and range of register
> +      - description: address offset and range of buffer register

Why this is optional?

> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +    description:
> +      Reference clock for the I2C bus
> +
> +  resets:
> +    maxItems: 1
> +
> +  clock-frequency:
> +    description:
> +      Desired I2C bus clock frequency in Hz. default 100khz.
> +
> +  multi-master:
> +    type: boolean
> +    description:
> +      states that there is another master active on this bus

Drop description and type. Just :true.

> +
> +  timeout:
> +    type: boolean
> +    description: Enable i2c bus timeout for master/slave (35ms)

Why this is property for DT? It's for sure not bool, but proper type
coming from units.

> +
> +  byte-mode:
> +    type: boolean
> +    description: Force i2c driver use byte mode transmit

Drop, not a DT property.

> +
> +  buff-mode:
> +    type: boolean
> +    description: Force i2c driver use buffer mode transmit

Drop, not a DT property.

> +
> +  aspeed,gr:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: The phandle of i2c global register node.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - resets
> +  - aspeed,gr
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/ast2600-clock.h>
> +    i2c: i2c-bus at 80 {

You did not test the bindings... This is i2c.


Best regards,
Krzysztof

