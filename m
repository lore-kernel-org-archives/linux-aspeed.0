From: Joel Stanley <joel@jms.id.au>
Date: Mon, 18 Jun 2018 15:08:40 +0930
Subject: [PATCH v2 3/4] gpio: aspeed: Add command source registers
In-Reply-To: <20180618045352.9489-4-benh@kernel.crashing.org>
References: <20180618045352.9489-1-benh@kernel.crashing.org>
 <20180618045352.9489-4-benh@kernel.crashing.org>
Message-ID: <CACPK8XdRHgNhz6xNJorUKPVk7SKrJEXTdfSPA_tnV_RYx7iL1A@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 18 June 2018 at 14:23, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> This adds the definitions for the command source registers
> and a helper to set them.
>
> Those registers allow to control which bus master on the
> SoC is allowed to modify a given bank of GPIOs and will
> be used by subsequent patches.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

>
> +static void aspeed_gpio_change_cmd_source(struct aspeed_gpio *gpio,
> +                                         const struct aspeed_gpio_bank *bank,
> +                                         int bindex, int cmdsrc)
> +{
> +       void __iomem *c0 = bank_reg(gpio, bank, reg_cmdsrc0);
> +       void __iomem *c1 = bank_reg(gpio, bank, reg_cmdsrc1);
> +       u32 bit, reg;
> +
> +       /*
> +        * Each register controls 4 banks, so take the bottom 2
> +        * bits of the bank index, and use them to select the
> +        * right control bit (0, 8, 16 or 24).
> +        */
> +       bit = BIT((bindex & 3) << 3);

This is still hard to understand (it looks like a mistake at first
glance). I don't have any suggestions other than changing  << 3 to *
8.

The comment does explain it, so I'm fine with it going in.

Reviewed-by: Joel Stanley <joel@jms.id.au>

> +
> +       /* Source 1 first to avoid illegal 11 combination */
> +       reg = ioread32(c1);
> +       if (cmdsrc & 2)
> +               reg |= bit;
> +       else
> +               reg &= ~bit;
> +       iowrite32(reg, c1);
> +
> +       /* Then Source 0 */
> +       reg = ioread32(c0);
> +       if (cmdsrc & 1)
> +               reg |= bit;
> +       else
> +               reg &= ~bit;
> +       iowrite32(reg, c0);
> +}
> +
>  static int aspeed_gpio_get(struct gpio_chip *gc, unsigned int offset)
>  {
>         struct aspeed_gpio *gpio = gpiochip_get_data(gc);
> --
> 2.17.1
>
