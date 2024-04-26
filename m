From: Eddie James <eajames@linux.ibm.com>
Date: Fri, 26 Apr 2024 10:09:34 -0500
Subject: [PATCH v3 05/14] dt-bindings: fsi: Document the IBM SBEFIFO
 engine
In-Reply-To: <5fb62fcf-36a8-4efa-9387-d0af8fcafb18@kernel.org>
References: <20240425213701.655540-1-eajames@linux.ibm.com>
 <20240425213701.655540-6-eajames@linux.ibm.com>
 <5fb62fcf-36a8-4efa-9387-d0af8fcafb18@kernel.org>
Message-ID: <47c8fd94-6137-4d84-99a9-e8ff86c6dc31@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On 4/26/24 01:20, Krzysztof Kozlowski wrote:
> On 25/04/2024 23:36, Eddie James wrote:
>> The SBEFIFO engine provides an interface to the POWER processor
>> Self Boot Engine (SBE).
>>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>> Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>
>> ---
>
>> +description:
>> +  The SBEFIFO is an FSI CFAM engine that provides an interface to the
>> +  POWER processor Self Boot Engine (SBE). This node will always be a child
>> +  of an FSI CFAM node; see fsi.txt for details on FSI slave and CFAM
>> +  nodes.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - ibm,p9-sbefifo
>> +      - ibm,odyssey-sbefifo
>> +
>> +  reg:
>> +    items:
>> +      - description: FSI slave address
>> +
>> +  "#address-cells":
>> +    const: 1
>> +
>> +  "#size-cells":
>> +    const: 0
>> +
>> +patternProperties:
>> +  "^occ(@.*)?":
> Why unit address is optional?


In this case, it's because we use the reg property (reflecting the unit 
address) to indicate the processor index of the occ node. However I 
think I should drop the unit address here, it's meaningless, there is no 
addressing for the OCC from the SBEFIFO.


>
>
>
> Best regards,
> Krzysztof
>
