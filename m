From: David Laight <David.Laight@ACULAB.COM>
Date: Mon, 7 Mar 2022 15:26:48 +0000
Subject: [PATCH 0/6] Remove usage of list iterator past the loop body
In-Reply-To: <20220307150037.GD3293@kadam>
References: <20220228110822.491923-1-jakobkoschel@gmail.com>
 <20220307150037.GD3293@kadam>
Message-ID: <f7ffd78aa68340e1ade6af15fa2f06d8@AcuMS.aculab.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Dan Carpenter
> Sent: 07 March 2022 15:01
> 
> Updating this API is risky because some places rely on the old behavior
> and not all of them have been updated.  Here are some additional places
> you might want to change.

I really can't help thinking that trying to merge this patch is
actually impossible.
It affects far too many different parts of the tree.

Since (I believe) this is a doubly linked list with forwards and
backwards pointers that point to a 'node' (not that there is a
nice comment to that effect in the header - and there are lots of
ways to do linked lists) the 'head' pretty much has to be a 'node'.

I'd write the following new defines (but I might be using
the old names here):

list_first(head, field) First item, NULL if empty.
list_last(head, field) Last item NULL if empty.
list_next(head, item, field) Item after 'item', NULL if last.
list_prev(head, item. field) Item before 'item', NULL if first.

You get (something like):
#define list_first(head, field) \
	head->next == &head ? NULL : list_item(head->next, field)
(probably needs typeof(item) from somewhere).

The iterator loop is then just:
#define loop_iterate(item, head, field) \
	for (item = list_first(head, field); item; \
		item = list_next(head, item, field)

I'm not sure, but making the 'head' be a structure that contains
a single member that is a 'node' might help type checking.

Then all the code that uses the current defines can slowly be
moved over (probably a couple of releases) before the existing
defines are deleted.

That should simplify all the open-coded search loops that are
just as likely to be buggy (possibly more so).

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

