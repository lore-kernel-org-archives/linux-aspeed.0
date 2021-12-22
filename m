From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 22 Dec 2021 10:18:31 +0100
Subject: [PATCH v1 1/1] gpio: gpio-aspeed-sgpio: Fix wrong hwirq base in
 irq handler
In-Reply-To: <20211214040239.8977-2-steven_lee@aspeedtech.com>
References: <20211214040239.8977-1-steven_lee@aspeedtech.com>
 <20211214040239.8977-2-steven_lee@aspeedtech.com>
Message-ID: <CAMRc=MdAgK7zKuJ=7cA2T-mSTJD3tWSW2aEB6G=0Tz4X+iHcZQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Dec 14, 2021 at 5:03 AM Steven Lee <steven_lee@aspeedtech.com> wrote:
>
> Each aspeed sgpio bank has 64 gpio pins(32 input pins and 32 output pins).
> The hwirq base for each sgpio bank should be multiples of 64 rather than
> multiples of 32.
>
> Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> ---
>  drivers/gpio/gpio-aspeed-sgpio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-aspeed-sgpio.c b/drivers/gpio/gpio-aspeed-sgpio.c
> index 3d6ef37a7702..b3a9b8488f11 100644
> --- a/drivers/gpio/gpio-aspeed-sgpio.c
> +++ b/drivers/gpio/gpio-aspeed-sgpio.c
> @@ -395,7 +395,7 @@ static void aspeed_sgpio_irq_handler(struct irq_desc *desc)
>                 reg = ioread32(bank_reg(data, bank, reg_irq_status));
>
>                 for_each_set_bit(p, &reg, 32)
> -                       generic_handle_domain_irq(gc->irq.domain, i * 32 + p * 2);
> +                       generic_handle_domain_irq(gc->irq.domain, (i * 32 + p) * 2);
>         }
>
>         chained_irq_exit(ic, desc);
> --
> 2.17.1
>

Joel, Andrew: any comments on this? I'd like to send it upstream tomorrow.

Bart
