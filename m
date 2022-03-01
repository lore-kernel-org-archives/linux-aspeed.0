From: Greg KH <greg@kroah.com>
Date: Tue, 1 Mar 2022 18:36:27 +0100
Subject: [PATCH 2/6] treewide: remove using list iterator after loop body
 as a ptr
In-Reply-To: <CEDAD0D9-56EE-4105-9107-72C2EAD940B0@gmail.com>
References: <20220228110822.491923-1-jakobkoschel@gmail.com>
 <20220228110822.491923-3-jakobkoschel@gmail.com>
 <2e4e95d6-f6c9-a188-e1cd-b1eae465562a@amd.com>
 <CAHk-=wgQps58DPEOe4y5cTh5oE9EdNTWRLXzgMiETc+mFX7jzw@mail.gmail.com>
 <CAHk-=wj8fkosQ7=bps5K+DDazBXk=ypfn49A0sEq+7-nZnyfXA@mail.gmail.com>
 <CAHk-=wiTCvLQkHcJ3y0hpqH7FEk9D28LDvZZogC6OVLk7naBww@mail.gmail.com>
 <FC710A1A-524E-481B-A668-FC258F529A2E@gmail.com>
 <CAHk-=whLK11HyvpUtEftOjc3Gup2V77KpAQ2fycj3uai=qceHw@mail.gmail.com>
 <CEDAD0D9-56EE-4105-9107-72C2EAD940B0@gmail.com>
Message-ID: <Yh5ZmwiH5AxtQ69K@kroah.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Mar 01, 2022 at 12:28:15PM +0100, Jakob Koschel wrote:
> 
> 
> > On 1. Mar 2022, at 01:41, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > 
> > On Mon, Feb 28, 2022 at 1:47 PM Jakob Koschel <jakobkoschel@gmail.com> wrote:
> >> 
> >> The goal of this is to get compiler warnings right? This would indeed be great.
> > 
> > Yes, so I don't mind having a one-time patch that has been gathered
> > using some automated checker tool, but I don't think that works from a
> > long-term maintenance perspective.
> > 
> > So if we have the basic rule being "don't use the loop iterator after
> > the loop has finished, because it can cause all kinds of subtle
> > issues", then in _addition_ to fixing the existing code paths that
> > have this issue, I really would want to (a) get a compiler warning for
> > future cases and (b) make it not actually _work_ for future cases.
> > 
> > Because otherwise it will just happen again.
> > 
> >> Changing the list_for_each_entry() macro first will break all of those cases
> >> (e.g. the ones using 'list_entry_is_head()).
> > 
> > So I have no problems with breaking cases that we basically already
> > have a patch for due to  your automated tool. There were certainly
> > more than a handful, but it didn't look _too_ bad to just make the
> > rule be "don't use the iterator after the loop".
> > 
> > Of course, that's just based on that patch of yours. Maybe there are a
> > ton of other cases that your patch didn't change, because they didn't
> > match your trigger case, so I may just be overly optimistic here.
> 
> Based on the coccinelle script there are ~480 cases that need fixing
> in total. I'll now finish all of them and then split them by
> submodules as Greg suggested and repost a patch set per submodule.
> Sounds good?

Sounds good to me!

If you need help carving these up and maintaining them over time as
different subsystem maintainers accept/ignore them, just let me know.
Doing large patchsets like this can be tough without a lot of
experience.

thanks,

greg k-h
