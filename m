From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 4 Sep 2019 19:30:09 +0300
Subject: [PATCH 3/4] gpio: Add in ast2600 details to Aspeed driver
In-Reply-To: <20190904061245.30770-3-rashmica.g@gmail.com>
References: <20190904061245.30770-1-rashmica.g@gmail.com>
 <20190904061245.30770-3-rashmica.g@gmail.com>
Message-ID: <CAHp75Ve0zEkuD-75aZ6FU+A=DvX8NvVvY3n9p_pYDyfa76sxoQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Sep 4, 2019 at 9:14 AM Rashmica Gupta <rashmica.g@gmail.com> wrote:
>
> The ast2600 has two gpio controllers, one for 3.6V GPIOS and one for 1.8V GPIOS.
>
> Signed-off-by: Rashmica Gupta <rashmica.g@gmail.com>

> -       for (i = 0; i < ARRAY_SIZE(aspeed_gpio_banks); i++) {
> +       banks = (gpio->config->nr_gpios >> 5) + 1;

Same comment as per the other patch.

> +       for (i = 0; i < banks; i++) {

> +static const struct aspeed_bank_props ast2600_bank_props[] = {
> +       /*     input      output   */
> +       {5, 0xffffffff,  0x0000ffff}, /* U/V/W/X */
> +       {6, 0xffff0000,  0x0fff0000}, /* Y/Z */

Perhaps GENMASK() for all values?

> +       { },

Comma is not needed here.

> +};
> +
> +static const struct aspeed_gpio_config ast2600_config =
> +       /* 208 3.6V GPIOs */

> +       { .nr_gpios = 208, .props = ast2600_bank_props, };

Seems curly braces missed their places.

> +static const struct aspeed_bank_props ast2600_1_8v_bank_props[] = {
> +       /*     input      output   */
> +       {1, 0x0000000f,  0x0000000f}, /* E */

GENMASK()?

> +       { },

No comma.

> +};

> +static const struct aspeed_gpio_config ast2600_1_8v_config =
> +       /* 36 1.8V GPIOs */
> +       { .nr_gpios = 36, .props = ast2600_1_8v_bank_props, };

Location of the curly braces?

-- 
With Best Regards,
Andy Shevchenko
