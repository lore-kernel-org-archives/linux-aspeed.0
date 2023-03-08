From: Joel Stanley <joel@jms.id.au>
Date: Wed, 8 Mar 2023 01:21:50 +0000
Subject: [PATCH v2 03/16] gpio: aspeed: Convert to immutable irq_chip
In-Reply-To: <20230215-immutable-chips-v2-3-d6b0e3f2d991@linaro.org>
References: <20230215-immutable-chips-v2-0-d6b0e3f2d991@linaro.org> <20230215-immutable-chips-v2-3-d6b0e3f2d991@linaro.org>
Message-ID: <CACPK8Xc7ekzM9oeR7+fYuK8RfZ4jA8gpH=nUJ-OTp0XZoKwzHQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 7 Mar 2023 at 13:04, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> Convert the driver to immutable irq-chip with a bit of
> intuition.
>
> Cc: Marc Zyngier <maz@kernel.org>
> Tested-by: Joel Stanley <joel@jms.id.au>
> Acked-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/gpio/gpio-aspeed.c | 44 ++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 38 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
> index a94da80d3a95..9c4852de2733 100644
> --- a/drivers/gpio/gpio-aspeed.c
> +++ b/drivers/gpio/gpio-aspeed.c
> @@ -15,6 +15,7 @@
>  #include <linux/module.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
> +#include <linux/seq_file.h>
>  #include <linux/spinlock.h>
>  #include <linux/string.h>
>
> @@ -53,7 +54,7 @@ struct aspeed_gpio_config {
>   */
>  struct aspeed_gpio {
>         struct gpio_chip chip;
> -       struct irq_chip irqc;
> +       struct device *dev;
>         raw_spinlock_t lock;
>         void __iomem *base;
>         int irq;
> @@ -566,6 +567,10 @@ static void aspeed_gpio_irq_set_mask(struct irq_data *d, bool set)
>
>         addr = bank_reg(gpio, bank, reg_irq_enable);
>
> +       /* Unmasking the IRQ */
> +       if (set)
> +               gpiochip_enable_irq(&gpio->chip, irqd_to_hwirq(d));
> +
>         raw_spin_lock_irqsave(&gpio->lock, flags);
>         copro = aspeed_gpio_copro_request(gpio, offset);
>
> @@ -579,6 +584,10 @@ static void aspeed_gpio_irq_set_mask(struct irq_data *d, bool set)
>         if (copro)
>                 aspeed_gpio_copro_release(gpio, offset);
>         raw_spin_unlock_irqrestore(&gpio->lock, flags);
> +
> +       /* Masking the IRQ */
> +       if (!set)
> +               gpiochip_disable_irq(&gpio->chip, irqd_to_hwirq(d));
>  }
>
>  static void aspeed_gpio_irq_mask(struct irq_data *d)
> @@ -1080,6 +1089,30 @@ int aspeed_gpio_copro_release_gpio(struct gpio_desc *desc)
>  }
>  EXPORT_SYMBOL_GPL(aspeed_gpio_copro_release_gpio);
>
> +static void aspeed_gpio_irq_print_chip(struct irq_data *d, struct seq_file *p)
> +{
> +       const struct aspeed_gpio_bank *bank;
> +       struct aspeed_gpio *gpio;
> +       u32 bit;
> +       int rc, offset;
> +
> +       rc = irqd_to_aspeed_gpio_data(d, &gpio, &bank, &bit, &offset);

Why do we call this instead of using irq_data_get_irq_chip_data?

Actually, the callback appears to do the same as the default
implementation, so we could just drop it?

from kernel/irq/proc.c:

        if (desc->irq_data.chip) {
                if (desc->irq_data.chip->irq_print_chip)
                        desc->irq_data.chip->irq_print_chip(&desc->irq_data, p);
                else if (desc->irq_data.chip->name)
                        seq_printf(p, " %8s", desc->irq_data.chip->name);

A test on the rainier ast2600 bmc machine:

# gpio-event-mon -n gpiochip0 -o 123 -r -f &
# cat /proc/interrupts  |grep gpio-event-mon
 60:          0          0  1e780800.gpio 123 Edge      gpio-event-mon




> +       if (rc)
> +               return;
> +
> +       seq_printf(p, dev_name(gpio->dev));
> +}
> +
> +static const struct irq_chip aspeed_gpio_irq_chip = {
> +       .irq_ack = aspeed_gpio_irq_ack,
> +       .irq_mask = aspeed_gpio_irq_mask,
> +       .irq_unmask = aspeed_gpio_irq_unmask,
> +       .irq_set_type = aspeed_gpio_set_type,
> +       .irq_print_chip = aspeed_gpio_irq_print_chip,
> +       .flags = IRQCHIP_IMMUTABLE,
> +       GPIOCHIP_IRQ_RESOURCE_HELPERS,
> +};
> +
>  /*
>   * Any banks not specified in a struct aspeed_bank_props array are assumed to
>   * have the properties:
> @@ -1149,6 +1182,8 @@ static int __init aspeed_gpio_probe(struct platform_device *pdev)
>         if (IS_ERR(gpio->base))
>                 return PTR_ERR(gpio->base);
>
> +       gpio->dev = &pdev->dev;
> +
>         raw_spin_lock_init(&gpio->lock);
>
>         gpio_id = of_match_node(aspeed_gpio_of_table, pdev->dev.of_node);
> @@ -1208,12 +1243,9 @@ static int __init aspeed_gpio_probe(struct platform_device *pdev)
>
>                 gpio->irq = rc;
>                 girq = &gpio->chip.irq;
> -               girq->chip = &gpio->irqc;
> +               gpio_irq_chip_set_chip(girq, &aspeed_gpio_irq_chip);
>                 girq->chip->name = dev_name(&pdev->dev);
> -               girq->chip->irq_ack = aspeed_gpio_irq_ack;
> -               girq->chip->irq_mask = aspeed_gpio_irq_mask;
> -               girq->chip->irq_unmask = aspeed_gpio_irq_unmask;
> -               girq->chip->irq_set_type = aspeed_gpio_set_type;
> +

I was thinking we could make the interrupt registration unconditional,
as there's always an irq in the device tree. Happy to send a follow
up, or for you to fold in a change along the lines of this:

--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -1091,14 +1091,7 @@ EXPORT_SYMBOL_GPL(aspeed_gpio_copro_release_gpio);

 static void aspeed_gpio_irq_print_chip(struct irq_data *d, struct seq_file *p)
 {
-       const struct aspeed_gpio_bank *bank;
-       struct aspeed_gpio *gpio;
-       u32 bit;
-       int rc, offset;
-
-       rc = irqd_to_aspeed_gpio_data(d, &gpio, &bank, &bit, &offset);
-       if (rc)
-               return;
+       struct aspeed_gpio *gpio = irq_data_get_irq_chip_data(d);

        seq_printf(p, dev_name(gpio->dev));
 }
@@ -1108,7 +1101,7 @@ static const struct irq_chip aspeed_gpio_irq_chip = {
        .irq_mask = aspeed_gpio_irq_mask,
        .irq_unmask = aspeed_gpio_irq_unmask,
        .irq_set_type = aspeed_gpio_set_type,
-       .irq_print_chip = aspeed_gpio_irq_print_chip,
+//     .irq_print_chip = aspeed_gpio_irq_print_chip,
        .flags = IRQCHIP_IMMUTABLE,
        GPIOCHIP_IRQ_RESOURCE_HELPERS,
 };
@@ -1170,6 +1163,7 @@ MODULE_DEVICE_TABLE(of, aspeed_gpio_of_table);
 static int __init aspeed_gpio_probe(struct platform_device *pdev)
 {
        const struct of_device_id *gpio_id;
+       struct gpio_irq_chip *girq;
        struct aspeed_gpio *gpio;
        int rc, i, banks, err;
        u32 ngpio;
@@ -1238,27 +1232,25 @@ static int __init aspeed_gpio_probe(struct
platform_device *pdev)

        /* Optionally set up an irqchip if there is an IRQ */
        rc = platform_get_irq(pdev, 0);
-       if (rc > 0) {
-               struct gpio_irq_chip *girq;
-
-               gpio->irq = rc;
-               girq = &gpio->chip.irq;
-               gpio_irq_chip_set_chip(girq, &aspeed_gpio_irq_chip);
-               girq->chip->name = dev_name(&pdev->dev);
-
-               girq->parent_handler = aspeed_gpio_irq_handler;
-               girq->num_parents = 1;
-               girq->parents = devm_kcalloc(&pdev->dev, 1,
-                                            sizeof(*girq->parents),
-                                            GFP_KERNEL);
-               if (!girq->parents)
-                       return -ENOMEM;
-               girq->parents[0] = gpio->irq;
-               girq->default_type = IRQ_TYPE_NONE;
-               girq->handler = handle_bad_irq;
-               girq->init_valid_mask = aspeed_init_irq_valid_mask;
+       if (rc < 0) {
+               return rc;
        }

+       gpio->irq = rc;
+       girq = &gpio->chip.irq;
+       gpio_irq_chip_set_chip(girq, &aspeed_gpio_irq_chip);
+       girq->chip->name = dev_name(&pdev->dev);
+
+       girq->parent_handler = aspeed_gpio_irq_handler;
+       girq->num_parents = 1;
+       girq->parents = devm_kcalloc(&pdev->dev, 1,
sizeof(*girq->parents), GFP_KERNEL);
+       if (!girq->parents)
+               return -ENOMEM;
+       girq->parents[0] = gpio->irq;
+       girq->default_type = IRQ_TYPE_NONE;
+       girq->handler = handle_bad_irq;
+       girq->init_valid_mask = aspeed_init_irq_valid_mask;
+
        gpio->offset_timer =
                devm_kzalloc(&pdev->dev, gpio->chip.ngpio, GFP_KERNEL);
        if (!gpio->offset_timer)


>                 girq->parent_handler = aspeed_gpio_irq_handler;
>                 girq->num_parents = 1;
>                 girq->parents = devm_kcalloc(&pdev->dev, 1,
>
> --
> 2.34.1
>
