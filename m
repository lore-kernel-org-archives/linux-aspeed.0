From: Eddie James <eajames@linux.ibm.com>
Date: Fri, 26 Apr 2024 10:00:31 -0500
Subject: [PATCH v3 03/14] dt-bindings: fsi: Document the FSI2PIB engine
In-Reply-To: <3f822b56-8e6a-43e4-afb0-15c964f9474e@kernel.org>
References: <20240425213701.655540-1-eajames@linux.ibm.com>
 <20240425213701.655540-4-eajames@linux.ibm.com>
 <3f822b56-8e6a-43e4-afb0-15c964f9474e@kernel.org>
Message-ID: <b89d39d2-ec54-4a88-aee5-7b5c95b3fca7@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On 4/26/24 01:18, Krzysztof Kozlowski wrote:
> On 25/04/2024 23:36, Eddie James wrote:
>> The FSI2PIB or SCOM engine provides an interface to the POWER processor
>> PIB (Pervasive Interconnect Bus).
>>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>> ---
>>   .../devicetree/bindings/fsi/ibm,fsi2pib.yaml  | 38 +++++++++++++++++++
>>   1 file changed, 38 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/fsi/ibm,fsi2pib.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/fsi/ibm,fsi2pib.yaml b/Documentation/devicetree/bindings/fsi/ibm,fsi2pib.yaml
>> new file mode 100644
>> index 000000000000..4d557150c2e3
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/fsi/ibm,fsi2pib.yaml
>> @@ -0,0 +1,38 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/fsi/ibm,fsi2pib.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: IBM FSI-attached SCOM engine
>> +
>> +maintainers:
>> +  - Eddie James <eajames@linux.ibm.com>
>> +
>> +description:
>> +  The SCOM engine is an interface to the POWER processor PIB (Pervasive
>> +  Interconnect Bus). This node will always be a child of an FSI CFAM node;
>> +  see fsi.txt for details on FSI slave and CFAM nodes.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - ibm,fsi2pib
>> +      - ibm,i2cr-scom
> Sometimes you call these p9, sometimes p10... what is the system or SoC
> here? Aren't you adding some generic compatibles? writing-bindings and
> numerous guides are clear on that.


Open source FSI support started with P9 chips so we initially added 
p9-sbefifo, p9-occ, etc. P10 has all of the same engines as P9 plus the 
SPI controller, so that's why SPI is p10-spi. P11 has the same engines 
as P10. For scom/fsi2pib we could call it p9-scom I suppose... This 
series isn't just documentation for a new system, I'm adding 
documentation that should have been added for P9. Anyway I'm not sure 
what you mean about generic compatibles? You mean just add a "scom" or 
"fsi2pib" compatible? writing-bindings says "DO make 'compatible' 
properties specific"


Thanks,

Eddie


>
> Best regards,
> Krzysztof
>
