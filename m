From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Thu, 24 Sep 2020 15:37:49 +0200
Subject: [PATCH] gpio: aspeed: fix ast2600 bank properties
In-Reply-To: <20200916204216.9423-1-rentao.bupt@gmail.com>
References: <20200916204216.9423-1-rentao.bupt@gmail.com>
Message-ID: <CAMpxmJWR7VqU9urj=-KypKLm3aFooMd9iyusYtr5dNY2oOgXQQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Sep 16, 2020 at 10:42 PM <rentao.bupt@gmail.com> wrote:
>
> From: Tao Ren <rentao.bupt@gmail.com>
>
> GPIO_U is mapped to the least significant byte of input/output mask, and
> the byte in "output" mask should be 0 because GPIO_U is input only. All
> the other bits need to be 1 because GPIO_V/W/X support both input and
> output modes.
>
> Similarly, GPIO_Y/Z are mapped to the 2 least significant bytes, and the
> according bits need to be 1 because GPIO_Y/Z support both input and
> output modes.
>
> Fixes: ab4a85534c3e ("gpio: aspeed: Add in ast2600 details to Aspeed driver")
> Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> ---
>  drivers/gpio/gpio-aspeed.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
> index 879db23d8454..d07bf2c3f136 100644
> --- a/drivers/gpio/gpio-aspeed.c
> +++ b/drivers/gpio/gpio-aspeed.c
> @@ -1114,8 +1114,8 @@ static const struct aspeed_gpio_config ast2500_config =
>
>  static const struct aspeed_bank_props ast2600_bank_props[] = {
>         /*     input      output   */
> -       {5, 0xffffffff,  0x0000ffff}, /* U/V/W/X */
> -       {6, 0xffff0000,  0x0fff0000}, /* Y/Z */
> +       {5, 0xffffffff,  0xffffff00}, /* U/V/W/X */
> +       {6, 0x0000ffff,  0x0000ffff}, /* Y/Z */
>         { },
>  };
>
> --
> 2.17.1
>

Queued for fixes, thanks!

Bartosz
