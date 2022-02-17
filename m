From: Cédric Le Goater <clg@kaod.org>
Date: Thu, 17 Feb 2022 09:37:02 +0100
Subject: [PATCH 02/10] dt-bindings: spi: Add Aspeed SMC controllers device
 tree binding
In-Reply-To: <YgwV5ZGCbrNhlk0s@robh.at.kernel.org>
References: <20220214094231.3753686-1-clg@kaod.org>
 <20220214094231.3753686-3-clg@kaod.org> <YgwV5ZGCbrNhlk0s@robh.at.kernel.org>
Message-ID: <a77fe4bb-c4d6-4329-b25e-26e990e8092b@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 2/15/22 22:06, Rob Herring wrote:
> On Mon, Feb 14, 2022 at 10:42:23AM +0100, C?dric Le Goater wrote:
>> The "interrupt" property is optional because it is only necessary for
>> controllers supporting DMAs (Not implemented yet in the new driver).
>>
>> Cc: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
>> Signed-off-by: C?dric Le Goater <clg@kaod.org>
>> ---
>>   .../bindings/spi/aspeed,ast2600-fmc.yaml      | 92 +++++++++++++++++++
>>   1 file changed, 92 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml b/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
>> new file mode 100644
>> index 000000000000..ed71c4d86930
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
>> @@ -0,0 +1,92 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/spi/aspeed,ast2600-fmc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Aspeed SMC controllers bindings
>> +
>> +maintainers:
>> +  - Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
>> +  - C?dric Le Goater <clg@kaod.org>
>> +
>> +description: |
>> +  This binding describes the Aspeed Static Memory Controllers (FMC and
>> +  SPI) of the AST2400, AST2500 and AST2600 SOCs.
>> +
>> +allOf:
>> +  - $ref: "spi-controller.yaml#"
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - aspeed,ast2600-fmc
>> +      - aspeed,ast2600-spi
>> +      - aspeed,ast2500-fmc
>> +      - aspeed,ast2500-spi
>> +      - aspeed,ast2400-fmc
>> +      - aspeed,ast2400-spi
>> +
>> +  reg:
>> +    items:
>> +      - description: registers
>> +      - description: memory mapping
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +patternProperties:
>> +  "@[0-9a-f]+":
>> +    type: object
>> +
>> +    properties:
>> +      spi-rx-bus-width:
>> +        enum: [1, 2, 4]
>> +
>> +    required:
>> +      - reg
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/interrupt-controller/aspeed-scu-ic.h>
>> +    #include <dt-bindings/clock/ast2600-clock.h>
>> +
>> +    spi at 1e620000 {
>> +        reg = < 0x1e620000 0xc4
>> +                0x20000000 0x10000000 >;
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +        compatible = "aspeed,ast2600-fmc";
>> +        clocks = <&syscon ASPEED_CLK_AHB>;
>> +        status = "disabled";
> 
> Why is your example disabled? Drop 'status'.

my bad. I took the basic definition of the SoC and the devices
are activated in the boards. I will fix in v2.

Thanks,

C.


> 
>> +        interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
>> +        flash at 0 {
>> +                reg = < 0 >;
>> +                compatible = "jedec,spi-nor";
>> +                spi-max-frequency = <50000000>;
>> +                status = "disabled";
> 
> Ditto.
> 
>> +        };
>> +        flash at 1 {
>> +                reg = < 1 >;
>> +                compatible = "jedec,spi-nor";
>> +                spi-max-frequency = <50000000>;
>> +                status = "disabled";
>> +        };
>> +        flash at 2 {
>> +                reg = < 2 >;
>> +                compatible = "jedec,spi-nor";
>> +                spi-max-frequency = <50000000>;
>> +                status = "disabled";
>> +        };
>> +    };
>> -- 
>> 2.34.1
>>
>>

