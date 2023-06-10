From: Corey Minyard <minyard@acm.org>
Date: Sat, 10 Jun 2023 07:52:23 -0500
Subject: [PATCH] dt-bindings: ipmi: aspeed,ast2400-kcs-bmc: drop unneeded
 quotes
In-Reply-To: <778e2930-1678-45bb-a01e-21bf321fb6d8@betaapp.fastmail.com>
References: <20230609140729.64799-1-krzysztof.kozlowski@linaro.org>
 <778e2930-1678-45bb-a01e-21bf321fb6d8@betaapp.fastmail.com>
Message-ID: <ZIRyB531ttuE1SUI@mail.minyard.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, Jun 10, 2023 at 08:49:27AM +0930, Andrew Jeffery wrote:
> 
> 
> On Fri, 9 Jun 2023, at 23:37, Krzysztof Kozlowski wrote:
> > Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> > checking for this can be enabled in yamllint.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Acked-by: Andrew Jeffery <andrew@aj.id.au>

This is in my next tree.  Thank you.

-corey

> 
> > ---
> >  .../devicetree/bindings/ipmi/aspeed,ast2400-kcs-bmc.yaml  | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git 
> > a/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-kcs-bmc.yaml 
> > b/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-kcs-bmc.yaml
> > index 4ff6fabfcb30..129e32c4c774 100644
> > --- a/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-kcs-bmc.yaml
> > +++ b/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-kcs-bmc.yaml
> > @@ -41,7 +41,7 @@ properties:
> >        - description: STR register
> > 
> >    aspeed,lpc-io-reg:
> > -    $ref: '/schemas/types.yaml#/definitions/uint32-array'
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> >      minItems: 1
> >      maxItems: 2
> >      description: |
> > @@ -50,7 +50,7 @@ properties:
> >        status address may be optionally provided.
> > 
> >    aspeed,lpc-interrupts:
> > -    $ref: "/schemas/types.yaml#/definitions/uint32-array"
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> >      minItems: 2
> >      maxItems: 2
> >      description: |
> > @@ -63,12 +63,12 @@ properties:
> > 
> >    kcs_chan:
> >      deprecated: true
> > -    $ref: '/schemas/types.yaml#/definitions/uint32'
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> >      description: The LPC channel number in the controller
> > 
> >    kcs_addr:
> >      deprecated: true
> > -    $ref: '/schemas/types.yaml#/definitions/uint32'
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> >      description: The host CPU IO map address
> > 
> >  required:
> > -- 
> > 2.34.1
