From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue, 03 Dec 2019 12:19:02 +1030
Subject: [PATCH v2 2/4] irqchip: Add Aspeed SCU interrupt controller
In-Reply-To: <1569617929-29055-3-git-send-email-eajames@linux.ibm.com>
References: <1569617929-29055-1-git-send-email-eajames@linux.ibm.com>
 <1569617929-29055-3-git-send-email-eajames@linux.ibm.com>
Message-ID: <0ddad614-0f1c-4ca1-bfc5-127ed3c61dc4@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Sat, 28 Sep 2019, at 06:28, Eddie James wrote:
> The Aspeed SOCs provide some interrupts through the System Control
> Unit registers. Add an interrupt controller that provides these
> interrupts to the system.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
> Changes since v1:
>  - add a spinlock to protect read-modify-write operation for irq masking
>  - use readl/writel relaxed versions

What's your motivation? I might have missed some comments on v1. The
descriptions make me slightly nervous (not guaranteed to be ordered wrt
spinlocks).

>  - add a comment explaining the irq status/enable register
>  - provide affinity callback that returns -EINVAL
> 
>  MAINTAINERS                         |   1 +
>  drivers/irqchip/Makefile            |   2 +-
>  drivers/irqchip/irq-aspeed-scu-ic.c | 233 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 235 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/irqchip/irq-aspeed-scu-ic.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c7e028c..b6db122 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2656,6 +2656,7 @@ M:	Eddie James <eajames@linux.ibm.com>
>  L:	linux-aspeed at lists.ozlabs.org (moderated for non-subscribers)
>  S:	Maintained
>  
> F:	Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2xxx-scu-ic.txt
> +F:	drivers/irqchip/irq-aspeed-scu-ic.c
>  F:	include/dt-bindings/interrupt-controller/aspeed-scu-ic.h
>  
>  ASPEED VIDEO ENGINE DRIVER
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index cc7c439..fce6b1d 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -86,7 +86,7 @@ obj-$(CONFIG_MVEBU_PIC)			+= irq-mvebu-pic.o
>  obj-$(CONFIG_MVEBU_SEI)			+= irq-mvebu-sei.o
>  obj-$(CONFIG_LS_SCFG_MSI)		+= irq-ls-scfg-msi.o
>  obj-$(CONFIG_EZNPS_GIC)			+= irq-eznps.o
> -obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-vic.o irq-aspeed-i2c-ic.o
> +obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-vic.o irq-aspeed-i2c-ic.o 
> irq-aspeed-scu-ic.o
>  obj-$(CONFIG_STM32_EXTI) 		+= irq-stm32-exti.o
>  obj-$(CONFIG_QCOM_IRQ_COMBINER)		+= qcom-irq-combiner.o
>  obj-$(CONFIG_IRQ_UNIPHIER_AIDET)	+= irq-uniphier-aidet.o
> diff --git a/drivers/irqchip/irq-aspeed-scu-ic.c 
> b/drivers/irqchip/irq-aspeed-scu-ic.c
> new file mode 100644
> index 0000000..64c3ac4
> --- /dev/null
> +++ b/drivers/irqchip/irq-aspeed-scu-ic.c
> @@ -0,0 +1,233 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Aspeed AST24XX, AST25XX, and AST26XX SCU Interrupt Controller
> + * Copyright 2019 IBM Corporation
> + *
> + * Eddie James <eajames@linux.ibm.com>
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/irq.h>
> +#include <linux/irqchip.h>
> +#include <linux/irqchip/chained_irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/io.h>
> +#include <linux/spinlock.h>
> +
> +#define ASPEED_SCU_IC_SHIFT		0
> +#define ASPEED_SCU_IC_ENABLE		GENMASK(6, ASPEED_SCU_IC_SHIFT)
> +#define ASPEED_SCU_IC_NUM_IRQS		7
> +#define ASPEED_SCU_IC_STATUS_SHIFT	16
> +
> +#define ASPEED_AST2600_SCU_IC0_SHIFT	0
> +#define ASPEED_AST2600_SCU_IC0_ENABLE	\
> +	GENMASK(5, ASPEED_AST2600_SCU_IC0_SHIFT)
> +#define ASPEED_AST2600_SCU_IC0_NUM_IRQS	6
> +
> +#define ASPEED_AST2600_SCU_IC1_SHIFT	4
> +#define ASPEED_AST2600_SCU_IC1_ENABLE	\
> +	GENMASK(5, ASPEED_AST2600_SCU_IC1_SHIFT)
> +#define ASPEED_AST2600_SCU_IC1_NUM_IRQS	2
> +
> +struct aspeed_scu_ic {
> +	unsigned long irq_enable;
> +	unsigned long irq_shift;

> +	unsigned int num_irqs;
> +	void __iomem *reg;
> +	struct irq_domain *irq_domain;
> +	spinlock_t lock;
> +};
> +
> +static void aspeed_scu_ic_irq_handler(struct irq_desc *desc)
> +{
> +	unsigned int irq;
> +	unsigned long bit;
> +	unsigned long enabled;
> +	unsigned long max;
> +	unsigned long status;
> +	struct aspeed_scu_ic *scu_ic = irq_desc_get_handler_data(desc);
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +
> +	chained_irq_enter(chip, desc);
> +
> +	/*
> +	 * The SCU IC has just one register to control its operation and read
> +	 * status. The interrupt enable bits occupy the lower 16 bits of the
> +	 * register, while the interrupt status bits occupy the upper 16 bits.
> +	 * The status bit for a given interrupt is always 16 bits shifted from
> +	 * the enable bit for the same interrupt.
> +	 * Therefore, perform the IRQ operations in the enable bit space by
> +	 * shifting the status down to get the mapping and then back up to
> +	 * clear the bit.
> +	 */
> +	status = readl_relaxed(scu_ic->reg);
> +	enabled = status & scu_ic->irq_enable;
> +	status = (status >> ASPEED_SCU_IC_STATUS_SHIFT) & enabled;
> +
> +	bit = scu_ic->irq_shift;
> +	max = scu_ic->num_irqs + bit;
> +
> +	for_each_set_bit_from(bit, &status, max) {
> +		irq = irq_find_mapping(scu_ic->irq_domain,
> +				       bit - scu_ic->irq_shift);
> +		generic_handle_irq(irq);
> +
> +		writel_relaxed(enabled | BIT(bit + ASPEED_SCU_IC_STATUS_SHIFT),
> +			       scu_ic->reg);
> +	}
> +
> +	chained_irq_exit(chip, desc);
> +}
> +
> +static void aspeed_scu_ic_irq_mask(struct irq_data *data)
> +{
> +	struct aspeed_scu_ic *scu_ic = irq_data_get_irq_chip_data(data);
> +	unsigned long bit = BIT(data->hwirq + scu_ic->irq_shift);
> +	unsigned long flags;
> +	unsigned long reg;
> +
> +	spin_lock_irqsave(&scu_ic->lock, flags);

The SCU is represented by a syscon in the devicetree, which has a regmap,
which does it's own locking internally. You could use regmap_update_bits()
to do an atomic read/modify/write and this will provide consistency for
other SCU drivers that might be accessing shared registers. Nothing else
should _currently_ be touching the SCU IRQ status/enable register, but
using the regmap would give us a consistent approach across all SCU
drivers.

Andrew
