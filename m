From: David Laight <David.Laight@ACULAB.COM>
Date: Thu, 3 Mar 2022 09:30:14 +0000
Subject: [PATCH 2/6] treewide: remove using list iterator after loop body
 as a ptr
In-Reply-To: <20220303072657.11124-1-xiam0nd.tong@gmail.com>
References: <39404befad5b44b385698ff65465abe5@AcuMS.aculab.com>
 <20220303072657.11124-1-xiam0nd.tong@gmail.com>
Message-ID: <2d208771c50b4c6db4f43039e9d62851@AcuMS.aculab.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Xiaomeng Tong
> Sent: 03 March 2022 07:27
> 
> On Thu, 3 Mar 2022 04:58:23 +0000, David Laight wrote:
> > on 3 Mar 2022 10:27:29 +0800, Xiaomeng Tong wrote:
> > > The problem is the mis-use of iterator outside the loop on exit, and
> > > the iterator will be the HEAD's container_of pointer which pointers
> > > to a type-confused struct. Sidenote: The *mis-use* here refers to
> > > mistakely access to other members of the struct, instead of the
> > > list_head member which acutally is the valid HEAD.
> >
> > The problem is that the HEAD's container_of pointer should never
> > be calculated at all.
> > This is what is fundamentally broken about the current definition.
> 
> Yes, the rule is "the HEAD's container_of pointer should never be
> calculated at all outside the loop", but how do you make sure everyone
> follows this rule?
> Everyone makes mistakes, but we can eliminate them all from the beginning
> with the help of compiler which can catch such use-after-loop things.
> 
> > > IOW, you would dereference a (NULL + offset_of_member) address here.
> >
> >Where?
> 
> In the case where a developer do not follows the above rule, and mistakely
> access a non-list-head member of the HEAD's container_of pointer outside
> the loop. For example:
>     struct req{
>       int a;
>       struct list_head h;
>     }
>     struct req *r;
>     list_for_each_entry(r, HEAD, h) {
>       if (r->a == 0x10)
>         break;
>     }
>     // the developer made a mistake: he didn't take this situation into
>     // account where all entries in the list are *r->a != 0x10*, and now
>     // the r is the HEAD's container_of pointer.
>     r->a = 0x20;
> Thus the "r->a = 0x20" would dereference a (NULL + offset_of_member)
> address here.

That is just a bug.
No different to failing to check anything else might 'return'
a NULL pointer.
Because it is a NULL dereference you find out pretty quickly.
The existing loop leaves you with a valid pointer to something
that isn't a list item.

> > > Please remind me if i missed something, thanks.
> > >
> > > Can you share your "alternative definitions" details? thanks!
> >
> > The loop should probably use as extra variable that points
> > to the 'list node' in the next structure.
> > Something like:
> > 	for (xxx *iter = head->next;
> > 		iter == &head ? ((item = NULL),0) : ((item = list_item(iter),1));
> > 		iter = item->member->next) {
> > 	   ...
> > With a bit of casting you can use 'item' to hold 'iter'.
> 
> you still can not make sure everyone follows this rule:
> "do not use iterator outside the loop" without the help of compiler,
> because item is declared outside the loop.

That one has 'iter' defined in the loop.

> BTW, to avoid ambiguity?the "alternative definitions" here i asked is
> something from you in this context:
> "OTOH there may be alternative definitions that can be used to get
> the compiler (or other compiler-like tools) to detect broken code.
> Even if the definition can't possibly generate a working kerrnel."

I was thinking of something like:
	if ((pos = list_first)), 1) pos = NULL else
so that unchecked dereferences after the loop will be detectable
as NULL pointer offsets - but that in itself isn't enough to avoid
other warnings.

> > > The "list_for_each_entry_inside(pos, type, head, member)" way makes
> > > the iterator invisiable outside the loop, and would be catched by
> > > compiler if use-after-loop things happened.
> 
> > It is also a compete PITA for anything doing a search.
> 
> You mean it would be a burden on search? can you show me some examples?

The whole business of having to save the pointer to the located item
before breaking the loop, remembering to have set it to NULL earlier etc.

It is so much better if you can just do:
		if (found)
			break;

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
