From: Rob Herring <robh@kernel.org>
Date: Mon, 7 Mar 2022 18:57:33 -0600
Subject: [PATCH v2 2/2] dt-bindings: gpu: Convert aspeed-gfx bindings to
 yaml
In-Reply-To: <44308465-db4c-80e7-2beb-b0f676d16edf@canonical.com>
References: <20220304000311.970267-1-joel@jms.id.au>
 <20220304000311.970267-3-joel@jms.id.au>
 <44308465-db4c-80e7-2beb-b0f676d16edf@canonical.com>
Message-ID: <Yiap/f48pLUXzaQ0@robh.at.kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, Mar 05, 2022 at 10:49:05PM +0100, Krzysztof Kozlowski wrote:
> On 04/03/2022 01:03, Joel Stanley wrote:
> > Convert the bindings to yaml and add the ast2600 compatible string.
> > 
> > The legacy mfd description was put in place before the gfx bindings
> > existed, to document the compatible that is used in the pinctrl
> > bindings.
> > 
> > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > ---
> >  .../devicetree/bindings/gpu/aspeed,gfx.yaml   | 69 +++++++++++++++++++
> >  .../devicetree/bindings/gpu/aspeed-gfx.txt    | 41 -----------
> >  .../devicetree/bindings/mfd/aspeed-gfx.txt    | 17 -----
> >  3 files changed, 69 insertions(+), 58 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/gpu/aspeed,gfx.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/gpu/aspeed-gfx.txt
> >  delete mode 100644 Documentation/devicetree/bindings/mfd/aspeed-gfx.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/gpu/aspeed,gfx.yaml b/Documentation/devicetree/bindings/gpu/aspeed,gfx.yaml
> > new file mode 100644
> > index 000000000000..8ddc4fa6e8e4
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/gpu/aspeed,gfx.yaml
> > @@ -0,0 +1,69 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/gpu/aspeed,gfx.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: ASPEED GFX display device
> > +
> > +maintainers:
> > +  - Joel Stanley <joel@jms.id.au>
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - aspeed,ast2400-gfx
> > +          - aspeed,ast2500-gfx
> > +          - aspeed,ast2600-gfx
> 
> That's different than original bindings - new patch. It's not currently
> supported, so adding it is more than just updating bindings to current
> state.
> 
> > +      - const: syscon
> > +
> > +  reg:
> > +    minItems: 1
> 
> maxItems?
> 
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  resets:
> > +    maxItems: 1
> > +
> > +  memory-region: true

Also need to define how many (maxItems: 1).

> > +
> > +  syscon: true
> 
> You need at least description. I see old bindings did not mention it
> (except that it is required)... I think you also need a type, because it
> is not a standard property.
> 
> > +
> > +  reg-io-width: true
> 
> Some constraints? Can it be anything from syscon schema?
> 
> Best regards,
> Krzysztof
> 
