From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 5 Oct 2022 17:02:46 +0200
Subject: [PATCH] greatlakes: dts: Add Facebook greatlakes (AST2600) BMC
In-Reply-To: <HK0PR04MB3105AE7BA97942C160A6939AF85D9@HK0PR04MB3105.apcprd04.prod.outlook.com>
References: <20220915072304.1438-1-Bonnie_Lo@Wiwynn.com>
 <10176630-3ff7-54f7-8836-779e5a2bf6d4@linaro.org>
 <HK0PR04MB3105F759F43FEDE24C24FB3AF84C9@HK0PR04MB3105.apcprd04.prod.outlook.com>
 <61de4c6c-84e9-345a-495d-4d44d9351d84@linaro.org>
 <HK0PR04MB3105AE7BA97942C160A6939AF85D9@HK0PR04MB3105.apcprd04.prod.outlook.com>
Message-ID: <6f11e588-c899-8d5d-1ef1-22535d251901@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 05/10/2022 10:43, Delphine_CC_Chiu/WYHQ/Wiwynn wrote:
>> On 20/09/2022 09:45, Bonnie Lo/WYHQ/Wiwynn wrote:
>>> Hi Krzysztof,
>>>
>>> I revise the device tree as following and resend the mail.
>>> It create a new mail thread " [PATCH] ARM: dts: aspeed: greatlakes: Add
>> Facebook greatlakes (AST2600) BMC".
>>> Kindly to correct me, if there is any problem.
>>>
>>>> Use subject prefixes matching the subsystem (git log --oneline -- ...).
>>>>
>>>>>
>>>>> Add linux device tree entry related to greatlakes specific devices
>>>>> connected to BMC SoC.
>>>>
>>>> Please wrap commit message according to Linux coding style /
>>>> submission
>>>> process:
>>>> https://apc01.safelinks.protection.outlook.com/?url=https%3A%2F%2Feli
>>>>
>> xir.b%2F&amp;data=05%7C01%7CBonnie_Lo%40wiwynn.com%7Ca2eecb3c2d
>> ff4eff
>>>>
>> 361b08da9ae190fd%7Cda6e0628fc834caf9dd273061cbab167%7C0%7C0%7C6
>> 379925
>>>>
>> 90848633103%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQI
>> joiV2luM
>>>>
>> zIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=MJn
>> u2iv19
>>>> dvbcMH7SJSExKOFV18dUtGRFSKO6Au2tFg%3D&amp;reserved=0
>>>>
>> ootlin.com%2Flinux%2Fv5.18-rc4%2Fsource%2FDocumentation%2Fprocess%2
>>>>
>> Fsubmitting-patches.rst%23L586&amp;data=05%7C01%7CBonnie_Lo%40wiw
>>>>
>> ynn.com%7C1dee8dcb540a49522fb608da98cdba6f%7Cda6e0628fc834caf9dd
>>>>
>> 273061cbab167%7C0%7C0%7C637990306620286314%7CUnknown%7CTWFp
>>>>
>> bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI
>>>>
>> 6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=mC2E3dJbuYgXklS%2Fw8s2w%2
>>>> BKH%2BZ3CsZSndFTgPBjyvpw%3D&amp;reserved=0
>>>>
>>>
>>> I have add " ARM: dts: aspeed: greatlakes:".
>>>
>>>>>
>>>>> Signed-off-by: Bonnie Lo <Bonnie_Lo@wiwynn.com>
>>>>> ---
>>>>>  arch/arm/boot/dts/Makefile                    |   1 +
>>>>>  .../dts/aspeed-bmc-facebook-greatlakes.dts    | 248
>>>> ++++++++++++++++++
>>>>
>>>> Missing documentation of board compatible (bindings) as first patch.
>>
>> Why did you ignore it?
> 
> We need to look at this more. There might be something under the Documentation tree.
> Could you guide us an example for adding the document?

https://lore.kernel.org/all/?q=s%3A%22dt-bindings%3A+arm%3A%22

Fix your email server so it won't add footers making open-source
collaboration not possible. You said that this email "contains
proprietary or confidential information", therefore it is not suitable
for open-source discussions.

Best regards,
Krzysztof

