From: Xiaomeng Tong <xiam0nd.tong@gmail.com>
Date: Wed,  2 Mar 2022 17:31:06 +0800
Subject: [PATCH 2/6] treewide: remove using list iterator after loop body
 as a ptr
In-Reply-To: <CAHk-=whLK11HyvpUtEftOjc3Gup2V77KpAQ2fycj3uai=qceHw@mail.gmail.com>
References: <CAHk-=whLK11HyvpUtEftOjc3Gup2V77KpAQ2fycj3uai=qceHw@mail.gmail.com>
Message-ID: <20220302093106.8402-1-xiam0nd.tong@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 28 Feb 2022 16:41:04 -0800, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But basically to _me_, the important part is that the end result is
> maintainable longer-term.

I couldn't agree more. And because of that, I stick with the following
approach because it's maintainable longer-term than "type(pos) pos" one:
 Implements a new macro for each list_for_each_entry* with _inside suffix.
  #define list_for_each_entry_inside(pos, type, head, member)

I have posted a patch series here to demonstrate this approach:
https://lore.kernel.org/lkml/20220301075839.4156-3-xiam0nd.tong at gmail.com/

Although we need replace all the use of list_for_each_entry* (15000+)
with list_for_each_entry*_inside, the work can be done gradually rather
than all at once. We can incrementally replace these callers until
all these in the kernel are completely updated with *_inside* one. At
that time, we can just remove the implements of origin macros and rename
the *_inside* macro back to the origin name just in one single patch.

And the "type(pos) pos" approach need teach developers to "not initialize
the iterator variable, otherwise the use-after-loop will not be reported by
compiler", which is unreasonable and impossible for all developers. 

And it will mess up the following code logic and no warnning reported by
compiler, even without initializing "ext" at the beginning:
void foo(struct mem_extent *arg) {
  struct mem_extent *ext;  // used both for iterator and normal ptr
  ...
  ext = arg;  // this assignment can alse be done in another bar() func
  ...
  list_for_each_entry(ext, head, member) {
    if (found(ext))
       break;
  }
  ...
  // use ext after the loop
  ret = ext;
}
If the loop hit the break, the last "ret" will be the found ext iterator.
However, if the "type(pos) pos" approach applied, the last "ret" will be
"arg" which is not the intention of the developers, because the "ext" is
two different variables inside and outside the loop.

Thus, my idea is *better a finger off than always aching*, let's choose
the "list_for_each_entry_inside(pos, type, head, member)" approach.

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

we can pass a shorter type name to list_for_each_entry_inside, thus no
need to split it over two lines. Actually it is not a big problem.
+ #define t struct sram_bank_info
- list_for_each_entry(pos, head, member) {
+ list_for_each_entry_inside(pos, t, head, member) {

I put the type at the second argument not the first to avoid messing up
the pattern match in some coccinelle scripts.

>  (b) gives us a nice warning for any normal use-after-loop case
> (unless you explicitly initialized it like that
> sgx_mmu_notifier_release() function did for no good reason

sometimes developers can be confused by the reported warnning:
"used without having been initialized", and can not figure out immediately
that "oh, now i am using another different variable but with the same name
of the loop iterator variable", which has changed the programming habits
of developers.

>  (c) also guarantees that even if you don't get a warning,
> non-converted (or newly written) bad code won't actually _work_
>
> so you end up getting the new rules without any ambiguity or mistaken

It will lead to a wrong/NULL pointer dereference if the pointer is used
anywhere else, depend on which value is used to initialized with.

Best regard,
--
Xiaomeng Tong
