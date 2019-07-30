From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue, 30 Jul 2019 10:17:54 +0930
Subject: [PATCH 1/4] dt-bindings: net: Add aspeed,ast2600-mdio binding
In-Reply-To: <CAL_JsqLytwfsoyS6TSnpPgTjRTOR0TeQwroX21AHqj3A1mPJ5Q@mail.gmail.com>
References: <20190729043926.32679-1-andrew@aj.id.au>
 <20190729043926.32679-2-andrew@aj.id.au>
 <CAL_JsqLytwfsoyS6TSnpPgTjRTOR0TeQwroX21AHqj3A1mPJ5Q@mail.gmail.com>
Message-ID: <097bdf8e-4409-4c23-8c4c-d50e16d952dc@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Tue, 30 Jul 2019, at 09:07, Rob Herring wrote:
> On Sun, Jul 28, 2019 at 10:39 PM Andrew Jeffery <andrew@aj.id.au> wrote:
> >
> > The AST2600 splits out the MDIO bus controller from the MAC into its own
> > IP block and rearranges the register layout. Add a new binding to
> > describe the new hardware.
> >
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > ---
> >  .../bindings/net/aspeed,ast2600-mdio.yaml     | 61 +++++++++++++++++++
> >  1 file changed, 61 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml b/Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml
> > new file mode 100644
> > index 000000000000..fa86f6438473
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml
> > @@ -0,0 +1,61 @@
> > +# SPDX-License-Identifier: GPL-2.0-or-later
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/aspeed,ast2600-mdio.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: ASPEED AST2600 MDIO Controller
> > +
> > +maintainers:
> > +  - Andrew Jeffery <andrew@aj.id.au>
> > +
> > +description: |+
> > +  The ASPEED AST2600 MDIO controller is the third iteration of ASPEED's MDIO
> > +  bus register interface, this time also separating out the controller from the
> > +  MAC.
> > +
> 
> Should have a:
> 
> allOf:
>   - $ref: "mdio.yaml#"

Ack.

> 
> > +properties:
> > +  compatible:
> > +    const: aspeed,ast2600-mdio
> > +  reg:
> > +    maxItems: 1
> > +    description: The register range of the MDIO controller instance
> 
> > +  "#address-cells":
> > +    const: 1
> > +  "#size-cells":
> > +    const: 0
> 
> Then you can drop these 2.

Great.

> 
> > +
> > +patternProperties:
> > +  "^ethernet-phy@[a-f0-9]$":
> > +    properties:
> > +      reg:
> > +        description:
> > +          The MDIO bus index of the PHY
> 
> And this.
> 
> > +      compatible:
> > +        enum:
> > +          - ethernet-phy-ieee802.3-c22
> > +          - ethernet-phy-ieee802.3-c45
> 
> This isn't specific to ASpeed either and is already covered by
> ethernet-phy.yaml.
> 
> So that means none of the child node schema is needed here.

Bah, I'd developed the patches on v5.2 while waiting for v5.3-rc1 to come
out.

> 
> > +    required:
> > +      - reg
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - "#address-cells"
> > +  - "#size-cells"
> > +
> > +examples:
> > +  - |
> > +    mdio0: mdio at 1e650000 {
> > +            compatible = "aspeed,ast2600-mdio";
> > +            reg = <0x1e650000 0x8>;
> > +            #address-cells = <1>;
> > +            #size-cells = <0>;
> > +
> > +            status = "okay";
> 
> Don't show status in examples.

Sorry, copy/paste at fault.

Thanks for the feedback.

Andrew

> 
> > +
> > +            ethphy0: ethernet-phy at 0 {
> > +                    compatible = "ethernet-phy-ieee802.3-c22";
> > +                    reg = <0>;
> > +            };
> > +    };
> > --
> > 2.20.1
> >
>
