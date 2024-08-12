From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Mon, 12 Aug 2024 08:54:07 +0000
Subject: [PATCH 3/4] dt-bindings: clock: Add AST2700 clock bindings
In-Reply-To: <9465f8c0-5270-46df-af4b-e9ee78db63d1@kernel.org>
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
Message-ID: <OS8PR06MB7541CC40B6B8877B2656182CF2852@OS8PR06MB7541.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> Subject: Re: [PATCH 3/4] dt-bindings: clock: Add AST2700 clock bindings
> 
> On 12/08/2024 10:22, Ryan Chen wrote:
> >> Subject: Re: [PATCH 3/4] dt-bindings: clock: Add AST2700 clock
> >> bindings
> >>
> >> On 12/08/2024 09:26, Ryan Chen wrote:
> >>>> Subject: RE: [PATCH 3/4] dt-bindings: clock: Add AST2700 clock
> >>>> bindings
> >>>>
> >>>>> Subject: Re: [PATCH 3/4] dt-bindings: clock: Add AST2700 clock
> >>>>> bindings
> >>>>>
> >>>>> On 09/08/2024 07:47, Ryan Chen wrote:
> >>>>>>> Subject: Re: [PATCH 3/4] dt-bindings: clock: Add AST2700 clock
> >>>>>>> bindings
> >>>>>>>
> >>>>>>> Le 08/08/2024 ? 09:59, Ryan Chen a ?crit :
> >>>>>>>> Add dt bindings for AST2700 clock controller
> >>>>>>>>
> >>>>>>>> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> >>>>>>>> ---
> >>>>>>>>   .../dt-bindings/clock/aspeed,ast2700-clk.h    | 175
> >>>>>>> ++++++++++++++++++
> >>>>>>>>   1 file changed, 175 insertions(+)
> >>>>>>>>   create mode 100644
> >>>>>>>> include/dt-bindings/clock/aspeed,ast2700-clk.h
> >>>>>>>>
> >>>>>>>> diff --git a/include/dt-bindings/clock/aspeed,ast2700-clk.h
> >>>>>>>> b/include/dt-bindings/clock/aspeed,ast2700-clk.h
> >>>>>>>> new file mode 100644
> >>>>>>>> index 000000000000..facf72352c3e
> >>>>>>>> --- /dev/null
> >>>>>>>> +++ b/include/dt-bindings/clock/aspeed,ast2700-clk.h
> >>>>>>>> @@ -0,0 +1,175 @@
> >>>>>>>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> >>>>>>>> +/*
> >>>>>>>> + * Device Tree binding constants for AST2700 clock controller.
> >>>>>>>> + *
> >>>>>>>> + * Copyright (c) 2024 Aspeed Technology Inc.
> >>>>>>>> + */
> >>>>>>>> +
> >>>>>>>> +#ifndef __DT_BINDINGS_CLOCK_AST2700_H #define
> >>>>>>>> +__DT_BINDINGS_CLOCK_AST2700_H
> >>>>>>>> +
> >>>>>>>> +/* SOC0 clk-gate */
> >>>>>>>> +#define SCU0_CLK_GATE_MCLK (0) #define
> SCU0_CLK_GATE_ECLK (1)
> >>>>>>>> +#define SCU0_CLK_GATE_2DCLK        (2)
> >>>>>>>> +#define SCU0_CLK_GATE_VCLK (3) #define SCU0_CLK_GATE_BCLK
> (4)
> >>>>>>>> +#define SCU0_CLK_GATE_VGA0CLK      (5)
> >>>>>>>> +#define SCU0_CLK_GATE_REFCLK       (6)
> >>>>>>>> +#define SCU0_CLK_GATE_PORTBUSB2CLK (7) #define
> >>>>> SCU0_CLK_GATE_RSV8
> >>>>>>>> +(8)
> >>>>>>>> +#define SCU0_CLK_GATE_UHCICLK      (9)
> >>>>>>>> +#define SCU0_CLK_GATE_VGA1CLK      (10)
> >>>>>>>> +#define SCU0_CLK_GATE_DDRPHYCLK    (11)
> >>>>>>>> +#define SCU0_CLK_GATE_E2M0CLK      (12)
> >>>>>>>> +#define SCU0_CLK_GATE_HACCLK       (13)
> >>>>>>>> +#define SCU0_CLK_GATE_PORTAUSB2CLK (14)
> >>>>>>>> +#define SCU0_CLK_GATE_UART4CLK     (15)
> >>>>>>>> +#define SCU0_CLK_GATE_SLICLK       (16)
> >>>>>>>> +#define SCU0_CLK_GATE_DACCLK       (17)
> >>>>>>>> +#define SCU0_CLK_GATE_DP   (18)
> >>>>>>>> +#define SCU0_CLK_GATE_E2M1CLK      (19)
> >>>>>>>> +#define SCU0_CLK_GATE_CRT0CLK      (20)
> >>>>>>>> +#define SCU0_CLK_GATE_CRT1CLK      (21)
> >>>>>>>> +#define SCU0_CLK_GATE_VLCLK        (22)
> >>>>>>>> +#define SCU0_CLK_GATE_ECDSACLK     (23)
> >>>>>>>> +#define SCU0_CLK_GATE_RSACLK       (24)
> >>>>>>>> +#define SCU0_CLK_GATE_RVAS0CLK     (25)
> >>>>>>>> +#define SCU0_CLK_GATE_UFSCLK       (26)
> >>>>>>>> +#define SCU0_CLK_GATE_EMMCCLK      (27)
> >>>>>>>> +#define SCU0_CLK_GATE_RVAS1CLK     (28)
> >>>>>>>> +/* reserved 29 ~ 31*/
> >>>>>
> >>>>> No, you cannot reserve IDs. They are always continous.
> >>>> I think for mis-understood.
> >>>> I will remove the comment.
> >>>> And keep it is continuous. Thanks.
> >>>>>
> >>>>>>>> +#define SCU0_CLK_GATE_NUM  (SCU0_CLK_GATE_RVAS1CLK +
> 1)
> >>>>>
> >>>>> No, not a binding.
> >>>>
> >>> I will modify by following.
> >>>
> >>> #define SCU0_CLK_GATE_RVAS1CLK  (28)
> >>> #define SCU0_CLK_GATE_NUM       (SCU0_CLK_GATE_RVAS1CLK + 1)
> >>
> >> Nothing changed. Still not a binding. Why do you send the same and
> >> expect different result? Drop.
> >>
> >> Address feedback sent to you from previous versions of the patchset.
> >> There was never a reply.
> > Sorry, mis-understood.
> > Since you think "#define SCU0_CLK_GATE_NUM" not a binding.
> > Do you mean I should #define SCU0_CLK_GATE_NUM in clk driver, not in
> binding header, am I right?
> 
> What did I write in the first Aspeed 2700 patch? So you are not going to
> respond there? Are you going to implement entire feedback received in the
> first version of the patchset?

Apologize again, I do the internal discussion, it should not send "Introduce ASPEED AST27XX BMC SoC" series patch. it should be separate series patch.
It should be bite by bite, example clk driver patches, platform patches, interrupt patches.
So I am not going to response there, prefer here.

So I still not understood your point "not a binding" is ~



> 
> Drop from the header. I am not saying you need to define it in the driver,
> because maybe it is pointless anyway.
> 
> Best regards,
> Krzysztof

