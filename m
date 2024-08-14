From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 14 Aug 2024 16:04:51 +0200
Subject: [PATCH v2 1/2] dt-bindings: interrupt-controller: Add support for
 ASPEED AST27XX INTC
In-Reply-To: <20240814114106.2809876-3-kevin_chen@aspeedtech.com>
References: <20240814114106.2809876-1-kevin_chen@aspeedtech.com>
 <20240814114106.2809876-3-kevin_chen@aspeedtech.com>
Message-ID: <31635635-b743-446d-a94e-b3b8082c06a2@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 14/08/2024 13:41, Kevin Chen wrote:
> The ASPEED AST27XX interrupt controller(INTC) contain second level and
> third level interrupt controller. The third level INTC combines 32 interrupt
> sources into 1 interrupt into parent interrupt controller. The second
> level INTC doing hand shake with third level INTC.


> +maintainers:
> +  - Kevin Chen <kevin_chen@aspeedtech.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - aspeed,ast2700-intc-ic
> +
> +  reg:
> +    minItems: 1

That's unconstrained. Instead: maxItems: 1

> +
> +  interrupt-controller: true
> +
> +  '#interrupt-cells':
> +    const: 2
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 10
> +    description:
> +      It contains two types of interrupt controller. The first type is multiple
> +      interrupt sources into parent interrupt controller. The second type is 
> +      1 interrupt source to parent interrupt controller.

I think I asked already - list the items with description.

Why the number is flexible?

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupt-controller
> +  - '#interrupt-cells'
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    bus {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +    
> +        interrupt-controller at 12101b00 {
> +          compatible = "aspeed,ast2700-intc-ic";

Messed indentation.



Best regards,
Krzysztof

