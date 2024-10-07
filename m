From: Kevin Chen <kevin_chen@aspeedtech.com>
Date: Mon, 7 Oct 2024 10:48:06 +0000
Subject: [PATCH v2 1/2] dt-bindings: interrupt-controller: Add support for
 ASPEED AST27XX INTC
In-Reply-To: <31635635-b743-446d-a94e-b3b8082c06a2@kernel.org>
References: <20240814114106.2809876-1-kevin_chen@aspeedtech.com>
 <20240814114106.2809876-3-kevin_chen@aspeedtech.com>
 <31635635-b743-446d-a94e-b3b8082c06a2@kernel.org>
Message-ID: <PSAPR06MB49494DB3D3062AB23931FD08897D2@PSAPR06MB4949.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> > The ASPEED AST27XX interrupt controller(INTC) contain second level and
> > third level interrupt controller. The third level INTC combines 32
> > interrupt sources into 1 interrupt into parent interrupt controller.
> > The second level INTC doing hand shake with third level INTC.
> 
> 
> > +maintainers:
> > +  - Kevin Chen <kevin_chen@aspeedtech.com>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - aspeed,ast2700-intc-ic
> > +
> > +  reg:
> > +    minItems: 1
> 
> That's unconstrained. Instead: maxItems: 1
Agree.

> 
> > +
> > +  interrupt-controller: true
> > +
> > +  '#interrupt-cells':
> > +    const: 2
> > +
> > +  interrupts:
> > +    minItems: 1
> > +    maxItems: 10
> > +    description:
> > +      It contains two types of interrupt controller. The first type is multiple
> > +      interrupt sources into parent interrupt controller. The second type is
> > +      1 interrupt source to parent interrupt controller.
> 
> I think I asked already - list the items with description.
> 
> Why the number is flexible?
Depend to which INTC0 or INTC1 used.
INTC0 and INTC1 are two kinds of interrupt controller with enable and raw status registers for use.
INTC0 is used to assert GIC(#192~#197) if interrupt in INTC1 asserted. There are 6 GIC interrupt number(#192~#197) used in one INTC0.
INTC1 is used to assert INTC0 if interrupt of modules asserted. There are 32 module interrupts used in one INTC1.

> 
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupt-controller
> > +  - '#interrupt-cells'
> > +  - interrupts
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    bus {
> > +        #address-cells = <2>;
> > +        #size-cells = <2>;
> > +
> > +        interrupt-controller at 12101b00 {
> > +          compatible = "aspeed,ast2700-intc-ic";
> 
> Messed indentation.
Agree. Would change to the following.
examples:
  - |
    #include <dt-bindings/interrupt-controller/arm-gic.h>

    bus {
        #address-cells = <2>;
        #size-cells = <2>;

        interrupt-controller at 12101b00 {
            compatible = "aspeed,ast2700-intc-ic";
            reg = <0 0x12101b00 0 0x10>;
            #interrupt-cells = <2>;
            interrupt-controller;
            interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
                         <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>,
                         <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>,
                         <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>,
                         <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
                         <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>,
                         <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
                         <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>,
                         <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>,
                         <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>;
        };
    };

> 
> Best regards,
> Krzysztof

