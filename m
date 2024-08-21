From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 21 Aug 2024 14:10:38 +0200
Subject: [PATCH v1 2/2] gpio: Add G7 Aspeed gpio controller driver
In-Reply-To: <20240821070740.2378602-3-billy_tsai@aspeedtech.com>
References: <20240821070740.2378602-1-billy_tsai@aspeedtech.com> <20240821070740.2378602-3-billy_tsai@aspeedtech.com>
Message-ID: <CAMRc=McaNo5hxEwJJhZSE8PWno5r7+9XLn-1iZoJkRfNHN8U0Q@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Aug 21, 2024 at 9:07?AM Billy Tsai <billy_tsai@aspeedtech.com> wrote:
>
> In the 7th generation of the SoC from Aspeed, the control logic of the
> GPIO controller has been updated to support per-pin control. Each pin now
> has its own 32-bit register, allowing for individual control of the pin?s
> value, direction, interrupt type, and other settings.
>
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  drivers/gpio/Kconfig          |   7 +
>  drivers/gpio/Makefile         |   1 +
>  drivers/gpio/gpio-aspeed-g7.c | 831 ++++++++++++++++++++++++++++++++++
>  3 files changed, 839 insertions(+)
>  create mode 100644 drivers/gpio/gpio-aspeed-g7.c
>
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 58f43bcced7c..93f237429b92 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -172,6 +172,13 @@ config GPIO_ASPEED
>         help
>           Say Y here to support Aspeed AST2400 and AST2500 GPIO controllers.
>
> +config GPIO_ASPEED_G7
> +       tristate "Aspeed G7 GPIO support"
> +       depends on (ARCH_ASPEED || COMPILE_TEST) && OF_GPIO
> +       select GPIOLIB_IRQCHIP
> +       help
> +         Say Y here to support Aspeed AST2700 GPIO controllers.
> +
>  config GPIO_ASPEED_SGPIO
>         bool "Aspeed SGPIO support"
>         depends on (ARCH_ASPEED || COMPILE_TEST) && OF_GPIO
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index 64dd6d9d730d..e830291761ee 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -34,6 +34,7 @@ obj-$(CONFIG_GPIO_AMD_FCH)            += gpio-amd-fch.o
>  obj-$(CONFIG_GPIO_AMDPT)               += gpio-amdpt.o
>  obj-$(CONFIG_GPIO_ARIZONA)             += gpio-arizona.o
>  obj-$(CONFIG_GPIO_ASPEED)              += gpio-aspeed.o
> +obj-$(CONFIG_GPIO_ASPEED_G7)           += gpio-aspeed-g7.o
>  obj-$(CONFIG_GPIO_ASPEED_SGPIO)                += gpio-aspeed-sgpio.o
>  obj-$(CONFIG_GPIO_ATH79)               += gpio-ath79.o
>  obj-$(CONFIG_GPIO_BCM_KONA)            += gpio-bcm-kona.o
> diff --git a/drivers/gpio/gpio-aspeed-g7.c b/drivers/gpio/gpio-aspeed-g7.c
> new file mode 100644
> index 000000000000..dbca097de6ea
> --- /dev/null
> +++ b/drivers/gpio/gpio-aspeed-g7.c
> @@ -0,0 +1,831 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright 2024 Aspeed Technology Inc.
> + *
> + * Billy Tsai <billy_tsai@aspeedtech.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/gpio/aspeed.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/hashtable.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/pinctrl/consumer.h>
> +#include <linux/platform_device.h>
> +#include <linux/seq_file.h>
> +#include <linux/spinlock.h>
> +#include <linux/string.h>
> +
> +#include <asm/div64.h>
> +
> +#define GPIO_G7_IRQ_STS_BASE 0x100
> +#define GPIO_G7_IRQ_STS_OFFSET(x) (GPIO_G7_IRQ_STS_BASE + (x) * 0x4)
> +#define GPIO_G7_CTRL_REG_BASE 0x180
> +#define GPIO_G7_CTRL_REG_OFFSET(x) (GPIO_G7_CTRL_REG_BASE + (x) * 0x4)
> +#define GPIO_G7_OUT_DATA BIT(0)
> +#define GPIO_G7_DIR BIT(1)
> +#define GPIO_G7_IRQ_EN BIT(2)
> +#define GPIO_G7_IRQ_TYPE0 BIT(3)
> +#define GPIO_G7_IRQ_TYPE1 BIT(4)
> +#define GPIO_G7_IRQ_TYPE2 BIT(5)
> +#define GPIO_G7_RST_TOLERANCE BIT(6)
> +#define GPIO_G7_DEBOUNCE_SEL GENMASK(8, 7)
> +#define GPIO_G7_INPUT_MASK BIT(9)
> +#define GPIO_G7_IRQ_STS BIT(12)
> +#define GPIO_G7_IN_DATA BIT(13)
> +/*
> + * The configuration of the following registers should be determined
> + * outside of the GPIO driver.
> + */
> +#define GPIO_G7_PRIVILEGE_W_REG_BASE 0x810
> +#define GPIO_G7_PRIVILEGE_W_REG_OFFSET(x) (GPIO_G7_PRIVILEGE_W_REG_BASE + ((x) >> 2) * 0x4)
> +#define GPIO_G7_PRIVILEGE_R_REG_BASE 0x910
> +#define GPIO_G7_PRIVILEGE_R_REG_OFFSET(x) (GPIO_G7_PRIVILEGE_R_REG_BASE + ((x) >> 2) * 0x4)
> +#define GPIO_G7_IRQ_TARGET_REG_BASE 0xA10
> +#define GPIO_G7_IRQ_TARGET_REG_OFFSET(x) (GPIO_G7_IRQ_TARGET_REG_BASE + ((x) >> 2) * 0x4)
> +#define GPIO_G7_IRQ_TO_INTC2_18 BIT(0)
> +#define GPIO_G7_IRQ_TO_INTC2_19 BIT(1)
> +#define GPIO_G7_IRQ_TO_INTC2_20 BIT(2)
> +#define GPIO_G7_IRQ_TO_SIO BIT(3)
> +#define GPIO_G7_IRQ_TARGET_RESET_TOLERANCE BIT(6)
> +#define GPIO_G7_IRQ_TARGET_W_PROTECT BIT(7)
> +
> +static inline u32 field_get(u32 _mask, u32 _val)
> +{
> +       return (((_val) & (_mask)) >> (ffs(_mask) - 1));
> +}
> +
> +static inline u32 field_prep(u32 _mask, u32 _val)
> +{
> +       return (((_val) << (ffs(_mask) - 1)) & (_mask));
> +}
> +
> +static inline void ast_write_bits(void __iomem *addr, u32 mask, u32 val)
> +{
> +       iowrite32((ioread32(addr) & ~(mask)) | field_prep(mask, val), addr);
> +}
> +
> +static inline void ast_clr_bits(void __iomem *addr, u32 mask)
> +{
> +       iowrite32((ioread32(addr) & ~(mask)), addr);
> +}

