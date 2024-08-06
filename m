From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Tue, 6 Aug 2024 08:12:12 +0200
Subject: [PATCH 2/2] dt-bindings: misc: aspeed,ast2400-cvic: Convert to DT
 schema
In-Reply-To: <20240802-dt-warnings-irq-aspeed-dt-schema-v1-2-8cd4266d2094@codeconstruct.com.au>
References: <20240802-dt-warnings-irq-aspeed-dt-schema-v1-0-8cd4266d2094@codeconstruct.com.au>
 <20240802-dt-warnings-irq-aspeed-dt-schema-v1-2-8cd4266d2094@codeconstruct.com.au>
Message-ID: <ec19fe07-84bd-4c32-a886-e6126af52f4c@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 02/08/2024 07:36, Andrew Jeffery wrote:
> Address warnings such as:
> 


> +description:
> +  The Aspeed AST2400 and AST2500 SoCs have a controller that provides interrupts
> +  to the ColdFire coprocessor. It's not a normal interrupt controller and it
> +  would be rather inconvenient to create an interrupt tree for it, as it
> +  somewhat shares some of the same sources as the main ARM interrupt controller
> +  but with different numbers.
> +
> +  The AST2500 also supports a software generated interrupt.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - aspeed,ast2400-cvic
> +          - aspeed,ast2500-cvic
> +      - const: aspeed,cvic
> +
> +  reg:
> +    maxItems: 1
> +
> +  valid-sources:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      One cell, bitmap of support sources for the implementation.

maxItems: 1
(and drop "One cell" - no need to repeat constraints in free form text)

BTW, for both bindings, I do not see any user in the kernel. Why is this
property needed in the DTS?

> +
> +  copro-sw-interrupts:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array

uint32? I do not see anywhere usage as an array. The in-kernel driver
explicitly reads just uint32.

Anyway, if this is supposed to stay as array, then min/maxItems.



> +    description:
> +      A list of interrupt numbers that can be used as software interrupts from
> +      the ARM to the coprocessor.
> +
> +required:
> +  - compatible
> +  - reg
> +  - valid-sources> +
> +allOf:
> +  - $ref: /schemas/interrupt-controller.yaml#


Best regards,
Krzysztof

