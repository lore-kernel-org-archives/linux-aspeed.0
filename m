From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Date: Fri, 17 Feb 2023 14:28:16 +0100
Subject: [PATCH 10/17] gpio: idt3243x: Convert to immutable irq_chip
In-Reply-To: <20230215-immutable-chips-v1-10-51a8f224a5d0@linaro.org>
References: <20230215-immutable-chips-v1-0-51a8f224a5d0@linaro.org>
 <20230215-immutable-chips-v1-10-51a8f224a5d0@linaro.org>
Message-ID: <20230217132816.GA9335@alpha.franken.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Feb 16, 2023 at 10:37:11AM +0100, Linus Walleij wrote:
> Convert the driver to immutable irq-chip with a bit of
> intuition.
> 
> Cc: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/gpio/gpio-idt3243x.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-idt3243x.c b/drivers/gpio/gpio-idt3243x.c
> index 1cafdf46f875..00f547d26254 100644
> --- a/drivers/gpio/gpio-idt3243x.c
> +++ b/drivers/gpio/gpio-idt3243x.c
> @@ -92,6 +92,8 @@ static void idt_gpio_mask(struct irq_data *d)
>  	writel(ctrl->mask_cache, ctrl->pic + IDT_PIC_IRQ_MASK);
>  
>  	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
> +
> +	gpiochip_disable_irq(gc, irqd_to_hwirq(d));
>  }
>  
>  static void idt_gpio_unmask(struct irq_data *d)
> @@ -100,6 +102,7 @@ static void idt_gpio_unmask(struct irq_data *d)
>  	struct idt_gpio_ctrl *ctrl = gpiochip_get_data(gc);
>  	unsigned long flags;
>  
> +	gpiochip_enable_irq(gc, irqd_to_hwirq(d));
>  	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
>  
>  	ctrl->mask_cache &= ~BIT(d->hwirq);
> @@ -119,12 +122,14 @@ static int idt_gpio_irq_init_hw(struct gpio_chip *gc)
>  	return 0;
>  }
>  
> -static struct irq_chip idt_gpio_irqchip = {
> +static const struct irq_chip idt_gpio_irqchip = {
>  	.name = "IDTGPIO",
>  	.irq_mask = idt_gpio_mask,
>  	.irq_ack = idt_gpio_ack,
>  	.irq_unmask = idt_gpio_unmask,
> -	.irq_set_type = idt_gpio_irq_set_type
> +	.irq_set_type = idt_gpio_irq_set_type,
> +	.flags = IRQCHIP_IMMUTABLE,
> +	GPIOCHIP_IRQ_RESOURCE_HELPERS,
>  };
>  
>  static int idt_gpio_probe(struct platform_device *pdev)
> @@ -168,7 +173,7 @@ static int idt_gpio_probe(struct platform_device *pdev)
>  			return parent_irq;
>  
>  		girq = &ctrl->gc.irq;
> -		girq->chip = &idt_gpio_irqchip;
> +		gpio_irq_chip_set_chip(girq, &idt_gpio_irqchip);
>  		girq->init_hw = idt_gpio_irq_init_hw;
>  		girq->parent_handler = idt_gpio_dispatch;
>  		girq->num_parents = 1;
> 
> -- 
> 2.34.1

Tested-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>


-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
