From: Kevin Chen <kevin_chen@aspeedtech.com>
Date: Tue, 8 Oct 2024 01:50:22 +0000
Subject: [PATCH v1 2/2] irqchip/aspeed-intc: Add support for 10 INTC
 interrupts on AST27XX platforms
In-Reply-To: <87h6borciq.ffs@tglx>
References: <20240813074338.969883-1-kevin_chen@aspeedtech.com>
 <20240813074338.969883-3-kevin_chen@aspeedtech.com> <87h6borciq.ffs@tglx>
Message-ID: <PSAPR06MB4949CF3FDD05C1259EE4F11E897E2@PSAPR06MB4949.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> > There are 10 interrupt sources of soc0_intc in CPU die INTC.
> >   1. 6 interrupt sources in IO die of soc1_intc0~soc1_intc5.
> >   2. 2 interrupt sources in LTPI of ltpi0_intc0 and ltpi0_intc1.
> >   3. 2 interrupt sources in LTPI of ltpi1_intc0 and ltpi1_intc1.
> > Request GIC interrupt to check each bit in status register to do next
> > level INTC handler.
> >
> > In next level INTC handler of IO die or LTPI INTC using soc1_intcX
> > combining
> > 32 interrupt sources into soc0_intc11 in CPU die. In soc1_intcX,
> > handler would check 32 bit of status register to do the requested
> > device handler.
> 
> I can't figure out what this word salad is trying to tell me. Nothing in the code
> does any combining. The handler reads the very same INTC_INT_STATUS_REG.
According to AST2700 datasheet, there are two kinds of interrupt controller with enable and raw status registers for use.
  1. INTC0 is used to assert GIC(#192~#197) if interrupt in INTC1 asserted. There are 6 GIC interrupt number(#192~#197) used in one INTC0.
  2. INTC1 is used to assert INTC0 if interrupt of modules asserted. There are 32 module interrupts used in one INTC1.
+------+   +---------+      +-----------+ ---module0
| GIC | -----|INTC0 | ---+----| INTC1_0|---module2...
+------+   +---------+  |   +-----------+---module31
                  |
                  |   +-----------+---module0
                  +-----| INTC1_0|---module2...
                  |   +-----------+---module31
                  ...
                  |   +-----------+---module0
                  +-----| INTC1_5|---module2...
                  |   +-----------+---module31
> 
> >
> 
> This lacks a Signed-off-by: tag. See Documentation/process/
> 
> > ---
> >  drivers/irqchip/Makefile          |   1 +
> >  drivers/irqchip/irq-aspeed-intc.c | 198
> > ++++++++++++++++++++++++++++++
> > +
> > +#define INTC_INT_ENABLE_REG	0x00
> > +#define INTC_INT_STATUS_REG	0x04
> > +
> > +struct aspeed_intc_ic {
> > +	void __iomem		*base;
> > +	raw_spinlock_t		gic_lock;
> > +	raw_spinlock_t		intc_lock;
> > +	struct irq_domain	*irq_domain;
> > +};
> > +
> > +static void aspeed_intc_ic_irq_handler(struct irq_desc *desc) {
> > +	struct aspeed_intc_ic *intc_ic = irq_desc_get_handler_data(desc);
> > +	struct irq_chip *chip = irq_desc_get_chip(desc);
> > +	unsigned long bit, status, flags;
> > +
> > +	chained_irq_enter(chip, desc);
> > +
> > +	raw_spin_lock_irqsave(&intc_ic->gic_lock, flags);
> 
> There is no point for irqsave(). This code is invoked with interrupts disabled and
> please convert to:
> 
>         scoped_guard(raw_spinlock, &intc_ic->gic_lock) {
Agree.

> 
> > +	status = readl(intc_ic->base + INTC_INT_STATUS_REG);
> > +	for_each_set_bit(bit, &status, 32) {
> 
> Please use a define and not a hardcoded number.
Agree.

> 
> > +		generic_handle_domain_irq(intc_ic->irq_domain, bit);
> > +		writel(BIT(bit), intc_ic->base + INTC_INT_STATUS_REG);
> > +	}
> 
>         }
> 
> > +	raw_spin_unlock_irqrestore(&intc_ic->gic_lock, flags);
> > +
> > +	chained_irq_exit(chip, desc);
> > +}
> > +
> > +static void aspeed_intc_irq_mask(struct irq_data *data) {
> > +	struct aspeed_intc_ic *intc_ic = irq_data_get_irq_chip_data(data);
> > +	unsigned int mask = readl(intc_ic->base + INTC_INT_ENABLE_REG) &
> ~BIT(data->hwirq);
> > +	unsigned long flags;
> 
> Invoked with interrupts disabled too.
Agree.

> 
> > +	raw_spin_lock_irqsave(&intc_ic->intc_lock, flags);
> > +	writel(mask, intc_ic->base + INTC_INT_ENABLE_REG);
> > +	raw_spin_unlock_irqrestore(&intc_ic->intc_lock, flags);
> 
>         guard(raw_spinlock)(&intc_ic->intc_lock);
Agree.

> 	writel(mask, intc_ic->base + INTC_INT_ENABLE_REG);
> 
> > +}
> > +
> > +static void aspeed_intc_irq_unmask(struct irq_data *data) {
> > +	struct aspeed_intc_ic *intc_ic = irq_data_get_irq_chip_data(data);
> > +	unsigned int unmask = readl(intc_ic->base + INTC_INT_ENABLE_REG) |
> BIT(data->hwirq);
> > +	unsigned long flags;
> 
> Ditto.
Agree.

> 
> > +	raw_spin_lock_irqsave(&intc_ic->intc_lock, flags);
> > +	writel(unmask, intc_ic->base + INTC_INT_ENABLE_REG);
> > +	raw_spin_unlock_irqrestore(&intc_ic->intc_lock, flags); }
> > +
> > +static int aspeed_intc_irq_set_affinity(struct irq_data *data, const struct
> cpumask *dest,
> > +					bool force)
> > +{
> > +	return -EINVAL;
> > +}
> 
> No point for this stub, just leave irq_set_affinity uninitialized. The core code
> checks that pointer for NULL. Aside of that this stub and the assignment would
> need a #ifdef CONFIG_SMP guard.
Agree.

> 
> > +static struct irq_chip aspeed_intc_chip = {
> > +	.name			= "ASPEED INTC",
> > +	.irq_mask		= aspeed_intc_irq_mask,
> > +	.irq_unmask		= aspeed_intc_irq_unmask,
> > +	.irq_set_affinity	= aspeed_intc_irq_set_affinity,
> > +};
> > +
> > +static int aspeed_intc_ic_map_irq_domain(struct irq_domain *domain,
> unsigned int irq,
> > +					 irq_hw_number_t hwirq)
> > +{
> > +	irq_set_chip_and_handler(irq, &aspeed_intc_chip, handle_level_irq);
> > +	irq_set_chip_data(irq, domain->host_data);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct irq_domain_ops aspeed_intc_ic_irq_domain_ops = {
> > +	.map = aspeed_intc_ic_map_irq_domain,
> 
> 	.map	= aspeed_intc_ic_map_irq_domain,
Agree.

> 
> > +};
> > +
> > +static int __init aspeed_intc_ic_of_init(struct device_node *node,
> > +struct device_node *parent) {
> > +	struct aspeed_intc_ic *intc_ic;
> > +	int ret = 0;
> > +	int irq;
> 
>         int irq, ret;
Agree.

> 
> No point in initializing ret.
Agree.

> 
> > +	intc_ic = kzalloc(sizeof(*intc_ic), GFP_KERNEL);
> > +	if (!intc_ic)
> > +		return -ENOMEM;
> > +
> > +	intc_ic->base = of_iomap(node, 0);
> > +	if (!intc_ic->base) {
> > +		pr_err("Failed to iomap intc_ic base\n");
> > +		ret = -ENOMEM;
> > +		goto err_free_ic;
> > +	}
> > +	writel(0xffffffff, intc_ic->base + INTC_INT_STATUS_REG);
> > +	writel(0x0, intc_ic->base + INTC_INT_ENABLE_REG);
> > +
> > +	irq = irq_of_parse_and_map(node, 0);
> > +	if (!irq) {
> > +		pr_err("Failed to get irq number\n");
> > +		ret = -EINVAL;
> > +		goto err_iounmap;
> > +	}
> > +
> > +	intc_ic->irq_domain = irq_domain_add_linear(node, 32,
> > +						    &aspeed_intc_ic_irq_domain_ops, intc_ic);
> > +	if (!intc_ic->irq_domain) {
> > +		ret = -ENOMEM;
> > +		goto err_iounmap;
> > +	}
> > +
> > +	raw_spin_lock_init(&intc_ic->gic_lock);
> > +	raw_spin_lock_init(&intc_ic->intc_lock);
> > +
> > +	intc_ic->irq_domain->name = "aspeed-intc-domain";
> 
> See above.
Do you mean the name of "ASPEED INTC" would be covered by "aspeed-intc-doman"?

> 
> > +	irq_set_chained_handler_and_data(irq,
> > +					 aspeed_intc_ic_irq_handler, intc_ic);
> > +
> > +	return 0;
> > +
> > +err_iounmap:
> > +	iounmap(intc_ic->base);
> > +err_free_ic:
> > +	kfree(intc_ic);
> > +	return ret;
> > +}
> > +
> > +static int __init aspeed_intc_ic_of_init_v2(struct device_node *node,
> > +					    struct device_node *parent)
> > +{
> > +	struct aspeed_intc_ic *intc_ic;
> > +	int ret = 0;
> > +	int irq, i;
> > +
> > +	intc_ic = kzalloc(sizeof(*intc_ic), GFP_KERNEL);
> > +	if (!intc_ic)
> > +		return -ENOMEM;
> > +
> > +	intc_ic->base = of_iomap(node, 0);
> > +	if (!intc_ic->base) {
> > +		pr_err("Failed to iomap intc_ic base\n");
> > +		ret = -ENOMEM;
> > +		goto err_free_ic;
> > +	}
> > +	writel(0xffffffff, intc_ic->base + INTC_INT_STATUS_REG);
> > +	writel(0x0, intc_ic->base + INTC_INT_ENABLE_REG);
> > +
> > +	intc_ic->irq_domain = irq_domain_add_linear(node, 32,
> > +						    &aspeed_intc_ic_irq_domain_ops, intc_ic);
> > +	if (!intc_ic->irq_domain) {
> > +		ret = -ENOMEM;
> > +		goto err_iounmap;
> > +	}
> > +
> > +	raw_spin_lock_init(&intc_ic->gic_lock);
> > +	raw_spin_lock_init(&intc_ic->intc_lock);
> > +
> > +	intc_ic->irq_domain->name = "aspeed-intc-domain";
> 
> So up to this point aspeed_intc_ic_of_init_v2() is a verbatim copy of
> aspeed_intc_ic_of_init(). Why can't you reuse that function? It's not rocket
> science to make that work.
Agree.

> 
> > +	for (i = 0; i < of_irq_count(node); i++) {
> > +		irq = irq_of_parse_and_map(node, i);
> > +		if (!irq) {
> > +			pr_err("Failed to get irq number\n");
> > +			ret = -EINVAL;
> > +			goto err_iounmap;
> 
> Assume #0 and #1 succeed. #2 fails and leaves the chained handlers and the
> irqdomain around, but then unmaps the base and frees the data which the
> handler and the domain code needs. Seriously?
So, do you recommend moving check irq out of for loop?
And, irq_set_chained_hanlder_and_data in another for loop?


> 
> > +		} else {
> 
> Pointless else as the if clause terminates with a goto.
Agree. I will remove the else

> 
> > +			irq_set_chained_handler_and_data(irq,
> aspeed_intc_ic_irq_handler,
> > +intc_ic);
> 
> So if I understand the code correctly then the hardware coalesces the pending
> bits into a single status register, but depending on which part of the SoC raised
> the interrupt one of the demultiplex interrupts is raised in the GIC.
Yes. 

> 
> Any of those demultiplex interrupt handles _all_ pending bits and therefore
> you need gic_lock to serialize them, right?
Yes.

> 
> Thanks,
> 
>         tglx
Thanks a lot for your review.
