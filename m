From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Thu, 12 Dec 2019 16:17:42 +0100
Subject: [PATCH v2 2/2] reset: simple: Add AST2600 compatibility string
In-Reply-To: <EFF7E049-08C0-40A0-946A-18822C7AEEE3@fuzziesquirrel.com>
References: <20191129000827.650566-1-joel@jms.id.au>
 <20191129000827.650566-3-joel@jms.id.au>
 <2498da189d5e21ae70fb6884df6fc16ecfee2087.camel@pengutronix.de>
 <EFF7E049-08C0-40A0-946A-18822C7AEEE3@fuzziesquirrel.com>
Message-ID: <ccc48df65e340c52218fd45549c26174a10f410c.camel@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Brad,

On Thu, 2019-12-12 at 09:51 -0500, Brad Bishop wrote:
> Hi Philipp.  Thanks for your time.
> 
> > On Dec 2, 2019, at 7:53 AM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> > 
> > On Fri, 2019-11-29 at 10:38 +1030, Joel Stanley wrote:
> > > From: Brad Bishop <bradleyb@fuzziesquirrel.com>
> > > 
> > > The AST2600 SoC contains the same LPC register set as the AST2500.
> > 
> > If the LPC register set is exactly the same, shouldn't AST2600 reuse the
> > AST2500 compatible, i.e.:
> > 	compatible = "aspeed,ast2600-lpc-reset", "aspeed,ast2500-lpc-reset";
> > ?
> 
> I?m not sure.  I let what was already there be my guide - the ast2500
> LPC registers are the same as the ast2400 as well and those got their
> own compatibles.  Is there a guideline written down somewhere that
> backs your thinking up?

I read section 2.3.1 "compatible" of the DeviceTree Specification [1] as
supporting that view. If all three LPC reset controllers are in fact
identical, I would argue that both ast2500 and ast2600 are compatible to
ast2400 and should be specified as:
	compatible = "aspeed,ast2500-lpc-reset", "aspeed,ast2400-lpc-reset";
and:
	compatible = "aspeed,ast2600-lpc-reset", "aspeed,ast2400-lpc-reset";
respectively.

[1] https://github.com/devicetree-org/devicetree-specification/releases/download/v0.2/devicetree-specification-v0.2.pdf

regards
Philipp

