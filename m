From: Jakob Koschel <jakobkoschel@gmail.com>
Date: Mon, 28 Feb 2022 22:47:00 +0100
Subject: [PATCH 2/6] treewide: remove using list iterator after loop body
 as a ptr
In-Reply-To: <CAHk-=wiTCvLQkHcJ3y0hpqH7FEk9D28LDvZZogC6OVLk7naBww@mail.gmail.com>
References: <20220228110822.491923-1-jakobkoschel@gmail.com>
 <20220228110822.491923-3-jakobkoschel@gmail.com>
 <2e4e95d6-f6c9-a188-e1cd-b1eae465562a@amd.com>
 <CAHk-=wgQps58DPEOe4y5cTh5oE9EdNTWRLXzgMiETc+mFX7jzw@mail.gmail.com>
 <CAHk-=wj8fkosQ7=bps5K+DDazBXk=ypfn49A0sEq+7-nZnyfXA@mail.gmail.com>
 <CAHk-=wiTCvLQkHcJ3y0hpqH7FEk9D28LDvZZogC6OVLk7naBww@mail.gmail.com>
Message-ID: <FC710A1A-524E-481B-A668-FC258F529A2E@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



> On 28. Feb 2022, at 21:10, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> On Mon, Feb 28, 2022 at 12:03 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>> 
>> Side note: we do need *some* way to do it.
> 
> Ooh.
> 
> This patch is a work of art.
> 
> And I mean that in the worst possible way.
> 
> We can do
> 
>        typeof(pos) pos
> 
> in the 'for ()' loop, and never use __iter at all.
> 
> That means that inside the for-loop, we use a _different_ 'pos' than outside.
> 
> And then the compiler will not see some "might be uninitialized", but
> the outer 'pos' *will* be uninitialized.
> 
> Unless, of course, the outer 'pos' had that pointless explicit initializer.

The goal of this is to get compiler warnings right? This would indeed be great.

Changing the list_for_each_entry() macro first will break all of those cases
(e.g. the ones using 'list_entry_is_head()).
I assumed it is better to fix those cases first and then have a simple
coccinelle script changing the macro + moving the iterator into the scope
of the macro.

> 
> Here - can somebody poke holes in this "work of art" patch?

With this you are no longer able to set the 'outer' pos within the list
iterator loop body or am I missing something? Like this it stays
uninitialized but you'll probably want to set it from within the loop.

You would then yet again need a variable with another name to use
after the loop.

I fail to see how this will make most of the changes in this
patch obsolete (if that was the intention).

> 
>                     Linus
> <patch.diff>

- Jakob