For all of the above and similar instances below - can you add the
aspeed prefix to symbols?

[snip]

> +
> +/*
> + * Note: The "value" register returns the input value sampled on the
> + *       line even when the GPIO is configured as an output. Since
> + *       that input goes through synchronizers, writing, then reading

Drop the leading tabs indentations from the comment.

[snip]

> +
> +       register_allocated_timer(gpio, offset, i);
> +       configure_timer(gpio, offset, i);
> +
> +out:
> +       raw_spin_unlock_irqrestore(&gpio->lock, flags);
> +

How about using scoped guards across the driver? You'll avoid such labels.

[snip]

> +
> +static int aspeed_gpio_g7_set_config(struct gpio_chip *chip, unsigned int offset,
> +                                    unsigned long config)
> +{
> +       unsigned long param = pinconf_to_config_param(config);
> +       u32 arg = pinconf_to_config_argument(config);
> +
> +       if (param == PIN_CONFIG_INPUT_DEBOUNCE)
> +               return set_debounce(chip, offset, arg);
> +       else if (param == PIN_CONFIG_BIAS_DISABLE || param == PIN_CONFIG_BIAS_PULL_DOWN ||
> +                param == PIN_CONFIG_DRIVE_STRENGTH)
> +               return pinctrl_gpio_set_config(offset, config);
> +       else if (param == PIN_CONFIG_DRIVE_OPEN_DRAIN || param == PIN_CONFIG_DRIVE_OPEN_SOURCE)
> +               /* Return -EOPNOTSUPP to trigger emulation, as per datasheet */
> +               return -EOPNOTSUPP;
> +       else if (param == PIN_CONFIG_PERSIST_STATE)
> +               return aspeed_gpio_g7_reset_tolerance(chip, offset, arg);
> +

