From: Dylan Hung <dylan_hung@aspeedtech.com>
Date: Wed, 13 Apr 2022 02:59:32 +0000
Subject: [PATCH v4 1/3] dt-bindings: net: add reset property for aspeed,
 ast2600-mdio binding
In-Reply-To: <CACPK8Xd0gh5pDafP3ysu7odhnP=YPNSYPV9u36CEoMPDtQxEJw@mail.gmail.com>
References: <20220412065611.8930-1-dylan_hung@aspeedtech.com>
 <20220412065611.8930-2-dylan_hung@aspeedtech.com>
 <CACPK8Xd0gh5pDafP3ysu7odhnP=YPNSYPV9u36CEoMPDtQxEJw@mail.gmail.com>
Message-ID: <HK0PR06MB2834E93356A4C3ECBE48F71A9CEC9@HK0PR06MB2834.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Joel Stanley [mailto:joel at jms.id.au]
> Sent: 2022?4?13? 10:34 AM
> To: Dylan Hung <dylan_hung@aspeedtech.com>
> Cc: Rob Herring <robh+dt@kernel.org>; Andrew Jeffery <andrew@aj.id.au>;
> Andrew Lunn <andrew@lunn.ch>; hkallweit1 at gmail.com; Russell King
> <linux@armlinux.org.uk>; David S . Miller <davem@davemloft.net>; Jakub
> Kicinski <kuba@kernel.org>; pabeni at redhat.com; Philipp Zabel
> <p.zabel@pengutronix.de>; devicetree <devicetree@vger.kernel.org>; Linux
> ARM <linux-arm-kernel@lists.infradead.org>; linux-aspeed
> <linux-aspeed@lists.ozlabs.org>; Linux Kernel Mailing List
> <linux-kernel@vger.kernel.org>; Networking <netdev@vger.kernel.org>;
> Krzysztof Kozlowski <krzk+dt@kernel.org>; BMC-SW
> <BMC-SW@aspeedtech.com>; Krzysztof Kozlowski <krzk@kernel.org>
> Subject: Re: [PATCH v4 1/3] dt-bindings: net: add reset property for aspeed,
> ast2600-mdio binding
> 
> On Tue, 12 Apr 2022 at 06:55, Dylan Hung <dylan_hung@aspeedtech.com>
> wrote:
> >
> > The AST2600 MDIO bus controller has a reset control bit and must be
> > deasserted before manipulating the MDIO controller. By default, the
> > hardware asserts the reset so the driver only need to deassert it.
> >
> > Regarding to the old DT blobs which don't have reset property in them,
> > the reset deassertion is usually done by the bootloader so the reset
> > property is optional to work with them.
> >
> > Signed-off-by: Dylan Hung <dylan_hung@aspeedtech.com>
> > Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  .../devicetree/bindings/net/aspeed,ast2600-mdio.yaml         | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml
> > b/Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml
> > index 1c88820cbcdf..1174c14898e1 100644
> > --- a/Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml
> > +++ b/Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml
> > @@ -20,10 +20,14 @@ allOf:
> >  properties:
> >    compatible:
> >      const: aspeed,ast2600-mdio
> > +
> >    reg:
> >      maxItems: 1
> >      description: The register range of the MDIO controller instance
> >
> > +  resets:
> > +    maxItems: 1
> > +
> >  required:
> >    - compatible
> >    - reg
> > @@ -39,6 +43,7 @@ examples:
> >              reg = <0x1e650000 0x8>;
> >              #address-cells = <1>;
> >              #size-cells = <0>;
> > +            resets = <&syscon ASPEED_RESET_MII>;
> 
> You will need to include the definition for ASPEED_RESET_MII at the start of
> the example:
> 
> #include <dt-bindings/clock/ast2600-clock.h>
> 
> You can test the bindings example by doing this:
> 
> pip install dtschema
> 
> make dt_binding_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/net/aspeed,ast2600-
> mdio.yaml
> 

Thank you for your comment, I have reproduced this error and fixed it on my side.
The change will be included in V5.

> Cheers,
> 
> Joel
> 
> >
> >              ethphy0: ethernet-phy at 0 {
> >                      compatible = "ethernet-phy-ieee802.3-c22";
> > --
> > 2.25.1
> >
