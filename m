From: Vaittinen, Matti <Matti.Vaittinen@fi.rohmeurope.com>
Date: Tue, 5 Nov 2019 13:30:20 +0000
Subject: [PATCH 00/62] Add definition for GPIO direction
In-Reply-To: <20191105131038.duol3rwwkbuvgvwv@pengutronix.de>
References: <cover.1572875541.git.matti.vaittinen@fi.rohmeurope.com>
 <20191105122042.GO32742@smile.fi.intel.com>
 <4e6fa62d7022c7b1426477a150a93c899725f5b0.camel@fi.rohmeurope.com>
 <20191105131038.duol3rwwkbuvgvwv@pengutronix.de>
Message-ID: <938a5ec7b41ae9ce7b0de83764d6b774cfdaa781.camel@fi.rohmeurope.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 2019-11-05 at 14:10 +0100, Uwe Kleine-K?nig wrote:
> Hello,
> 
> On Tue, Nov 05, 2019 at 12:54:55PM +0000, Vaittinen, Matti wrote:
> > On Tue, 2019-11-05 at 14:20 +0200, Andy Shevchenko wrote:
> > > I would also like to see bloat-o-meter statistics before and
> > > after
> > > your patch.
> > > My guts tell me that the result will be not in the favour of
> > > yours
> > > solution.
> > 
> > Can you please tell me what type of stats you hope to see? I can
> > try
> > generating what you are after. The cover letter contained typical
> > +/-
> > change stats from git and summary:
> > 
> > 62 files changed, 228 insertions(+), 104 deletions(-)
> 
> I guess he wants to see
> 
> 	scripts/bloat-o-meter vmlinuz.old vmlinuz
> 
> . I would expect a 0 there. I didn't look in detail, but in general I
> like the idea to give 0 and 1 a symbolic name.

Thanks Uwe. This far I have only cross-compiled the series for arm
which I use for developing the ROHM PMICs. scripts/bloat-o-meter /
tools it uses does not seem to recognize the image format (not a big
surprize as my host is x86_64).

Br,
	Matti Vaittinen

