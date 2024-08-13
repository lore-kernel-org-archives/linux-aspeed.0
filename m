From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Tue, 13 Aug 2024 10:42:16 +0200
Subject: [PATCH v1 1/2] dt-bindings: interrupt-controller: Add support for
 ASPEED AST27XX INTC
In-Reply-To: <20240813074338.969883-2-kevin_chen@aspeedtech.com>
References: <20240813074338.969883-1-kevin_chen@aspeedtech.com>
 <20240813074338.969883-2-kevin_chen@aspeedtech.com>
Message-ID: <9cc3ef01-6f95-4ce2-9e3d-cc679b50feb6@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 13/08/2024 09:43, Kevin Chen wrote:
> The ASPEED AST27XX interrupt controller(INTC) combines 32 interrupt
> sources into 1 interrupt into GIC from CPU die to CPU die.
> The INTC design contains soc0_intc and soc1_intc module doing hand shake
> between CPU die and IO die INTC.
> 
> In soc0_intc11, each bit represent 1 GIC_SPI interrupt from soc1_intcX.
> In soc1_intcX, each bit represent 1 device interrupt in IO die.
> 
> By soc1_intcX in IO die, AST27XX INTC combines 32 interrupt sources to
> 1 interrupt source in soc0_intc11 in CPU die, which achieve the
> interrupt passing between the different die in AST27XX.
> ---

This was never tested. Please do not send untested code.

It does not look like you tested the bindings, at least after quick
look. Please run `make dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).
Maybe you need to update your dtschema and yamllint.

Limited review follows due to lack of basic testing.

>  .../aspeed,ast2700-intc.yaml                  | 120 ++++++++++++++++++
>  1 file changed, 120 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
> new file mode 100644
> index 000000000000..93d7141bf9f9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
> @@ -0,0 +1,120 @@
> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Aspeed Interrupt Controller driver

Drop driver, describe hardware. Aspeed or some specific SoC?

> +
> +description:
> +  These bindings are for the Aspeed interrupt controller. The AST2700

Drop first sentence. Pointless.

> +  SoC families include a legacy register layout before a re-designed
> +  layout, but the bindings do not prescribe the use of one or the other.

Entire description is pointless - you do not say anything valuable here.
Describe this hardware instead.


> +
> +maintainers:
> +  - Kevin Chen <kevin_chen@aspeedtech.com>
> +
> +allOf:
> +  - $ref: /schemas/interrupt-controller.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:

Drop

> +      - items:

Drop

> +        - enum:
> +          - aspeed,ast2700-intc-ic
> +          - aspeed,ast2700-intc-icv2
> +        description: |
> +          Use "aspeed,ast2700-intc-ic" for soc1 INTC in IO die
> +          Use "aspeed,ast2700-intc-icv2" for soc0 INTC in CPU die

Use consistent naming. Isn't your other block called 0 and 1? Why using
different namings?

> +
> +  interrupt-controller: true
> +
> +  interrupts-extended:

interrupts instead.

> +    minItems: 1
> +    maxItems: 3
> +    description:
> +      Specifies which contexts are connected to the INTC, with "-1" specifying
> +      that a context is not present. Each node pointed to should be a
> +      aspeed,ast2700-intc-ic or aspeed,ast2700-intc-icv2 nodes which are pointed
> +      to gic node.

Don't repeat constraints in free form text. Describe items instead.


> +
> +  "#address-cells":
> +    const: 2

Blank line

> +  "#size-cells":
> +    const: 2
> +
> +  '#interrupt-cells':
> +    const: 2
> +    description: |

Do not need '|' unless you need to preserve formatting.

> +      The first cell cell is the interrupt source IRQ number, and the second cell
> +      is the trigger type as defined in interrupt.txt in this directory.
> +
> +  reg:
> +    minItems: 1
> +    maxItems: 2
> +    description: |
> +      The first cell cell is the interrupt enable register, and the second cell
> +      is the status register.

List and describe the items instead.

> +
> +  ranges: true
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 10
> +    description: |
> +      Interrupt source of the CPU interrupts. In soc0_intc in CPU die INTC each bit
> +      represent soc1_intc interrupt source. soc0_intc take care 10 interrupt source
> +      from soc1_intc0~5 and ltpi0/1_soc1_intc0/1.

No, you cannot have both. That's total mess. Anyway, standard comment
applies - list and describe items.


> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupt-controller
> +  - '#interrupt-cells'
> +
> +additionalProperties: false
> +
> +example:
> +  - |
> +    soc0_intc: interrupt-controller at 12100000 {

Drop label

> +      compatible = "simple-mfd";

No, it's not. Drop. Look how other bindings do it.

> +      reg = <0 0x12100000 0 0x4000>;
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +      ranges = <0x0 0x0 0x0 0x12100000 0x0 0x4000>;

Read DTS coding style.

> +
> +      soc0_intc11: interrupt-controller at 1b00 {

Drop label

> +        compatible = "aspeed,ast2700-intc-icv2";
> +        interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>;
> +        #interrupt-cells = <2>;
> +        interrupt-controller;
> +        reg = <0x0 0x1b00 0x0 0x10>;

DTS coding style

> +      };
> +    };
> +
> +  - |
> +    soc1_intc: interrupt-controller at 14c18000 {
> +      compatible = "simple-mfd";
> +      reg = <0 0x14c18000 0 0x400>;
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +      ranges = <0x0 0x0 0x0 0x14c18000 0x0 0x400>;
> +
> +      soc1_intc0: interrupt-controller at 100 {
> +       compatible = "aspeed,ast2700-intc-ic";

Drop this example, almost no differences.

Best regards,
Krzysztof

