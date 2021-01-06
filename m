From: Marc Zyngier <maz@kernel.org>
Date: Wed, 06 Jan 2021 10:59:25 +0000
Subject: [PATCH 4/6] irqchip/aspeed: Add Aspeed eSPI interrupt controller
In-Reply-To: <20210106055939.19386-5-chiawei_wang@aspeedtech.com>
References: <20210106055939.19386-1-chiawei_wang@aspeedtech.com>
 <20210106055939.19386-5-chiawei_wang@aspeedtech.com>
Message-ID: <123bc25c72b3b17c0c4154d8bd8ce3b0@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 2021-01-06 05:59, Chia-Wei, Wang wrote:
> The eSPI interrupt controller acts as a SW IRQ number
> decoder to correctly control/dispatch interrupts of
> the eSPI peripheral, virtual wire, out-of-band, and
> flash channels.
> 
> Signed-off-by: Chia-Wei, Wang <chiawei_wang@aspeedtech.com>
> ---
>  drivers/irqchip/Makefile             |   2 +-
>  drivers/irqchip/irq-aspeed-espi-ic.c | 251 ++++++++++++++++++++++++
>  include/soc/aspeed/espi.h            | 279 +++++++++++++++++++++++++++
>  3 files changed, 531 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/irqchip/irq-aspeed-espi-ic.c
>  create mode 100644 include/soc/aspeed/espi.h
> 
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index 0ac93bfaec61..56da4a3123f8 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -86,7 +86,7 @@ obj-$(CONFIG_MVEBU_PIC)			+= irq-mvebu-pic.o
>  obj-$(CONFIG_MVEBU_SEI)			+= irq-mvebu-sei.o
>  obj-$(CONFIG_LS_EXTIRQ)			+= irq-ls-extirq.o
>  obj-$(CONFIG_LS_SCFG_MSI)		+= irq-ls-scfg-msi.o
> -obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-vic.o irq-aspeed-i2c-ic.o
> irq-aspeed-scu-ic.o
> +obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-vic.o irq-aspeed-i2c-ic.o
> irq-aspeed-scu-ic.o irq-aspeed-espi-ic.o
>  obj-$(CONFIG_STM32_EXTI) 		+= irq-stm32-exti.o
>  obj-$(CONFIG_QCOM_IRQ_COMBINER)		+= qcom-irq-combiner.o
>  obj-$(CONFIG_IRQ_UNIPHIER_AIDET)	+= irq-uniphier-aidet.o
> diff --git a/drivers/irqchip/irq-aspeed-espi-ic.c
> b/drivers/irqchip/irq-aspeed-espi-ic.c
> new file mode 100644
> index 000000000000..8a5cc8fe3f0c
> --- /dev/null
> +++ b/drivers/irqchip/irq-aspeed-espi-ic.c
> @@ -0,0 +1,251 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2020 Aspeed Technology Inc.
> + */
> +#include <linux/bitops.h>
> +#include <linux/module.h>
> +#include <linux/irq.h>
> +#include <linux/irqchip.h>
> +#include <linux/irqchip/chained_irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/regmap.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +
> +#include <soc/aspeed/espi.h>
> +#include <dt-bindings/interrupt-controller/aspeed-espi-ic.h>
> +
> +#define DEVICE_NAME	"aspeed-espi-ic"
> +#define IRQCHIP_NAME	"eSPI-IC"
> +
> +#define ESPI_IC_IRQ_NUM	7
> +
> +struct aspeed_espi_ic {
> +	struct regmap *map;
> +	int irq;
> +	int gpio_irq;
> +	struct irq_domain *irq_domain;
> +};
> +
> +static void aspeed_espi_ic_gpio_isr(struct irq_desc *desc)
> +{
> +	unsigned int irq;
> +	struct aspeed_espi_ic *espi_ic = irq_desc_get_handler_data(desc);
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +
> +	chained_irq_enter(chip, desc);
> +
> +	irq = irq_find_mapping(espi_ic->irq_domain,
> +				   ASPEED_ESPI_IC_CTRL_RESET);
> +	generic_handle_irq(irq);
> +
> +	irq = irq_find_mapping(espi_ic->irq_domain,
> +				   ASPEED_ESPI_IC_CHAN_RESET);
> +	generic_handle_irq(irq);

So for each mux interrupt, you generate two endpoints interrupt,
without even checking whether they are pending? That's no good.

> +
> +	chained_irq_exit(chip, desc);
> +}
> +
> +static void aspeed_espi_ic_isr(struct irq_desc *desc)
> +{
> +	unsigned int sts;
> +	unsigned int irq;
> +	struct aspeed_espi_ic *espi_ic = irq_desc_get_handler_data(desc);
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +
> +	chained_irq_enter(chip, desc);
> +
> +	regmap_read(espi_ic->map, ESPI_INT_STS, &sts);
> +
> +	if (sts & ESPI_INT_STS_PERIF_BITS) {
> +		irq = irq_find_mapping(espi_ic->irq_domain,
> +				       ASPEED_ESPI_IC_PERIF_EVENT);
> +		generic_handle_irq(irq);
> +	}
> +
> +	if (sts & ESPI_INT_STS_VW_BITS) {
> +		irq = irq_find_mapping(espi_ic->irq_domain,
> +				       ASPEED_ESPI_IC_VW_EVENT);
> +		generic_handle_irq(irq);
> +	}
> +
> +	if (sts & ESPI_INT_STS_OOB_BITS) {
> +		irq = irq_find_mapping(espi_ic->irq_domain,
> +				       ASPEED_ESPI_IC_OOB_EVENT);
> +		generic_handle_irq(irq);
> +	}
> +
> +	if (sts & ESPI_INT_STS_FLASH_BITS) {
> +		irq = irq_find_mapping(espi_ic->irq_domain,
> +				       ASPEED_ESPI_IC_FLASH_EVENT);
> +		generic_handle_irq(irq);
> +	}
> +
> +	if (sts & ESPI_INT_STS_HW_RST_DEASSERT) {
> +		irq = irq_find_mapping(espi_ic->irq_domain,
> +				       ASPEED_ESPI_IC_CTRL_EVENT);
> +		generic_handle_irq(irq);
> +	}

This is horrible. Why can't you just use fls() in a loop?

> +
> +	chained_irq_exit(chip, desc);
> +}
> +
> +static void aspeed_espi_ic_irq_disable(struct irq_data *data)
> +{
> +	struct aspeed_espi_ic *espi_ic = irq_data_get_irq_chip_data(data);
> +
> +	switch (data->hwirq) {
> +	case ASPEED_ESPI_IC_CTRL_EVENT:
> +		regmap_update_bits(espi_ic->map, ESPI_INT_EN,
> +				   ESPI_INT_EN_HW_RST_DEASSERT,
> +				   0);
> +		break;
> +	case ASPEED_ESPI_IC_PERIF_EVENT:
> +		regmap_update_bits(espi_ic->map, ESPI_INT_EN,
> +				   ESPI_INT_EN_PERIF_BITS, 0);
> +		break;
> +	case ASPEED_ESPI_IC_VW_EVENT:
> +		regmap_update_bits(espi_ic->map, ESPI_INT_EN,
> +				   ESPI_INT_EN_VW_BITS, 0);
> +		break;
> +	case ASPEED_ESPI_IC_OOB_EVENT:
> +		regmap_update_bits(espi_ic->map, ESPI_INT_EN,
> +				   ESPI_INT_EN_OOB_BITS, 0);
> +		break;
> +	case ASPEED_ESPI_IC_FLASH_EVENT:
> +		regmap_update_bits(espi_ic->map, ESPI_INT_EN,
> +				   ESPI_INT_EN_FLASH_BITS, 0);
> +		break;
> +	}

Most of these are masking multiple events at once, which makes me
think that it really doesn't belong here...

> +}
> +
> +static void aspeed_espi_ic_irq_enable(struct irq_data *data)
> +{
> +	struct aspeed_espi_ic *espi_ic = irq_data_get_irq_chip_data(data);
> +
> +	switch (data->hwirq) {
> +	case ASPEED_ESPI_IC_CTRL_EVENT:
> +		regmap_update_bits(espi_ic->map, ESPI_INT_EN,
> +				   ESPI_INT_EN_HW_RST_DEASSERT,
> +				   ESPI_INT_EN_HW_RST_DEASSERT);
> +		break;
> +	case ASPEED_ESPI_IC_PERIF_EVENT:
> +		regmap_update_bits(espi_ic->map, ESPI_INT_EN,
> +				   ESPI_INT_EN_PERIF_BITS,
> +				   ESPI_INT_EN_PERIF_BITS);
> +		break;
> +	case ASPEED_ESPI_IC_VW_EVENT:
> +		regmap_update_bits(espi_ic->map, ESPI_INT_EN,
> +				   ESPI_INT_EN_VW_BITS,
> +				   ESPI_INT_EN_VW_BITS);
> +		break;
> +	case ASPEED_ESPI_IC_OOB_EVENT:
> +		regmap_update_bits(espi_ic->map, ESPI_INT_EN,
> +				   ESPI_INT_EN_OOB_BITS,
> +				   ESPI_INT_EN_OOB_BITS);
> +		break;
> +	case ASPEED_ESPI_IC_FLASH_EVENT:
> +		regmap_update_bits(espi_ic->map, ESPI_INT_EN,
> +				   ESPI_INT_EN_FLASH_BITS,
> +				   ESPI_INT_EN_FLASH_BITS);
> +		break;
> +	}
> +}
> +
> +static struct irq_chip aspeed_espi_ic_chip = {
> +	.name = IRQCHIP_NAME,
> +	.irq_enable = aspeed_espi_ic_irq_enable,
> +	.irq_disable = aspeed_espi_ic_irq_disable,
> +};
> +
> +static int aspeed_espi_ic_map(struct irq_domain *domain, unsigned int 
> irq,
> +			     irq_hw_number_t hwirq)
> +{
> +	irq_set_chip_and_handler(irq, &aspeed_espi_ic_chip, 
> handle_simple_irq);
> +	irq_set_chip_data(irq, domain->host_data);
> +
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops aspeed_espi_ic_domain_ops = {
> +	.map = aspeed_espi_ic_map,
> +};
> +
> +static int aspeed_espi_ic_probe(struct platform_device *pdev)
> +{
> +	struct device *dev;
> +	struct aspeed_espi_ic *espi_ic;
> +
> +	dev = &pdev->dev;
> +
> +	espi_ic = devm_kzalloc(dev, sizeof(*espi_ic), GFP_KERNEL);
> +	if (!espi_ic)
> +		return -ENOMEM;
> +
> +	espi_ic->map = syscon_node_to_regmap(dev->parent->of_node);
> +	if (IS_ERR(espi_ic->map)) {
> +		dev_err(dev, "cannot get regmap\n");
> +		return -ENODEV;
> +	}
> +
> +	espi_ic->irq = platform_get_irq(pdev, 0);
> +	if (espi_ic->irq < 0)
> +		return espi_ic->irq;
> +
> +	espi_ic->gpio_irq = platform_get_irq(pdev, 1);
> +	if (espi_ic->gpio_irq < 0)
> +		return espi_ic->gpio_irq;
> +
> +	espi_ic->irq_domain = irq_domain_add_linear(dev->of_node, 
> ESPI_IC_IRQ_NUM,
> +						    &aspeed_espi_ic_domain_ops,
> +						    espi_ic);
> +	if (!espi_ic->irq_domain) {
> +		dev_err(dev, "cannot to add irq domain\n");
> +		return -ENOMEM;
> +	}
> +
> +	irq_set_chained_handler_and_data(espi_ic->irq,
> +					 aspeed_espi_ic_isr,
> +					 espi_ic);
> +
> +	irq_set_chained_handler_and_data(espi_ic->gpio_irq,
> +					 aspeed_espi_ic_gpio_isr,
> +					 espi_ic);
> +
> +	dev_set_drvdata(dev, espi_ic);
> +
> +	dev_info(dev, "eSPI IRQ controller initialized\n");
> +
> +	return 0;
> +}
> +
> +static int aspeed_espi_ic_remove(struct platform_device *pdev)
> +{
> +	struct aspeed_espi_ic *espi_ic = platform_get_drvdata(pdev);
> +
> +	irq_domain_remove(espi_ic->irq_domain);
> +	return 0;
> +}
> +
> +static const struct of_device_id aspeed_espi_ic_of_matches[] = {
> +	{ .compatible = "aspeed,ast2600-espi-ic" },
> +	{ },
> +};
> +
> +static struct platform_driver aspeed_espi_ic_driver = {
> +	.driver = {
> +		.name = DEVICE_NAME,
> +		.of_match_table = aspeed_espi_ic_of_matches,
> +	},
> +	.probe = aspeed_espi_ic_probe,
> +	.remove = aspeed_espi_ic_remove,
> +};
> +
> +module_platform_driver(aspeed_espi_ic_driver);
> +
> +MODULE_AUTHOR("Chia-Wei Wang <chiawei_wang@aspeedtech.com>");
> +MODULE_AUTHOR("Ryan Chen <ryan_chen@aspeedtech.com>");
> +MODULE_DESCRIPTION("Aspeed eSPI interrupt controller");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/soc/aspeed/espi.h b/include/soc/aspeed/espi.h
> new file mode 100644
> index 000000000000..c9a4f51737ee
> --- /dev/null
> +++ b/include/soc/aspeed/espi.h
> @@ -0,0 +1,279 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2020 Aspeed Technology Inc.
> + * Author: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> + */
> +#ifndef _ASPEED_ESPI_H_
> +#define _ASPEED_ESPI_H_

[...]

If nothing else uses the data here, move it to the irqchip driver.

         M.
-- 
Jazz is not dead. It just smells funny...
