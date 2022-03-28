From: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
Date: Mon, 28 Mar 2022 07:41:19 -0700
Subject: [PATCH v2 2/5] pinctrl: pinctrl-aspeed-g6: remove FWQSPID group
 in pinctrl
In-Reply-To: <c846fd5f-56e0-4289-af2c-42603c1abda2@www.fastmail.com>
References: <20220325154048.467245-1-quic_jaehyoo@quicinc.com>
 <20220325154048.467245-3-quic_jaehyoo@quicinc.com>
 <c846fd5f-56e0-4289-af2c-42603c1abda2@www.fastmail.com>
Message-ID: <0645f716-d664-4e48-577e-57251c1c3f58@quicinc.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 3/27/2022 8:18 PM, Andrew Jeffery wrote:
> 
> 
> On Sat, 26 Mar 2022, at 02:10, Jae Hyun Yoo wrote:
>> FWSPIDQ2 and FWSPIDQ3 are not part of FWSPI18 interface so remove
>> FWQSPID group in pinctrl. These pins must be used with the FWSPI
>> pins that are dedicated for boot SPI interface which provides
>> same 3.3v logic level.
>>
>> Signed-off-by: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
>> Fixes: 2eda1cdec49f ("pinctrl: aspeed: Add AST2600 pinmux support")
>> ---
>> Changes in v2:
>>   * None.
>>
>>   drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c | 14 +++-----------
>>   1 file changed, 3 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
>> b/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
>> index a3fa03bcd9a3..54064714d73f 100644
>> --- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
>> +++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
>> @@ -1236,18 +1236,12 @@ FUNC_GROUP_DECL(SALT8, AA12);
>>   FUNC_GROUP_DECL(WDTRST4, AA12);
>>
>>   #define AE12 196
>> -SIG_EXPR_LIST_DECL_SEMG(AE12, FWSPIDQ2, FWQSPID, FWSPID,
>> -			SIG_DESC_SET(SCU438, 4));
>>   SIG_EXPR_LIST_DECL_SESG(AE12, GPIOY4, GPIOY4);
>> -PIN_DECL_(AE12, SIG_EXPR_LIST_PTR(AE12, FWSPIDQ2),
>> -	  SIG_EXPR_LIST_PTR(AE12, GPIOY4));
>> +PIN_DECL_(AE12, SIG_EXPR_LIST_PTR(AE12, GPIOY4));
>>
>>   #define AF12 197
>> -SIG_EXPR_LIST_DECL_SEMG(AF12, FWSPIDQ3, FWQSPID, FWSPID,
>> -			SIG_DESC_SET(SCU438, 5));
>>   SIG_EXPR_LIST_DECL_SESG(AF12, GPIOY5, GPIOY5);
>> -PIN_DECL_(AF12, SIG_EXPR_LIST_PTR(AF12, FWSPIDQ3),
>> -	  SIG_EXPR_LIST_PTR(AF12, GPIOY5));
>> +PIN_DECL_(AF12, SIG_EXPR_LIST_PTR(AF12, GPIOY5));
>>
>>   #define AC12 198
>>   SSSF_PIN_DECL(AC12, GPIOY6, FWSPIABR, SIG_DESC_SET(SCU438, 6));
>> @@ -1520,9 +1514,8 @@ SIG_EXPR_LIST_DECL_SEMG(Y4, EMMCDAT7, EMMCG8,
>> EMMC, SIG_DESC_SET(SCU404, 3));
>>   PIN_DECL_3(Y4, GPIO18E3, FWSPIDMISO, VBMISO, EMMCDAT7);
>>
>>   GROUP_DECL(FWSPID, Y1, Y2, Y3, Y4);
>> -GROUP_DECL(FWQSPID, Y1, Y2, Y3, Y4, AE12, AF12);
>>   GROUP_DECL(EMMCG8, AB4, AA4, AC4, AA5, Y5, AB5, AB6, AC5, Y1, Y2, Y3,
>> Y4);
>> -FUNC_DECL_2(FWSPID, FWSPID, FWQSPID);
>> +FUNC_DECL_1(FWSPID, FWSPID);
> 
> Really this is the FWSPI18 group now? The FWSPID name never made sense.
> I'm not sure what I was thinking.

Yes, it's now the FWSPI18 which is described as 'debug SPI' in the
datasheet. Corresponding SCU500[3] bit is also described as that 'the
bit is for verification and testing only'. Probably, you was thinking
'D' as in 'Debug' for the FWSPID naming.

> Actually, I think it's worth squashing this with 3/5 so it's a proper
> fix rather than separate remove/add?

Two reasons I separated them.
1. Author is different.
2. 2/5 is a bug fix and 3/5 introduces a new pinmux.

>>   FUNC_GROUP_DECL(VB, Y1, Y2, Y3, Y4);
>>   FUNC_DECL_3(EMMC, EMMCG1, EMMCG4, EMMCG8);
>>   /*
>> @@ -1918,7 +1911,6 @@ static const struct aspeed_pin_group
>> aspeed_g6_groups[] = {
>>   	ASPEED_PINCTRL_GROUP(FSI2),
>>   	ASPEED_PINCTRL_GROUP(FWSPIABR),
>>   	ASPEED_PINCTRL_GROUP(FWSPID),
>> -	ASPEED_PINCTRL_GROUP(FWQSPID),
> 
> We should also remove the function (not just the group).

Still worth to keep FWSPID to support SCU500[3] - Boot from debug SPI.
FWSPID would work on single and dual data mode only.

Thanks,
Jae

> 
> Andrew
> 
>>   	ASPEED_PINCTRL_GROUP(FWSPIWP),
>>   	ASPEED_PINCTRL_GROUP(GPIT0),
>>   	ASPEED_PINCTRL_GROUP(GPIT1),
>> -- 
>> 2.25.1
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
