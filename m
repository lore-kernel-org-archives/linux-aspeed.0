From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 16 Oct 2019 22:11:48 +1030
Subject: [PATCH 0/7] pinctrl: Fixes for AST2600 support
In-Reply-To: <CACRpkda5cWaA7R3XzyiERCCgwUrjnXd+wCBeKvt-wtjex7wNDg@mail.gmail.com>
References: <20191008044153.12734-1-andrew@aj.id.au>
 <CACRpkda5cWaA7R3XzyiERCCgwUrjnXd+wCBeKvt-wtjex7wNDg@mail.gmail.com>
Message-ID: <2de90789-c374-4821-89f9-5d5f01e7d2d6@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Wed, 16 Oct 2019, at 21:49, Linus Walleij wrote:
> On Tue, Oct 8, 2019 at 6:41 AM Andrew Jeffery <andrew@aj.id.au> wrote:
> 
> > This series resolves several issues found in testing by Johnny Huang from
> > ASPEED, who also contributed the patches to fix them. We'll have more patches
> > from him in the near future (which I'm pretty happy about).
> >
> > The major issue resolved is the way I grouped the eMMC pins. What I had was
> > ugly and I want to get rid of it before the binding is solidified with the 5.4
> > release.
> 
> Should some of these go in with fixes? All of them? Or just some?
> I applied them to devel right now (for v5.5).

I was hoping to get them into the 5.4 fixes branch: I consider them all fixes - the rework of the eMMC pin groups and functions is a fix for the binding. The rest are fixes for the driver itself. My preference is that they get into a release sooner rather than later.

It's there something that makes you think they shouldn't be merged as fixes for 5.4?

> 
> > The remaining fixes are minor issues that stem from lack of documentation or
> > understanding on my part, and at least one brain-fart.
> 
> Do they need to go in to v5.4 or not?
> 
> I need a shortlist of anything that should go into v5.4 if anything.

IMO all of them should go into 5.4, as above. It's there something I can do in the future to communicate this better? Explicit shortlist in the cover letter? Fixes tags on the relevant patches? Keen to make things easier/more obvious if I can.

Cheers,

Andrew