Please use a switch here like everyone else.

> +       return -EOPNOTSUPP;
> +}
> +
> +static void aspeed_gpio_g7_irq_print_chip(struct irq_data *d, struct seq_file *p)
> +{
> +       struct aspeed_gpio_g7 *gpio;
> +       int rc, offset;
> +
> +       rc = irqd_to_aspeed_gpio_g7_data(d, &gpio, &offset);
> +       if (rc)
> +               return;
> +
> +       seq_printf(p, dev_name(gpio->dev));
> +}
> +
> +static const struct irq_chip aspeed_gpio_g7_irq_chip = {
> +       .irq_ack = aspeed_gpio_g7_irq_ack,
> +       .irq_mask = aspeed_gpio_g7_irq_mask,
> +       .irq_unmask = aspeed_gpio_g7_irq_unmask,
> +       .irq_set_type = aspeed_gpio_g7_set_type,
> +       .irq_print_chip = aspeed_gpio_g7_irq_print_chip,
> +       .flags = IRQCHIP_IMMUTABLE,
> +       GPIOCHIP_IRQ_RESOURCE_HELPERS,
> +};
> +
> +static const struct aspeed_bank_props ast2700_bank_props[] = {
> +       /*     input      output   */
> +       { 1, 0x0fffffff, 0x0fffffff }, /* E/F/G/H, 4-GPIO hole */
> +       { 6, 0x00ffffff, 0x00ffffff }, /* Y/Z/AA */
> +       {},
> +};
> +
> +static const struct aspeed_gpio_g7_config ast2700_config =
> +       /*
> +        * ast2700 has two controllers one with 212 GPIOs and one with 16 GPIOs.
> +        * 216 for simplicity, actual number is 212 (4-GPIO hole in GPIOH)
> +        * We expect ngpio being set in the device tree and this is a fallback
> +        * option.
> +        */
> +       {
> +               .nr_gpios = 216,
> +               .props = ast2700_bank_props,
> +       };
> +
> +static const struct of_device_id aspeed_gpio_g7_of_table[] = {
> +       {
> +               .compatible = "aspeed,ast2700-gpio",
> +               .data = &ast2700_config,
> +       },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, aspeed_gpio_g7_of_table);
> +
> +static int __init aspeed_gpio_g7_probe(struct platform_device *pdev)
> +{
> +       const struct of_device_id *gpio_id;
> +       struct aspeed_gpio_g7 *gpio;
> +       int rc, banks, err;
> +       u32 ngpio;
> +
> +       gpio = devm_kzalloc(&pdev->dev, sizeof(*gpio), GFP_KERNEL);
> +       if (!gpio)
> +               return -ENOMEM;
> +
> +       gpio->base = devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(gpio->base))
> +               return PTR_ERR(gpio->base);
> +
> +       gpio->dev = &pdev->dev;
> +
> +       raw_spin_lock_init(&gpio->lock);
> +
> +       gpio_id = of_match_node(aspeed_gpio_g7_of_table, pdev->dev.of_node);

Please use device_get_match_data() and elsewhere use generic device
property getters instead of the specialized OF variants.

