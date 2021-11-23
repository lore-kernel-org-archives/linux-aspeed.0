From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 23 Nov 2021 17:21:41 +0100
Subject: [PATCH 01/17] bitfield: Add non-constant field_{prep,get}()
 helpers
In-Reply-To: <CAMuHMdUnBgFpqhgjf5AA0LH9MZOFALeC=YinZ4Tv_V+Y9hkRSg@mail.gmail.com>
References: <cover.1637592133.git.geert+renesas@glider.be>
 <3a54a6703879d10f08cf0275a2a69297ebd2b1d4.1637592133.git.geert+renesas@glider.be>
 <01b44b38c087c151171f8d45a2090474c2559306.camel@sipsolutions.net>
 <CAMuHMdUnBgFpqhgjf5AA0LH9MZOFALeC=YinZ4Tv_V+Y9hkRSg@mail.gmail.com>
Message-ID: <12825803045d1cec0df968f72a9ef2724a2548fb.camel@sipsolutions.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 2021-11-23 at 09:30 +0100, Geert Uytterhoeven wrote:
> > We have the upper-case (constant) versions, and already
> > {u32,...}_get_bits()/etc.
> 
> These don't work for non-const masks.

Obviously, I know that. Still, just saying.

I'm actually in the opposite camp to you I guess - I much prefer the
typed versions (u32_get_bits() and friends) over the FIELD_GET() macros
that are more magic.

Mostly though that's because the typed ones also have le32_/be32_/...
variants, which are tremendously useful, and so I prefer to use them all
across. In fact, I have considered in the past to just remove the upper-
case macros entirely but ... no time I guess.

> > Also, you're using __ffs(), which doesn't work for 64-bit on 32-bit
> > architectures (afaict), so that seems a bit awkward.
> 
> That's a valid comment. Can be fixed by using a wrapper macro
> that checks if typeof(mask) == u64, and uses an __ffs64() version when
> needed.

You can't really do a typeof()==something, but you can check the size,
so yeah, that could be done.

> > Maybe we can make {u32,...}_get_bits() be doing compile-time only checks
> > if it is indeed a constant? The __field_overflow() usage is already only
> > done if __builtin_constant_p(v), so I guess we can do the same with
> > __bad_mask()?
> 
> Are all compilers smart enough to replace the division by
> field_multiplier(field) by a shift?

In the constant case they are, but you'd have to replace
field_multiplier() with the __ffs(), including the size check discussed
above. Then it's no longer a constant, and then I'm not so sure it would
actually be able to translate it, even if it's "1<<__ffs64(...)". I
guess you can check, or just change it to not use the division and
multiplication, but shifts/masks instead manually?

IOW - I would much prefer to make the type_get_bits() and friends work
for non-constant masks.

In fact, you have e.g. code in drivers/usb/chipidea/udc.c that does
things like cpu_to_le32(mul << __ffs(...)) - though in those cases it's
actually constant today, so you could already write it as
le32_encode_bits(...).

johannes
