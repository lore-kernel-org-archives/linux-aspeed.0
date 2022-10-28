From: Neal Liu <neal_liu@aspeedtech.com>
Date: Fri, 28 Oct 2022 07:30:40 +0000
Subject: [PATCH v2 4/4] dt-bindings: bus: add documentation for Aspeed
 AHBC
In-Reply-To: <HK0PR06MB32020E4C2124FDD9C68F811A805C9@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20221004032841.3714928-1-neal_liu@aspeedtech.com>
 <20221004032841.3714928-5-neal_liu@aspeedtech.com>
 <20221005131840.GA3256371-robh@kernel.org>
 <HK0PR06MB32020E4C2124FDD9C68F811A805C9@HK0PR06MB3202.apcprd06.prod.outlook.com>
Message-ID: <HK0PR06MB3202285F061E0DFD0967395380329@HK0PR06MB3202.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> > > Add device tree binding documentation for the Aspeed Advanced
> > > High-Performance Bus (AHB) Controller.
> > >
> > > Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> > > ---
> > >  .../bindings/bus/aspeed,ast2600-ahbc.yaml     | 46
> > +++++++++++++++++++
> > >  1 file changed, 46 insertions(+)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/bus/aspeed,ast2600-ahbc.yaml
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/bus/aspeed,ast2600-ahbc.yaml
> > > b/Documentation/devicetree/bindings/bus/aspeed,ast2600-ahbc.yaml
> > > new file mode 100644
> > > index 000000000000..c42a350d30a1
> > > --- /dev/null
> > > +++
> b/Documentation/devicetree/bindings/bus/aspeed,ast2600-ahbc.yaml
> > > @@ -0,0 +1,46 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/bus/aspeed,ast2600-ahbc.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: ASPEED Advanced High-Performance Bus Controller (AHBC)
> > > +Device Tree Bindings
> > > +
> > > +maintainers:
> > > +  - Neal Liu <neal_liu@aspeedtech.com>
> > > +  - Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> > > +
> > > +description: |
> > > +  Advanced High-performance Bus Controller (AHBC) supports plenty
> > > +of mechanisms
> > > +  including a priority arbiter, an address decoder and a data
> > > +multiplexer
> > > +  to control the overall operations of Advanced High-performance
> > > +  Bus (AHB). AHB is the main system bus for ARM CPU to communicate
> > > +with the
> > > +  related peripherals.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - aspeed,ast2600-ahbc
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    bus {
> > > +        compatible = "simple-bus";
> > > +        #address-cells = <1>;
> > > +        #size-cells = <1>;
> > > +        ranges;
> > > +
> > > +        ahbc: bus at 1e600000 {
> > > +            compatible = "aspeed,ast2600-ahbc";
> > > +            reg = <0x1e600000 0x100>;
> >
> > Devices on the AHB bus should be child nodes here. Unless this is just
> > for device master interface to memory, but that's not what the description
> says.
> 
> Sorry, I don't understand. "ahbc" device is already a child node here under
> AHB bus.
> "ahbc" is a controller to control the overall operations of AHB, which is
> described in the description.
> Could you explain more details?
> Thanks.

Hi Rob,

This controller is a device master interface to memory, not the bus itself. Maybe the description confuse it, I'll try to revise it.
Thanks.