> +       if (!gpio_id)
> +               return -EINVAL;
> +
> +       gpio->clk = of_clk_get(pdev->dev.of_node, 0);
> +       if (IS_ERR(gpio->clk)) {
> +               dev_warn(&pdev->dev, "Failed to get clock from devicetree, debouncing disabled\n");
> +               gpio->clk = NULL;
> +       }
> +
> +       gpio->config = gpio_id->data;
> +
> +       gpio->chip.parent = &pdev->dev;
> +       err = of_property_read_u32(pdev->dev.of_node, "ngpios", &ngpio);
> +       gpio->chip.ngpio = (u16)ngpio;
> +       if (err)
> +               gpio->chip.ngpio = gpio->config->nr_gpios;
> +       gpio->chip.direction_input = aspeed_gpio_g7_dir_in;
> +       gpio->chip.direction_output = aspeed_gpio_g7_dir_out;
> +       gpio->chip.get_direction = aspeed_gpio_g7_get_direction;
> +       gpio->chip.request = aspeed_gpio_g7_request;
> +       gpio->chip.free = aspeed_gpio_g7_free;
> +       gpio->chip.get = aspeed_gpio_g7_get;
> +       gpio->chip.set = aspeed_gpio_g7_set;
> +       gpio->chip.set_config = aspeed_gpio_g7_set_config;
> +       gpio->chip.label = dev_name(&pdev->dev);
> +       gpio->chip.base = -1;
> +
> +       /* Allocate a cache of the output registers */
> +       banks = DIV_ROUND_UP(gpio->chip.ngpio, 32);
> +       gpio->dcache = devm_kcalloc(&pdev->dev, banks, sizeof(u32), GFP_KERNEL);
> +       if (!gpio->dcache)
> +               return -ENOMEM;
> +
> +       /* Optionally set up an irqchip if there is an IRQ */
> +       rc = platform_get_irq(pdev, 0);
> +       if (rc > 0) {
> +               struct gpio_irq_chip *girq;
> +
> +               gpio->irq = rc;
> +               girq = &gpio->chip.irq;
> +               gpio_irq_chip_set_chip(girq, &aspeed_gpio_g7_irq_chip);
> +               girq->chip->name = dev_name(&pdev->dev);
> +
> +               girq->parent_handler = aspeed_gpio_g7_irq_handler;
> +               girq->num_parents = 1;
> +               girq->parents = devm_kcalloc(&pdev->dev, 1, sizeof(*girq->parents), GFP_KERNEL);
> +               if (!girq->parents)
> +                       return -ENOMEM;
> +               girq->parents[0] = gpio->irq;
> +               girq->default_type = IRQ_TYPE_NONE;
> +               girq->handler = handle_bad_irq;
> +               girq->init_valid_mask = aspeed_init_irq_valid_mask;
> +       }
> +
> +       gpio->offset_timer = devm_kzalloc(&pdev->dev, gpio->chip.ngpio, GFP_KERNEL);
> +       if (!gpio->offset_timer)
> +               return -ENOMEM;
> +
> +       rc = devm_gpiochip_add_data(&pdev->dev, &gpio->chip, gpio);

Just return devm_gpiochip_add_data().

> +       if (rc < 0)
> +               return rc;
> +
> +       return 0;
> +}
> +
> +static struct platform_driver aspeed_gpio_g7_driver = {
> +       .driver = {
> +               .name = KBUILD_MODNAME,
> +               .of_match_table = aspeed_gpio_g7_of_table,
> +       },
> +};
> +
> +module_platform_driver_probe(aspeed_gpio_g7_driver, aspeed_gpio_g7_probe);

I see that it was done like this in other aspeed drivers but I would
need some explanation as to why you think it's needed here. You do get
some resources in probe() that may defer the probing of this driver
and this macro doesn't allow it. Unless you have a very good reason, I
suspect you want to use module_platform_driver() here instead.

> +
> +MODULE_DESCRIPTION("Aspeed G7 GPIO Driver");
> +MODULE_LICENSE("GPL");

MODULE_AUTHOR()?

Bart

> --
> 2.25.1
>
