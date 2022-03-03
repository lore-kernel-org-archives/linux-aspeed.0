From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Thu, 3 Mar 2022 13:56:02 +0300
Subject: [PATCH 2/6] treewide: remove using list iterator after loop body
 as a ptr
In-Reply-To: <78ccb184-405e-da93-1e02-078f90d2b9bc@rasmusvillemoes.dk>
References: <282f0f8d-f491-26fc-6ae0-604b367a5a1a@amd.com>
 <b2d20961dbb7533f380827a7fcc313ff849875c1.camel@HansenPartnership.com>
 <7D0C2A5D-500E-4F38-AD0C-A76E132A390E@kernel.org>
 <73fa82a20910c06784be2352a655acc59e9942ea.camel@HansenPartnership.com>
 <CAHk-=wiT5HX6Kp0Qv4ZYK_rkq9t5fZ5zZ7vzvi6pub9kgp=72g@mail.gmail.com>
 <7dc860874d434d2288f36730d8ea3312@AcuMS.aculab.com>
 <CAHk-=whKqg89zu4T95+ctY-hocR6kDArpo2qO14-kV40Ga7ufw@mail.gmail.com>
 <0ced2b155b984882b39e895f0211037c@AcuMS.aculab.com>
 <CAHk-=wix0HLCBs5sxAeW3uckg0YncXbTjMsE-Tv8WzmkOgLAXQ@mail.gmail.com>
 <78ccb184-405e-da93-1e02-078f90d2b9bc@rasmusvillemoes.dk>
Message-ID: <20220303105602.GE2794@kadam>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Mar 02, 2022 at 10:29:31AM +0100, Rasmus Villemoes wrote:
> This won't help the current issue (because it doesn't exist and might
> never), but just in case some compiler people are listening, I'd like to
> have some sort of way to tell the compiler "treat this variable as
> uninitialized from here on". So one could do
> 
> #define kfree(p) do { __kfree(p); __magic_uninit(p); } while (0)
> 

I think this is a good idea.

Smatch can already find all the iterator used outside the loop bugs that
Jakob did with a manageably small number of false positives.  The
problems are that:
1) It would be better to find it in the compile stage instead of later.
2) I hadn't published that check.  Will do shortly.
3) A couple weeks back I noticed that the list_for_each_entry() check
   was no longer working.  Fixed now.
4) Smatch was only looking at cases which dereferenced the iterator and
   not checks for NULL.  I will test the fix for that tonight.
5) Smatch is broken on PowerPC.

Coccinelle also has checks for iterator used outside the loop.
Coccinelle had these checks before Smatch did.  I copied Julia's idea.

If your annotation was added to GCC it would solve all those problems.

But it's kind of awkward that we can't annotate kfree() directly
instead of creating the kfree() macro.  And there are lots of other
functions which free things so you'd have to create a ton of macros
like:

#define gr_free_dma_desc(a, b) do { __gr_free_dma_desc(a, b); __magic_uninit(b); } while (0)

And then there are functions which free a struct member:

void free_bar(struct foo *p) { kfree(p->bar); }

Or functions which free a container_of().

Smatch is more evolved than designed but what I do these days is use $0,
$1, $2 to represent the parameters.  So you can say a function frees
$0->bar.  For container_of() then is "(168<~$0)->bar" which means 168
bytes from $0.  Returns are parameter -1 so I guess it would be $(-1),
but as I said Smatch evolved so right now places that talk about
returned values use a different format.

What you could do is just make a parseable table next to the function
definition with all the information.  Then you would use a Perl script
to automatically generate a Coccinelle check to warn about use after
frees.

diff --git a/mm/slab.c b/mm/slab.c
index ddf5737c63d9..c9dffa5c40a2 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3771,6 +3771,9 @@ EXPORT_SYMBOL(kmem_cache_free_bulk);
  *
  * Don't free memory not originally allocated by kmalloc()
  * or you will run into trouble.
+ *
+ * CHECKER information
+ * frees: $0
  */
 void kfree(const void *objp)
 {

regards,
dan carpenter

