From: David Laight <David.Laight@ACULAB.COM>
Date: Wed, 2 Mar 2022 14:04:06 +0000
Subject: [PATCH 2/6] treewide: remove using list iterator after loop body
 as a ptr
In-Reply-To: <20220302093106.8402-1-xiam0nd.tong@gmail.com>
References: <CAHk-=whLK11HyvpUtEftOjc3Gup2V77KpAQ2fycj3uai=qceHw@mail.gmail.com>
 <20220302093106.8402-1-xiam0nd.tong@gmail.com>
Message-ID: <1077f17e50d34dc2bbfdf4e52a1cb2fd@AcuMS.aculab.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Xiaomeng Tong
> Sent: 02 March 2022 09:31
> 
> On Mon, 28 Feb 2022 16:41:04 -0800, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > But basically to _me_, the important part is that the end result is
> > maintainable longer-term.
> 
> I couldn't agree more. And because of that, I stick with the following
> approach because it's maintainable longer-term than "type(pos) pos" one:
>  Implements a new macro for each list_for_each_entry* with _inside suffix.
>   #define list_for_each_entry_inside(pos, type, head, member)

I think that it would be better to make any alternate loop macro
just set the variable to NULL on the loop exit.
That is easier to code for and the compiler might be persuaded to
not redo the test.

It also doesn't need an extra variable defined in the for() statement
so can be back-ported to older kernels without required declaration
in the middle of blocks.

OTOH there may be alternative definitions that can be used to get
the compiler (or other compiler-like tools) to detect broken code.
Even if the definition can't possibly generate a working kerrnel.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

