From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 6 Sep 2024 09:38:35 +0200
Subject: [PATCH v15 30/32] ARM: dts: aspeed: yosemite4: add SQ52205 support
In-Reply-To: <20240906062701.37088-31-Delphine_CC_Chiu@wiwynn.com>
References: <20240906062701.37088-1-Delphine_CC_Chiu@wiwynn.com> <20240906062701.37088-31-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <CAMuHMdV80pF+rVhRWeeZy3tyZCr5y=qRWYm1Z655t3ULZJO=yA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Delphine,

Thanks for your patch!

On Fri, Sep 6, 2024 at 8:35?AM Delphine CC Chiu
<Delphine_CC_Chiu@wiwynn.com> wrote:
> Add SQ52205 in yosemite4 DTS.

Please explain.

> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>


> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -1245,35 +1245,35 @@ adc at 37 {
>         };
>
>         power-sensor at 40 {
> -               compatible = "ti,ina233", "richtek,rtq6056";
> +               compatible = "ti,ina233", "richtek,rtq6056", "silergy,sq52205";

At first sight, this looks wrong.
However, these three all seem to be functionally equivalent power monitors.
Are they software compatible too?
There are also no DT bindings to guide us, except for the rtq6056 part.

>                 reg = <0x40>;
>                 resistor-calibration = /bits/ 16 <0x0400>;
>                 current-lsb= /bits/ 16 <0x0001>;
>         };

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
