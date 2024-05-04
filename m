From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sat, 4 May 2024 13:50:22 +0200
Subject: [PATCH v4 04/17] dt-bindings: fsi: p9-occ: Convert to json-schema
In-Reply-To: <e3601656-84d3-47e1-9cbd-d2cb0dde5f51@linux.ibm.com>
References: <20240429210131.373487-1-eajames@linux.ibm.com>
 <20240429210131.373487-5-eajames@linux.ibm.com>
 <0fcadbe6-7615-498e-89c0-e3b072c4828c@kernel.org>
 <e3601656-84d3-47e1-9cbd-d2cb0dde5f51@linux.ibm.com>
Message-ID: <e98ade57-0646-49d4-8b41-ab6f936bb1f0@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 01/05/2024 17:59, Eddie James wrote:
> 
> On 4/30/24 01:53, Krzysztof Kozlowski wrote:
>> On 29/04/2024 23:01, Eddie James wrote:
>>> Conver to json-schema for the OCC documentation. Also document the fact
>>> that the OCC "bridge" device will often have the hwmon node as a
>>> child.
>>>
>>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>>> ---
>>> Changes since v3:
>>>   - Move required below other properties
>>>   - Drop "occ-" in child node
>>>   - Drop hwmon unit address
>>>   - Complete example
>>>   - Change commit message to match similar commits
>>>
>>>   .../devicetree/bindings/fsi/ibm,p9-occ.txt    | 16 --------
>>>   .../devicetree/bindings/fsi/ibm,p9-occ.yaml   | 41 +++++++++++++++++++
>>>   2 files changed, 41 insertions(+), 16 deletions(-)
>>>   delete mode 100644 Documentation/devicetree/bindings/fsi/ibm,p9-occ.txt
>>>   create mode 100644 Documentation/devicetree/bindings/fsi/ibm,p9-occ.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/fsi/ibm,p9-occ.txt b/Documentation/devicetree/bindings/fsi/ibm,p9-occ.txt
>>> deleted file mode 100644
>>> index e73358075a90..000000000000
>>> --- a/Documentation/devicetree/bindings/fsi/ibm,p9-occ.txt
>>> +++ /dev/null
>>> @@ -1,16 +0,0 @@
>>> -Device-tree bindings for FSI-attached POWER9/POWER10 On-Chip Controller (OCC)
>>> ------------------------------------------------------------------------------
>>> -
>>> -This is the binding for the P9 or P10 On-Chip Controller accessed over FSI from
>>> -a service processor. See fsi.txt for details on bindings for FSI slave and CFAM
>>> -nodes. The OCC is not an FSI slave device itself, rather it is accessed
>>> -through the SBE FIFO.
>>> -
>>> -Required properties:
>>> - - compatible = "ibm,p9-occ" or "ibm,p10-occ"
>>> -
>>> -Examples:
>>> -
>>> -    occ {
>>> -        compatible = "ibm,p9-occ";
>>> -    };
>>> diff --git a/Documentation/devicetree/bindings/fsi/ibm,p9-occ.yaml b/Documentation/devicetree/bindings/fsi/ibm,p9-occ.yaml
>>> new file mode 100644
>>> index 000000000000..3ab2582cb8a0
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/fsi/ibm,p9-occ.yaml
>>> @@ -0,0 +1,41 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/fsi/ibm,p9-occ.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: IBM FSI-attached On-Chip Controller (OCC)
>>> +
>>> +maintainers:
>>> +  - Eddie James <eajames@linux.ibm.com>
>>> +
>>> +description:
>>> +  The POWER processor On-Chip Controller (OCC) helps manage power and
>>> +  thermals for the system, accessed through the FSI-attached SBEFIFO
>>> +  from a service processor.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - ibm,p9-occ
>>> +      - ibm,p10-occ
>>> +
>>> +patternProperties:
>>> +  "^hwmon":
>> And now it raises questions:
>> 1. Other devices on FSI bus have unit addresses, so why this does not?
>> 2. This suggest only one hwmon, so ^hwmon$, which is then not a
>> patternProperty but property.
>> 3. But the true problem why do you even need two empty nodes? These
>> should be combined into one node.
> 
> 
> 1. This is not truly on the FSI bus. It is on the SBEFIFO "bus"
> 
> 2. True enough, I'll change it to property.
> 
> 3. If this binding was being designed now, I'd agree with you, but the 
> two nodes (occ and occ-hwmon) are already documented, I'm just changing 
> to yaml here... Changing that would require a lot of changes and would 
> break the two drivers.

No child was documented before and documenting things post-factum does
not allow to bypass regular review rules.

Best regards,
Krzysztof

