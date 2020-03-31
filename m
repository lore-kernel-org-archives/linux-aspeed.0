From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 31 Mar 2020 11:13:17 +1100
Subject: [PATCH v2 6/6] dt-bindings: usb: document aspeed vhub device
 ID/string properties
In-Reply-To: <20200330192347.GA6388@bogus>
References: <20200315191632.12536-1-rentao.bupt@gmail.com>
 <20200315191632.12536-7-rentao.bupt@gmail.com>
 <20200330192347.GA6388@bogus>
Message-ID: <4dc3ac910c79dcca398eb5161dde44e1cc50baca.camel@kernel.crashing.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 2020-03-30 at 13:23 -0600, Rob Herring wrote:
> On Sun, Mar 15, 2020 at 12:16:32PM -0700, rentao.bupt at gmail.com wrote:
> > From: Tao Ren <rentao.bupt@gmail.com>
> > 
> > Update device tree binding document for aspeed vhub's device IDs and
> > string properties.
> > 
> > Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> > ---
> >  No change in v2:
> >    - the patch is added into the series since v2.
> > 
> >  .../bindings/usb/aspeed,usb-vhub.yaml         | 68 +++++++++++++++++++
> >  1 file changed, 68 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml b/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml
> > index 06399ba0d9e4..5b2e8d867219 100644
> > --- a/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml
> > +++ b/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml
> > @@ -52,6 +52,59 @@ properties:
> >          minimum: 1
> >          maximum: 21
> >  
> > +  vhub-vendor-id:
> > +    description: vhub Vendor ID
> > +    allOf:
> > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > +      - maximum: 65535
> > +
> > +  vhub-product-id:
> > +    description: vhub Product ID
> > +    allOf:
> > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > +      - maximum: 65535
> 
> There's already standard 'vendor-id' and 'device-id' properties. Use 
> those.

So yes and no... I don't fundamentally object but keep in mind that
traditionally, the properties are about matching with a physical
hardware.

In this case however, we are describing a virtual piece of HW and so
those IDs are going to be picked up to be exposed as the USB
vendor/device of the vhub on the USB bus.

Not necessarily an issue but it's more "configuration" than "matching"
and as such, it might make sense to expose that with a prefix, though I
would prefer something like usb-vendor-id or usb,vendor-id...

> > +
> > +  vhub-device-revision:
> 
> Specific to USB, not vhub.

Same as the above.

> > +    description: vhub Device Revision in binary-coded decimal
> > +    allOf:
> > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > +      - maximum: 65535
> > +
> > +  vhub-strings:
> > +    type: object
> > +
> > +    properties:
> > +      '#address-cells':
> > +        const: 1
> > +
> > +      '#size-cells':
> > +        const: 0
> > +
> > +    patternProperties:
> > +      '^string@[0-9a-f]+$':
> > +        type: object
> > +        description: string descriptors of the specific language
> > +
> > +        properties:
> > +          reg:
> > +            maxItems: 1
> > +            description: 16-bit Language Identifier defined by USB-IF
> > +
> > +          manufacturer:
> > +            description: vhub manufacturer
> > +            allOf:
> > +              - $ref: /schemas/types.yaml#/definitions/string
> > +
> > +          product:
> > +            description: vhub product name
> > +            allOf:
> > +              - $ref: /schemas/types.yaml#/definitions/string
> > +
> > +          serial-number:
> > +            description: vhub device serial number
> > +            allOf:
> > +              - $ref: /schemas/types.yaml#/definitions/string
> 
> For all of this, it's USB specific, not vhub specific. I'm not sure this 
> is the right approach. It might be better to just define properties 
> which are just raw USB descriptors rather than inventing some DT format 
> that then has to be converted into USB descriptors.

Raw blob in the DT is rather annoying and leads to hard to parse stuff
for both humans and scripts. The main strenght of the DT is it's easy
to read and manipulate.

Also not the entire descriptor is configurable this way.

That said, it could be that using  the DT for the above is overkill and
instead, we should consider a configfs like the rest of USB gadget.
Though it isn't obvious how to do that, the current gadget stuff
doesn't really "fit" what we need here.

Maybe we could expose the port as UDCs but not actually expose them on
the bus until the hub is "activated" via a special configfs entry...

Cheers,
Ben.

> os the 
> Rob

