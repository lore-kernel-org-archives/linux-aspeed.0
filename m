From: Eddie James <eajames@linux.ibm.com>
Date: Fri, 26 Apr 2024 09:49:27 -0500
Subject: [PATCH v3 01/14] dt-bindings: spi: Document the IBM Power SPI
 controller
In-Reply-To: <e2b52bfb-0742-4baf-8269-86075b5cc54e@kernel.org>
References: <20240425213701.655540-1-eajames@linux.ibm.com>
 <20240425213701.655540-2-eajames@linux.ibm.com>
 <e2b52bfb-0742-4baf-8269-86075b5cc54e@kernel.org>
Message-ID: <f1c3947c-e1c8-4dac-bbf7-e9c0dc9c27e9@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On 4/26/24 01:15, Krzysztof Kozlowski wrote:
> On 25/04/2024 23:36, Eddie James wrote:
>> The IBM Power chips have a basic SPI controller. Document it.
> Please use subject prefixes matching the subsystem. You can get them for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching.


Isn't spi the right subsystem here?


>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>> ---
>>   .../devicetree/bindings/spi/ibm,p10-spi.yaml  | 56 +++++++++++++++++++
>>   1 file changed, 56 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/spi/ibm,p10-spi.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/spi/ibm,p10-spi.yaml b/Documentation/devicetree/bindings/spi/ibm,p10-spi.yaml
>> new file mode 100644
>> index 000000000000..9bf57b621c1f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/spi/ibm,p10-spi.yaml
>> @@ -0,0 +1,56 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/spi/ibm,p10-spi.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: IBM SPI Controller
> IBM P10 SPI Controller


Ack.


>
>> +
>> +maintainers:
>> +  - Eddie James <eajames@linux.ibm.com>
>> +
>> +description:
>> +  A basic SPI controller found on IBM Power chips, accessed over FSI. This
>> +  node will always be a child node of an ibm,fsi2spi node.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - ibm,p10-spi
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +allOf:
>> +  - $ref: spi-controller.yaml#
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    fsi2spi at 1c00 {
>> +        compatible = "ibm,fsi2spi";
>> +        reg = <0x1c00 0x400>;
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
> Use rather some simple wrapper instead of node causing warnings, e.g.
> fsi {} with only address/size cells.


Will do, thanks.


>
>
>
> Best regards,
> Krzysztof
>
