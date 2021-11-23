From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 23 Nov 2021 09:36:22 +0100
Subject: [PATCH 01/17] bitfield: Add non-constant field_{prep,
 get}() helpers
In-Reply-To: <20211122171739.03848154@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <cover.1637592133.git.geert+renesas@glider.be>
 <3a54a6703879d10f08cf0275a2a69297ebd2b1d4.1637592133.git.geert+renesas@glider.be>
 <01b44b38c087c151171f8d45a2090474c2559306.camel@sipsolutions.net>
 <20211122171739.03848154@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <CAMuHMdWAAGrQUZN18cnDTDUUhuPNTZTFkRMe2Sbf+s7CedPSxA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Jakub,

On Tue, Nov 23, 2021 at 2:17 AM Jakub Kicinski <kuba@kernel.org> wrote:
> On Mon, 22 Nov 2021 17:32:43 +0100 Johannes Berg wrote:
> > On Mon, 2021-11-22 at 16:53 +0100, Geert Uytterhoeven wrote:
> > > The existing FIELD_{GET,PREP}() macros are limited to compile-time
> > > constants.  However, it is very common to prepare or extract bitfield
> > > elements where the bitfield mask is not a compile-time constant.
> >
> > I'm not sure it's really a good idea to add a third API here?
>
> +1

Yeah, a smaller API is better.

> > We have the upper-case (constant) versions, and already
> > {u32,...}_get_bits()/etc.

TBH, I don't like the *_get_bits() API: in general, u32_get_bits() does
the same as FIELD_GET(), but the order of the parameters is different?
(*_replace_bits() seems to be useful, though)

That's why I picked field_{get,prep}().

> > Also, you're using __ffs(), which doesn't work for 64-bit on 32-bit
> > architectures (afaict), so that seems a bit awkward.
> >
> > Maybe we can make {u32,...}_get_bits() be doing compile-time only checks
> > if it is indeed a constant? The __field_overflow() usage is already only
> > done if __builtin_constant_p(v), so I guess we can do the same with
> > __bad_mask()?
>
> Either that or add decomposition macros. Are compilers still really bad
> at passing small structs by value?

Sorry, I don't get what you mean by adding decomposition macros.
Can you please elaborate?
Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
