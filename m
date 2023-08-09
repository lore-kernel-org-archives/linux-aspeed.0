From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Wed, 09 Aug 2023 11:12:51 +0800
Subject: [PATCH 0/3] Add Aspeed AST2600 I3C support
In-Reply-To: <TYZPR06MB65674B8AA26D959254101A749C12A@TYZPR06MB6567.apcprd06.prod.outlook.com>
References: <20230808154241.749641-1-dylan_hung@aspeedtech.com>
	 <d8d577e91779e045d5a2c7d701f65133a15b5d64.camel@codeconstruct.com.au>
	 <TYZPR06MB65674B8AA26D959254101A749C12A@TYZPR06MB6567.apcprd06.prod.outlook.com>
Message-ID: <ee48336f94f7e32de81e1f07facf0663c70091b0.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Dylan,

> Thank you for your review. I3C1 and I3C2 can only operate in low
> voltage (1.0V/1.2V), which is why there are no HVI3C1 and HVI3C2
> pinctrl definitions.

Yep, and that was config that I hadn't tested (so hadn't proposed
pinctrl definitions for those).

> > For 2/3 and 3/3, you're adding a reset control for the global
> > register block within the per-controller driver, but we can already
> > do that on a global basis with the existing syscon device. Hence
> > this earlier change:
> ?
> I followed your recommendation and verified that it worked on my end.

OK, excellent!

> Should I resend the pinctrl patch as a stand-alone submission?

Yes, and feel free to add:

Reviewed-by: Jeremy Kerr <jk@codeconstruct.com.au>

Did your test use my i3c DTS definitions? If so, that's a decent
datapoint that the config works (on something other than my setup), and
so I'll submit upstream. Alternatively, feel free to include it with
your pinctrl change, if you like.

Cheers,


Jeremy
