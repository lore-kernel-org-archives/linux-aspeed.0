From: Kevin Chen <kevin_chen@aspeedtech.com>
Date: Fri, 11 Oct 2024 10:06:57 +0000
Subject: [PATCH v3 2/2] irqchip/aspeed-intc: Add support for AST27XX INTC
In-Reply-To: <f65dd139-1021-47d6-93a1-1477d6b4ca1d@web.de>
References: <20241009115813.2908803-3-kevin_chen@aspeedtech.com>
 <f65dd139-1021-47d6-93a1-1477d6b4ca1d@web.de>
Message-ID: <PSAPR06MB4949904D1FA95DBD3EF5288A89792@PSAPR06MB4949.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Markus,

Thank you for your review. Could you check the message below. Thanks a lot.

> 
> ?
> > To support ASPEED interrupt controller(INTC) maps the internal
> > interrupt sources of the AST27XX device to an parent interrupt controller.
> > ---
> 
> * I miss your tag ?Signed-off-by?.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Docume
> ntation/process/submitting-patches.rst?h=v6.12-rc2#n396
> 
> * How do you think about to choose an additional imperative wording
>   for an improved change description?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Docume
> ntation/process/submitting-patches.rst?h=v6.12-rc2#n94
> 
> 
> ?
> > +++ b/drivers/irqchip/irq-aspeed-intc.c
> > @@ -0,0 +1,139 @@
> ?
> > +static void aspeed_intc_ic_irq_handler(struct irq_desc *desc)
> +{
> > +	struct aspeed_intc_ic *intc_ic = irq_desc_get_handler_data(desc);
> > +	struct irq_chip *chip = irq_desc_get_chip(desc);
> > +	unsigned long bit, status;
> 
> I suggest to reduce the scopes for three local variables.
May I check the scopes of bit and status usage?
Variables of bit and status are used in for_each_set_bit.
How could I reduce the scopes?

> 
> 
> > +
> > +	chained_irq_enter(chip, desc);
> 
> Would you become interested to collaborate with another scoped guard for
> this programming interface?
> https://elixir.bootlin.com/linux/v6.12-rc2/source/include/linux/irqchip/chained
> _irq.h#L13
Maybe like the change in the following?

diff --git a/drivers/irqchip/irq-aspeed-intc.c b/drivers/irqchip/irq-aspeed-intc.c
index ef1c095ad09e..54d1881c56c6 100644
--- a/drivers/irqchip/irq-aspeed-intc.c
+++ b/drivers/irqchip/irq-aspeed-intc.c
@@ -32,7 +32,7 @@ static void aspeed_intc_ic_irq_handler(struct irq_desc *desc)
        struct irq_chip *chip = irq_desc_get_chip(desc);
        unsigned long bit, status;

-       chained_irq_enter(chip, desc);
+       guard(chained_irq)(desc);

        scoped_guard(raw_spinlock, &intc_ic->gic_lock) {
                status = readl(intc_ic->base + INTC_INT_STATUS_REG);
@@ -41,8 +41,6 @@ static void aspeed_intc_ic_irq_handler(struct irq_desc *desc)
                        writel(BIT(bit), intc_ic->base + INTC_INT_STATUS_REG);
                }
        }
-
-       chained_irq_exit(chip, desc);
 }

 static void aspeed_intc_irq_mask(struct irq_data *data)
diff --git a/include/linux/irqchip/chained_irq.h b/include/linux/irqchip/chained_irq.h
index dd8b3c476666..399a4ae30205 100644
--- a/include/linux/irqchip/chained_irq.h
+++ b/include/linux/irqchip/chained_irq.h
@@ -38,4 +38,5 @@ static inline void chained_irq_exit(struct irq_chip *chip,
                chip->irq_unmask(&desc->irq_data);
 }

+DEFINE_GUARD (chained_irq, struct irq_desc * , chained_irq_exit ( _T ->irq_data.chip, _T ), chained_irq_enter (_T->irq_data.chip, _T))
 #endif /* __IRQCHIP_CHAINED_IRQ_H */


> 
> 
> > +
> > +	scoped_guard(raw_spinlock, &intc_ic->gic_lock) {
> > +		status = readl(intc_ic->base + INTC_INT_STATUS_REG);
> > +		for_each_set_bit(bit, &status, IRQS_PER_WORD) {
> > +			generic_handle_domain_irq(intc_ic->irq_domain, bit);
> > +			writel(BIT(bit), intc_ic->base + INTC_INT_STATUS_REG);
> > +		}
> > +	}
> > +
> > +	chained_irq_exit(chip, desc);
> > +}
> 
> 
> Regards,
> Markus
