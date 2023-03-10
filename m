From: Romain Perier <romain.perier@gmail.com>
Date: Fri, 10 Mar 2023 09:06:38 +0100
Subject: [PATCH v3 11/17] gpio: msc313: Convert to immutable irq_chip
In-Reply-To: <20230215-immutable-chips-v3-11-972542092a77@linaro.org>
References: <20230215-immutable-chips-v3-0-972542092a77@linaro.org> <20230215-immutable-chips-v3-11-972542092a77@linaro.org>
Message-ID: <CABgxDoLkhOR=eq5TAoLk-GfOvPgKzbRyedaM+j-8YsRYn27DMw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Le jeu. 9 mars 2023 ? 08:46, Linus Walleij <linus.walleij@linaro.org> a ?crit :
>
> Convert the driver to immutable irq-chip with a bit of
> intuition.
>
> This conversion follows the pattern of the gpio-ixp4xx
> hierarchical GPIO interrupt driver.

Hi,

lgtm

>
> Cc: Marc Zyngier <maz@kernel.org>
> Acked-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Romain Perier <romain.perier@gmail.com>

> ---
>  drivers/gpio/gpio-msc313.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpio/gpio-msc313.c b/drivers/gpio/gpio-msc313.c
> index b0773e5652fa..036ad2324892 100644
> --- a/drivers/gpio/gpio-msc313.c
> +++ b/drivers/gpio/gpio-msc313.c
> @@ -532,17 +532,35 @@ static int msc313_gpio_direction_output(struct gpio_chip *chip, unsigned int off
>         return 0;
>  }
>
> +static void msc313_gpio_irq_mask(struct irq_data *d)
> +{
> +       struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
> +
> +       irq_chip_mask_parent(d);
> +       gpiochip_disable_irq(gc, d->hwirq);
> +}
> +
> +static void msc313_gpio_irq_unmask(struct irq_data *d)
> +{
> +       struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
> +
> +       gpiochip_enable_irq(gc, d->hwirq);
> +       irq_chip_unmask_parent(d);
> +}
> +
>  /*
>   * The interrupt handling happens in the parent interrupt controller,
>   * we don't do anything here.
>   */
> -static struct irq_chip msc313_gpio_irqchip = {
> +static const struct irq_chip msc313_gpio_irqchip = {
>         .name = "GPIO",
>         .irq_eoi = irq_chip_eoi_parent,
> -       .irq_mask = irq_chip_mask_parent,
> -       .irq_unmask = irq_chip_unmask_parent,
> +       .irq_mask = msc313_gpio_irq_mask,
> +       .irq_unmask = msc313_gpio_irq_unmask,
>         .irq_set_type = irq_chip_set_type_parent,
>         .irq_set_affinity = irq_chip_set_affinity_parent,
> +       .flags = IRQCHIP_IMMUTABLE,
> +       GPIOCHIP_IRQ_RESOURCE_HELPERS,
>  };
>
>  /*
> @@ -644,7 +662,7 @@ static int msc313_gpio_probe(struct platform_device *pdev)
>         gpiochip->names = gpio->gpio_data->names;
>
>         gpioirqchip = &gpiochip->irq;
> -       gpioirqchip->chip = &msc313_gpio_irqchip;
> +       gpio_irq_chip_set_chip(gpioirqchip, &msc313_gpio_irqchip);
>         gpioirqchip->fwnode = of_node_to_fwnode(dev->of_node);
>         gpioirqchip->parent_domain = parent_domain;
>         gpioirqchip->child_to_parent_hwirq = msc313e_gpio_child_to_parent_hwirq;
>
> --
> 2.34.1
>
