From: David Laight <David.Laight@ACULAB.COM>
Date: Tue, 1 Mar 2022 02:15:09 +0000
Subject: [PATCH 2/6] treewide: remove using list iterator after loop body
 as a ptr
In-Reply-To: <CAHk-=wgQps58DPEOe4y5cTh5oE9EdNTWRLXzgMiETc+mFX7jzw@mail.gmail.com>
References: <20220228110822.491923-1-jakobkoschel@gmail.com>
 <20220228110822.491923-3-jakobkoschel@gmail.com>
 <2e4e95d6-f6c9-a188-e1cd-b1eae465562a@amd.com>
 <CAHk-=wgQps58DPEOe4y5cTh5oE9EdNTWRLXzgMiETc+mFX7jzw@mail.gmail.com>
Message-ID: <d245f691cfdf43d9a1e1e33acb570325@AcuMS.aculab.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Linus Torvalds
> Sent: 28 February 2022 19:56
> On Mon, Feb 28, 2022 at 4:19 AM Christian K?nig
> <christian.koenig@amd.com> wrote:
> >
> > I don't think that using the extra variable makes the code in any way
> > more reliable or easier to read.
> 
> So I think the next step is to do the attached patch (which requires
> that "-std=gnu11" that was discussed in the original thread).
> 
> That will guarantee that the 'pos' parameter of list_for_each_entry()
> is only updated INSIDE the for_each_list_entry() loop, and can never
> point to the (wrongly typed) head entry.
> 
> And I would actually hope that it should actually cause compiler
> warnings about possibly uninitialized variables if people then use the
> 'pos' pointer outside the loop. Except
> 
>  (a) that code in sgx/encl.c currently initializes 'tmp' to NULL for
> inexplicable reasons - possibly because it already expected this
> behavior
> 
>  (b) when I remove that NULL initializer, I still don't get a warning,
> because we've disabled -Wno-maybe-uninitialized since it results in so
> many false positives.
> 
> Oh well.
> 
> Anyway, give this patch a look, and at least if it's expanded to do
> "(pos) = NULL" in the entry statement for the for-loop, it will avoid
> the HEAD type confusion that Jakob is working on. And I think in a
> cleaner way than the horrid games he plays.
> 
> (But it won't avoid possible CPU speculation of such type confusion.
> That, in my opinion, is a completely different issue)
> 
> I do wish we could actually poison the 'pos' value after the loop
> somehow - but clearly the "might be uninitialized" I was hoping for
> isn't the way to do it.
> 
> Anybody have any ideas?
> 
>                 Linus
diff --git a/include/linux/list.h b/include/linux/list.h
index dd6c2041d09c..bab995596aaa 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -634,10 +634,10 @@ static inline void list_splice_tail_init(struct list_head *list,
  * @head:	the head for your list.
  * @member:	the name of the list_head within the struct.
  */
-#define list_for_each_entry(pos, head, member)				\
-	for (pos = list_first_entry(head, typeof(*pos), member);	\
-	     !list_entry_is_head(pos, head, member);			\
-	     pos = list_next_entry(pos, member))
+#define list_for_each_entry(pos, head, member)					\
+	for (typeof(pos) __iter = list_first_entry(head, typeof(*pos), member);	\
+	     !list_entry_is_head(__iter, head, member) && (((pos)=__iter),1);	\
+	     __iter = list_next_entry(__iter, member))
 
 /**
  * list_for_each_entry_reverse - iterate backwards over list of given type.

I think you actually want:
	!list_entry_is_head(__iter, head, member) ? (((pos)=__iter),1) : (((pos) = NULL),0);

Which can be done in the original by:
	!list_entry_is_head(pos, head, member) ? 1 : (((pos) = NULL), 0);

Although it would be safer to have (without looking up the actual name):
	for (item *__item = head; \
		__item ? (((pos) = list_item(__item, member)), 1) : (((pos) = NULL), 0);
		__item = (pos)->member)

The local does need 'fixing' to avoid shadowing for nested loops.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
