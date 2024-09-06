From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 6 Sep 2024 09:45:26 +0200
Subject: [PATCH v15 23/32] ARM: dts: aspeed: yosemite4: add fan led config
In-Reply-To: <20240906062701.37088-24-Delphine_CC_Chiu@wiwynn.com>
References: <20240906062701.37088-1-Delphine_CC_Chiu@wiwynn.com> <20240906062701.37088-24-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <CAMuHMdXs=hOgzorsh=Ezf65-3STVtBHrTaM2o==cUm9H_ftCSg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Delphine,

On Fri, Sep 6, 2024 at 8:28?AM Delphine CC Chiu
<Delphine_CC_Chiu@wiwynn.com> wrote:
> Set fan led config in yosemite4 DTS.
>
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>

Thanks for your patch!

> @@ -75,6 +75,154 @@ tpmdev at 0 {
>                         reg = <0>;
>                 };
>         };
> +
> +       leds {
> +               compatible = "gpio-leds";
> +
> +               fan0_blue {

Please no underscores in node names.
LED node names should follow the pattern in
Documentation/devicetree/bindings/leds/leds-gpio.yaml.
LED color should be described using the "color" property, cfr.
Documentation/devicetree/bindings/leds/common.yaml.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
