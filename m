From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Wed, 7 Apr 2021 16:42:04 +0700
Subject: [PATCH v2 1/4] dt-bindings: mfd: Add bindings for Ampere Altra
 SMPro drivers
In-Reply-To: <20210330211443.GA326528@robh.at.kernel.org>
References: <20210329015238.19474-1-quan@os.amperecomputing.com>
 <20210329015238.19474-2-quan@os.amperecomputing.com>
 <20210330211443.GA326528@robh.at.kernel.org>
Message-ID: <29f5f458-5694-aa70-ea90-2bb239e825b6@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Rob,
Thank you for reviewing

On 31/03/2021 04:14, Rob Herring wrote:
> On Mon, Mar 29, 2021 at 08:52:35AM +0700, Quan Nguyen wrote:
>> Adds device tree bindings for SMPro drivers found on the Mt.Jade hardware
>> reference platform with Ampere's Altra Processor family.
>>
>> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
>> ---
>>   .../bindings/hwmon/ampere,ac01-hwmon.yaml     | 27 ++++++
>>   .../devicetree/bindings/mfd/ampere,smpro.yaml | 82 +++++++++++++++++++
>>   2 files changed, 109 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/hwmon/ampere,ac01-hwmon.yaml
>>   create mode 100644 Documentation/devicetree/bindings/mfd/ampere,smpro.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/hwmon/ampere,ac01-hwmon.yaml b/Documentation/devicetree/bindings/hwmon/ampere,ac01-hwmon.yaml
>> new file mode 100644
>> index 000000000000..015130a281f4
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/hwmon/ampere,ac01-hwmon.yaml
>> @@ -0,0 +1,27 @@
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
>> +
>> +additionalProperties: false
>> diff --git a/Documentation/devicetree/bindings/mfd/ampere,smpro.yaml b/Documentation/devicetree/bindings/mfd/ampere,smpro.yaml
>> new file mode 100644
>> index 000000000000..bf789c8a3d7d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mfd/ampere,smpro.yaml
>> @@ -0,0 +1,82 @@
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
>> +    const: ampere,smpro
> 
> Only 1 version of SMPro? Needs to be more specific or provide details on
> how the exact version of firmware/hardware is discovered.
> 
Will change to enum in next version.

     enum:
       - ampere,smpro

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
>> +    type: object
>> +    description: Ampere Altra SMPro Misc driver
> 
> Bindings describe h/w, not drivers.
>
Will fix in next version

>> +    properties:
>> +      compatible:
>> +        const: "ampere,ac01-misc"
>> +
>> +  "^errmon(@[0-9a-f]+)?$":
>> +    type: object
>> +    description: Ampere Altra SMPro Error Monitor driver
>> +    properties:
>> +      compatible:
>> +        const: "ampere,ac01-errmon"
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
>> +            hwmon {
>> +                compatible = "ampere,ac01-hwmon";
>> +            };
>> +
>> +            misc {
>> +                compatible = "ampere,ac01-misc";
>> +            };
>> +
>> +            errmon {
>> +                compatible = "ampere,ac01-errmon";
>> +            };
> 
> None of the child nodes have any resources in DT, so you don't need
> them in DT.
> 
> Rob
> 

The intention was to re-use the drivers/mfd/simple-mfd-i2c.c and dont 
want to add extra codes to this driver just to instantiate these 
children. So for this case, the child drivers will not be instantiated 
if there are no child nodes in DT.

One solution I have in mind is to introduce resource (reg offset) for 
each child drivers.

-Quan
