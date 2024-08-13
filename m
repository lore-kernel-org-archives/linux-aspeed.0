From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Tue, 13 Aug 2024 07:55:11 +0200
Subject: [PATCH 3/4] dt-bindings: clock: Add AST2700 clock bindings
In-Reply-To: <OS8PR06MB7541D5AB85D8E44E89389BC3F2862@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20240808075937.2756733-1-ryan_chen@aspeedtech.com>
 <20240808075937.2756733-4-ryan_chen@aspeedtech.com>
 <14ef9485-54ba-402b-9b90-5f10c1523d4e@wanadoo.fr>
 <OS8PR06MB75413728F0FCEE022B4B4F5BF2BA2@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <eec21668-3674-40c6-b443-90c7c02262e3@kernel.org>
 <OS8PR06MB7541CA018C86E262F826B9E5F2BA2@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <OS8PR06MB7541B0D9A43B989DC1738F68F2852@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <5081c41b-dfbd-49ad-a993-b983d4c339f0@kernel.org>
 <OS8PR06MB7541196D3058904998820CFFF2852@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <9465f8c0-5270-46df-af4b-e9ee78db63d1@kernel.org>
 <OS8PR06MB7541CC40B6B8877B2656182CF2852@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <OS8PR06MB75415EC7A912DBD4D21A0035F2852@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <e3733148-142c-40a1-b250-4502e8726f0c@kernel.org>
 <OS8PR06MB7541D5AB85D8E44E89389BC3F2862@OS8PR06MB7541.apcprd06.prod.outlook.com>
Message-ID: <26988bcd-4d58-4100-b89c-00e8ef879329@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 13/08/2024 03:53, Ryan Chen wrote:
>> Drop the define for number of clocks from the header, because it is not a

*NUMBER OF CLOCKS*

>> binding. You can put it in the driver or not, I don't care and do not provide
>> guidance on this because I don't know if it makes sense at all.
>> What I know is that number of clocks is not related to binding. It is not needed

*NUMBER OF CLOCKS*

>> in the binding, either.
> 
> Sorry, I am confused.
> if you think that number of clocks is not related to binding.

*NUMBER OF CLOCKS*

> How dtsi claim for clk?
> For example in dtsi.
> include <dt-bindings/clock/aspeed,ast2700-clk.h>
> usb3bhp: usb3bhp {
> ....
> clocks = <&syscon0 SCU0_CLK_GATE_PORTAUSB>;

And where is *NUMBER OF CLOCKS* here? I don't see any problem. No
useless SCU0_CLK_GATE_NUM define here.

> ...
> }
> 
> It need for dtsi binding include for clock enable. 
> 
> If there is no binding clock include file, how device know the clock index?

Just look how ALL other bindings for new platforms are doing it. Why are
we discussing obvious kernel aspects? Spend time to read other drivers
before posting yours.

Best regards,
Krzysztof

