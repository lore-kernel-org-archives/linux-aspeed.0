From: Joel Stanley <joel@jms.id.au>
Date: Mon, 19 Oct 2020 07:29:54 +0000
Subject: [PATCH] gpio: aspeed: fix ast2600 bank properties
In-Reply-To: <20201019045026.10732-1-billy_tsai@aspeedtech.com>
References: <20201019045026.10732-1-billy_tsai@aspeedtech.com>
Message-ID: <CACPK8Xdp16BJYpGOB9qmXjYDgU7s8eOAiYNDPniRwq3qnG8d5g@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Billy,

On Mon, 19 Oct 2020 at 04:50, Billy Tsai <billy_tsai@aspeedtech.com> wrote:
>
> GPIO_T is mapped to the most significant byte of input/output mask, and
> the byte in "output" mask should be 0 because GPIO_T is input only. All
> the other bits need to be 1 because GPIO_Q/R/S support both input and
> output modes.
>
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>

This is a very similar commit message to the one that Tao sent out, so
I thought for a moment that it was a duplicate patch. I can see now
that it's a different change.

Reviewed-by: Joel Stanley <joel@jms.id.au>
Fixes: ab4a85534c3e ("gpio: aspeed: Add in ast2600 details to Aspeed driver")

Cheers,

Joel




> ---
>  drivers/gpio/gpio-aspeed.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
> index d07bf2c3f136..f24754b3f6d1 100644
> --- a/drivers/gpio/gpio-aspeed.c
> +++ b/drivers/gpio/gpio-aspeed.c
> @@ -1114,6 +1114,7 @@ static const struct aspeed_gpio_config ast2500_config =
>
>  static const struct aspeed_bank_props ast2600_bank_props[] = {
>         /*     input      output   */
> +       {4, 0xffffffff,  0x00ffffff}, /* Q/R/S/T */
>         {5, 0xffffffff,  0xffffff00}, /* U/V/W/X */
>         {6, 0x0000ffff,  0x0000ffff}, /* Y/Z */
>         { },
> --
> 2.17.1
>
