From: Pratyush Yadav <p.yadav@ti.com>
Date: Thu, 31 Mar 2022 17:50:02 +0530
Subject: [PATCH v4 02/11] dt-bindings: spi: Add Aspeed SMC controllers
 device tree binding
In-Reply-To: <2a411a3e-4b7f-c116-b595-f33bffccb4e7@kaod.org>
References: <20220325100849.2019209-1-clg@kaod.org>
 <20220325100849.2019209-3-clg@kaod.org>
 <20220330191908.nhg52a5ayzczpzai@ti.com>
 <2a411a3e-4b7f-c116-b595-f33bffccb4e7@kaod.org>
Message-ID: <20220331122002.55vwda6fnnenuqhf@ti.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 31/03/22 09:36AM, C?dric Le Goater wrote:
> Hello Pratyush,
> 
> On 3/30/22 21:19, Pratyush Yadav wrote:
> > On 25/03/22 11:08AM, C?dric Le Goater wrote:
> > > The "interrupt" property is optional because it is only necessary for
> > > controllers supporting DMAs (Not implemented yet in the new driver).
> > > 
> > > Cc: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> > > Tested-by: Joel Stanley <joel@jms.id.au>
> > > Tested-by: Tao Ren <rentao.bupt@gmail.com>
> > > Reviewed-by: Joel Stanley <joel@jms.id.au>
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > Signed-off-by: C?dric Le Goater <clg@kaod.org>
> > > ---
> > >   .../bindings/spi/aspeed,ast2600-fmc.yaml      | 87 +++++++++++++++++++
> > >   MAINTAINERS                                   |  9 ++
> > >   2 files changed, 96 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml b/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
> > > new file mode 100644
> > > index 000000000000..e16bbcd38560
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
> > > @@ -0,0 +1,87 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/spi/aspeed,ast2600-fmc.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Aspeed SMC controllers bindings
> > > +
> > > +maintainers:
> > > +  - Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> > > +  - C?dric Le Goater <clg@kaod.org>
> > > +
> > > +description: |
> > > +  This binding describes the Aspeed Static Memory Controllers (FMC and
> > > +  SPI) of the AST2400, AST2500 and AST2600 SOCs.
> > > +
> > > +allOf:
> > > +  - $ref: "spi-controller.yaml#"
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - aspeed,ast2600-fmc
> > > +      - aspeed,ast2600-spi
> > > +      - aspeed,ast2500-fmc
> > > +      - aspeed,ast2500-spi
> > > +      - aspeed,ast2400-fmc
> > > +      - aspeed,ast2400-spi
> > > +
> > > +  reg:
> > > +    items:
> > > +      - description: registers
> > > +      - description: memory mapping
> > > +
> > > +  clocks:
> > > +    maxItems: 1
> > > +
> > > +  interrupts:
> > > +    maxItems: 1
> > > +
> > > +patternProperties:
> > > +  "@[0-9a-f]+":
> > > +    type: object
> > > +
> > > +    properties:
> > > +      spi-rx-bus-width:
> > > +        enum: [1, 2, 4]
> > 
> > No need for this. It should already be taken care of by
> > spi-peripheral-props.yaml
> 
> So we could drop the whole 'patternProperties' section ?

Yes.

[...]

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
