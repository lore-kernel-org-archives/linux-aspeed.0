From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 14 Feb 2024 14:36:40 -0000
Subject: [PATCH 3/6] arm64: dts: Fix dtc interrupt_provider warnings
In-Reply-To: <20240213-arm-dt-cleanups-v1-3-f2dee1292525@kernel.org>
References: <20240213-arm-dt-cleanups-v1-0-f2dee1292525@kernel.org> <20240213-arm-dt-cleanups-v1-3-f2dee1292525@kernel.org>
Message-ID: <CAMuHMdXjJcsFiusnBQmJg1p-oy-NPmr+qyt0znOk0n+wL8TrnA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Feb 13, 2024 at 8:35?PM Rob Herring <robh@kernel.org> wrote:
> The dtc interrupt_provider warning is off by default. Fix all the warnings
> so it can be enabled.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

>  arch/arm64/boot/dts/renesas/ulcb-kf.dtsi            | 4 ++++

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
