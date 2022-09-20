From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 20 Sep 2022 10:24:36 +0200
Subject: [PATCH] greatlakes: dts: Add Facebook greatlakes (AST2600) BMC
In-Reply-To: <HK0PR04MB3105F759F43FEDE24C24FB3AF84C9@HK0PR04MB3105.apcprd04.prod.outlook.com>
References: <20220915072304.1438-1-Bonnie_Lo@Wiwynn.com>
 <10176630-3ff7-54f7-8836-779e5a2bf6d4@linaro.org>
 <HK0PR04MB3105F759F43FEDE24C24FB3AF84C9@HK0PR04MB3105.apcprd04.prod.outlook.com>
Message-ID: <61de4c6c-84e9-345a-495d-4d44d9351d84@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 20/09/2022 09:45, Bonnie Lo/WYHQ/Wiwynn wrote:
> Hi Krzysztof,
> 
> I revise the device tree as following and resend the mail.
> It create a new mail thread " [PATCH] ARM: dts: aspeed: greatlakes: Add Facebook greatlakes (AST2600) BMC".
> Kindly to correct me, if there is any problem.
> 
>> Use subject prefixes matching the subsystem (git log --oneline -- ...).
>>
>>>
>>> Add linux device tree entry related to greatlakes specific devices
>>> connected to BMC SoC.
>>
>> Please wrap commit message according to Linux coding style / submission
>> process:
>> https://apc01.safelinks.protection.outlook.com/?url=https%3A%2F%2Felixir.b
>> ootlin.com%2Flinux%2Fv5.18-rc4%2Fsource%2FDocumentation%2Fprocess%2
>> Fsubmitting-patches.rst%23L586&amp;data=05%7C01%7CBonnie_Lo%40wiw
>> ynn.com%7C1dee8dcb540a49522fb608da98cdba6f%7Cda6e0628fc834caf9dd
>> 273061cbab167%7C0%7C0%7C637990306620286314%7CUnknown%7CTWFp
>> bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI
>> 6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=mC2E3dJbuYgXklS%2Fw8s2w%2
>> BKH%2BZ3CsZSndFTgPBjyvpw%3D&amp;reserved=0
>>
> 
> I have add " ARM: dts: aspeed: greatlakes:".
> 
>>>
>>> Signed-off-by: Bonnie Lo <Bonnie_Lo@wiwynn.com>
>>> ---
>>>  arch/arm/boot/dts/Makefile                    |   1 +
>>>  .../dts/aspeed-bmc-facebook-greatlakes.dts    | 248
>> ++++++++++++++++++
>>
>> Missing documentation of board compatible (bindings) as first patch.

Why did you ignore it?

>>
>>>  2 files changed, 249 insertions(+)
>>>  create mode 100644
>>> arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts
>>>
>>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>>> index 05d8aef6e5d2..40fa906ab17f 100644
>>> --- a/arch/arm/boot/dts/Makefile
>>> +++ b/arch/arm/boot/dts/Makefile
>>> @@ -1580,6 +1580,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>>>         aspeed-bmc-asrock-e3c246d4i.dtb \
>>>         aspeed-bmc-asrock-romed8hm3.dtb \
>>>         aspeed-bmc-bytedance-g220a.dtb \
>>> +       aspeed-bmc-facebook-greatlakes.dtb \
>>
>> Wrong order.
> 
> I have reordered it.
> 
>>
>>>         aspeed-bmc-facebook-bletchley.dtb \
>>>         aspeed-bmc-facebook-cloudripper.dtb \
>>>         aspeed-bmc-facebook-cmm.dtb \
>>> diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts
>>> b/arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts
>>> new file mode 100644
>>> index 000000000000..f011cc4d370f
>>> --- /dev/null
>>> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts
>>> @@ -0,0 +1,248 @@
>>> +// SPDX-License-Identifier: GPL-2.0-or-later // Copyright 2022
>>> +Facebook Inc.
>>> +
>>> +/dts-v1/;
>>> +#include "aspeed-g6.dtsi"
>>> +#include <dt-bindings/gpio/aspeed-gpio.h> #include
>>> +<dt-bindings/i2c/i2c.h> #include <dt-bindings/leds/leds-pca955x.h>
>>> +
>>> +/ {
>>> +       model = "AST2600 EVB";
>>
>> Wrong name.
> 
> I have revies the model name " Facebook Greatlakes BMC ".
> 
>>
>>> +       compatible = "aspeed,ast2600";
>>
>> Missing board compatible.
>>
> 
> I add board compatible " facebook,greatlakes-bmc"

And what is the output of the checkpatch?

> 
>>> +
>>> +       aliases {
>>> +               serial4 = &uart5;
>>> +       };
>>> +
>>> +       chosen {
>>> +               stdout-path = &uart5;
>>> +               bootargs = "console=ttyS4,57600n8 root=/dev/ram rw
>>> + vmalloc=384M";
>>
>> Bootargs usually do not belong to mainline DTS.
> 
> Removed.

I still saw bootargs.

(...)

>>>
>>> WIWYNN PROPRIETARY This email (and any attachments) contains
>> proprietary or confidential information and is for the sole use of its intended
>> recipient. Any unauthorized review, use, copying or distribution of this email
>> or the content of this email is strictly prohibited. If you are not the intended
>> recipient, please notify the sender and delete this email immediately.
>>
>> This means we cannot take this patch. Proprietary and/or confidential
>> patches cannot be merged.
>>
>> Please license the patch as you wrote in SPDX header.
>>
>> Best regards,
>> Krzysztof
> WIWYNN PROPRIETARY
> This email (and any attachments) contains proprietary or confidential information and is for the sole use of its intended recipient. Any unauthorized review, use, copying or distribution of this email or the content of this email is strictly prohibited. If you are not the intended recipient, please notify the sender and delete this email immediately.

Your company is still adding proprietary license. Since I am not
intended recipient, I will remove your messages.

Best regards,
Krzysztof
