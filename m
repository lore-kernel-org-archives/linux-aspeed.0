From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Tue, 6 Aug 2024 08:07:55 +0200
Subject: [PATCH 1/2] dt-bindings: interrupt-controller:
 aspeed,ast2400-vic: Convert to DT schema
In-Reply-To: <20240802-dt-warnings-irq-aspeed-dt-schema-v1-1-8cd4266d2094@codeconstruct.com.au>
References: <20240802-dt-warnings-irq-aspeed-dt-schema-v1-0-8cd4266d2094@codeconstruct.com.au>
 <20240802-dt-warnings-irq-aspeed-dt-schema-v1-1-8cd4266d2094@codeconstruct.com.au>
Message-ID: <c51fb027-f8bd-4b10-b9c0-dbbe8e8cf4c1@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 02/08/2024 07:36, Andrew Jeffery wrote:
> Squash warnings such as:
> 
>     arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dtb: /ahb/interrupt-controller at 1e6c0080: failed to match any schema with compatible: ['aspeed,ast2400-vic']
> 
> The YAML DT schema defines an optional property, valid-sources, which
> was not previously described in the prose binding. It is added to
> document existing practice in the Aspeed devicetrees. Unfortunately
> the property seems to predate the requirement that vendor-specific
> properties be prefixed.
> 
> Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>


> +
> +description:
> +  The AST2400 and AST2500 SoC families include a legacy register layout before
> +  a redesigned layout, but the bindings do not prescribe the use of one or the
> +  other.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - aspeed,ast2400-vic
> +      - aspeed,ast2500-vic
> +
> +  interrupt-controller: true
> +
> +  "#interrupt-cells":
> +    const: 1
> +    description:
> +      Specifies the number of cells needed to encode an interrupt source. It
> +      must be 1 as the VIC has no configuration options for interrupt sources.
> +      The single cell defines the interrupt number.
> +
> +  valid-sources:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      One cell, bitmap of support sources for the implementation.

maxItems: 2
What does "one cell" mean? uint32? DTS has two items.

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1

Is this correct? DTS does not have parent interrupt controller for this
device.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupt-controller
> +  - "#interrupt-cells"
> +
> +allOf:
> +  - $ref: /schemas/interrupt-controller.yaml
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    interrupt-controller at 1e6c0080 {
> +         compatible = "aspeed,ast2400-vic";
> +         reg = <0x1e6c0080 0x80>;
> +         interrupt-controller;
> +         #interrupt-cells = <1>;

Make the example complete - add valid-sources interupts.



Best regards,
Krzysztof

