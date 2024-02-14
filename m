From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 14 Feb 2024 15:01:29 -0000
Subject: [PATCH 0/6] dts: Fix dtc interrupt warnings
In-Reply-To: <20240213-arm-dt-cleanups-v1-0-f2dee1292525@kernel.org>
References: <20240213-arm-dt-cleanups-v1-0-f2dee1292525@kernel.org>
Message-ID: <CAMuHMdWgvD9szXksK+jzyvwLQ8ufWWf1TPQ7s-5z4JWgrvXmkg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Rob,

On Tue, Feb 13, 2024 at 8:35?PM Rob Herring <robh@kernel.org> wrote:
> I had a branch with most of these changes sitting in my tree for some
> time. Geert's asking about some errors not getting found prompted me to
> clean it up and send it out. This series fixes all* interrupt related
> warnings and enables the check by default.

> *There's a few Renesas warnings still Geert said he would fix.

Thanks, fix sent
https://lore.kernel.org/r/a351e503ea97fb1af68395843f513925ff1bdf26.1707922460.git.geert+renesas at glider.be

>       dtc: Enable dtc interrupt_provider check

>  scripts/Makefile.lib                                  |  3 +--

Just wondering, can the remaining disabler be removed, too?

Documentation/devicetree/bindings/Makefile:     -Wno-interrupt_provider \

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
