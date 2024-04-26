From: Eddie James <eajames@linux.ibm.com>
Date: Fri, 26 Apr 2024 10:19:54 -0500
Subject: [PATCH v3 09/14] dt-bindings: fsi: Document the FSI Hub
 Controller
In-Reply-To: <91d5683b-17a2-466c-ab3d-baf216c97fa3@kernel.org>
References: <20240425213701.655540-1-eajames@linux.ibm.com>
 <20240425213701.655540-10-eajames@linux.ibm.com>
 <91d5683b-17a2-466c-ab3d-baf216c97fa3@kernel.org>
Message-ID: <8d5cca29-2b4d-40a7-a7dd-c3eff625af95@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On 4/26/24 01:26, Krzysztof Kozlowski wrote:
> On 25/04/2024 23:36, Eddie James wrote:
>> Document the FSI Hub Controller CFAM engine.
>>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>> ---
>>   .../bindings/fsi/ibm,hub-fsi-controller.yaml  | 44 +++++++++++++++++++
>>   1 file changed, 44 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/fsi/ibm,hub-fsi-controller.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/fsi/ibm,hub-fsi-controller.yaml b/Documentation/devicetree/bindings/fsi/ibm,hub-fsi-controller.yaml
>> new file mode 100644
>> index 000000000000..d96d777d4d9f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/fsi/ibm,hub-fsi-controller.yaml
>> @@ -0,0 +1,44 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/fsi/ibm,hub-fsi-controller.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: IBM FSI-attached FSI Hub Controller
>> +
>> +maintainers:
>> +  - Eddie James <eajames@linux.ibm.com>
>> +
>> +description: |
> Do not need '|' unless you need to preserve formatting.


Ack.


>
>> +  The FSI Hub Controller is an FSI controller, providing a number of FSI links,
>> +  located on a CFAM. Therefore this node will always be a child of an FSI CFAM
>> +  node.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - ibm,hub-fsi-controller
> Again, is it for specific chip? SoC? Aren't you using generic
> compatibles (not allowed)?


This one is fairly universally supported on FSI (any POWER chip will 
have it) so I didn't add a specific chip... Should i? Do you mean 
generic compatibles are not allowed? How generic do you mean?


>
>
>
> Best regards,
> Krzysztof
>
