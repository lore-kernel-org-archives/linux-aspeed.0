From: Xiaomeng Tong <xiam0nd.tong@gmail.com>
Date: Thu,  3 Mar 2022 15:26:57 +0800
Subject: [PATCH 2/6] treewide: remove using list iterator after loop body
 as a ptr
In-Reply-To: <39404befad5b44b385698ff65465abe5@AcuMS.aculab.com>
References: <39404befad5b44b385698ff65465abe5@AcuMS.aculab.com>
Message-ID: <20220303072657.11124-1-xiam0nd.tong@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 3 Mar 2022 04:58:23 +0000, David Laight wrote:
> on 3 Mar 2022 10:27:29 +0800, Xiaomeng Tong wrote:
> > The problem is the mis-use of iterator outside the loop on exit, and
> > the iterator will be the HEAD's container_of pointer which pointers
> > to a type-confused struct. Sidenote: The *mis-use* here refers to
> > mistakely access to other members of the struct, instead of the
> > list_head member which acutally is the valid HEAD.
>
> The problem is that the HEAD's container_of pointer should never
> be calculated at all.
> This is what is fundamentally broken about the current definition.

Yes, the rule is "the HEAD's container_of pointer should never be
calculated at all outside the loop", but how do you make sure everyone
follows this rule?
Everyone makes mistakes, but we can eliminate them all from the beginning
with the help of compiler which can catch such use-after-loop things.

> > IOW, you would dereference a (NULL + offset_of_member) address here.
>
>Where?

In the case where a developer do not follows the above rule, and mistakely
access a non-list-head member of the HEAD's container_of pointer outside
the loop. For example:
    struct req{
      int a;
      struct list_head h;
    }
    struct req *r;
    list_for_each_entry(r, HEAD, h) {
      if (r->a == 0x10)
        break;
    }
    // the developer made a mistake: he didn't take this situation into
    // account where all entries in the list are *r->a != 0x10*, and now
    // the r is the HEAD's container_of pointer. 
    r->a = 0x20;
Thus the "r->a = 0x20" would dereference a (NULL + offset_of_member)
address here.

> > Please remind me if i missed something, thanks.
> >
> > Can you share your "alternative definitions" details? thanks!
>
> The loop should probably use as extra variable that points
> to the 'list node' in the next structure.
> Something like:
> 	for (xxx *iter = head->next;
> 		iter == &head ? ((item = NULL),0) : ((item = list_item(iter),1));
> 		iter = item->member->next) {
> 	   ...
> With a bit of casting you can use 'item' to hold 'iter'.

you still can not make sure everyone follows this rule: 
"do not use iterator outside the loop" without the help of compiler,
because item is declared outside the loop.

BTW, to avoid ambiguity?the "alternative definitions" here i asked is
something from you in this context:
"OTOH there may be alternative definitions that can be used to get
the compiler (or other compiler-like tools) to detect broken code.
Even if the definition can't possibly generate a working kerrnel."

> > 
> > > OTOH there may be alternative definitions that can be used to get
> > > the compiler (or other compiler-like tools) to detect broken code.
> > > Even if the definition can't possibly generate a working kerrnel.
> > 
> > The "list_for_each_entry_inside(pos, type, head, member)" way makes
> > the iterator invisiable outside the loop, and would be catched by
> > compiler if use-after-loop things happened.

> It is also a compete PITA for anything doing a search.

You mean it would be a burden on search? can you show me some examples?

Or you mean it is too long the list_for_each_entry_inside* string to live
in one single line, and should spilt into two line? If it is the case, there
are 2 way to mitigate it.
1. pass a shorter t as struct type to the macro
2. after all list_for_each_entry macros be replaced with
list_for_each_entry_inside, remove the list_for_each_entry implementations
and rename all list_for_each_entry_inside use back to the origin
list_for_each_entry in a single patch.

For me, it is acceptable and not a such big problem.

--
Xiaomeng Tong
