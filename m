From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Tue, 5 Nov 2019 14:10:38 +0100
Subject: [PATCH 00/62] Add definition for GPIO direction
In-Reply-To: <4e6fa62d7022c7b1426477a150a93c899725f5b0.camel@fi.rohmeurope.com>
References: <cover.1572875541.git.matti.vaittinen@fi.rohmeurope.com>
 <20191105122042.GO32742@smile.fi.intel.com>
 <4e6fa62d7022c7b1426477a150a93c899725f5b0.camel@fi.rohmeurope.com>
Message-ID: <20191105131038.duol3rwwkbuvgvwv@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

On Tue, Nov 05, 2019 at 12:54:55PM +0000, Vaittinen, Matti wrote:
> On Tue, 2019-11-05 at 14:20 +0200, Andy Shevchenko wrote:
> > I would also like to see bloat-o-meter statistics before and after
> > your patch.
> > My guts tell me that the result will be not in the favour of yours
> > solution.
> 
> Can you please tell me what type of stats you hope to see? I can try
> generating what you are after. The cover letter contained typical +/-
> change stats from git and summary:
> 
> 62 files changed, 228 insertions(+), 104 deletions(-)

I guess he wants to see

	scripts/bloat-o-meter vmlinuz.old vmlinuz

. I would expect a 0 there. I didn't look in detail, but in general I
like the idea to give 0 and 1 a symbolic name.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
