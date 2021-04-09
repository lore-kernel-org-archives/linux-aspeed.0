From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 9 Apr 2021 10:13:36 +0200
Subject: [PATCH v2 00/21] ipmi: Allow raw access to KCS devices
In-Reply-To: <CACPK8Xc5HC7TZ6cUDH6+uHQO1LQCZE0YeENua1sE8nDXs0R2mg@mail.gmail.com>
References: <20210319061952.145040-1-andrew@aj.id.au>
 <2db77e16-3f44-4c02-a7ba-a4fac8141ae3@www.fastmail.com>
 <20210408121441.GG7166@minyard.net>
 <6ff29d26-543a-4790-abb4-ebaa3f8d0265@www.fastmail.com>
 <CACPK8Xc5HC7TZ6cUDH6+uHQO1LQCZE0YeENua1sE8nDXs0R2mg@mail.gmail.com>
Message-ID: <CAK8P3a2ch82=QccNZboa-e1tVaotyJfGFTfqDuQCO0xPVitXgA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Apr 9, 2021 at 6:09 AM Joel Stanley <joel@jms.id.au> wrote:
> On Thu, 8 Apr 2021 at 23:47, Andrew Jeffery <andrew@aj.id.au> wrote:
> > On Thu, 8 Apr 2021, at 21:44, Corey Minyard wrote:
> > > On Thu, Apr 08, 2021 at 10:27:46AM +0930, Andrew Jeffery wrote:
> > > There were some minor concerns that were unanswered, and there really
> > > was no review by others for many of the patches.
> >
> > Right; I was planning to clean up the minor concerns once I'd received
> > some more feedback. I could have done a better job of communicating
> > that :)
>
> I'll merge the first five through the aspeed tree this coming merge
> window. We have acks from the relevant maintainers.
>
> Arnd: would you prefer that this come as it's own pull request, or as
> part of the device tree branch?

When you are unsure, it's almost never wrong to go for a separate
branch, which gives you a chance to have a concise description
of the contents in the tag. This would be particularly helpful if there
are incompatible changes to the DT binding that require a justification.

If you are only adding a few DT nodes to existing files, then merging
these through the regular branch is probably easier.

       Arnd
