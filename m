From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Wed, 5 May 2021 15:44:04 +0700
Subject: [PATCH v4 1/4] dt-bindings: mfd: Add bindings for Ampere Altra
 SMPro drivers
In-Reply-To: <20210430201918.GA3806853@robh.at.kernel.org>
References: <20210422090843.4614-1-quan@os.amperecomputing.com>
 <20210422090843.4614-2-quan@os.amperecomputing.com>
 <20210430201918.GA3806853@robh.at.kernel.org>
Message-ID: <52550615-ae38-d88e-a597-29dc9c71755a@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 01/05/2021 03:19, Rob Herring wrote:
> On Thu, Apr 22, 2021 at 04:08:40PM +0700, Quan Nguyen wrote:
>> Adds device tree bindings for SMPro driver found on the Mt.Jade hardware
>> reference platform with Ampere's Altra Processor family.
>>
>> The SMpro co-processor on Ampere Altra processor family is to monitor
>> and report various data included hwmon-related info, RAS errors, and
>> other miscellaneous information. This parent SMPro MFD driver creates
>> a single simple register map to be shared by all sub-devices and leave
>> all the specific to be handled by the child drivers.
> 
> Again, just because you have multiple functions aka MFD, that doesn't
> mean you need child nodes for each function. The only thing you have
> in DT is a register address. Does this vary? If so, how often? How many
> different versions of a DT do you currently or expect to have?
> 
Hi Rob,

Thank you for your review.
I will try to explain what I think below and expect to receive more 
comments to improve these patches. And if any misundertood, please help 
correct me.

The idea is to keep the SMPro MFD as a simple generic register map and 
expect not to change or to handle any specific in this parent device 
driver. This is why we see the simple_mfd_i2c fit in this case.

And so, all the specific details will be handled in child devices driver 
and we expect to have child nodes for these child devices. If the child 
node exist we can then add any specific if necessary later.

One case is that, each socket (ie: the Ampere Altra processor) has it 
own SMPro co-processor instance in form of register map and each socket 
could be either slave or master. Some function may not available in 
slave socket but exist in master socket and we simply choose not to 
define the child node if that function not existed.

The other case is that if there are multi instances of the same function 
in one SMPro MFD register map, then each instance might need to be 
differentiated by using is own register address or maybe a DT property. 
Then we can simply add them to the node of these instance.

For your specific questions:

+ Does this vary ?
yes, I think so. The register address in each child nodes may vary if 
the SMPro co-processor firmware change its register map layout or maybe 
other instances of a function added. Child device drivers are expected 
to handle these changes if necessary.

+ About how often ?
I actually can't say how often but the purpose of this SMPro register 
map is to provide the info to the BMC. The BMC will need more info from 
the host so I think changes will be unavoidable.

Please help with your comments
Thank you,
- Quan

>>
>> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
>> ---
>> Changes in v4:
>>    + Revised the commit message to clarify how the specific info will
>>      be handled commented by Rob.
>>
>> Changes in v3:
>>    + Supported list of compatible string [Rob]
>>    + Introduced reg property in DT to specify reg offset [Rob]
>>    + Updated description and other minor changes in yaml file [Rob]
>>
>> Changes in v2:
>>    + Changed "ampere,ac01-smpro" to "ampere,smpro" [Quan]
>>
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

