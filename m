From: Joel Stanley <joel@jms.id.au>
Date: Fri, 9 Apr 2021 04:07:41 +0000
Subject: [PATCH v2 00/21] ipmi: Allow raw access to KCS devices
In-Reply-To: <6ff29d26-543a-4790-abb4-ebaa3f8d0265@www.fastmail.com>
References: <20210319061952.145040-1-andrew@aj.id.au>
 <2db77e16-3f44-4c02-a7ba-a4fac8141ae3@www.fastmail.com>
 <20210408121441.GG7166@minyard.net>
 <6ff29d26-543a-4790-abb4-ebaa3f8d0265@www.fastmail.com>
Message-ID: <CACPK8Xc5HC7TZ6cUDH6+uHQO1LQCZE0YeENua1sE8nDXs0R2mg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 8 Apr 2021 at 23:47, Andrew Jeffery <andrew@aj.id.au> wrote:
> On Thu, 8 Apr 2021, at 21:44, Corey Minyard wrote:
> > On Thu, Apr 08, 2021 at 10:27:46AM +0930, Andrew Jeffery wrote:

> > > > 1. It begins with patches 1-5 put together by Chia-Wei, which I've
> > > > rebased on v5.12-rc2. These fix the ASPEED LPC bindings and other
> > > > non-KCS LPC-related ASPEED device drivers in a way that enables the
> > > > SerIRQ patches at the end of the series. With Joel's review I'm hoping
> > > > these 5 can go through the aspeed tree, and that the rest can go through
> > > > the IPMI tree.

> > > >
> > > > Please review!
> > >
> > > Unfortunately the cover letter got detached from the rest of the series.
> > >
> > > Any chance you can take a look at the patches?
> >
> > There were some minor concerns that were unanswered, and there really
> > was no review by others for many of the patches.
>
> Right; I was planning to clean up the minor concerns once I'd received
> some more feedback. I could have done a better job of communicating
> that :)

I'll merge the first five through the aspeed tree this coming merge
window. We have acks from the relevant maintainers.

Arnd: would you prefer that this come as it's own pull request, or as
part of the device tree branch?

Andrew, Corey: once I've got my pull requests out I'll look at
reviewing the rest of the series. Perhaps it would pay to re-send that
hunk of patches Andrew with the nits fixed?

Cheers,

Joel
