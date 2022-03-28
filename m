From: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
Date: Mon, 28 Mar 2022 07:26:51 -0700
Subject: [PATCH v2 3/5] pinctrl: pinctrl-aspeed-g6: add FWQSPI
 function-group
In-Reply-To: <50fe6b39-e5ca-439c-a390-59eddca4a021@www.fastmail.com>
References: <20220325154048.467245-1-quic_jaehyoo@quicinc.com>
 <20220325154048.467245-4-quic_jaehyoo@quicinc.com>
 <50fe6b39-e5ca-439c-a390-59eddca4a021@www.fastmail.com>
Message-ID: <c01d55d4-3b54-591b-bc13-1671481fe08e@quicinc.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 3/27/2022 8:15 PM, Andrew Jeffery wrote:
> 
> 
> On Sat, 26 Mar 2022, at 02:10, Jae Hyun Yoo wrote:
>> From: Johnny Huang <johnny_huang@aspeedtech.com>
>>
>> Add FWSPIDQ2 (AE12) and FWSPIDQ3 (AF12) function-group to support
>> AST2600 FW SPI quad mode. These pins can be used with dedicated FW
>> SPI pins - FWSPICS0# (AB14), FWSPICK (AF13), FWSPIMOSI (AC14)
>> and FWSPIMISO (AB13).
>>
>> Signed-off-by: Johnny Huang <johnny_huang@aspeedtech.com>
>> Signed-off-by: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
>> ---
>> Changes in v2:
>>   * None.
>>
>>   drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c | 11 +++++++++--
>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
>> b/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
>> index 54064714d73f..80838dc54b3a 100644
>> --- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
>> +++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
>> @@ -1236,12 +1236,17 @@ FUNC_GROUP_DECL(SALT8, AA12);
>>   FUNC_GROUP_DECL(WDTRST4, AA12);
>>
>>   #define AE12 196
>> +SIG_EXPR_LIST_DECL_SESG(AE12, FWSPIQ2, FWQSPI, SIG_DESC_SET(SCU438, 4));
>>   SIG_EXPR_LIST_DECL_SESG(AE12, GPIOY4, GPIOY4);
>> -PIN_DECL_(AE12, SIG_EXPR_LIST_PTR(AE12, GPIOY4));
>> +PIN_DECL_(AE12, SIG_EXPR_LIST_PTR(AE12, FWSPIQ2),
>> +	  SIG_EXPR_LIST_PTR(AE12, GPIOY4));
>>
>>   #define AF12 197
>> +SIG_EXPR_LIST_DECL_SESG(AF12, FWSPIQ3, FWQSPI, SIG_DESC_SET(SCU438, 5));
>>   SIG_EXPR_LIST_DECL_SESG(AF12, GPIOY5, GPIOY5);
>> -PIN_DECL_(AF12, SIG_EXPR_LIST_PTR(AF12, GPIOY5));
>> +PIN_DECL_(AF12, SIG_EXPR_LIST_PTR(AF12, FWSPIQ3),
>> +	  SIG_EXPR_LIST_PTR(AF12, GPIOY5));
>> +FUNC_GROUP_DECL(FWQSPI, AE12, AF12);
>>
>>   #define AC12 198
>>   SSSF_PIN_DECL(AC12, GPIOY6, FWSPIABR, SIG_DESC_SET(SCU438, 6));
>> @@ -1911,6 +1916,7 @@ static const struct aspeed_pin_group
>> aspeed_g6_groups[] = {
>>   	ASPEED_PINCTRL_GROUP(FSI2),
>>   	ASPEED_PINCTRL_GROUP(FWSPIABR),
>>   	ASPEED_PINCTRL_GROUP(FWSPID),
>> +	ASPEED_PINCTRL_GROUP(FWQSPI),
>>   	ASPEED_PINCTRL_GROUP(FWSPIWP),
>>   	ASPEED_PINCTRL_GROUP(GPIT0),
>>   	ASPEED_PINCTRL_GROUP(GPIT1),
>> @@ -2152,6 +2158,7 @@ static const struct aspeed_pin_function
>> aspeed_g6_functions[] = {
>>   	ASPEED_PINCTRL_FUNC(FSI2),
>>   	ASPEED_PINCTRL_FUNC(FWSPIABR),
>>   	ASPEED_PINCTRL_FUNC(FWSPID),
>> +	ASPEED_PINCTRL_FUNC(FWQSPI),
> 
> You need to update the binding documentation as well.

Will do it in v3.

Thanks,
Jae
