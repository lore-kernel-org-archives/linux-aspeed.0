From: Dhananjay Phadke <dphadke@linux.microsoft.com>
Date: Wed, 29 Jun 2022 20:32:48 -0700
Subject: [PATCH v6 2/5] dt-bindings: clock: Add AST2500/AST2600 HACE reset
 definition
In-Reply-To: <HK0PR06MB3202B894962013238CB93B2880BA9@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20220629094426.1930589-1-neal_liu@aspeedtech.com>
 <20220629094426.1930589-3-neal_liu@aspeedtech.com>
 <c24d0e6d-d9ba-68c5-b1c8-13ad31d39ec8@linux.microsoft.com>
 <HK0PR06MB3202B894962013238CB93B2880BA9@HK0PR06MB3202.apcprd06.prod.outlook.com>
Message-ID: <845139cd-f2df-3204-8639-297da145fec1@linux.microsoft.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 6/29/2022 8:17 PM, Neal Liu wrote:
[...]
>> On 6/29/2022 2:44 AM, Neal Liu wrote:
>>> Add HACE reset bit definition for AST2500/AST2600.
>>>
>>> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
>>> Signed-off-by: Johnny Huang <johnny_huang@aspeedtech.com>
>>> ---
>>>    include/dt-bindings/clock/aspeed-clock.h  | 1 +
>>>    include/dt-bindings/clock/ast2600-clock.h | 1 +
>>>    2 files changed, 2 insertions(+)
>>>
>>> diff --git a/include/dt-bindings/clock/aspeed-clock.h
>>> b/include/dt-bindings/clock/aspeed-clock.h
>>> index 9ff4f6e4558c..06d568382c77 100644
>>> --- a/include/dt-bindings/clock/aspeed-clock.h
>>> +++ b/include/dt-bindings/clock/aspeed-clock.h
>>> @@ -52,5 +52,6 @@
>>>    #define ASPEED_RESET_I2C		7
>>>    #define ASPEED_RESET_AHB		8
>>>    #define ASPEED_RESET_CRT1		9
>>> +#define ASPEED_RESET_HACE		10
>>
>> NAK.
>>
>> I replied to older v5 of this patch, but this v6 also looks incorrect as per HW
>> manual.
>>
>> https://lore.kernel.org/linux-arm-kernel/20220629032008.1579899-1-neal_liu
>> @aspeedtech.com/T/#m000bd3388b3e41117aa0eef10bf6f8a6a3a85cce
>>
>> For both AST2400 and AST2500:
>> SCU04[10] = PECI.
>>
>> It will be best to refactor/split aspeed-clock.h into separate files.
> 
> Hi, based on @Krzysztof mentioned, change these define is not allowed due to breaking ABI.
> So another way is to define a new value(interface), and we can change driver's implementation.
> I know this is not intuitive to hardware register's value, it also confused me at the first time.
> 
> 

This is not SW ABI issue. Each controller in the device-tree needs
correct clock and reset paths. aspeed-clock.h is shared between g4 and 
g5 dtsi. Not sure how you picked bit 10 for HACE, it's for resetting
PECI controller.

See drivers/clk/clk-aspeed.c, which BTW is duplicating same stuff.
         [ASPEED_RESET_MIC]      = 18,
         [ASPEED_RESET_PWM]      =  9,
         [ASPEED_RESET_PECI]     = 10,

FWIW, the reset bit for HACE and MIC are interchanged for AST2400 and 
AST2500 (at least as per HW datasheet).

So this is really fixing what's apparently already broken.

Regards,
Dhananjay
