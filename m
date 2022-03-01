From: David Laight <David.Laight@ACULAB.COM>
Date: Tue, 1 Mar 2022 23:19:46 +0000
Subject: [PATCH 2/6] treewide: remove using list iterator after loop body
 as a ptr
In-Reply-To: <CAHk-=whKqg89zu4T95+ctY-hocR6kDArpo2qO14-kV40Ga7ufw@mail.gmail.com>
References: <20220228110822.491923-1-jakobkoschel@gmail.com>
 <20220228110822.491923-3-jakobkoschel@gmail.com>
 <2e4e95d6-f6c9-a188-e1cd-b1eae465562a@amd.com>
 <CAHk-=wgQps58DPEOe4y5cTh5oE9EdNTWRLXzgMiETc+mFX7jzw@mail.gmail.com>
 <282f0f8d-f491-26fc-6ae0-604b367a5a1a@amd.com>
 <b2d20961dbb7533f380827a7fcc313ff849875c1.camel@HansenPartnership.com>
 <7D0C2A5D-500E-4F38-AD0C-A76E132A390E@kernel.org>
 <73fa82a20910c06784be2352a655acc59e9942ea.camel@HansenPartnership.com>
 <CAHk-=wiT5HX6Kp0Qv4ZYK_rkq9t5fZ5zZ7vzvi6pub9kgp=72g@mail.gmail.com>
 <7dc860874d434d2288f36730d8ea3312@AcuMS.aculab.com>
 <CAHk-=whKqg89zu4T95+ctY-hocR6kDArpo2qO14-kV40Ga7ufw@mail.gmail.com>
Message-ID: <0ced2b155b984882b39e895f0211037c@AcuMS.aculab.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Linus Torvalds
> Sent: 01 March 2022 23:03
> 
> On Tue, Mar 1, 2022 at 2:58 PM David Laight <David.Laight@aculab.com> wrote:
> >
> > Can it be resolved by making:
> > #define list_entry_is_head(pos, head, member) ((pos) == NULL)
> > and double-checking that it isn't used anywhere else (except in
> > the list macros themselves).
> 
> Well, yes, except for the fact that then the name is entirely misleading...
> 
> And somebody possibly uses it together with list_first_entry() etc, so
> it really is completely broken to mix that change with the list
> traversal change.

Probably true :-(

Actually adding list_entry_not_found() as a synonym for
list_entry_is_head() and changing the 25ish places that
use it after a loop might work.

Once that is done the loop can be changed at the same time
as list_entry_not_found().
That won't affect the in-tree callers.
(and my out of tree modules don't use those lists - so I
don't care about that!)

Having said that there are so few users of list_entry_is_head()
it is reasonable to generate two new names.
One for use after list_for_each_entry() and one for list_next_entry().
Then the change all the call sites.
After that list_entry_is_head() can be deleted - breaking out of
tree compiles.
Finally list_for_each_entry() can be rewritten to set NULL
at the end of the list.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
