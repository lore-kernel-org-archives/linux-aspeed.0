From: ChiaWei Wang <chiawei_wang@aspeedtech.com>
Date: Mon, 27 Sep 2021 01:16:52 +0000
Subject: [PATCH v6 1/4] dt-bindings: mfd: aspeed-lpc: Convert to YAML
 schema
In-Reply-To: <CAL_JsqLDztZpw9wWfCCKn8rBZxKcsh_idc903kEUDAuh_31OQw@mail.gmail.com>
References: <20210922073241.14119-1-chiawei_wang@aspeedtech.com>
 <20210922073241.14119-2-chiawei_wang@aspeedtech.com>
 <CAL_JsqLDztZpw9wWfCCKn8rBZxKcsh_idc903kEUDAuh_31OQw@mail.gmail.com>
Message-ID: <HK0PR06MB3779D4CE9C043C42DA958A3091A79@HK0PR06MB3779.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Rob,

> From: Rob Herring <robh+dt@kernel.org>
> Sent: Wednesday, September 22, 2021 9:15 PM
> 
> On Wed, Sep 22, 2021 at 2:32 AM Chia-Wei Wang
> <chiawei_wang@aspeedtech.com> wrote:
> >
> > Convert the bindings of Aspeed LPC from text file into YAML schema.
> >
> > Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> > ---
> >  .../devicetree/bindings/mfd/aspeed-lpc.txt    | 157 ---------------
> >  .../devicetree/bindings/mfd/aspeed-lpc.yaml   | 187
> ++++++++++++++++++
> >  2 files changed, 187 insertions(+), 157 deletions(-)  delete mode
> > 100644 Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
> >  create mode 100644
> > Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
> 
> This has lots of warnings with 'make dtbs_check':
> 
> /builds/robherring/linux-dt-review/arch/arm/boot/dts/aspeed-ast2500-evb.dt.y
> aml:
> lpc at 1e789000: 'ibt at 140', 'kcs at 114', 'kcs at 24', 'kcs at 28', 'kcs at 2c', 'lhc at a0',
> 'reg-io-width' do not match any of the regexes:
> '^lpc-ctrl@[0-9a-f]+$', '^lpc-snoop@[0-9a-f]+$', '^reset-controller@[0-9a-f]+$',
> 'pinctrl-[0-9]+'
> From schema:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/as
> peed-lpc.yaml
> 
> Is 'reg-io-width' valid?

I think that 'reg-io-width' can be removed along with this YAML conversion.
The LPC drivers does not refer to this property (Andrew, correct me if I missed something).

> 
> You can quiet all the child nodes with:
> 
> additionalProperties:
>   type: object
> 
> (They will still warn about undocumented compatibles, so we don't lose any
> todo list).

Thanks!
I will add this and run the checks for the v7 revision.

Regards,
Chiawei

