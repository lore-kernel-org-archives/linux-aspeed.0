From: Matthew Wilcox <willy@infradead.org>
Date: Mon, 28 Feb 2022 23:26:42 +0000
Subject: [PATCH 2/6] treewide: remove using list iterator after loop body
 as a ptr
In-Reply-To: <CAHk-=wgBfJ1-cPA2LTvFyyy8owpfmtCuyiZi4+um8DhFNe+CyA@mail.gmail.com>
References: <20220228110822.491923-1-jakobkoschel@gmail.com>
 <20220228110822.491923-3-jakobkoschel@gmail.com>
 <2e4e95d6-f6c9-a188-e1cd-b1eae465562a@amd.com>
 <CAHk-=wgQps58DPEOe4y5cTh5oE9EdNTWRLXzgMiETc+mFX7jzw@mail.gmail.com>
 <CAHk-=wj8fkosQ7=bps5K+DDazBXk=ypfn49A0sEq+7-nZnyfXA@mail.gmail.com>
 <CAHk-=wiTCvLQkHcJ3y0hpqH7FEk9D28LDvZZogC6OVLk7naBww@mail.gmail.com>
 <Yh0tl3Lni4weIMkl@casper.infradead.org>
 <CAHk-=wgBfJ1-cPA2LTvFyyy8owpfmtCuyiZi4+um8DhFNe+CyA@mail.gmail.com>
Message-ID: <Yh1aMm3hFe/j9ZbI@casper.infradead.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Feb 28, 2022 at 12:37:15PM -0800, Linus Torvalds wrote:
> On Mon, Feb 28, 2022 at 12:16 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > Then we can never use -Wshadow ;-(  I'd love to be able to turn it on;
> > it catches real bugs.
> 
> Oh, we already can never use -Wshadow regardless of things like this.
> That bridge hasn't just been burned, it never existed in the first
> place.
> 
> The whole '-Wshadow' thing simply cannot work with local variables in
> macros - something that we've used since day 1.
> 
> Try this (as a "p.c" file):
> 
>         #define min(a,b) ({                     \
>                 typeof(a) __a = (a);            \
>                 typeof(b) __b = (b);            \
>                 __a < __b ? __a : __b; })
> 
>         int min3(int a, int b, int c)
>         {
>                 return min(a,min(b,c));
>         }
> 
> and now do "gcc -O2 -S t.c".
> 
> Then try it with -Wshadow.

#define ___PASTE(a, b)	a##b
#define __PASTE(a, b) ___PASTE(a, b)
#define _min(a, b, u) ({         \
        typeof(a) __PASTE(__a,u) = (a);            \
        typeof(b) __PASTE(__b,u) = (b);            \
        __PASTE(__a,u) < __PASTE(__b,u) ? __PASTE(__a,u) : __PASTE(__b,u); })

#define min(a, b) _min(a, b, __COUNTER__)

int min3(int a, int b, int c)
{
        return min(a,min(b,c));
}

(probably there's a more elegant way to do this)
