From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 30 Jan 2023 23:52:27 +0100
Subject: [PATCH] pinctrl: aspeed: Revert "Force to disable the function's signal"
In-Reply-To: <20230130220845.917985-1-joel@jms.id.au>
References: <20230130220845.917985-1-joel@jms.id.au>
Message-ID: <CACRpkdY3VtkJZn4pHawFiW7yie+BWvT8o9Qx0Ym0ihgi3ACJ2A@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jan 30, 2023 at 11:09 PM Joel Stanley <joel@jms.id.au> wrote:

> This reverts commit cf517fef601b9dde151f0afc27164d13bf1fd907.
>
> The commit cf517fef601b ("pinctrl: aspeed: Force to disable the
> function's signal") exposed a problem with fetching the regmap for
> reading the GFX register.
>
> The Romulus machine the device tree contains a gpio hog for GPIO S7.
> With the patch applied:
>
>   Muxing pin 151 for GPIO
>   Disabling signal VPOB9 for VPO
>   aspeed-g5-pinctrl 1e6e2080.pinctrl: Failed to acquire regmap for IP block 1
>   aspeed-g5-pinctrl 1e6e2080.pinctrl: request() failed for pin 151
>
> The code path is aspeed-gpio -> pinmux-g5 -> regmap -> clk, and the
> of_clock code returns an error as it doesn't have a valid struct clk_hw
> pointer. The regmap call happens because pinmux wants to check the GFX
> node (IP block 1) to query bits there.
>
> For reference, before the offending patch:
>
>   Muxing pin 151 for GPIO
>   Disabling signal VPOB9 for VPO
>   Want SCU8C[0x00000080]=0x1, got 0x0 from 0x00000000
>   Disabling signal VPOB9 for VPOOFF1
>   Want SCU8C[0x00000080]=0x1, got 0x0 from 0x00000000
>   Disabling signal VPOB9 for VPOOFF2
>   Want SCU8C[0x00000080]=0x1, got 0x0 from 0x00000000
>   Enabling signal GPIOS7 for GPIOS7
>   Muxed pin 151 as GPIOS7
>   gpio-943 (seq_cont): hogged as output/low
>
> We can't skip the clock check to allow pinmux to proceed, because the
> write to disable VPOB9 will try to set a bit in the GFX register space
> which will not stick when the IP is in reset. However, we do not want to
> enable the IP just so pinmux can do a disable-enable dance for the pin.
>
> For now, revert the offending patch while a correct solution is found.
>
> Fixes: cf517fef601b ("pinctrl: aspeed: Force to disable the function's signal")
> Link: https://github.com/openbmc/linux/issues/218
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Patch applied for fixes, sorry for not getting around to reverting it
myself, but the commit message got really nice in the meantime :)

Yours,
Linus Walleij
