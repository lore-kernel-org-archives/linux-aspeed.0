From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 1 Jun 2022 11:19:07 +0200
Subject: [PATCH 4/5] dt-bindings: crypto: add documentation for aspeed
 hace
In-Reply-To: <HK0PR06MB3202D6A6C66480BF60ED829080DF9@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20220601054204.1522976-1-neal_liu@aspeedtech.com>
 <20220601054204.1522976-5-neal_liu@aspeedtech.com>
 <dca283db-0b2e-1fc1-bc76-811c4c918fb5@linaro.org>
 <HK0PR06MB3202D6A6C66480BF60ED829080DF9@HK0PR06MB3202.apcprd06.prod.outlook.com>
Message-ID: <d1ffbc04-0c80-369e-a1dc-e47e50f52340@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 01/06/2022 10:01, Neal Liu wrote:
>>> +  clocks:
>>> +    maxItems: 1
>>> +
>>> +  clock-names:
>>> +    maxItems: 1
>>
>> You need to list clock names, however usually it does not make sense to have
>> names for just one main device clock.
>>
> I think list clock-names is optional, I'll remove it from required list.

I actually suggest to remove the clock-names property entirely, if is
has one generic entry called "clk" (or "vclk" - the same). Do you
already expect adding here more clocks?


Best regards,
Krzysztof
