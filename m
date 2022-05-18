From: Rob Herring <robh@kernel.org>
Date: Wed, 18 May 2022 13:26:10 -0500
Subject: [PATCH v5 1/4] dt-bindings: aspeed: Add eSPI controller
In-Reply-To: <HK0PR06MB3779B567DE70F859E28F66C991D19@HK0PR06MB3779.apcprd06.prod.outlook.com>
References: <20220516005412.4844-1-chiawei_wang@aspeedtech.com>
 <20220516005412.4844-2-chiawei_wang@aspeedtech.com>
 <20220517183154.GA1352926-robh@kernel.org>
 <HK0PR06MB3779B567DE70F859E28F66C991D19@HK0PR06MB3779.apcprd06.prod.outlook.com>
Message-ID: <20220518182610.GI3302100-robh@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, May 18, 2022 at 12:15:10AM +0000, ChiaWei Wang wrote:
> Hi Rob,
> 
> > From: Rob Herring <robh@kernel.org>
> > Sent: Wednesday, May 18, 2022 2:32 AM
> > 
> > On Mon, May 16, 2022 at 08:54:09AM +0800, Chia-Wei Wang wrote:
> > > Add dt-bindings for Aspeed eSPI controller
> > >
> > > Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> > > ---
> > >  .../devicetree/bindings/soc/aspeed/espi.yaml  | 162
> > > ++++++++++++++++++
> > 
> > bindings/spi/ includes SPI slaves. Is there a reason this doesn't fit there?
> 
> eSPI resues the timing and electrical specification of SPI but runs completely different protocol.
> Only the flash channel is related to SPI and the other 3 channels are for EC/BMC/SIO.
> Therefore, an eSPI driver does not fit into the SPI model.
> 
> > 
> > >  1 file changed, 162 insertions(+)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/soc/aspeed/espi.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/soc/aspeed/espi.yaml
> > > b/Documentation/devicetree/bindings/soc/aspeed/espi.yaml
> > > new file mode 100644
> > > index 000000000000..aa91ec8caf6a
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/soc/aspeed/espi.yaml
> > > @@ -0,0 +1,162 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) # #
> > > +Copyright (c) 2021 Aspeed Technology Inc.
> > > +%YAML 1.2
> > > +---
> > > +$id: "http://devicetree.org/schemas/soc/aspeed/espi.yaml#"
> > > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > > +
> > > +title: Aspeed eSPI Controller
> > > +
> > > +maintainers:
> > > +  - Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> > > +  - Ryan Chen <ryan_chen@aspeedtech.com>
> > > +
> > > +description:
> > > +  Aspeed eSPI controller implements a slave side eSPI endpoint device
> > > +  supporting the four eSPI channels, namely peripheral, virtual wire,
> > > +  out-of-band, and flash.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    items:
> > > +      - enum:
> > > +          - aspeed,ast2500-espi
> > > +          - aspeed,ast2600-espi
> > > +      - const: simple-mfd
> > > +      - const: syscon
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  "#address-cells":
> > > +    const: 1
> > > +
> > > +  "#size-cells":
> > > +    const: 1
> > > +
> > > +  ranges: true
> > > +
> > > +patternProperties:
> > > +  "^espi-ctrl@[0-9a-f]+$":
> > > +    type: object
> > > +
> > > +    description: Control of the four basic eSPI channels
> > > +
> > > +    properties:
> > > +      compatible:
> > > +        items:
> > > +          - enum:
> > > +              - aspeed,ast2500-espi-ctrl
> > > +              - aspeed,ast2600-espi-ctrl
> > > +
> > > +      interrupts:
> > > +        maxItems: 1
> > > +
> > > +      clocks:
> > > +        maxItems: 1
> > > +
> > > +      perif,memcyc-enable:
> > 
> > What vendor is 'perif'?
> 
> It refers to the eSPI peripheral channel.

The convention for properties is <vendor-prefix>,<property-name>. Fix 
your property names to follow this. 

> 
> > 
> > > +        type: boolean
> > > +        description: Enable memory cycle over eSPI peripheral channel
> > > +
> > > +      perif,memcyc-src-addr:
> > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > +        description: The Host side address to be decoded into the
> > > + memory cycle over eSPI peripheral channel
> > > +
> > > +      perif,memcyc-size:
> > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > +        description: The size of the memory region allocated for the
> > memory cycle over eSPI peripheral channel
> > > +        minimum: 65536
> > 
> > This region is defined by the h/w or just some carveout of system memory? In
> > the former, perhaps this should be part of 'reg'. In the latter case, use a
> > /reserved-memory node and memory-region here.
> 
> The region is going to be allocated at runtime phase.
> It is a kind of shared memory between Host and BMC.

