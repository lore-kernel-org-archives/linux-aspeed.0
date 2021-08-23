From: ChiaWei Wang <chiawei_wang@aspeedtech.com>
Date: Mon, 23 Aug 2021 01:21:15 +0000
Subject: [PATCH v2 1/5] dt-bindings: aspeed: Add eSPI controller
In-Reply-To: <YSAKM16WLx4UWIQu@robh.at.kernel.org>
References: <20210819080040.31242-1-chiawei_wang@aspeedtech.com>
 <20210819080040.31242-2-chiawei_wang@aspeedtech.com>
 <YSAKM16WLx4UWIQu@robh.at.kernel.org>
Message-ID: <HK0PR06MB3779C39208BDFEB6A80006AF91C49@HK0PR06MB3779.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Rob,

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Saturday, August 21, 2021 4:02 AM
> To: ChiaWei Wang <chiawei_wang@aspeedtech.com>
> Cc: joel at jms.id.au; andrew at aj.id.au; linux-aspeed at lists.ozlabs.org;
> openbmc at lists.ozlabs.org; devicetree at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org; Ryan Chen
> <ryan_chen@aspeedtech.com>
> Subject: Re: [PATCH v2 1/5] dt-bindings: aspeed: Add eSPI controller
> 
> On Thu, Aug 19, 2021 at 04:00:36PM +0800, Chia-Wei Wang wrote:
> > Add dt-bindings for Aspeed eSPI controller
> >
> > Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> > ---
> >  .../devicetree/bindings/soc/aspeed/espi.yaml  | 158
> > ++++++++++++++++++
> >  1 file changed, 158 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/soc/aspeed/espi.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/soc/aspeed/espi.yaml
> > b/Documentation/devicetree/bindings/soc/aspeed/espi.yaml
> > new file mode 100644
> > index 000000000000..fec3d37f3ffd
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/soc/aspeed/espi.yaml
> > @@ -0,0 +1,158 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) # #
> > +Copyright (c) 2021 Aspeed Technology Inc.
> > +%YAML 1.2
> > +---
> > +$id: "http://devicetree.org/schemas/soc/aspeed/espi.yaml#"
> > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > +
> > +title: Aspeed eSPI Controller
> > +
> > +maintainers:
> > +  - Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> > +  - Ryan Chen <ryan_chen@aspeedtech.com>
> > +
> > +description:
> > +  Aspeed eSPI controller implements a slave side eSPI endpoint device
> > +  supporting the four eSPI channels, namely peripheral, virtual wire,
> > +  out-of-band, and flash.
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - aspeed,ast2500-espi
> > +          - aspeed,ast2600-espi
> > +      - const: simple-mfd
> > +      - const: syscon
> 
> Is this really 2 sub devices that could be used individually or in a different
> combination? If not, then I'd make all this 1 node.

espi-mmbi has individual function and control registers.
However, espi-mmbi is also a feature extended based on the memory cycle of eSPI peripheral channel.
Thereby, it has dependency on the eSPI channel initialization conducted by espi-ctrl.
The scenario is similar to the lpc-ctrl and other lpc-xxx drivers of Aspeed SoCs.

Chiawei
