From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 6 Sep 2024 09:42:01 +0200
Subject: [PATCH v15 22/32] ARM: dts: aspeed: yosemite4: Revise i2c duty-cycle
In-Reply-To: <20240906062701.37088-23-Delphine_CC_Chiu@wiwynn.com>
References: <20240906062701.37088-1-Delphine_CC_Chiu@wiwynn.com> <20240906062701.37088-23-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <CAMuHMdXFC-TMNdJryq4MBh+QQOntxdHYJrfP2kLqxJk7LKgb9Q@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Delphine,

On Fri, Sep 6, 2024 at 8:28?AM Delphine CC Chiu
<Delphine_CC_Chiu@wiwynn.com> wrote:
> Revise duty cycle SMB11 and SMB16 to high: 40%, low: 60%,
> to meet 400kHz-i2c clock low time spec (> 1.3 us) from EE request
>
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>

Thanks for your patch!

> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -761,6 +761,7 @@ eeprom at 54 {
>  &i2c10 {
>         status = "okay";
>         bus-frequency = <400000>;
> +       i2c-clk-high-min-percent = <40>;

This property is documented nowhere, except for a not-yet-accepted
patch submission in 2022. It looks like you've been told before, multiple
times...

>         i2c-mux at 74 {
>                 compatible = "nxp,pca9544";
>                 i2c-mux-idle-disconnect;

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
