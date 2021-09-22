From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Wed, 22 Sep 2021 11:24:08 +0200
Subject: [PATCH -next v1 1/1] gpio: gpio-aspeed-sgpio: Fix wrong hwirq in
 irq handler.
In-Reply-To: <20210907095525.24668-2-steven_lee@aspeedtech.com>
References: <20210907095525.24668-1-steven_lee@aspeedtech.com>
 <20210907095525.24668-2-steven_lee@aspeedtech.com>
Message-ID: <CAMpxmJVzAiZvg2xfUGgt5RqTyRbZggkxUTGZJod_5Tq2pzsS8g@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Sep 7, 2021 at 11:55 AM Steven Lee <steven_lee@aspeedtech.com> wrote:
>
> The current hwirq is calculated based on the old GPIO pin order(input
> GPIO range is from 0 to ngpios - 1).
> It should be calculated based on the current GPIO input pin order(input
> GPIOs are 0, 2, 4, ..., (ngpios - 1) * 2).
>
> Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> ---
>  drivers/gpio/gpio-aspeed-sgpio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-aspeed-sgpio.c b/drivers/gpio/gpio-aspeed-sgpio.c
> index 10f303d15225..3d6ef37a7702 100644
> --- a/drivers/gpio/gpio-aspeed-sgpio.c
> +++ b/drivers/gpio/gpio-aspeed-sgpio.c
> @@ -395,7 +395,7 @@ static void aspeed_sgpio_irq_handler(struct irq_desc *desc)
>                 reg = ioread32(bank_reg(data, bank, reg_irq_status));
>
>                 for_each_set_bit(p, &reg, 32)
> -                       generic_handle_domain_irq(gc->irq.domain, i * 32 + p);
> +                       generic_handle_domain_irq(gc->irq.domain, i * 32 + p * 2);
>         }
>
>         chained_irq_exit(ic, desc);
> --
> 2.17.1
>

Applied for fixes, thanks!

Bart
