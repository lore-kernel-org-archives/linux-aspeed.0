From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue, 09 Mar 2021 13:14:52 +1030
Subject: =?UTF-8?Q?Re:_[PATCH_17/19]_dt-bindings:_ipmi:_Add_optional_SerIRQ_prope?=
 =?UTF-8?Q?rty_to_ASPEED_KCS_devices?=
In-Reply-To: <20210305230940.GA809870@robh.at.kernel.org>
References: <20210219142523.3464540-1-andrew@aj.id.au>
 <20210219142523.3464540-18-andrew@aj.id.au>
 <20210305230940.GA809870@robh.at.kernel.org>
Message-ID: <331c242b-cf22-4d0e-a08c-b9dbb06f2f32@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Sat, 6 Mar 2021, at 09:39, Rob Herring wrote:
> On Sat, Feb 20, 2021 at 12:55:21AM +1030, Andrew Jeffery wrote:
> > Allocating IO and IRQ resources to LPC devices is in-theory an operation
> > for the host, however ASPEED don't appear to expose this capability
> > outside the BMC (e.g. SuperIO). Instead, we are left with BMC-internal
> > registers for managing these resources, so introduce a devicetree
> > property for KCS devices to describe SerIRQ properties.
> > 
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > ---
> >  .../bindings/ipmi/aspeed,ast2400-kcs-bmc.yaml      | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-kcs-bmc.yaml b/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-kcs-bmc.yaml
> > index 1c1cc4265948..808475a2c2ca 100644
> > --- a/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-kcs-bmc.yaml
> > +++ b/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-kcs-bmc.yaml
> > @@ -47,6 +47,18 @@ properties:
> >        channels the status address is derived from the data address, but the
> >        status address may be optionally provided.
> >  
> > +  aspeed,lpc-interrupts:
> > +    $ref: "/schemas/types.yaml#/definitions/uint32-matrix"
> > +    minItems: 1
> > +    maxItems: 1
> > +    description: |
> > +      A 2-cell property expressing the LPC SerIRQ number and the interrupt
> > +      level/sense encoding (specified in the standard fashion).
> 
> That would be uint32-array with 'maxItems: 2'.
> 

Ah, thanks.