> 
> 
> > diff --git a/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
> > b/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
> > new file mode 100644
> > index 000000000000..9c66795a1fb6
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
> > @@ -0,0 +1,187 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) # #
> > +Copyright (c) 2021 Aspeed Tehchnology Inc.
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Aspeed Low Pin Count (LPC) Bus Controller
> > +
> > +maintainers:
> > +  - Andrew Jeffery <andrew@aj.id.au>
> > +  - Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> > +
> > +description:
> 
> You need '|' to preserve paragraphs.
> 
> > +  The LPC bus is a means to bridge a host CPU to a number of
> > + low-bandwidth  peripheral devices, replacing the use of the ISA bus
> > + in the age of PCI[0]. The  primary use case of the Aspeed LPC
> > + controller is as a slave on the bus  (typically in a Baseboard
> > + Management Controller SoC), but under certain  conditions it can also
> take the role of bus master.
> > +
> > +  The LPC controller is represented as a multi-function device to
> > + account for the  mix of functionality, which includes, but is not
> > + limited to
> > +
> > +  * An IPMI Block Transfer[2] Controller
> > +
> > +  * An LPC Host Interface Controller manages functions exposed to the host
> such
> > +    as LPC firmware hub cycles, configuration of the LPC-to-AHB mapping,
> UART
> > +    management and bus snoop configuration.
> > +
> > +  * A set of SuperIO[3] scratch registers enableing implementation of e.g.
> custom
> > +    hardware management protocols for handover between the host and
> baseboard
> > +    management controller.
> > +
> > +  Additionally the state of the LPC controller influences the pinmux
> > + configuration, therefore the host portion of the controller is
> > + exposed as a  syscon as a means to arbitrate access.
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - aspeed,ast2400-lpc-v2
> > +          - aspeed,ast2500-lpc-v2
> > +          - aspeed,ast2600-lpc-v2
> > +      - const: simple-mfd
> > +      - const: syscon
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  "#address-cells":
> > +    const: 1
> > +
> > +  "#size-cells":
> > +    const: 1
> > +
> > +  ranges: true
> > +
> > +patternProperties:
> > +  "^lpc-ctrl@[0-9a-f]+$":
> > +    type: object
> > +
> > +    description:
> > +      The LPC Host Interface Controller manages functions exposed to the
> host such as
> > +      LPC firmware hub cycles, configuration of the LPC-to-AHB mapping,
> UART management
> > +      and bus snoop configuration.
> > +
> > +    properties:
> > +      compatible:
> > +        items:
> > +          - enum:
> > +              - aspeed,ast2400-lpc-ctrl
> > +              - aspeed,ast2500-lpc-ctrl
> > +              - aspeed,ast2600-lpc-ctrl
> > +
> > +      reg:
> > +        maxItems: 1
> > +
> > +      clocks:
> > +        maxItems: 1
> > +
> > +      memory-region:
> > +        $ref: /schemas/types.yaml#/definitions/phandle
> 
> Already has a type. Needs how many entries (maxItems: 1).
> 
> > +        description: A reserved_memory region to be used for the LPC
> > + to AHB mapping
> > +
> > +      flash:
> > +        $ref: /schemas/types.yaml#/definitions/phandle
> > +        description: The SPI flash controller containing the flash to
> > + be exposed over the LPC to AHB mapping
> > +
> > +    required:
> > +      - compatible
> > +      - clocks
> > +
> > +  "^reset-controller@[0-9a-f]+$":
> > +    type: object
> > +
> > +    description:
> > +      The UARTs present in the ASPEED SoC can have their resets tied to
> the reset
> > +      state of the LPC bus. Some systems may chose to modify this
> > + configuration
> > +
> > +    properties:
> > +      compatible:
> > +        items:
> > +          - enum:
> > +              - aspeed,ast2400-lpc-reset
> > +              - aspeed,ast2500-lpc-reset
> > +              - aspeed,ast2600-lpc-reset
> > +
> > +      reg:
> > +        maxItems: 1
> > +
> > +    required:
> > +      - compatible
> > +
> > +  "^lpc-snoop@[0-9a-f]+$":
> > +    type: object
> > +
> > +    description:
> > +      The LPC snoop interface allows the BMC to listen on and record the
> data
> > +      bytes written by the Host to the targeted LPC I/O pots.
> > +
> > +    properties:
> > +      compatible:
> > +        items:
> > +          - enum:
> > +              - aspeed,ast2400-lpc-snoop
> > +              - aspeed,ast2500-lpc-snoop
> > +              - aspeed,ast2600-lpc-snoop
> > +
> > +      reg:
> > +        maxItems: 1
> > +
> > +      interrupts:
> > +        maxItems: 1
> > +
> > +      snoop-ports:
> > +        $ref: /schemas/types.yaml#/definitions/uint32-array
> > +        description: The LPC I/O ports to snoop
> > +
> > +    required:
> > +      - compatible
> > +      - interrupts
> > +      - snoop-ports
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - "#address-cells"
> > +  - "#size-cells"
> > +  - ranges
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/clock/ast2600-clock.h>
> > +
> > +    lpc: lpc at 1e789000 {
> > +        compatible = "aspeed,ast2600-lpc-v2", "simple-mfd", "syscon";
> > +        reg = <0x1e789000 0x1000>;
> > +
> > +        #address-cells = <1>;
> > +        #size-cells = <1>;
> > +        ranges = <0x0 0x1e789000 0x1000>;
> > +
> > +        lpc_ctrl: lpc-ctrl at 80 {
> > +            compatible = "aspeed,ast2600-lpc-ctrl";
> > +            reg = <0x80 0x80>;
> > +            clocks = <&syscon ASPEED_CLK_GATE_LCLK>;
> > +            memory-region = <&flash_memory>;
> > +            flash = <&spi>;
> > +        };
> > +
> > +        lpc_reset: reset-controller at 98 {
> > +            compatible = "aspeed,ast2600-lpc-reset";
> > +            reg = <0x98 0x4>;
> > +            #reset-cells = <1>;
> > +        };
> > +
> > +        lpc_snoop: lpc-snoop at 90 {
> > +            compatible = "aspeed,ast2600-lpc-snoop";
> > +            reg = <0x90 0x8>;
> > +            interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
> > +            snoop-ports = <0x80>;
> > +        };
> > +    };
> > --
> > 2.17.1
> >
