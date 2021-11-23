From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 23 Nov 2021 15:39:33 -0800
Subject: [PATCH 01/17] bitfield: Add non-constant field_{prep,get}()
 helpers
In-Reply-To: <CAMuHMdWAAGrQUZN18cnDTDUUhuPNTZTFkRMe2Sbf+s7CedPSxA@mail.gmail.com>
References: <cover.1637592133.git.geert+renesas@glider.be>
 <3a54a6703879d10f08cf0275a2a69297ebd2b1d4.1637592133.git.geert+renesas@glider.be>
 <01b44b38c087c151171f8d45a2090474c2559306.camel@sipsolutions.net>
 <20211122171739.03848154@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CAMuHMdWAAGrQUZN18cnDTDUUhuPNTZTFkRMe2Sbf+s7CedPSxA@mail.gmail.com>
Message-ID: <20211123153933.49ff8b72@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 23 Nov 2021 09:36:22 +0100 Geert Uytterhoeven wrote:
> > > Also, you're using __ffs(), which doesn't work for 64-bit on 32-bit
> > > architectures (afaict), so that seems a bit awkward.
> > >
> > > Maybe we can make {u32,...}_get_bits() be doing compile-time only checks
> > > if it is indeed a constant? The __field_overflow() usage is already only
> > > done if __builtin_constant_p(v), so I guess we can do the same with
> > > __bad_mask()?  
> >
> > Either that or add decomposition macros. Are compilers still really bad
> > at passing small structs by value?  
> 
> Sorry, I don't get what you mean by adding decomposition macros.
> Can you please elaborate?

#define DECOMPOSE(_mask) \
  (struct bf){ .mask = _mask, .shf = __bf_shf(_mask), }

Then drivers can save or pass around the mask and shift params 
broken apart as a small struct.
