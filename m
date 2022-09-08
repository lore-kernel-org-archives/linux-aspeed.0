From: Neal Liu <neal_liu@aspeedtech.com>
Date: Thu, 8 Sep 2022 03:26:04 +0000
Subject: [PATCH v1 4/4] dt-bindings: bus: add documentation for Aspeed
 AHBC
In-Reply-To: <20220907205033.GA317033-robh@kernel.org>
References: <20220902060012.3758637-1-neal_liu@aspeedtech.com>
 <20220902060012.3758637-5-neal_liu@aspeedtech.com>
 <20220907205033.GA317033-robh@kernel.org>
Message-ID: <HK0PR06MB32025230C219AD97D39537AF80409@HK0PR06MB3202.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> On Fri, Sep 02, 2022 at 02:00:12PM +0800, Neal Liu wrote:
> > Add device tree binding documentation for the Aspeed Advanced
> > High-Performance Bus (AHB) Controller.
> >
> > Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> > ---
> >  .../bindings/bus/aspeed,ast2600-ahbc.yaml     | 39
> +++++++++++++++++++
> >  1 file changed, 39 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/bus/aspeed,ast2600-ahbc.yaml
> >
> > diff --git
> > a/Documentation/devicetree/bindings/bus/aspeed,ast2600-ahbc.yaml
> > b/Documentation/devicetree/bindings/bus/aspeed,ast2600-ahbc.yaml
> > new file mode 100644
> > index 000000000000..ca09eb531666
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/bus/aspeed,ast2600-ahbc.yaml
> > @@ -0,0 +1,39 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/bus/aspeed,ast2600-ahbc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: ASPEED Advanced High-Performance Bus Controller (AHBC) Device
> > +Tree Bindings
> > +
> > +maintainers:
> > +  - Neal Liu <neal_liu@aspeedtech.com>
> > +  - Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> > +
> > +description: |
> > +  Advanced High-performance Bus Controller (AHBC) supports plenty of
> > +mechanisms
> > +  including a priority arbiter, an address decoder and a data
> > +multiplexer
> > +  to control the overall operations of Advanced Highperformance
> 
> High-performance
> 
> > +  Bus (AHB). AHB is the main system bus for ARM CPU to communicate
> > + with the  related peripherals.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - aspeed,ast2600-ahbc
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    ahbc: bus at 1e600000 {
> > +        compatible = "aspeed,ast2600-ahbc";
> > +        reg = <0x1e600000 0x100>;
> 
> Shouldn't devices on the bus be child nodes?

Yes, I miss this part, I'll update it.
Thanks.

> > +    };
> > --
> > 2.25.1
> >
> >
