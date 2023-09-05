From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 5 Sep 2023 12:38:31 +0200
Subject: [PATCH v4 1/2] ARM: dts: aspeed: Minerva: Add Facebook Minerva
 (AST2600) BMC
In-Reply-To: <18b78489-6a12-a09f-620d-985be747f9da@gmail.com>
References: <20230830090212.3880559-1-peteryin.openbmc@gmail.com>
 <20230830090212.3880559-2-peteryin.openbmc@gmail.com>
 <b9cbe9be-b03e-6c7a-d06c-b75b012b5b25@linaro.org>
 <18b78489-6a12-a09f-620d-985be747f9da@gmail.com>
Message-ID: <a0f0ab97-2333-542a-327f-f5711136b35a@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 05/09/2023 11:55, PeterYin wrote:
> 
> On 8/30/23 17:44, Krzysztof Kozlowski wrote:
>> On 30/08/2023 11:02, peteryin wrote:
>>> Add linux device tree entry related to
>>> Minerva specific devices connected to BMC SoC.
>>>
>>> Signed-off-by: peteryin <peteryin.openbmc@gmail.com>
>> To clarify: your full name or known identity is "peteryin"?
>>
>>> ---
>>>   arch/arm/boot/dts/Makefile                    |   1 +
>>>   .../boot/dts/aspeed-bmc-facebook-minerva.dts  | 385 ++++++++++++++++++
>>>   2 files changed, 386 insertions(+)
>>>   create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-minerva.dts
>>>
>>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>>> index 9e1d7bf3cff6..edb0b2105333 100644
>>> --- a/arch/arm/boot/dts/Makefile
>>> +++ b/arch/arm/boot/dts/Makefile
>>> @@ -1604,6 +1604,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>>>   	aspeed-bmc-facebook-wedge400.dtb \
>>>   	aspeed-bmc-facebook-yamp.dtb \
>>>   	aspeed-bmc-facebook-yosemitev2.dtb \
>>> +	aspeed-bmc-facebook-minerva.dtb \
>> Nothing improved here.
>>
>>>   	aspeed-bmc-ibm-bonnell.dtb \
>>>   	aspeed-bmc-ibm-everest.dtb \
>>>   	aspeed-bmc-ibm-rainier.dtb \
>>
>>> +	"","","","","","","","",
>>> +	/*O0-O3 line 224-231*/
>>> +	"","","","","","","","",
>>> +	/*O4-O7 line 232-239*/
>>> +	"","","","","","","","",
>>> +	/*P0-P3 line 240-247*/
>>> +	"","","","","","","","",
>>> +	/*P4-P7 line 248-255*/
>>> +	"","","","","","","","";
>>> +};
>>> +
>> Nor here.
>>
>> This is a friendly reminder during the review process.
>>
>> It seems my previous comments were not fully addressed. Maybe my
>> feedback got lost between the quotes, maybe you just forgot to apply it.
>> Please go back to the previous discussion and either implement all
>> requested changes or keep discussing them.
>>
> Could you please clarify for me?
> 
> Are you asking if the last line should not have a blank line, or I can't 
> set a comment for the sgpio line like this:

6 or 7 versions ago I said:
"Still redundant blank line."
so it is about stray blank line.

https://lore.kernel.org/all/9f499fe5-db59-f4c8-6a50-93725b7287fd at linaro.org/

Best regards,
Krzysztof

