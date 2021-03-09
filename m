From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue, 09 Mar 2021 13:15:55 +1030
Subject: =?UTF-8?Q?Re:_[PATCH_16/19]_dt-bindings:_ipmi:_Convert_ASPEED_KCS_bindin?=
 =?UTF-8?Q?g_to_schema?=
In-Reply-To: <20210305230710.GA798530@robh.at.kernel.org>
References: <20210219142523.3464540-1-andrew@aj.id.au>
 <20210219142523.3464540-17-andrew@aj.id.au>
 <20210305230710.GA798530@robh.at.kernel.org>
Message-ID: <0fbc1435-1f0f-4c0e-935f-95874d438fbf@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Sat, 6 Mar 2021, at 09:37, Rob Herring wrote:
> On Sat, Feb 20, 2021 at 12:55:20AM +1030, Andrew Jeffery wrote:
> > Given the deprecated binding, improve the ability to detect issues in
> > the platform devicetrees. Further, a subsequent patch will introduce a
> > new interrupts property for specifying SerIRQ behaviour, so convert
> > before we do any further additions.
> > 
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > ---
> >  .../bindings/ipmi/aspeed,ast2400-kcs-bmc.yaml | 92 +++++++++++++++++++
> >  .../bindings/ipmi/aspeed-kcs-bmc.txt          | 33 -------
> >  2 files changed, 92 insertions(+), 33 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/ipmi/aspeed,ast2400-kcs-bmc.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/ipmi/aspeed-kcs-bmc.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-kcs-bmc.yaml b/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-kcs-bmc.yaml
> > new file mode 100644
> > index 000000000000..1c1cc4265948
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-kcs-bmc.yaml
> > @@ -0,0 +1,92 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: ASPEED BMC KCS Devices
> > +
> > +maintainers:
> > +  - Andrew Jeffery <andrew@aj.id.au>
> > +
> > +description: |
> > +  The Aspeed BMC SoCs typically use the Keyboard-Controller-Style (KCS)
> > +  interfaces on the LPC bus for in-band IPMI communication with their host.
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - description: Channel ID derived from reg
> > +        items:
> > +          enum:
> > +            - aspeed,ast2400-kcs-bmc-v2
> > +            - aspeed,ast2500-kcs-bmc-v2
> > +            - aspeed,ast2600-kcs-bmc
> > +
> > +      - description: Old-style with explicit channel ID, no reg
> > +        deprecated: true
> > +        items:
> > +          enum:
> > +            - aspeed,ast2400-kcs-bmc
> > +            - aspeed,ast2500-kcs-bmc
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  reg:
> > +    minItems: 3
> > +    maxItems: 3
> > +    description: IDR, ODR and STR register addresses
> 
> items:
>   - description: IDR register
>   - description: ODR register
>   - description: STR register

Oh, neat.

> 
> > +
> > +  aspeed,lpc-io-reg:
> > +    $ref: '/schemas/types.yaml#/definitions/uint32'
> > +    minItems: 1
> > +    maxItems: 2
> 
> A uint32 can only have 1 item. uint32-array perhaps?

That sounds more appropriate.

> 
> 
> > +    description: |
> > +      The host CPU LPC IO data and status addresses for the device. For most
> > +      channels the status address is derived from the data address, but the
> > +      status address may be optionally provided.
> > +
> > +  kcs_chan:
> > +    deprecated: true
> > +    $ref: '/schemas/types.yaml#/definitions/uint32'
> > +    maxItems: 1
> 
> Drop

Ack.

> 
> > +    description: The LPC channel number in the controller
> > +
> > +  kcs_addr:
> > +    deprecated: true
> > +    $ref: '/schemas/types.yaml#/definitions/uint32'
> > +    maxItems: 1
> 
> Drop

Ack.
