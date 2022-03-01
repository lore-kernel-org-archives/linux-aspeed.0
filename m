From: David Laight <David.Laight@ACULAB.COM>
Date: Tue, 1 Mar 2022 22:58:11 +0000
Subject: [PATCH 2/6] treewide: remove using list iterator after loop body
 as a ptr
In-Reply-To: <CAHk-=wiT5HX6Kp0Qv4ZYK_rkq9t5fZ5zZ7vzvi6pub9kgp=72g@mail.gmail.com>
References: <20220228110822.491923-1-jakobkoschel@gmail.com>
 <20220228110822.491923-3-jakobkoschel@gmail.com>
 <2e4e95d6-f6c9-a188-e1cd-b1eae465562a@amd.com>
 <CAHk-=wgQps58DPEOe4y5cTh5oE9EdNTWRLXzgMiETc+mFX7jzw@mail.gmail.com>
 <282f0f8d-f491-26fc-6ae0-604b367a5a1a@amd.com>
 <b2d20961dbb7533f380827a7fcc313ff849875c1.camel@HansenPartnership.com>
 <7D0C2A5D-500E-4F38-AD0C-A76E132A390E@kernel.org>
 <73fa82a20910c06784be2352a655acc59e9942ea.camel@HansenPartnership.com>
 <CAHk-=wiT5HX6Kp0Qv4ZYK_rkq9t5fZ5zZ7vzvi6pub9kgp=72g@mail.gmail.com>
Message-ID: <7dc860874d434d2288f36730d8ea3312@AcuMS.aculab.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Linus Torvalds
> Sent: 01 March 2022 19:07
> On Mon, Feb 28, 2022 at 2:29 PM James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> >
> > However, if the desire is really to poison the loop variable then we
> > can do
> >
> > #define list_for_each_entry(pos, head, member)                          \
> >         for (pos = list_first_entry(head, typeof(*pos), member);        \
> >              !list_entry_is_head(pos, head, member) && ((pos = NULL) == NULL;                   \
> >              pos = list_next_entry(pos, member))
> >
> > Which would at least set pos to NULL when the loop completes.
> 
> That would actually have been excellent if we had done that
> originally. It would not only avoid the stale and incorrectly typed
> head entry left-over turd, it would also have made it very easy to
> test for "did I find an entry in the loop".
> 
> But I don't much like it in the situation we are now.
> 
> Why? Mainly because it basically changes the semantics of the loop
> _without_ any warnings about it.  And we don't actually get the
> advantage of the nicer semantics, because we can't actually make code
> do
> 
>         list_for_each_entry(entry, ....) {
>                 ..
>         }
>         if (!entry)
>                 return -ESRCH;
>         .. use the entry we found ..
> 
> because that would be a disaster for back-porting, plus it would be a
> flag-day issue (ie we'd have to change the semantics of the loop at
> the same time we change every single user).
> 
> So instead of that simple "if (!entry)", we'd effectively have to
> continue to use something that still works with the old world order
> (ie that "if (list_entry_is_head())" model).
> 
> So we couldn't really take _advantage_ of the nicer semantics, and
> we'd not even get a warning if somebody does it wrong - the code would
> just silently do the wrong thing.
> 
> IOW: I don't think you are wrong about that patch: it would solve the
> problem that Jakob wants to solve, and it would have absolutely been
> much better if we had done this from the beginning. But I think that
> in our current situation, it's actually a really fragile solution to
> the "don't do that then" problem we have.

Can it be resolved by making:
#define list_entry_is_head(pos, head, member) ((pos) == NULL)
and double-checking that it isn't used anywhere else (except in
the list macros themselves).

The odd ones I just found are fs/locks.c mm/page_reporting.c
security/apparmor/apparmorfs.c (3 times)

net/xfrm/xfrm_ipcomp.c#L244 is buggy.
(There is a WARN_ON() then it just carries on regardless!)

There are only about 25 uses of list_entry_is_head().

There are a lot more places where these lists seem to be scanned by hand.
I bet a few of those aren't actually right either.

(Oh at 3am this morning I thought it was a different list type
that could have much the same problem!)

Another plausible solution is a variant of list_foreach_entry()
that does set the 'entry' to NULL at the end.
Then code can be moved over in stages.
I'd reorder the arguments as well as changing the name!

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
