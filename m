From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 1 Mar 2022 11:42:26 -0800
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
Message-ID: <CAHk-=wghQygmASNUWj=LZn5FR5wsce2osyR6EXcfEB_FaX_6Og@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Mar 1, 2022 at 11:06 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So instead of that simple "if (!entry)", we'd effectively have to
> continue to use something that still works with the old world order
> (ie that "if (list_entry_is_head())" model).

Just to prove my point about how this is painful, that doesn't work at all.

If the loop iterator at the end is NULL (good, in theory), we can't
use "list_entry_is_head()" to check whether we ended. We'd have to use
a new thing entirely, to handle the "list_for_each_entry() has the
old/new semantics" cases.

That's largely why I was pushing for the "let's make it impossible to
use the loop iterator at all outside the loop". It avoids the
confusing case, and the patches to move to that stricter semantic can
be merged independently (and before) doing the actual semantic change.

I'm not saying my suggested approach is wonderful either. Honestly,
it's painful that we have so nasty semantics for the end-of-loop case
for list_for_each_entry().

The minimal patch would clearly be to keep those broken semantics, and
just force everybody to use the list_entry_is_head() case. That's the
"we know we messed up, we are too lazy to fix it, we'll just work
around it and people need to be careful" approach.

And laziness is a virtue. But bad semantics are bad semantics. So it's
a question of balancing those two issues.

               Linus
