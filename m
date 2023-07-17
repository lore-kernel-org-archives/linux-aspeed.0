From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 17 Jul 2023 09:41:10 +0200
Subject: [PATCH] clk: Explicitly include correct DT includes
In-Reply-To: <20230714174342.4052882-1-robh@kernel.org>
References: <20230714174342.4052882-1-robh@kernel.org>
Message-ID: <CAMuHMdUUWy3Knk6Jqao12KULam_3XpYc=cGqRXe4reH7FPVZsg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jul 14, 2023 at 7:44?PM Rob Herring <robh@kernel.org> wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

>  drivers/clk/renesas/rcar-usb2-clock-sel.c        | 1 -
>  drivers/clk/renesas/renesas-cpg-mssr.c           | 1 -
>  drivers/clk/renesas/rzg2l-cpg.c                  | 3 +--

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
