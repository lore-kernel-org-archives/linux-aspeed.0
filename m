From: Dhananjay Phadke <dphadke@linux.microsoft.com>
Date: Wed, 29 Jun 2022 04:39:00 -0700
Subject: [PATCH v5 2/5] dt-bindings: clock: Add AST2500/AST2600 HACE reset
 definition
In-Reply-To: <HK0PR06MB32021F63833C4C482CC616D580BB9@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20220629032008.1579899-1-neal_liu@aspeedtech.com>
 <20220629032008.1579899-3-neal_liu@aspeedtech.com>
 <b70e06e7-81fc-dfc1-f9c5-f83cb4a18293@linaro.org>
 <HK0PR06MB32025ACEE605D1016DD3B99D80BB9@HK0PR06MB3202.apcprd06.prod.outlook.com>
 <409af908-5e03-8df7-fcd5-7fab75cdfb34@linaro.org>
 <HK0PR06MB32021F63833C4C482CC616D580BB9@HK0PR06MB3202.apcprd06.prod.outlook.com>
Message-ID: <74981148-70ab-059b-6e77-b88ea908e703@linux.microsoft.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 6/29/2022 1:49 AM, Neal Liu wrote:
[...]
>>>>> diff --git a/include/dt-bindings/clock/aspeed-clock.h
>>>>> b/include/dt-bindings/clock/aspeed-clock.h
>>>>> index 9ff4f6e4558c..6e040f7c3426 100644
>>>>> --- a/include/dt-bindings/clock/aspeed-clock.h
>>>>> +++ b/include/dt-bindings/clock/aspeed-clock.h
>>>>> @@ -46,11 +46,12 @@
>>>>>   #define ASPEED_RESET_MCTP		1
>>>>>   #define ASPEED_RESET_ADC		2
>>>>>   #define ASPEED_RESET_JTAG_MASTER	3
>>>>> -#define ASPEED_RESET_MIC		4
>>>>> +#define ASPEED_RESET_HACE		4
>>>>
>>>> I did not ack such change. This is a significant change from previous
>>>> version, invalidating my previous ack.
>>>>
>>>> This breaks the ABI, so NAK without proper explanation why ABI break
>>>> is accepted.
>>>
>>> I changed the original define (MIC) into different value (see below diff), and
>> add a new define for HACE.
>>> How does that break the ABI? I'll be appreciated if you can explain it more
>> details.
>>> And sorry for not remove ack with new change.
>>
>> Yes, this breaks ABI. Previously the ASPEED_RESET_MIC define had value of 4,
>> now it has value of something else.
> 
> Got your point. I'll re-define HACE without modifying ABI.
> Thanks for your suggestion.
> 

As per HW manuals, new def is correct for AST2500, but not for AST2400.

AST2500:
SCU04[4] = HACE
SCU04[18] = MIC

AST2400:
SCU04[4] = MIC
SCU04[18] = HACE

The header file is shared between AST2400 and AST2500 (aspeed-g4.dtsi
and aspeed-g5.dtsi), which needs to be split into separate header files
given the collision.

Also, It will be better to split AST2500 and AST2600 changes in separate
patches.

Regards,
Dhananjay

