From: David Laight <David.Laight@ACULAB.COM>
Date: Tue, 1 Mar 2022 03:03:52 +0000
Subject: [PATCH 2/6] treewide: remove using list iterator after loop body
 as a ptr
In-Reply-To: <Yh0tl3Lni4weIMkl@casper.infradead.org>
References: <20220228110822.491923-1-jakobkoschel@gmail.com>
 <20220228110822.491923-3-jakobkoschel@gmail.com>
 <2e4e95d6-f6c9-a188-e1cd-b1eae465562a@amd.com>
 <CAHk-=wgQps58DPEOe4y5cTh5oE9EdNTWRLXzgMiETc+mFX7jzw@mail.gmail.com>
 <CAHk-=wj8fkosQ7=bps5K+DDazBXk=ypfn49A0sEq+7-nZnyfXA@mail.gmail.com>
 <CAHk-=wiTCvLQkHcJ3y0hpqH7FEk9D28LDvZZogC6OVLk7naBww@mail.gmail.com>
 <Yh0tl3Lni4weIMkl@casper.infradead.org>
Message-ID: <198022f201814cdc9384ef083741185e@AcuMS.aculab.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Matthew Wilcox
> Sent: 28 February 2022 20:16
> 
> On Mon, Feb 28, 2022 at 12:10:24PM -0800, Linus Torvalds wrote:
> > We can do
> >
> >         typeof(pos) pos
> >
> > in the 'for ()' loop, and never use __iter at all.
> >
> > That means that inside the for-loop, we use a _different_ 'pos' than outside.
> 
> Then we can never use -Wshadow ;-(  I'd love to be able to turn it on;
> it catches real bugs.
> 
> > +#define list_for_each_entry(pos, head, member)					\
> > +	for (typeof(pos) pos = list_first_entry(head, typeof(*pos), member);	\
> > +	     !list_entry_is_head(pos, head, member);	\
> >  	     pos = list_next_entry(pos, member))

Actually can't you use 'pos' to temporarily hold the address of 'member'.
Something like:
	for (pos = (void *)head; \
		pos ? ((pos = (void *)pos - offsetof(member)), 1) : 0; \
		pos = (void *)pos->next)
So that 'pos' is NULL if the loop terminates.
No pointers outside structures are generated.
Probably need to kill list_entry_is_head() - or it just checks for NULL.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

