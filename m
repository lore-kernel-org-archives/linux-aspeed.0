From: Joel Stanley <joel@jms.id.au>
Date: Thu, 10 Sep 2020 04:10:05 +0000
Subject: [PATCH 1/2] gpio/aspeed-sgpio: enable access to all 80 input &
 output sgpios
In-Reply-To: <20200715135418.3194860-1-jk@codeconstruct.com.au>
References: <20200715135418.3194860-1-jk@codeconstruct.com.au>
Message-ID: <CACPK8XcT02qv+1H=DDv8BRAdUmrBoweZ+Qb3aG34bQ9-UC08Xg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 15 Jul 2020 at 14:06, Jeremy Kerr <jk@codeconstruct.com.au> wrote:
>
> Currently, the aspeed-sgpio driver exposes up to 80 GPIO lines,
> corresponding to the 80 status bits available in hardware. Each of these
> lines can be configured as either an input or an output.
>
> However, each of these GPIOs is actually an input *and* an output; we
> actually have 80 inputs plus 80 outputs.
>
> This change expands the maximum number of GPIOs to 160; the lower half
> of this range are the input-only GPIOs, the upper half are the outputs.
> We fix the GPIO directions to correspond to this mapping.
>
> This also fixes a bug when setting GPIOs - we were reading from the
> input register, making it impossible to set more than one output GPIO.
>
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>

A Fixes: might be a good idea.

> ---
>  .../devicetree/bindings/gpio/sgpio-aspeed.txt |   5 +-
>  drivers/gpio/gpio-aspeed-sgpio.c              | 115 +++++++++++-------
>  2 files changed, 77 insertions(+), 43 deletions(-)

> diff --git a/drivers/gpio/gpio-aspeed-sgpio.c b/drivers/gpio/gpio-aspeed-sgpio.c
> index 8319812593e3..927d46f159b8 100644
> --- a/drivers/gpio/gpio-aspeed-sgpio.c
> +++ b/drivers/gpio/gpio-aspeed-sgpio.c
> @@ -17,7 +17,8 @@
>  #include <linux/spinlock.h>
>  #include <linux/string.h>
>
> -#define MAX_NR_SGPIO                   80
> +#define MAX_NR_HW_SGPIO                        80
> +#define SGPIO_OUTPUT_OFFSET            MAX_NR_HW_SGPIO

A short comment explaining what's going on with these defines (as you
did in your commit message) will help future reviewers.

> +static void aspeed_sgpio_irq_init_valid_mask(struct gpio_chip *gc,
> +               unsigned long *valid_mask, unsigned int ngpios)
> +{
> +       struct aspeed_sgpio *sgpio = gpiochip_get_data(gc);
> +       int n = sgpio->n_sgpio;
> +
> +       WARN_ON(ngpios < MAX_NR_HW_SGPIO * 2);
> +
> +       /* input GPIOs in the lower range */
> +       bitmap_set(valid_mask, 0, n);
> +       bitmap_clear(valid_mask, n, ngpios - n);
> +}
> +
> +static const bool aspeed_sgpio_is_input(unsigned int offset)

The 0day bot complained about the 'const' here.

> +{
> +       return offset < SGPIO_OUTPUT_OFFSET;
> +}

>  static int aspeed_sgpio_dir_out(struct gpio_chip *gc, unsigned int offset, int val)
>  {
>         struct aspeed_sgpio *gpio = gpiochip_get_data(gc);
>         unsigned long flags;
> +       int rc;
>
> -       spin_lock_irqsave(&gpio->lock, flags);
> -
> -       gpio->dir_in[GPIO_BANK(offset)] &= ~GPIO_BIT(offset);
> -       sgpio_set_value(gc, offset, val);
> +       /* No special action is required for setting the direction; we'll
> +        * error-out in sgpio_set_value if this isn't an output GPIO */
>
> +       spin_lock_irqsave(&gpio->lock, flags);
> +       rc = sgpio_set_value(gc, offset, val);
>         spin_unlock_irqrestore(&gpio->lock, flags);
>
>         return 0;

I think this should be 'return rc'

Cheers,

Joel
