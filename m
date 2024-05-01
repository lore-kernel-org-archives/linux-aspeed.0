From: Eddie James <eajames@linux.ibm.com>
Date: Wed, 1 May 2024 11:16:22 -0500
Subject: [PATCH v4 10/17] dt-bindings: i2c: i2c-fsi: Convert to
 json-schema
In-Reply-To: <bbf12675-e0f5-4150-96d1-097eb7abd81a@kernel.org>
References: <20240429210131.373487-1-eajames@linux.ibm.com>
 <20240429210131.373487-11-eajames@linux.ibm.com>
 <bbf12675-e0f5-4150-96d1-097eb7abd81a@kernel.org>
Message-ID: <1ebaaa48-9812-467e-9189-c1cd3369b6cb@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On 4/30/24 02:35, Krzysztof Kozlowski wrote:
> On 29/04/2024 23:01, Eddie James wrote:
>> Convert to json-schema for the FSI-attached I2C controller.
>>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>> ---
>> Changes since v3:
>>   - Update MAINTAINERS
>>   - Change commit message to match similar commits
>>
>>   .../devicetree/bindings/i2c/i2c-fsi.txt       | 40 -------------
>>   .../devicetree/bindings/i2c/ibm,i2c-fsi.yaml  | 58 +++++++++++++++++++
>
> Please split independent patches to separate patchsets, so they can be
> reviewed and picked up by respective maintainers.
>
> I don't see any dependency here. Neither in 1st patch.


OK, I guess that makes it complicated for Andrew to pull together with 
the device tree changes in a way that avoids warnings, but I agree there 
is no direct dependency.


>
>
>>   MAINTAINERS                                   |  2 +-
>>   3 files changed, 59 insertions(+), 41 deletions(-)
>>   delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-fsi.txt
>>   create mode 100644 Documentation/devicetree/bindings/i2c/ibm,i2c-fsi.yaml
>>
> ...
>
>> diff --git a/Documentation/devicetree/bindings/i2c/ibm,i2c-fsi.yaml b/Documentation/devicetree/bindings/i2c/ibm,i2c-fsi.yaml
>> new file mode 100644
>> index 000000000000..8ff5585a3aa5
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/i2c/ibm,i2c-fsi.yaml
>> @@ -0,0 +1,58 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/i2c/ibm,i2c-fsi.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: IBM FSI-attached I2C controller
>> +
>> +maintainers:
>> +  - Eddie James <eajames@linux.ibm.com>
>> +
>> +description:
>> +  This I2C controller is an FSI CFAM engine, providing access to a number of
>> +  I2C busses. Therefore this node will always be a child of an FSI CFAM node.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - ibm,i2c-fsi
>> +
>> +  reg:
>> +    items:
>> +      - description: FSI slave address
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +allOf:
>> +  - $ref: /schemas/i2c/i2c-controller.yaml#
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    i2c at 1800 {
>> +        compatible = "ibm,i2c-fsi";
>> +        reg = <0x1800 0x400>;
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        i2c-bus at 0 {
>> +            reg = <0>;
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
> This does not look right. Why do you have multiple i2c-bus children? I
> do not think i2c-controller.yaml schema allows this.


It does seem to allow it, as this validates here and in the device tree. 
It is this way because the I2C controller provides multiple busses. 
Should I change it so to add "bus" pattern properties that reference 
i2c-controller.yaml?


Thanks,

Eddie


>
> Best regards,
> Krzysztof
>
