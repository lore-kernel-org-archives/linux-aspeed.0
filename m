From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 28 Mar 2022 09:57:08 +0200 (CEST)
Subject: [PATCH RFC 1/1] ARM/arm64: categorize dts in arm dir and fix
 dependency in arm64
In-Reply-To: <20220328000915.15041-2-ansuelsmth@gmail.com>
References: <20220328000915.15041-1-ansuelsmth@gmail.com>
 <20220328000915.15041-2-ansuelsmth@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2203280956080.1685195@ramsan.of.borg>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

 	Hi Ansuel,

On Mon, 28 Mar 2022, Ansuel Smith wrote:
> - Categorize every dts in arm directory in subdirectory
> - Fix Makefile to address for the arm subdirectory
> - Fix any arm64 dependency
>
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>

Thanks for your patch!

> --- /dev/null
> +++ b/arch/arm/boot/dts/renasas/Makefile

s/renasas/renesas/

The actual split for the Renesas parts LGTM.

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
