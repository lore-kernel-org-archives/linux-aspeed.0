From: Kevin Chen <kevin_chen@aspeedtech.com>
Date: Mon, 14 Oct 2024 00:17:05 +0000
Subject: [PATCH v3 2/2] irqchip/aspeed-intc: Add support for AST27XX INTC
In-Reply-To: <37525238-c9f8-4f0e-b4e5-4e2f05fab775@stanley.mountain>
References: <20241009115813.2908803-1-kevin_chen@aspeedtech.com>
 <20241009115813.2908803-3-kevin_chen@aspeedtech.com>
 <37525238-c9f8-4f0e-b4e5-4e2f05fab775@stanley.mountain>
Message-ID: <PSAPR06MB494904BAC3F09133E3E0121189442@PSAPR06MB4949.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> > +static int __init aspeed_intc_ic_of_init(struct device_node *node,
> > +					 struct device_node *parent)
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
> > +	/* Check all the irq numbers valid. If not, unmaps all the base and frees
> the data. */
> > +	for (i = 0; i < of_irq_count(node); i++) {
> > +		irq = irq_of_parse_and_map(node, i);
> > +		if (!irq) {
> > +			pr_err("Failed to get irq number\n");
> > +			ret = -EINVAL;
> > +			goto err_iounmap;
> > +		}
> > +	}
> > +
> > +	for (i = 0; i < of_irq_count(node); i++) {
> > +		irq = irq_of_parse_and_map(node, i);
> > +			irq_set_chained_handler_and_data(irq,
> aspeed_intc_ic_irq_handler, intc_ic);
> 
> There is an extra tab on this line.
OK. Fixed. Thanks a lot.

> 
> regards,
> dan carpenter
> 
> > +	}
> > +
> > +	return 0;
> 

