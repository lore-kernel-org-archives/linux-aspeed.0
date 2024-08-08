From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Thu, 08 Aug 2024 11:32:04 +0930
Subject: [PATCH 1/2] dt-bindings: interrupt-controller:
 aspeed,ast2400-vic: Convert to DT schema
In-Reply-To: <c51fb027-f8bd-4b10-b9c0-dbbe8e8cf4c1@kernel.org>
References: <20240802-dt-warnings-irq-aspeed-dt-schema-v1-0-8cd4266d2094@codeconstruct.com.au>
	 <20240802-dt-warnings-irq-aspeed-dt-schema-v1-1-8cd4266d2094@codeconstruct.com.au>
	 <c51fb027-f8bd-4b10-b9c0-dbbe8e8cf4c1@kernel.org>
Message-ID: <18a932d777d1b3b86af15e80af82b50d2189872f.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 2024-08-06 at 08:07 +0200, Krzysztof Kozlowski wrote:
> On 02/08/2024 07:36, Andrew Jeffery wrote:
> > Squash warnings such as:
> > 
> >     arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dtb: /ahb/interrupt-controller at 1e6c0080: failed to match any schema with compatible: ['aspeed,ast2400-vic']
> > 
> > The YAML DT schema defines an optional property, valid-sources, which
> > was not previously described in the prose binding. It is added to
> > document existing practice in the Aspeed devicetrees. Unfortunately
> > the property seems to predate the requirement that vendor-specific
> > properties be prefixed.
> > 
> > Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> 
> 
> > +
> > +description:
> > +  The AST2400 and AST2500 SoC families include a legacy register layout before
> > +  a redesigned layout, but the bindings do not prescribe the use of one or the
> > +  other.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - aspeed,ast2400-vic
> > +      - aspeed,ast2500-vic
> > +
> > +  interrupt-controller: true
> > +
> > +  "#interrupt-cells":
> > +    const: 1
> > +    description:
> > +      Specifies the number of cells needed to encode an interrupt source. It
> > +      must be 1 as the VIC has no configuration options for interrupt sources.
> > +      The single cell defines the interrupt number.
> > +
> > +  valid-sources:
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > +    description:
> > +      One cell, bitmap of support sources for the implementation.
> 
> maxItems: 2

Ack.

> What does "one cell" mean? uint32? DTS has two items.

Hah, I think that was a process error :) Two is correct here. I'll
rework the description.

> 
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> 
> Is this correct? DTS does not have parent interrupt controller for this
> device.

I'll removed it, it's not necessary.

> 
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupt-controller
> > +  - "#interrupt-cells"
> > +
> > +allOf:
> > +  - $ref: /schemas/interrupt-controller.yaml
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    interrupt-controller at 1e6c0080 {
> > +         compatible = "aspeed,ast2400-vic";
> > +         reg = <0x1e6c0080 0x80>;
> > +         interrupt-controller;
> > +         #interrupt-cells = <1>;
> 
> Make the example complete - add valid-sources interupts.
> 

Ack.

Thanks for the review.

Andrew
