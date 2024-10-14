From: Kevin Chen <kevin_chen@aspeedtech.com>
Date: Mon, 14 Oct 2024 02:00:00 +0000
Subject: [PATCH v3 2/2] irqchip/aspeed-intc: Add support for AST27XX INTC
In-Reply-To: <0b995a34-28c4-4ba6-8ad2-e8413c6a63f5@web.de>
References: <20241009115813.2908803-3-kevin_chen@aspeedtech.com>
 <f65dd139-1021-47d6-93a1-1477d6b4ca1d@web.de>
 <PSAPR06MB4949904D1FA95DBD3EF5288A89792@PSAPR06MB4949.apcprd06.prod.outlook.com>
 <0b995a34-28c4-4ba6-8ad2-e8413c6a63f5@web.de>
Message-ID: <PSAPR06MB49491F8E0CE4069E9B9B1EA289442@PSAPR06MB4949.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> >> ?
> >>> +++ b/drivers/irqchip/irq-aspeed-intc.c
> >>> @@ -0,0 +1,139 @@
> >> ?
> >>> +static void aspeed_intc_ic_irq_handler(struct irq_desc *desc)
> >> +{
> >>> +	struct aspeed_intc_ic *intc_ic = irq_desc_get_handler_data(desc);
> >>> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> >>> +	unsigned long bit, status;
> >>
> >> I suggest to reduce the scopes for three local variables.
> > May I check the scopes of bit and status usage?
> > Variables of bit and status are used in for_each_set_bit.
> > How could I reduce the scopes?
> 
> I propose to move selected variable definitions into corresponding compound
> statements (by using extra curly brackets).
> https://refactoring.com/catalog/reduceScopeOfVariable.html
OK. I moved these two local variables into scoped_guard.

+static void aspeed_intc_ic_irq_handler(struct irq_desc *desc)
+{
+       struct aspeed_intc_ic *intc_ic = irq_desc_get_handler_data(desc);
+
+       guard(chained_irq)(desc);
+       scoped_guard(raw_spinlock, &intc_ic->gic_lock) {
+               unsigned long bit, status;
+
+               status = readl(intc_ic->base + INTC_INT_STATUS_REG);
+               for_each_set_bit(bit, &status, IRQS_PER_WORD) {
+                       generic_handle_domain_irq(intc_ic->irq_domain, bit);
+                       writel(BIT(bit), intc_ic->base + INTC_INT_STATUS_REG);
+               }
+       }
+}


> 
> 
> >> Would you become interested to collaborate with another scoped guard
> >> for this programming interface?
> >> https://elixir.bootlin.com/linux/v6.12-rc2/source/include/linux/irqch
> >> ip/chained
> >> _irq.h#L13
> >
> > Maybe like the change in the following?
> >
> > diff --git a/drivers/irqchip/irq-aspeed-intc.c
> > b/drivers/irqchip/irq-aspeed-intc.c
> > index ef1c095ad09e..54d1881c56c6 100644
> > --- a/drivers/irqchip/irq-aspeed-intc.c
> > +++ b/drivers/irqchip/irq-aspeed-intc.c
> > @@ -32,7 +32,7 @@ static void aspeed_intc_ic_irq_handler(struct irq_desc
> *desc)
> >         struct irq_chip *chip = irq_desc_get_chip(desc);
> >         unsigned long bit, status;
> >
> > -       chained_irq_enter(chip, desc);
> > +       guard(chained_irq)(desc);
> >
> >         scoped_guard(raw_spinlock, &intc_ic->gic_lock) {
> >                 status = readl(intc_ic->base + INTC_INT_STATUS_REG);
> 
> Perhaps.
> 
> 
> > @@ -41,8 +41,6 @@ static void aspeed_intc_ic_irq_handler(struct irq_desc
> *desc)
> >                         writel(BIT(bit), intc_ic->base +
> INTC_INT_STATUS_REG);
> >                 }
> >         }
> > -
> > -       chained_irq_exit(chip, desc);
> >  }
> ?
> 
> Probably, yes.
> 
> 
> ?
> > +++ b/include/linux/irqchip/chained_irq.h
> > @@ -38,4 +38,5 @@ static inline void chained_irq_exit(struct irq_chip *chip,
> >                 chip->irq_unmask(&desc->irq_data);
> >  }
> >
> > +DEFINE_GUARD (chained_irq, struct irq_desc * , chained_irq_exit ( _T
> > +->irq_data.chip, _T ), chained_irq_enter (_T->irq_data.chip, _T))
> ?
> 
> * Such a macro call looks promising.
>   Would you like to omit any space characters before open parentheses?
OK. Fixed.

diff --git a/include/linux/irqchip/chained_irq.h b/include/linux/irqchip/chained_irq.h
index dd8b3c476666..7ee29e478152 100644
--- a/include/linux/irqchip/chained_irq.h
+++ b/include/linux/irqchip/chained_irq.h
@@ -38,4 +38,6 @@ static inline void chained_irq_exit(struct irq_chip *chip,
                chip->irq_unmask(&desc->irq_data);
 }

+DEFINE_GUARD(chained_irq, struct irq_desc *, chained_irq_exit((_T->irq_data.chip), (_T)),
+            chained_irq_enter((_T->irq_data.chip), (_T)))

> 
> * Would you like to support scoped guard variants accordingly?
Do you mean that I need to change the MACRO name for this usage?

> 
> 
> Regards,
> Markus
