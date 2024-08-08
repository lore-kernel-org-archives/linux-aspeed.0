From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Thu, 08 Aug 2024 11:36:28 +0930
Subject: [PATCH 2/2] dt-bindings: misc: aspeed,ast2400-cvic: Convert to
 DT schema
In-Reply-To: <ec19fe07-84bd-4c32-a886-e6126af52f4c@kernel.org>
References: <20240802-dt-warnings-irq-aspeed-dt-schema-v1-0-8cd4266d2094@codeconstruct.com.au>
	 <20240802-dt-warnings-irq-aspeed-dt-schema-v1-2-8cd4266d2094@codeconstruct.com.au>
	 <ec19fe07-84bd-4c32-a886-e6126af52f4c@kernel.org>
Message-ID: <4d26bde0bda7cb1d44958d967c4b0c2da5b2abc4.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 2024-08-06 at 08:12 +0200, Krzysztof Kozlowski wrote:
> On 02/08/2024 07:36, Andrew Jeffery wrote:
> > Address warnings such as:
> > 
> 
> 
> > +description:
> > +  The Aspeed AST2400 and AST2500 SoCs have a controller that provides interrupts
> > +  to the ColdFire coprocessor. It's not a normal interrupt controller and it
> > +  would be rather inconvenient to create an interrupt tree for it, as it
> > +  somewhat shares some of the same sources as the main ARM interrupt controller
> > +  but with different numbers.
> > +
> > +  The AST2500 also supports a software generated interrupt.
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - aspeed,ast2400-cvic
> > +          - aspeed,ast2500-cvic
> > +      - const: aspeed,cvic
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  valid-sources:
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > +    description:
> > +      One cell, bitmap of support sources for the implementation.
> 
> maxItems: 1
> (and drop "One cell" - no need to repeat constraints in free form text)

Ack to both.

> 
> BTW, for both bindings, I do not see any user in the kernel. Why is this
> property needed in the DTS?

Good question. This is a hangover from when benh was involved in the
Aspeed kernel port.

Given it's specified in the prose binding and the devicetrees contain
the property I'll leaving it in for now, but I think it's something we
could consider removing down the track.

> 
> > +
> > +  copro-sw-interrupts:
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> 
> uint32? I do not see anywhere usage as an array. The in-kernel driver
> explicitly reads just uint32.

You're right, and in the context of the hardware an array doesn't make
sense here. I'll switch it to a uint32.

Thanks for the review.

Andrew
