From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 29 Jun 2022 10:03:39 +0200
Subject: [PATCH v5 2/5] dt-bindings: clock: Add AST2500/AST2600 HACE reset
 definition
In-Reply-To: <HK0PR06MB32025ACEE605D1016DD3B99D80BB9@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20220629032008.1579899-1-neal_liu@aspeedtech.com>
 <20220629032008.1579899-3-neal_liu@aspeedtech.com>
 <b70e06e7-81fc-dfc1-f9c5-f83cb4a18293@linaro.org>
 <HK0PR06MB32025ACEE605D1016DD3B99D80BB9@HK0PR06MB3202.apcprd06.prod.outlook.com>
Message-ID: <409af908-5e03-8df7-fcd5-7fab75cdfb34@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 29/06/2022 09:59, Neal Liu wrote:
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Wednesday, June 29, 2022 1:58 PM
>> To: Neal Liu <neal_liu@aspeedtech.com>; Corentin Labbe
>> <clabbe.montjoie@gmail.com>; Christophe JAILLET
>> <christophe.jaillet@wanadoo.fr>; Randy Dunlap <rdunlap@infradead.org>;
>> Herbert Xu <herbert@gondor.apana.org.au>; David S . Miller
>> <davem@davemloft.net>; Rob Herring <robh+dt@kernel.org>; Krzysztof
>> Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Joel Stanley <joel@jms.id.au>;
>> Andrew Jeffery <andrew@aj.id.au>; Dhananjay Phadke
>> <dhphadke@microsoft.com>; Johnny Huang
>> <johnny_huang@aspeedtech.com>
>> Cc: linux-aspeed at lists.ozlabs.org; linux-crypto at vger.kernel.org;
>> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
>> linux-kernel at vger.kernel.org; BMC-SW <BMC-SW@aspeedtech.com>
>> Subject: Re: [PATCH v5 2/5] dt-bindings: clock: Add AST2500/AST2600 HACE
>> reset definition
>>
>> On 29/06/2022 05:20, Neal Liu wrote:
>>> Add HACE reset bit definition for AST2500/AST2600.
>>>
>>> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
>>> Signed-off-by: Johnny Huang <johnny_huang@aspeedtech.com>
>>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>>>  include/dt-bindings/clock/aspeed-clock.h  | 3 ++-
>>> include/dt-bindings/clock/ast2600-clock.h | 1 +
>>>  2 files changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/dt-bindings/clock/aspeed-clock.h
>>> b/include/dt-bindings/clock/aspeed-clock.h
>>> index 9ff4f6e4558c..6e040f7c3426 100644
>>> --- a/include/dt-bindings/clock/aspeed-clock.h
>>> +++ b/include/dt-bindings/clock/aspeed-clock.h
>>> @@ -46,11 +46,12 @@
>>>  #define ASPEED_RESET_MCTP		1
>>>  #define ASPEED_RESET_ADC		2
>>>  #define ASPEED_RESET_JTAG_MASTER	3
>>> -#define ASPEED_RESET_MIC		4
>>> +#define ASPEED_RESET_HACE		4
>>
>> I did not ack such change. This is a significant change from previous version,
>> invalidating my previous ack.
>>
>> This breaks the ABI, so NAK without proper explanation why ABI break is
>> accepted.
> 
> I changed the original define (MIC) into different value (see below diff), and add a new define for HACE.
> How does that break the ABI? I'll be appreciated if you can explain it more details.
> And sorry for not remove ack with new change.

Yes, this breaks ABI. Previously the ASPEED_RESET_MIC define had value
of 4, now it has value of something else.

Best regards,
Krzysztof
