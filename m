From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 20 Feb 2024 09:27:05 +0100
Subject: [PATCH] dt-bindings: gpio: Convert Aspeed binding to YAML schema
In-Reply-To: <20240220052918.742793-1-andrew@codeconstruct.com.au>
References: <20240220052918.742793-1-andrew@codeconstruct.com.au>
Message-ID: <0d1dd262-b6dd-4d71-9239-8b0aec8cceff@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 20/02/2024 06:29, Andrew Jeffery wrote:
> Squash warnings such as:
> 

Missing subject prefix: aspeed,ast2400-gpio


> ```
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dtb: /ahb/apb at 1e600000/gpio at 1e780000: failed to match any schema with compatible: ['aspeed,ast2400-gpio']
> ```
> 
> Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>

Thank you for your patch. There is something to discuss/improve.


> ---
>  .../bindings/gpio/aspeed,ast2400-gpio.yaml    | 64 +++++++++++++++++++
>  .../devicetree/bindings/gpio/gpio-aspeed.txt  | 39 -----------
>  2 files changed, 64 insertions(+), 39 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
>  delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-aspeed.txt
> 
> diff --git a/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml b/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
> new file mode 100644
> index 000000000000..353c7620013f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpio/aspeed,ast2400-gpio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Aspeed GPIO controller
> +
> +maintainers:
> +  - Andrew Jeffery <andrew@codeconstruct.com.au>
> +
> +allOf:
> +  - $ref: /schemas/gpio/gpio.yaml#

From where did you take it? None of the bindings have such code. Start
from recent bindings in given category when writing new ones.

Please drop it.

> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: aspeed,ast2600-gpio
> +    then:
> +      required:
> +        - ngpios

Please put entire allOf: after required: block. That's the convention
when it has something more than $ref, because we still want the most
important parts at the top of the file.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - aspeed,ast2400-gpio
> +      - aspeed,ast2500-gpio
> +      - aspeed,ast2600-gpio
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +    description: The clock to use for debounce timings
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-controller: true
> +
> +  "#interrupt-cells":
> +    const: 2
> +

ngpios with some constraints

> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-controller
> +  - "#gpio-cells"
> +  - gpio-controller
> +
> +unevaluatedProperties: false

Instead additionalProperties: false.


Best regards,
Krzysztof

