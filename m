From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 23 Nov 2021 09:38:51 +0100
Subject: [PATCH 01/17] bitfield: Add non-constant field_{prep,
 get}() helpers
In-Reply-To: <5936f811-fa48-33e9-2a1a-66c68f74aa5e@ieee.org>
References: <cover.1637592133.git.geert+renesas@glider.be>
 <3a54a6703879d10f08cf0275a2a69297ebd2b1d4.1637592133.git.geert+renesas@glider.be>
 <01b44b38c087c151171f8d45a2090474c2559306.camel@sipsolutions.net>
 <5936f811-fa48-33e9-2a1a-66c68f74aa5e@ieee.org>
Message-ID: <CAMuHMdX4C0EgkGXR=MwSuBOFoj7O9xx8xwH5dP8rWzN1ckejQA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Alex,

On Tue, Nov 23, 2021 at 2:52 AM Alex Elder <elder@ieee.org> wrote:
> On 11/22/21 10:32 AM, Johannes Berg wrote:
> > On Mon, 2021-11-22 at 16:53 +0100, Geert Uytterhoeven wrote:
> >> The existing FIELD_{GET,PREP}() macros are limited to compile-time
> >> constants.  However, it is very common to prepare or extract bitfield
> >> elements where the bitfield mask is not a compile-time constant.
> >
> > I'm not sure it's really a good idea to add a third API here?
> >
> > We have the upper-case (constant) versions, and already
> > {u32,...}_get_bits()/etc.
>
> I've used these a lot (and personally prefer the lower-case ones).
>
> Your new macros don't do anything to ensure the field mask is
> of the right form, which is basically:  (2 ^ width - 1) << shift

> I really like the property that the field mask must be constant.

That's correct. How to enforce that in the non-const case?
BUG()/WARN() is not an option ;-)

> That being said, I've had to use some strange coding patterns
> in order to adhere to the "const only" rule in a few cases.
> So if you can come up with a satisfactory naming scheme I'm
> all for it.

There are plenty of drivers that handle masks stored in a data
structure, so it would be good if they can use a suitable helper,
as open-coding is prone to errors.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
