From: ChiaWei Wang <chiawei_wang@aspeedtech.com>
Date: Mon, 20 Mar 2023 02:56:17 +0000
Subject: [PATCH v2 2/5] dt-bindings: dmaengine: Add AST2600 UDMA bindings
In-Reply-To: <20230317210542.GB2790192-robh@kernel.org>
References: <20230314021817.30446-1-chiawei_wang@aspeedtech.com>
 <20230314021817.30446-3-chiawei_wang@aspeedtech.com>
 <20230317210542.GB2790192-robh@kernel.org>
Message-ID: <KL1PR0601MB378198F19051147004321C0491809@KL1PR0601MB3781.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> From: Rob Herring <robh@kernel.org>
> Sent: Saturday, March 18, 2023 5:06 AM
> 
> On Tue, Mar 14, 2023 at 10:18:14AM +0800, Chia-Wei Wang wrote:
> > Add the dmaengine bindings for the UART DMA engine of Aspeed AST2600
> SoC.
> >
> > Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> > ---
> >  .../bindings/dma/aspeed,ast2600-udma.yaml     | 56
> +++++++++++++++++++
> >  include/dt-bindings/dma/ast2600-udma.h        | 40 +++++++++++++
> >  2 files changed, 96 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/dma/aspeed,ast2600-udma.yaml
> >  create mode 100644 include/dt-bindings/dma/ast2600-udma.h
> >
> > diff --git
> > a/Documentation/devicetree/bindings/dma/aspeed,ast2600-udma.yaml
> > b/Documentation/devicetree/bindings/dma/aspeed,ast2600-udma.yaml
> > new file mode 100644
> > index 000000000000..f92e06ac9f39
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/dma/aspeed,ast2600-udma.yaml
> > @@ -0,0 +1,56 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/dma/aspeed,ast2600-udma.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Aspeed AST2600 UART DMA controller
> > +
> > +maintainers:
> > +  - Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> > +
> > +description: |
> 
> Don't need '|'

Will revise in v3 revision.

> 
> > +  The Aspeed AST2600 UDMA controller provides direct memory access
> > + capabilities  for the NS16550A-compatible UART devices inside
> > + AST2600 SoCs. UDMA supports 28  DMA channels and each UART device
> has its dedicated pair of TX and RX channels.
> > +
> > +allOf:
> > +  - $ref: "dma-controller.yaml#"
> 
> Drop quotes

Will revise in v3 revision.

> 
> > +
> > +properties:
> > +  compatible:
> > +    const: aspeed,ast2600-udma
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  "#dma-cells":
> > +    const: 1
> > +
> > +  dma-channels:
> > +    maximum: 28
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - "#dma-cells"
> > +  - dma-channels
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    udma: dma-controller at 1e79e000 {
> 
> Drop unused label.

Will revise in v3 revision.

> 
> > +        compatible = "aspeed,ast2600-udma";
> > +        reg = <0x1e79e000 0x1000>;
> > +        interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
> > +        dma-channels = <28>;
> > +        #dma-cells = <1>;
> > +    };
> > +
> > +...
> > diff --git a/include/dt-bindings/dma/ast2600-udma.h
> > b/include/dt-bindings/dma/ast2600-udma.h
> > new file mode 100644
> > index 000000000000..0b92035b94f1
> > --- /dev/null
> > +++ b/include/dt-bindings/dma/ast2600-udma.h
> > @@ -0,0 +1,40 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> 
> Headers should be dual licensed.
> 
> However, similar to interrupts, we don't normally do defines for DMA request
> numbers. It's only when we make up the numbering (e.g. clock ids).
> 

Will remove the header file in v3 revision.

Thanks,
Chiawei

