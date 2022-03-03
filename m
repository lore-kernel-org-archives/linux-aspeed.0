From: David Laight <David.Laight@ACULAB.COM>
Date: Thu, 3 Mar 2022 04:58:23 +0000
Subject: [PATCH 2/6] treewide: remove using list iterator after loop body
 as a ptr
In-Reply-To: <20220303022729.9321-1-xiam0nd.tong@gmail.com>
References: <1077f17e50d34dc2bbfdf4e52a1cb2fd@AcuMS.aculab.com>
 <20220303022729.9321-1-xiam0nd.tong@gmail.com>
Message-ID: <39404befad5b44b385698ff65465abe5@AcuMS.aculab.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Xiaomeng Tong
> Sent: 03 March 2022 02:27
> 
> On Wed, 2 Mar 2022 14:04:06 +0000, David Laight
> <David.Laight@ACULAB.COM> wrote:
> > I think that it would be better to make any alternate loop macro
> > just set the variable to NULL on the loop exit.
> > That is easier to code for and the compiler might be persuaded to
> > not redo the test.
> 
> No, that would lead to a NULL dereference.

Why, it would make it b ethe same as the 'easy to use':
	for (item = head; item; item = item->next) {
		...
		if (...)
			break;
		...
	}
	if (!item)
		return;
 
> The problem is the mis-use of iterator outside the loop on exit, and
> the iterator will be the HEAD's container_of pointer which pointers
> to a type-confused struct. Sidenote: The *mis-use* here refers to
> mistakely access to other members of the struct, instead of the
> list_head member which acutally is the valid HEAD.

The problem is that the HEAD's container_of pointer should never
be calculated at all.
This is what is fundamentally broken about the current definition.

> IOW, you would dereference a (NULL + offset_of_member) address here.

Where?

> Please remind me if i missed something, thanks.
>
> Can you share your "alternative definitions" details? thanks!

The loop should probably use as extra variable that points
to the 'list node' in the next structure.
Something like:
	for (xxx *iter = head->next;
		iter == &head ? ((item = NULL),0) : ((item = list_item(iter),1));
		iter = item->member->next) {
	   ...
With a bit of casting you can use 'item' to hold 'iter'.

> 
> > OTOH there may be alternative definitions that can be used to get
> > the compiler (or other compiler-like tools) to detect broken code.
> > Even if the definition can't possibly generate a working kerrnel.
> 
> The "list_for_each_entry_inside(pos, type, head, member)" way makes
> the iterator invisiable outside the loop, and would be catched by
> compiler if use-after-loop things happened.

It is also a compete PITA for anything doing a search.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

