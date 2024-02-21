From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Wed, 21 Feb 2024 13:11:35 +1030
Subject: [PATCH] dt-bindings: gpio: Convert Aspeed binding to YAML schema
In-Reply-To: <0d1dd262-b6dd-4d71-9239-8b0aec8cceff@linaro.org>
References: <20240220052918.742793-1-andrew@codeconstruct.com.au>
	 <0d1dd262-b6dd-4d71-9239-8b0aec8cceff@linaro.org>
Message-ID: <18dfd5f2eff5049fa5e3a098490dc601cf146f96.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Krzysztof, thanks for the feedback.

On Tue, 2024-02-20 at 09:27 +0100, Krzysztof Kozlowski wrote:
> > On 20/02/2024 06:29, Andrew Jeffery wrote:
> > > > Squash warnings such as:
> > > > 
> > 
> > Missing subject prefix: aspeed,ast2400-gpio
> > 
> > 
> > > > ```
> > > > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dtb: /ahb/apb at 1e600000/gpio at 1e780000: failed to match any schema with compatible: ['aspeed,ast2400-gpio']
> > > > ```
> > > > 
> > > > Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> > 
> > Thank you for your patch. There is something to discuss/improve.
> > 
> > 
> > > > ---
> > > >  .../bindings/gpio/aspeed,ast2400-gpio.yaml    | 64 +++++++++++++++++++
> > > >  .../devicetree/bindings/gpio/gpio-aspeed.txt  | 39 -----------
> > > >  2 files changed, 64 insertions(+), 39 deletions(-)
> > > >  create mode 100644 Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
> > > >  delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-aspeed.txt
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml b/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
> > > > new file mode 100644
> > > > index 000000000000..353c7620013f
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
> > > > @@ -0,0 +1,64 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/gpio/aspeed,ast2400-gpio.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Aspeed GPIO controller
> > > > +
> > > > +maintainers:
> > > > +  - Andrew Jeffery <andrew@codeconstruct.com.au>
> > > > +
> > > > +allOf:
> > > > +  - $ref: /schemas/gpio/gpio.yaml#
> > 
> > From where did you take it? None of the bindings have such code. Start
> > from recent bindings in given category when writing new ones.

I didn't take it from anywhere so much as try to apply some reasoning
via the commentary in the example at [1]. Maybe I could have fought
that approach by contrasting what I wrote to a wider set of existing
binding documents (I did look at some and obviously didn't find
anything similar).

Anyway reflecting on the misunderstanding, is the ref unnecessary
because the gpio binding sets `select: true`[2] and so is applied to
the node regardless?

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/example-schema.yaml?h=v6.7#n238
[2]: https://github.com/devicetree-org/dt-schema/blob/v2023.11/dtschema/schemas/gpio/gpio.yaml#L12

> > 
> > Please drop it.

Ack.

> > 
> > > > +  - if:
> > > > +      properties:
> > > > +        compatible:
> > > > +          contains:
> > > > +            const: aspeed,ast2600-gpio
> > > > +    then:
> > > > +      required:
> > > > +        - ngpios
> > 
> > Please put entire allOf: after required: block. That's the convention
> > when it has something more than $ref, because we still want the most
> > important parts at the top of the file.

Ack.

> > 
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    enum:
> > > > +      - aspeed,ast2400-gpio
> > > > +      - aspeed,ast2500-gpio
> > > > +      - aspeed,ast2600-gpio
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +  clocks:
> > > > +    maxItems: 1
> > > > +    description: The clock to use for debounce timings
> > > > +
> > > > +  interrupts:
> > > > +    maxItems: 1
> > > > +
> > > > +  interrupt-controller: true
> > > > +
> > > > +  "#interrupt-cells":
> > > > +    const: 2
> > > > +
> > 
> > ngpios with some constraints

Is this just with regard to the constraints I have under allOf above?
Or something further (constrain the values of ngpios for the various
controllers across the Aspeed SoCs)?

Maybe I'll look at some more of the existing bindings for this as
well...

> > 
> > > > +required:
> > > > +  - compatible
> > > > +  - reg
> > > > +  - interrupts
> > > > +  - interrupt-controller
> > > > +  - "#gpio-cells"
> > > > +  - gpio-controller
> > > > +
> > > > +unevaluatedProperties: false
> > 
> > Instead additionalProperties: false.

Ack - this is the same misunderstanding as the gpio schema ref
discussed above.

Andrew

