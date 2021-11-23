From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 23 Nov 2021 09:20:23 +0100
Subject: [PATCH 00/17] Non-const bitfield helper conversions
In-Reply-To: <YZvYW1ElW7ZYZNTC@piout.net>
References: <cover.1637592133.git.geert+renesas@glider.be>
 <YZvYW1ElW7ZYZNTC@piout.net>
Message-ID: <CAMuHMdWKHoBWm2XQmKwB0q8Ya8KzpCgA29D0igXJrGY8=3e8_A@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Alexandre,

On Mon, Nov 22, 2021 at 6:50 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> On 22/11/2021 16:53:53+0100, Geert Uytterhoeven wrote:
> > The existing FIELD_{GET,PREP}() macros are limited to compile-time
> > constants.  However, it is very common to prepare or extract bitfield
> > elements where the bitfield mask is not a compile-time constant.
> > To avoid this limitation, the AT91 clock driver already has its own
> > field_{prep,get}() macros.
>
> My understanding was that this (being compile time only) was actually
> done on purpose. Did I misunderstand?

Yes, it was done on purpose, to maximize type safety.

However, this imposes a severe limitation: we cannot use them in case
the mask is non-const (i.e. stored in some data structure).  This
is a quite common use-case, given the examples I found and converted,
and given you added field_{get,prep}() to the AT91 clock driver.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
