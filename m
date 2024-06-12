From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Wed, 12 Jun 2024 02:23:59 +0000
Subject: [PATCH] peci: aspeed: Clear clock_divider value before setting it
In-Reply-To: <1583360debaee14a988e4019cf30250f6eb4d8da.camel@codeconstruct.com.au>
References: <20240417134849.5793-1-iwona.winiarska@intel.com>
	 <7b0ef5c90138e8c1d1829de249a480709170141b.camel@codeconstruct.com.au>
	 <7520ac6ef7afae66f9b1636e5806ff2bfd93584d.camel@intel.com>
 <1583360debaee14a988e4019cf30250f6eb4d8da.camel@codeconstruct.com.au>
Message-ID: <OSQPR06MB725292ECF1EA0849C9FED1E48BC02@OSQPR06MB7252.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> On Thu, 2024-04-18 at 13:41 +0000, Winiarska, Iwona wrote:
> > On Thu, 2024-04-18 at 09:11 +0930, Andrew Jeffery wrote:
> > > Hi Iwona,
> > >
> > > On Wed, 2024-04-17 at 15:48 +0200, Iwona Winiarska wrote:
> > > > PECI clock divider is programmed on 10:8 bits of PECI Control register.
> > > > Before setting a new value, clear bits read from hardware.
> > > >
> > > > Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
> > >
> > > I think it would be best to add a Fixes: tag and Cc: stable in
> > > accordance with the stable tree rules. Are you happy to do so?
> >
> > Hi!
> >
> > Technically, the initial value of this register should be 0, but I've added the
> > clear just to be on the safe side and to not have to rely on that.

> Yeah, it could cause havoc with an unbind/bind sequence if people are
> messing with the clocks in between.

> > I don't think we're ever programming invalid values in the real-world scenarios,
> > and because of that - I don't think this is stable material.

> Right, I don't expect people are doing the above in environments where
> stability is a concern.

Reviewed-by: Billy Tsai <billy_tsai@aspeedtech.com>

Billy
