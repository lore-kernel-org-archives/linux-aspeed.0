From: Brad Bishop <bradleyb@fuzziesquirrel.com>
Date: Thu, 12 Dec 2019 09:51:58 -0500
Subject: [PATCH v2 2/2] reset: simple: Add AST2600 compatibility string
In-Reply-To: <2498da189d5e21ae70fb6884df6fc16ecfee2087.camel@pengutronix.de>
References: <20191129000827.650566-1-joel@jms.id.au>
 <20191129000827.650566-3-joel@jms.id.au>
 <2498da189d5e21ae70fb6884df6fc16ecfee2087.camel@pengutronix.de>
Message-ID: <EFF7E049-08C0-40A0-946A-18822C7AEEE3@fuzziesquirrel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Philipp.  Thanks for your time.

> On Dec 2, 2019, at 7:53 AM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> 
> On Fri, 2019-11-29 at 10:38 +1030, Joel Stanley wrote:
>> From: Brad Bishop <bradleyb@fuzziesquirrel.com>
>> 
>> The AST2600 SoC contains the same LPC register set as the AST2500.
> 
> If the LPC register set is exactly the same, shouldn't AST2600 reuse the
> AST2500 compatible, i.e.:
> 	compatible = "aspeed,ast2600-lpc-reset", "aspeed,ast2500-lpc-reset";
> ?

I?m not sure.  I let what was already there be my guide - the ast2500 LPC registers are the same as the ast2400 as well and those got their own compatibles.  Is there a guideline written down somewhere that backs your thinking up?

thanks - brad
