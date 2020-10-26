From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Mon, 26 Oct 2020 15:53:09 +0100
Subject: [PATCH] gpio: aspeed: fix ast2600 bank properties
In-Reply-To: <20201019045026.10732-1-billy_tsai@aspeedtech.com>
References: <20201019045026.10732-1-billy_tsai@aspeedtech.com>
Message-ID: <CAMpxmJXzku3+gfs3jnfpRzLxmQFx3QAJArXEJ0maRx=EKK4WTw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Oct 19, 2020 at 6:50 AM Billy Tsai <billy_tsai@aspeedtech.com> wrote:
>
> GPIO_T is mapped to the most significant byte of input/output mask, and
> the byte in "output" mask should be 0 because GPIO_T is input only. All
> the other bits need to be 1 because GPIO_Q/R/S support both input and
> output modes.
>
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
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

Applied to fixes with reviews collected and added the Fixes: tag.

Bartosz
