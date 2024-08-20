From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Tue, 20 Aug 2024 06:51:54 +0000
Subject: [PATCH 1/4] dt-bindings: mfd: aspeed: support for AST2700
In-Reply-To: <94efc2d4ff280a112b869124fc9d7e35ac031596.camel@codeconstruct.com.au>
References: <20240808075937.2756733-1-ryan_chen@aspeedtech.com>
	 <20240808075937.2756733-2-ryan_chen@aspeedtech.com>
	 <2f27285e-6aa5-4e42-b361-224d8d164113@kernel.org>
	 <OS8PR06MB75416FAD2A1A16E7BE2D255DF2BA2@OS8PR06MB7541.apcprd06.prod.outlook.com>
	 <10809e91-31be-4110-86c1-1e1ccb05b664@kernel.org>
	 <OS8PR06MB7541F4F740FDB17F50EBCACBF2BA2@OS8PR06MB7541.apcprd06.prod.outlook.com>
	 <20240813191454.GA1570645-robh@kernel.org>
	 <OS8PR06MB7541BB03AEE90B090AB990B3F2872@OS8PR06MB7541.apcprd06.prod.outlook.com>
	 <7e1dc98e0f69a095a8f7725b742df3c8d8436a67.camel@codeconstruct.com.au>
	 <OS8PR06MB754121818B9431941C18E09DF2802@OS8PR06MB7541.apcprd06.prod.outlook.com>
	 <OS8PR06MB7541C54CA074410C50BA419AF28C2@OS8PR06MB7541.apcprd06.prod.outlook.com>
	 <64d13efd3119429ed876ad7ea499cff62e100fb9.camel@codeconstruct.com.au>
	 <OS8PR06MB754148E915F6E6014F490583F28D2@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <94efc2d4ff280a112b869124fc9d7e35ac031596.camel@codeconstruct.com.au>
Message-ID: <OS8PR06MB7541E86C43C2078617A69E2CF28D2@OS8PR06MB7541.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> Subject: Re: [PATCH 1/4] dt-bindings: mfd: aspeed: support for AST2700
> 
> On Tue, 2024-08-20 at 01:52 +0000, Ryan Chen wrote:
> > > Subject: Re: [PATCH 1/4] dt-bindings: mfd: aspeed: support for
> > > AST2700
> > >
> > > On Mon, 2024-08-19 at 03:05 +0000, Ryan Chen wrote:
> > > > > > Subject: Re: [PATCH 1/4] dt-bindings: mfd: aspeed: support for
> > > > > > AST2700
> > > > > >
> > > > > > On Wed, 2024-08-14 at 06:35 +0000, Ryan Chen wrote:
> > > > > > > >
> > > > > > > > Didn't I see in another patch one die is cpu and one is
> > > > > > > > io?
> > > > > > > > Use
> > > > > > > > those in the compatible rather than 0 and 1 if so.
> > > > > > > >
> > > > > > > Sorry, I want to align with our datasheet description.
> > > > > > > It will but scu0 and scu1 register setting.
> > > > > >
> > > > > > Can we document that relationship in the binding? Rob's
> > > > > > suggestion seems more descriptive.
> > > > > Hello,
> > > > > 	Do you want me document it in yaml file or just in commit
> > > > > message?
> > > >
> > > > Hello Rob, Andrew,
> > > > 	I will add in yaml file in description. Like following.
> > > >
> > > > description:
> > > > ??The Aspeed System Control Unit manages the global behaviour of
> > > > the SoC,
> > > > ??configuring elements such as clocks, pinmux, and reset.
> > > > +  In AST2700, it has two soc combination. Each soc include its
> > > > own
> > > > scu register control.
> > > > +  ast2700-scu0 for soc0, ast2700-scu1 for soc1.
> > > >
> > > > Is that will be better way ?
> > >
> > > What Rob is suggesting is to add the compatibles "aspeed,ast2700-
> > > scu-
> > > cpu" and "aspeed,ast2700-scu-io", and then in the description say
> > > something like:
> > >
> > > ???The AST2700 integrates both a CPU and an IO die, each with their
> > > own
> > > ???SCU. The "aspeed,ast2700-scu-cpu" and "aspeed,ast2700-scu-io"
> > > ???compatibles correspond to SCU0 and SCU1 respectively.
> > >
> > Hello Andrew,
> > 	Sorry, for correspond for ast2700 datasheet, the description is
> > scu0/scu1.
> > 	System Control Unit #0 (SCU0)/ System Control Unit #1 (SCU1) why not
> > we
> > 	Keep align with datasheet statement?
> 
> Well, IMO we have an opportunity do better in the compatibles. I expect we
> should take advantage of it. As some support for Rob's suggestion, the
> datasheet chapter for SCU1 calls it "SCUIO" in the first sentence of the
> description. Further, there are only two SCUs, and I don't think the mapping of
> "cpu" to 0 and "io" to 1 is too difficult to keep track of, certainly not if it's
> written in the binding documentation (as long as these names are accurate!).
> The argument works both ways but I don't think it's contentious that using the
> indexes is _less_ descriptive.
> 
> That said, this is just my semi-informed opinion. It's up to you to decide what
> names you're going to push for. Rob's suggestion seems reasonable to me
> though.
> 
Understood, I think I will keep ast2700-scu0,ast2700-scu1, and I will also align with
Our datasheet generates to be consistence. scu0 and scu1.
> Andrew
