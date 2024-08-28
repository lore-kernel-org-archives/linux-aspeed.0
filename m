From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Wed, 28 Aug 2024 07:36:08 +0000
Subject: [PATCH v2 1/3] dt-bindings: reset Add AST2700 reset bindings
In-Reply-To: <465c04fe-4455-4eee-9d65-43f66434b784@kernel.org>
References: <20240828062740.1614744-1-ryan_chen@aspeedtech.com>
 <20240828062740.1614744-2-ryan_chen@aspeedtech.com>
 <465c04fe-4455-4eee-9d65-43f66434b784@kernel.org>
Message-ID: <OS8PR06MB7541FBC6591CD129D32B4A3DF2952@OS8PR06MB7541.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> Subject: Re: [PATCH v2 1/3] dt-bindings: reset Add AST2700 reset bindings
> 
> On 28/08/2024 08:27, Ryan Chen wrote:
> > Add dt bindings for AST2700 reset driver.
> >
> > Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> > ---
> >  .../dt-bindings/reset/aspeed,ast2700-reset.h  | 125
> > ++++++++++++++++++
> >  1 file changed, 125 insertions(+)
> >  create mode 100644 include/dt-bindings/reset/aspeed,ast2700-reset.h
> 
> NAK.
> 
> You still did not respond to my previous comments and did not implement
> them.
> 
> Month ago I told you this is not a separate patch.
> 
> https://lore.kernel.org/all/e13c16db-e1a7-4ee0-867b-b184d421de7f at kernel
> .org/
> 
Sorry, I think your point is still two files, but it should be at 1 patch. am I right?
If yes, I will put aspeed,ast2700-reset.h and aspeed,ast2700-clk.h to be 1 patch.

> Best regards,
> Krzysztof

