From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Mon, 19 Aug 2024 06:42:30 +0000
Subject: [PATCH 3/4] dt-bindings: clock: Add AST2700 clock bindings
In-Reply-To: <929c322e-7385-48da-b925-7f363cf5b6f7@kernel.org>
References: <20240808075937.2756733-1-ryan_chen@aspeedtech.com>
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
 <26988bcd-4d58-4100-b89c-00e8ef879329@kernel.org>
 <OS8PR06MB7541A7E690A2D72BA671622EF28C2@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <929c322e-7385-48da-b925-7f363cf5b6f7@kernel.org>
Message-ID: <OS8PR06MB7541672B4F9BCAA37E0D4005F28C2@OS8PR06MB7541.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> Subject: Re: [PATCH 3/4] dt-bindings: clock: Add AST2700 clock bindings
> 
> On 19/08/2024 07:55, Ryan Chen wrote:
> >> Subject: Re: [PATCH 3/4] dt-bindings: clock: Add AST2700 clock
> >> bindings
> >>
> >> On 13/08/2024 03:53, Ryan Chen wrote:
> >>>> Drop the define for number of clocks from the header, because it is
> >>>> not a
> >>
> >> *NUMBER OF CLOCKS*
> >>
> >>>> binding. You can put it in the driver or not, I don't care and do
> >>>> not provide guidance on this because I don't know if it makes sense at all.
> >>>> What I know is that number of clocks is not related to binding. It
> >>>> is not needed
> >>
> >> *NUMBER OF CLOCKS*
> >>
> >>>> in the binding, either.
> >>>
> >>> Sorry, I am confused.
> >>> if you think that number of clocks is not related to binding.
> >>
> >> *NUMBER OF CLOCKS*
> >>
> >>> How dtsi claim for clk?
> >>> For example in dtsi.
> >>> include <dt-bindings/clock/aspeed,ast2700-clk.h>
> >>> usb3bhp: usb3bhp {
> >>> ....
> >>> clocks = <&syscon0 SCU0_CLK_GATE_PORTAUSB>;
> >>
> >> And where is *NUMBER OF CLOCKS* here? I don't see any problem. No
> >> useless SCU0_CLK_GATE_NUM define here.
> >>
> > Understood now, I will remove those *NUMBER OF CLOCKS*.
> > And will replace to
> > #define SCU0_CLK_END  34
> 
> NAK, it's like you keep ignoring my comments entirely. Even if you call it
> "SCU0_CLK_NOT_END" it does not change. Do you understand that it is not
> about name? Read my first comment.
> 
> >
> > Refer:
> > https://github.com/torvalds/linux/blob/master/include/dt-bindings/cloc
> > k/imx8-clock.h#L87
> 
> So you found a bug and this allows you to create the same bug?
> 
Sorry, I don't see this is a bug.
But I try to understand your point, you prefer following for clock nums, am I correct?
https://github.com/torvalds/linux/blob/master/drivers/clk/meson/g12a.c#L5558-L5559

dt-binding is index table like following.
https://github.com/torvalds/linux/blob/master/drivers/clk/meson/g12a.c#L4380

> 
> Best regards,
> Krzysztof

