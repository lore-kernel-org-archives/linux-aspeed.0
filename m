From: Jakob Koschel <jakobkoschel@gmail.com>
Date: Tue, 1 Mar 2022 12:28:15 +0100
Subject: [PATCH 2/6] treewide: remove using list iterator after loop body
 as a ptr
In-Reply-To: <CAHk-=whLK11HyvpUtEftOjc3Gup2V77KpAQ2fycj3uai=qceHw@mail.gmail.com>
References: <20220228110822.491923-1-jakobkoschel@gmail.com>
 <20220228110822.491923-3-jakobkoschel@gmail.com>
 <2e4e95d6-f6c9-a188-e1cd-b1eae465562a@amd.com>
 <CAHk-=wgQps58DPEOe4y5cTh5oE9EdNTWRLXzgMiETc+mFX7jzw@mail.gmail.com>
 <CAHk-=wj8fkosQ7=bps5K+DDazBXk=ypfn49A0sEq+7-nZnyfXA@mail.gmail.com>
 <CAHk-=wiTCvLQkHcJ3y0hpqH7FEk9D28LDvZZogC6OVLk7naBww@mail.gmail.com>
 <FC710A1A-524E-481B-A668-FC258F529A2E@gmail.com>
 <CAHk-=whLK11HyvpUtEftOjc3Gup2V77KpAQ2fycj3uai=qceHw@mail.gmail.com>
Message-ID: <CEDAD0D9-56EE-4105-9107-72C2EAD940B0@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



> On 1. Mar 2022, at 01:41, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> On Mon, Feb 28, 2022 at 1:47 PM Jakob Koschel <jakobkoschel@gmail.com> wrote:
>> 
>> The goal of this is to get compiler warnings right? This would indeed be great.
> 
> Yes, so I don't mind having a one-time patch that has been gathered
> using some automated checker tool, but I don't think that works from a
> long-term maintenance perspective.
> 
> So if we have the basic rule being "don't use the loop iterator after
> the loop has finished, because it can cause all kinds of subtle
> issues", then in _addition_ to fixing the existing code paths that
> have this issue, I really would want to (a) get a compiler warning for
> future cases and (b) make it not actually _work_ for future cases.
> 
> Because otherwise it will just happen again.
> 
>> Changing the list_for_each_entry() macro first will break all of those cases
>> (e.g. the ones using 'list_entry_is_head()).
> 
> So I have no problems with breaking cases that we basically already
> have a patch for due to  your automated tool. There were certainly
> more than a handful, but it didn't look _too_ bad to just make the
> rule be "don't use the iterator after the loop".
> 
> Of course, that's just based on that patch of yours. Maybe there are a
> ton of other cases that your patch didn't change, because they didn't
> match your trigger case, so I may just be overly optimistic here.

Based on the coccinelle script there are ~480 cases that need fixing
in total. I'll now finish all of them and then split them by
submodules as Greg suggested and repost a patch set per submodule.
Sounds good?

> 
> But basically to _me_, the important part is that the end result is
> maintainable longer-term. I'm more than happy to have a one-time patch
> to fix a lot of dubious cases if we can then have clean rules going
> forward.
> 
>> I assumed it is better to fix those cases first and then have a simple
>> coccinelle script changing the macro + moving the iterator into the scope
>> of the macro.
> 
> So that had been another plan of mine, until I actually looked at
> changing the macro. In the one case I looked at, it was ugly beyond
> belief.
> 
> It turns out that just syntactically, it's really nice to give the
> type of the iterator from outside the way we do now. Yeah, it may be a
> bit odd, and maybe it's partly because I'm so used to the
> "list_for_each_list_entry()" syntax, but moving the type into the loop
> construct really made it nasty - either one very complex line, or
> having to split it over two lines which was even worse.
> 
> Maybe the place I looked at just happened to have a long typename, but
> it's basically always going to be a struct, so it's never a _simple_
> type. And it just looked very odd adn unnatural to have the type as
> one of the "arguments" to that list_for_each_entry() macro.
> 
> So yes, initially my idea had been to just move the iterator entirely
> inside the macro. But specifying the type got so ugly that I think
> that
> 
>        typeof (pos) pos
> 
> trick inside the macro really ends up giving us the best of all worlds:
> 
> (a) let's us keep the existing syntax and code for all the nice cases
> that did everything inside the loop anyway
> 
> (b) gives us a nice warning for any normal use-after-loop case
> (unless you explicitly initialized it like that
> sgx_mmu_notifier_release() function did for no good reason
> 
> (c) also guarantees that even if you don't get a warning,
> non-converted (or newly written) bad code won't actually _work_
> 
> so you end up getting the new rules without any ambiguity or mistaken
> 
>> With this you are no longer able to set the 'outer' pos within the list
>> iterator loop body or am I missing something?
> 
> Correct. Any assignment inside the loop will be entirely just to the
> local loop case. So any "break;" out of the loop will have to set
> another variable - like your updated patch did.
> 
>> I fail to see how this will make most of the changes in this
>> patch obsolete (if that was the intention).
> 
> I hope my explanation above clarifies my thinking: I do not dislike
> your patch, and in fact your patch is indeed required to make the new
> semantics work.

ok it's all clear now, thanks for clarifying.
I've defined all the 'tmp' iterator variables uninitialized so applying
your patch on top of that later will just give the nice compiler warning 
if they are used past the loop body.

> 
> What I disliked was always the maintainability of your patch - making
> the rules be something that isn't actually visible in the source code,
> and letting the old semantics still work as well as they ever did, and
> having to basically run some verification pass to find bad users.

Since this patch is not a complete list of cases that need fixing (30%)
I haven't included the actual change of moving the iterator variable
into the loop and thought that would be a second step coming after this
is merged.

With these changes alone, yes you still rely on manual verification passes.

> 
> (I also disliked your original patch that mixed up the "CPU
> speculation type safety" with the actual non-speculative problems, but
> that was another issue).
> 
>                Linus

- Jakob

