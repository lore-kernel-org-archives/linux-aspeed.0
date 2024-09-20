From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Fri, 20 Sep 2024 07:31:01 +0000
Subject: [PATCH v3 2/4] dt-bindings: Add AST2700 bindings
In-Reply-To: <d076275a-ff71-43e2-8a30-969a7d062acd@kernel.org>
References: <20240916091039.3584505-1-ryan_chen@aspeedtech.com>
 <20240916091039.3584505-3-ryan_chen@aspeedtech.com>
 <b9bf19af-0c3c-4622-9124-a66d9df649b2@kernel.org>
 <OS8PR06MB754148AD165538D3D6B6C3DDF2632@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <195a8bfe-e4d7-4140-9635-b86a6ce3c663@kernel.org>
 <OS8PR06MB7541F08D97EC0CF83F8B36ACF2632@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <d076275a-ff71-43e2-8a30-969a7d062acd@kernel.org>
Message-ID: <OS8PR06MB754175D3DEB44835C673A82DF26C2@OS8PR06MB7541.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> Subject: Re: [PATCH v3 2/4] dt-bindings: Add AST2700 bindings
> 
> On 19/09/2024 09:15, Ryan Chen wrote:
> >>>>
> >>>>>  create mode 100644 include/dt-bindings/clock/aspeed,ast2700-clk.h
> >>>>>  create mode 100644
> >>>>> include/dt-bindings/reset/aspeed,ast2700-reset.h
> >>>>>
> >>>>> diff --git a/include/dt-bindings/clock/aspeed,ast2700-clk.h
> >>>>> b/include/dt-bindings/clock/aspeed,ast2700-clk.h
> >>>>> new file mode 100644
> >>>>> index 000000000000..63021af3caf5
> >>>>> --- /dev/null
> >>>>> +++ b/include/dt-bindings/clock/aspeed,ast2700-clk.h
> >>>>
> >>>> Use compatible as filename.
> >>> Modify from aspeed,ast2700-clk.h to aspeed, clk-ast2700.h, is it ok?
> >>> How about the aspeed,ast2700-reset.h file name is ok ?
> >>
> >> No. For both use the same filename, so the full compatible. FULL.
> >
> > Do you mean remove aspeed,ast2700-reset.h?
> > And move reset information into "aspeed, clk-ast2700.h"
> >>
> 
> I did not say that. "For both" means for both files, so you can keep both files.
> 
So, I think you want both file use the same name right? To be following
include/dt-bindings/clock/aspeed,ast2700-scu.h
include/dt-bindings/reset/aspeed,ast2700-scu.h

> 
> Best regards,
> Krzysztof

