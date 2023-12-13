From: Ninad Palsule <ninad@linux.ibm.com>
Date: Wed, 13 Dec 2023 12:36:48 -0600
Subject: [PATCH v1 1/8] dt-bindings: arm: aspeed: add IBM system1-bmc
In-Reply-To: <CXNEVH8BZUJT.1UHVUI66SZMTE@suppilovahvero>
References: <20231212164004.1683589-1-ninad@linux.ibm.com>
 <20231212164004.1683589-2-ninad@linux.ibm.com>
 <CXNEVH8BZUJT.1UHVUI66SZMTE@suppilovahvero>
Message-ID: <6e1a7f5d-c15f-4938-893b-0aa77ef9fcfc@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Jarkko,

On 12/13/23 12:18, Jarkko Sakkinen wrote:
> On Tue Dec 12, 2023 at 6:39 PM EET, Ninad Palsule wrote:
>> Document the new compatibles used on IBM system1-bmc
>>
>> Tested:
> this not very useful line :-) (nit)
>
>>      This board is tested using the simics simulator.
> Just leave this (w/o indentation)

Based on Conor's suggestion, I have removed both lines.

Thanks for the review.

Thanks & Regards,

Ninad

>
>> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
>> ---
>>   Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
>>   Documentation/devicetree/bindings/trivial-devices.yaml   | 2 ++
>>   2 files changed, 3 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
>> index 6f7543463d89..ebebe14c42aa 100644
>> --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
>> +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
>> @@ -85,6 +85,7 @@ properties:
>>                 - facebook,yosemite4-bmc
>>                 - ibm,everest-bmc
>>                 - ibm,rainier-bmc
>> +              - ibm,system1-bmc
>>                 - ibm,tacoma-bmc
>>                 - inventec,starscream-bmc
>>                 - inventec,transformer-bmc
>> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
>> index 441b55723675..b12a60d2eb0f 100644
>> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
>> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
>> @@ -135,6 +135,8 @@ properties:
>>             - ibm,cffps1
>>               # IBM Common Form Factor Power Supply Versions 2
>>             - ibm,cffps2
>> +            # Infineon barometric pressure and temperature sensor
>> +          - infineon,dps310
>>               # Infineon IR36021 digital POL buck controller
>>             - infineon,ir36021
>>               # Infineon IR38060 Voltage Regulator
> BR, Jarkko
