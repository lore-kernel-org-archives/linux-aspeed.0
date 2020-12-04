From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 4 Dec 2020 10:19:12 +0100
Subject: [PATCH] pinctrl: aspeed: Fix GPIO requests on pass-through banks
In-Reply-To: <20201126063337.489927-1-andrew@aj.id.au>
References: <20201126063337.489927-1-andrew@aj.id.au>
Message-ID: <CACRpkdbMoLXiSipDkmRXeWA_tcyDC8R1kuxHzzvfYaeqLU5deg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Nov 26, 2020 at 7:34 AM Andrew Jeffery <andrew@aj.id.au> wrote:

> Commit 6726fbff19bf ("pinctrl: aspeed: Fix GPI only function problem.")
> fixes access to GPIO banks T and U on the AST2600. Both banks contain
> input-only pins and the GPIO pin function is named GPITx and GPIUx
> respectively. Unfortunately the fix had a negative impact on GPIO banks
> D and E for the AST2400 and AST2500 where the GPIO pass-through
> functions take similar "GPI"-style names. The net effect on the older
> SoCs was that when the GPIO subsystem requested a pin in banks D or E be
> muxed for GPIO, they were instead muxed for pass-through mode.
> Mistakenly muxing pass-through mode e.g. breaks booting the host on
> IBM's Witherspoon (AC922) platform where GPIOE0 is used for FSI.
>
> Further exploit the names in the provided expression structure to
> differentiate pass-through from pin-specific GPIO modes.
>
> This follow-up fix gives the expected behaviour for the following tests:
>
> Witherspoon BMC (AST2500):
>
> 1. Power-on the Witherspoon host
> 2. Request GPIOD1 be muxed via /sys/class/gpio/export
> 3. Request GPIOE1 be muxed via /sys/class/gpio/export
> 4. Request the balls for GPIOs E2 and E3 be muxed as GPIO pass-through
>    ("GPIE2" mode) via a pinctrl hog in the devicetree
>
> Rainier BMC (AST2600):
>
> 5. Request GPIT0 be muxed via /sys/class/gpio/export
> 6. Request GPIU0 be muxed via /sys/class/gpio/export
>
> Together the tests demonstrate that all three pieces of functionality
> (general GPIOs via 1, 2 and 3, input-only GPIOs via 5 and 6, pass-through
> mode via 4) operate as desired across old and new SoCs.
>
> Fixes: 6726fbff19bf ("pinctrl: aspeed: Fix GPI only function problem.")
> Cc: Billy Tsai <billy_tsai@aspeedtech.com>
> Cc: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Patch applied for fixes.

Yours,
Linus Walleij
