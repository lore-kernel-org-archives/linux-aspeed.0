From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Mon, 28 Feb 2022 17:28:58 -0500
Subject: [PATCH 2/6] treewide: remove using list iterator after loop
 body as a ptr
In-Reply-To: <7D0C2A5D-500E-4F38-AD0C-A76E132A390E@kernel.org>
References: <20220228110822.491923-1-jakobkoschel@gmail.com>
 <20220228110822.491923-3-jakobkoschel@gmail.com>
 <2e4e95d6-f6c9-a188-e1cd-b1eae465562a@amd.com>
 <CAHk-=wgQps58DPEOe4y5cTh5oE9EdNTWRLXzgMiETc+mFX7jzw@mail.gmail.com>
 <282f0f8d-f491-26fc-6ae0-604b367a5a1a@amd.com>
 <b2d20961dbb7533f380827a7fcc313ff849875c1.camel@HansenPartnership.com>
 <7D0C2A5D-500E-4F38-AD0C-A76E132A390E@kernel.org>
Message-ID: <73fa82a20910c06784be2352a655acc59e9942ea.camel@HansenPartnership.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 2022-02-28 at 23:59 +0200, Mike Rapoport wrote:
> 
> On February 28, 2022 10:42:53 PM GMT+02:00, James Bottomley <
> James.Bottomley at HansenPartnership.com> wrote:
> > On Mon, 2022-02-28 at 21:07 +0100, Christian K?nig wrote:
[...]
> > > > I do wish we could actually poison the 'pos' value after the
> > > > loop somehow - but clearly the "might be uninitialized" I was
> > > > hoping for isn't the way to do it.
> > > > 
> > > > Anybody have any ideas?
> > > 
> > > I think we should look at the use cases why code is touching
> > > (pos) after the loop.
> > > 
> > > Just from skimming over the patches to change this and experience
> > > with the drivers/subsystems I help to maintain I think the
> > > primary pattern looks something like this:
> > > 
> > > list_for_each_entry(entry, head, member) {
> > >      if (some_condition_checking(entry))
> > >          break;
> > > }
> > > do_something_with(entry);
> > 
> > Actually, we usually have a check to see if the loop found
> > anything, but in that case it should something like
> > 
> > if (list_entry_is_head(entry, head, member)) {
> >    return with error;
> > }
> > do_somethin_with(entry);
> > 
> > Suffice?  The list_entry_is_head() macro is designed to cope with
> > the bogus entry on head problem.
> 
> Won't suffice because the end goal of this work is to limit scope of
> entry only to loop. Hence the need for additional variable.

Well, yes, but my objection is more to the size of churn than the
desire to do loop local.  I'm not even sure loop local is possible,
because it's always annoyed me that for (int i = 0; ...  in C++ defines
i in the outer scope not the loop scope, which is why I never use it.

However, if the desire is really to poison the loop variable then we
can do

#define list_for_each_entry(pos, head, member)				\
	for (pos = list_first_entry(head, typeof(*pos), member);	\
	     !list_entry_is_head(pos, head, member) && ((pos = NULL) == NULL;			\
	     pos = list_next_entry(pos, member))

Which would at least set pos to NULL when the loop completes.

> Besides, there are no guarantees that people won't
> do_something_with(entry) without the check or won't compare entry to
> NULL to check if the loop finished with break or not.

I get the wider goal, but we have to patch the problem cases now and a
simple one-liner is better than a larger patch that may or may not work
if we ever achieve the local definition or value poisoning idea.  I'm
also fairly certain coccinelle can come up with a use without checking
for loop completion semantic patch which we can add to 0day.

James


