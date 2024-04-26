From: Eddie James <eajames@linux.ibm.com>
Date: Fri, 26 Apr 2024 10:05:50 -0500
Subject: [PATCH v3 04/14] dt-bindings: fsi: p9-occ: Switch to yaml format
In-Reply-To: <d5e79c40-d961-43a9-ad4c-ebed17dfe814@kernel.org>
References: <20240425213701.655540-1-eajames@linux.ibm.com>
 <20240425213701.655540-5-eajames@linux.ibm.com>
 <d5e79c40-d961-43a9-ad4c-ebed17dfe814@kernel.org>
Message-ID: <9a480ab1-242f-4577-bb86-4fe5f4434c26@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On 4/26/24 01:19, Krzysztof Kozlowski wrote:
> On 25/04/2024 23:36, Eddie James wrote:
>> Switch to yaml for the OCC documentation. Also document the fact
>> that the OCC "bridge" device will often have the hwmon node as a
>> child.
>>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>> ---
>>   .../devicetree/bindings/fsi/ibm,p9-occ.txt    | 16 --------
>>   .../devicetree/bindings/fsi/ibm,p9-occ.yaml   | 41 +++++++++++++++++++
>>   2 files changed, 41 insertions(+), 16 deletions(-)
>>   delete mode 100644 Documentation/devicetree/bindings/fsi/ibm,p9-occ.txt
>>   create mode 100644 Documentation/devicetree/bindings/fsi/ibm,p9-occ.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/fsi/ibm,p9-occ.txt b/Documentation/devicetree/bindings/fsi/ibm,p9-occ.txt
>> deleted file mode 100644
>> index e73358075a90..000000000000
>> --- a/Documentation/devicetree/bindings/fsi/ibm,p9-occ.txt
>> +++ /dev/null
>> @@ -1,16 +0,0 @@
>> -Device-tree bindings for FSI-attached POWER9/POWER10 On-Chip Controller (OCC)
>> ------------------------------------------------------------------------------
>> -
>> -This is the binding for the P9 or P10 On-Chip Controller accessed over FSI from
>> -a service processor. See fsi.txt for details on bindings for FSI slave and CFAM
>> -nodes. The OCC is not an FSI slave device itself, rather it is accessed
>> -through the SBE FIFO.
>> -
>> -Required properties:
>> - - compatible = "ibm,p9-occ" or "ibm,p10-occ"
>> -
>> -Examples:
>> -
>> -    occ {
>> -        compatible = "ibm,p9-occ";
>> -    };
>> diff --git a/Documentation/devicetree/bindings/fsi/ibm,p9-occ.yaml b/Documentation/devicetree/bindings/fsi/ibm,p9-occ.yaml
>> new file mode 100644
>> index 000000000000..1fa87d452489
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/fsi/ibm,p9-occ.yaml
>> @@ -0,0 +1,41 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/fsi/ibm,p9-occ.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: IBM FSI-attached On-Chip Controller (OCC)
>> +
>> +maintainers:
>> +  - Eddie James <eajames@linux.ibm.com>
>> +
>> +description:
>> +  The POWER processor On-Chip Controller (OCC) helps manage power and
>> +  thermals for the system, accessed through the FSI-attached SBEFIFO
>> +  from a service processor.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - ibm,p9-occ
>> +      - ibm,p10-occ
>> +
>> +  reg:
>> +    items:
>> +      - description: Processor index
>> +
>> +required:
>> +  - compatible
> required goes after all properties, so below.


Ack.


>
>> +
>> +patternProperties:
>> +  "^occ-hwmon(@.*)?":
>> +    type: object
>> +    $ref: /schemas/hwmon/ibm,occ-hwmon.yaml
> Drop occ, not relevant. Why unit address is optional? This is supposed
> to be specific. Use proper regex as well for hex numbers.


Well, there isn't really any concept of address here, it's a 1-to-1 
relationship. I should just drop the unit address.


>
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    occ {
>> +        compatible = "ibm,p9-occ";
> Not complete.


Ack.


>
>
> Best regards,
> Krzysztof
>
