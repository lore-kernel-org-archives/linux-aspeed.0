From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Mon, 28 Feb 2022 14:53:07 -0600
Subject: [PATCH 2/6] treewide: remove using list iterator after loop body
 as a ptr
In-Reply-To: <CAHk-=wj27SZQ3kPTesBzkiGhe-mA3gOQqr_adt_bMFzmg1VNaA@mail.gmail.com>
References: <20220228110822.491923-1-jakobkoschel@gmail.com>
 <20220228110822.491923-3-jakobkoschel@gmail.com>
 <2e4e95d6-f6c9-a188-e1cd-b1eae465562a@amd.com>
 <CAHk-=wgQps58DPEOe4y5cTh5oE9EdNTWRLXzgMiETc+mFX7jzw@mail.gmail.com>
 <CAHk-=wj8fkosQ7=bps5K+DDazBXk=ypfn49A0sEq+7-nZnyfXA@mail.gmail.com>
 <CAHk-=wiTCvLQkHcJ3y0hpqH7FEk9D28LDvZZogC6OVLk7naBww@mail.gmail.com>
 <CAHk-=wj27SZQ3kPTesBzkiGhe-mA3gOQqr_adt_bMFzmg1VNaA@mail.gmail.com>
Message-ID: <20220228205307.GD614@gate.crashing.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Feb 28, 2022 at 12:14:44PM -0800, Linus Torvalds wrote:
> On Mon, Feb 28, 2022 at 12:10 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > We can do
> >
> >         typeof(pos) pos
> >
> > in the 'for ()' loop, and never use __iter at all.
> >
> > That means that inside the for-loop, we use a _different_ 'pos' than outside.
> 
> The thing that makes me throw up in my mouth a bit is that in that
> 
>         typeof(pos) pos
> 
> the first 'pos' (that we use for just the typeof) is that outer-level
> 'pos', IOW it's a *different* 'pos' than the second 'pos' in that same
> declaration that declares the inner level shadowing new 'pos'
> variable.

The new "pos" has not yet been declared, so this has to refer to the
outer "pos", it cannot be the inner one.  Because it hasn't been
declared yet :-)

Compare this to
  typeof (pos) pos = pos;
where that last "pos" *does* refer to the newly declared one: that
declaration has already been done!  (So this code is UB btw, 6.3.2.1/2).

> If I was a compiler person, I would say "Linus, that thing is too ugly
> to live", and I would hate it. I'm just hoping that even compiler
> people say "that's *so* ugly it's almost beautiful".

It is perfectly well-defined.  Well, it would be good if we (GCC) would
document it does work, and if someone tested it on LLVM as well.  But it
is really hard to implement it to *not* work :-)

> Because it does seem to work. It's not pretty, but hey, it's not like
> our headers are really ever be winning any beauty contests...

It is very pretty!  Needs a comment though :-)


Segher
