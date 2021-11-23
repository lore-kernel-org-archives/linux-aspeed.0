From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 23 Nov 2021 17:31:54 +0100
Subject: [PATCH 01/17] bitfield: Add non-constant field_{prep,
 get}() helpers
In-Reply-To: <12825803045d1cec0df968f72a9ef2724a2548fb.camel@sipsolutions.net>
References: <cover.1637592133.git.geert+renesas@glider.be>
 <3a54a6703879d10f08cf0275a2a69297ebd2b1d4.1637592133.git.geert+renesas@glider.be>
 <01b44b38c087c151171f8d45a2090474c2559306.camel@sipsolutions.net>
 <CAMuHMdUnBgFpqhgjf5AA0LH9MZOFALeC=YinZ4Tv_V+Y9hkRSg@mail.gmail.com>
 <12825803045d1cec0df968f72a9ef2724a2548fb.camel@sipsolutions.net>
Message-ID: <CAMuHMdXwhO30gy42tfGSsEgJAjDOAkQ_cUXMMiSBjMsUj0nqaA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Johannes,

On Tue, Nov 23, 2021 at 5:21 PM Johannes Berg <johannes@sipsolutions.net> wrote:
> On Tue, 2021-11-23 at 09:30 +0100, Geert Uytterhoeven wrote:
> > > We have the upper-case (constant) versions, and already
> > > {u32,...}_get_bits()/etc.
> >
> > These don't work for non-const masks.
>
> Obviously, I know that. Still, just saying.
>
> I'm actually in the opposite camp to you I guess - I much prefer the
> typed versions (u32_get_bits() and friends) over the FIELD_GET() macros
> that are more magic.
>
> Mostly though that's because the typed ones also have le32_/be32_/...
> variants, which are tremendously useful, and so I prefer to use them all
> across. In fact, I have considered in the past to just remove the upper-
> case macros entirely but ... no time I guess.

OK, I have to think a bit about this.
FTR, initially I didn't like the FIELD_{GET,PREP}() macros neither ;-)

> In fact, you have e.g. code in drivers/usb/chipidea/udc.c that does
> things like cpu_to_le32(mul << __ffs(...)) - though in those cases it's
> actually constant today, so you could already write it as
> le32_encode_bits(...).

Yeah, there are lots of opportunities for improvement for
drivers/usb/chipidea/.  I didn't include a conversion patch for that
driver, as it led me too deep into the rabbit hole, and I wanted to
get something posted rather sooner than later...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
