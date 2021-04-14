From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Wed, 14 Apr 2021 15:28:25 +0700
Subject: [PATCH v3 1/4] dt-bindings: mfd: Add bindings for Ampere Altra
 SMPro drivers
In-Reply-To: <20210413134906.GA1538655@robh.at.kernel.org>
References: <20210409031332.21919-1-quan@os.amperecomputing.com>
 <20210409031332.21919-2-quan@os.amperecomputing.com>
 <20210413134906.GA1538655@robh.at.kernel.org>
Message-ID: <8eb27308-03e3-1a90-28a3-d8b3ad720cc4@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 13/04/2021 20:49, Rob Herring wrote:
> On Fri, Apr 09, 2021 at 10:13:29AM +0700, Quan Nguyen wrote:
>> Adds device tree bindings for SMPro drivers found on the Mt.Jade hardware
>> reference platform with Ampere's Altra Processor family.
>>
>> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
>> ---
>>   .../bindings/hwmon/ampere,ac01-hwmon.yaml     |  28 +++++
>>   .../devicetree/bindings/mfd/ampere,smpro.yaml | 105 ++++++++++++++++++
>>   2 files changed, 133 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/hwmon/ampere,ac01-hwmon.yaml
>>   create mode 100644 Documentation/devicetree/bindings/mfd/ampere,smpro.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/hwmon/ampere,ac01-hwmon.yaml b/Documentation/devicetree/bindings/hwmon/ampere,ac01-hwmon.yaml
>> new file mode 100644
>> index 000000000000..fbf7ec754160
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/hwmon/ampere,ac01-hwmon.yaml
>> @@ -0,0 +1,28 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/hwmon/ampere,ac01-hwmon.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Hardware monitoring driver for the Ampere Altra SMPro
>> +
>> +maintainers:
>> +  - Quan Nguyen <quan@os.amperecomputing.com>
>> +
>> +description: |
>> +  This module is part of the Ampere Altra SMPro multi-function device. For more
>> +  details see ../mfd/ampere,smpro.yaml.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - ampere,ac01-hwmon
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +additionalProperties: false
>> diff --git a/Documentation/devicetree/bindings/mfd/ampere,smpro.yaml b/Documentation/devicetree/bindings/mfd/ampere,smpro.yaml
>> new file mode 100644
>> index 000000000000..5613c420869e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mfd/ampere,smpro.yaml
>> @@ -0,0 +1,105 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/mfd/ampere,smpro.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Ampere Altra SMPro firmware driver
>> +
>> +maintainers:
>> +  - Quan Nguyen <quan@os.amperecomputing.com>
>> +
>> +description: |
>> +  Ampere Altra SMPro firmware may contain different blocks like hardware
>> +  monitoring, error monitoring and other miscellaneous features.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - ampere,smpro
> 
> Again, not very specific. There's only 1 version of 'smpro' h/w or
> firmware? Are the firmware version and features discoverable? If not,
> you need to be more specific (or better yet, make them discoverable).
> 
Hi Rob,

So far, there's nothing to guarantee this is the only version of SMPro 
and neither firmware version nor features that are discoverable.

In fact, it was "ampere,ac01-smpro" specifically in my v1. But this is 
the "ampere,smpro" in arch/arm/boot/dts/nuvoton-npcm730-kudo.dts, that 
is why it got changed to "ampere,smpro" to avoid changes in that dts file.

I'm thinking about change it back to "ampere,ac01-smpro" in next version 
to make this compatible string more specific.

>> +
>> +  reg:
>> +    description:
>> +      I2C device address.
>> +    maxItems: 1
>> +
>> +  "#address-cells":
>> +    const: 1
>> +
>> +  "#size-cells":
>> +    const: 0
>> +
>> +patternProperties:
>> +  "^hwmon(@[0-9a-f]+)?$":
>> +    $ref: ../hwmon/ampere,ac01-hwmon.yaml
>> +
>> +  "^misc(@[0-9a-f]+)?$":
> 
> You don't need these child nodes in DT if there are no resources
> associated with them. The parent driver can instantiate all the
> sub-functions.
> 

 From v3, there is a "reg" property introduced for the child driver, 
especially for the misc driver. This is unavoidable because other 
properties might be introduced in future for other misc features.

>> +    type: object
>> +    description: |
>> +      This module is part of the Ampere Altra SMPro multi-function device
>> +      to support miscellaneous features
>> +    properties:
>> +      compatible:
>> +        enum:
>> +          - ampere,ac01-misc
>> +      reg:
>> +        maxItems: 1
>> +
>> +    required:
>> +      - compatible
>> +      - reg
>> +
>> +  "^errmon(@[0-9a-f]+)?$":
>> +    type: object
>> +    description: |
>> +      This module is part of the Ampere Altra SMPro multi-function device
>> +      that supports error monitoring feature.
>> +
>> +    properties:
>> +      compatible:
>> +        enum:
>> +          - ampere,ac01-errmon
>> +      reg:
>> +        maxItems: 1
>> +
>> +    required:
>> +      - compatible
>> +      - reg
>> +
>> +required:
>> +  - "#address-cells"
>> +  - "#size-cells"
>> +  - compatible
>> +  - reg
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    i2c {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        smpro at 4f {
>> +            compatible = "ampere,smpro";
>> +            reg = <0x4f>;
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +
>> +            hwmon at 10 {
>> +                compatible = "ampere,ac01-hwmon";
>> +                reg = <0x10>;
>> +            };
>> +
>> +            misc at b0 {
>> +                compatible = "ampere,ac01-misc";
>> +                reg = <0xb0>;
>> +            };
>> +
>> +            errmon at 80 {
>> +                compatible = "ampere,ac01-errmon";
>> +                reg = <0x80>;
>> +            };
>> +
>> +        };
>> +    };
>> -- 
>> 2.28.0
>>