Use /reserved-memory.

> 
> > 
> > > +
> > > +      perif,dma-mode:
> > > +        type: boolean
> > > +        description: Enable DMA support for eSPI peripheral channel
> > > +
> > > +      oob,dma-mode:
> > 
> > What vendor is 'oob'?
> 
> It refers to the eSPI out-of-band channel.
> 
> > 
> > > +        type: boolean
> > > +        description: Enable DMA support for eSPI out-of-band channel
> > > +
> > > +      oob,dma-tx-desc-num:
> > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > +        minimum: 2
> > > +        maximum: 1023
> > > +        description: The number of TX descriptors available for eSPI
> > > + OOB DMA engine
> > > +
> > > +      oob,dma-rx-desc-num:
> > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > +        minimum: 2
> > > +        maximum: 1023
> > > +        description: The number of RX descriptors available for eSPI
> > > + OOB DMA engine
> > > +
> > > +      flash,dma-mode:
> > > +        type: boolean
> > > +        description: Enable DMA support for eSPI flash channel
> > 
> > Why does this need to be in DT. It's configuration.
> 
> The property is used to decide the operation mode (i.e. FIFO or DMA) of the eSPI flash channel.
> Is it a wrong idea to use the DTS property for?
> 
> > 
> > > +
> > > +      flash,safs-mode:
> > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > +        enum: [ 0, 1, 2 ]
> > > +        default: 0
> > > +        description: Slave-Attached-Sharing-Flash mode, 0->Mix,
> > > + 1->SW, 2->HW
> > > +
> > > +    dependencies:
> > > +      perif,memcyc-src-addr: [ "perif,memcyc-enable" ]
> > > +      perif,memcyc-size: [ "perif,memcyc-enable" ]
> > > +      oob,dma-tx-desc-num: [ "oob,dma-mode" ]
> > > +      oob,dma-rx-desc-num: [ "oob,dma-mode" ]
> > > +
> > > +    required:
> > > +      - compatible
> > > +      - interrupts
> > > +      - clocks
> > > +
> > > +  "^espi-mmbi@[0-9a-f]+$":
> > > +    type: object
> > > +
> > > +    description: Control of the PCH-BMC data exchange over eSPI
> > > + peripheral memory cycle
> > > +
> > > +    properties:
> > > +      compatible:
> > > +        const: aspeed,ast2600-espi-mmbi
> > > +
> > > +      interrupts:
> > > +        maxItems: 1
> > > +
> > > +    required:
> > > +      - compatible
> > > +      - interrupts
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - "#address-cells"
> > > +  - "#size-cells"
> > > +  - ranges
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > > +    #include <dt-bindings/clock/ast2600-clock.h>
> > > +
> > > +    espi: espi at 1e6ee000 {
> > > +        compatible = "aspeed,ast2600-espi", "simple-mfd", "syscon";
> > > +        reg = <0x1e6ee000 0x1000>;
> > > +
> > > +        #address-cells = <1>;
> > > +        #size-cells = <1>;
> > > +        ranges = <0x0 0x1e6ee000 0x1000>;
> > > +
> > > +        espi_ctrl: espi-ctrl at 0 {
> > > +            compatible = "aspeed,ast2600-espi-ctrl";
> > > +            reg = <0x0 0x800>;
> > > +            interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
> > > +            clocks = <&syscon ASPEED_CLK_GATE_ESPICLK>;
> > > +        };
> > > +
> > > +        espi_mmbi: espi-mmbi at 800 {
> > > +            compatible = "aspeed,ast2600-espi-mmbi";
> > > +            reg = <0x800 0x50>;
> > > +            interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
> > > +        };
> > 
> > Why do you need these child nodes? Are the subblocks somehow useful on
> > their own or reuseable in another configuration? If not, looks like this could all
> > be 1 node.
> 
> espi-mmbi has individual function and control registers.
> However, espi-mmbi is also a feature extended based on the memory cycle of eSPI peripheral channel.
> Thereby, it has dependency on the eSPI channel initialization conducted by espi-ctrl.
> The scenario is similar to the lpc-ctrl and other lpc-xxx drivers of Aspeed SoCs.

Doesn't LPC have independent downstream devices like a bus? Is this a 
bus where the ESPI controls access to MMBI and espi-ctrl devices? If so, 
then the devices need their own binding and descriptions. But it doesn't 
really look like that to me given the limited description.

Rob
