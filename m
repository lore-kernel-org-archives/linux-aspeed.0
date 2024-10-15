From: Kevin Chen <kevin_chen@aspeedtech.com>
Date: Tue, 15 Oct 2024 10:19:49 +0000
Subject: [PATCH v3 2/2] irqchip/aspeed-intc: Add support for AST27XX INTC
In-Reply-To: <trinity-a5696b99-bf11-4ae3-8b00-20db116f86e4-1728911450361@3c-app-webde-bs22>
References: <20241009115813.2908803-3-kevin_chen@aspeedtech.com>
 <f65dd139-1021-47d6-93a1-1477d6b4ca1d@web.de>
 <PSAPR06MB4949904D1FA95DBD3EF5288A89792@PSAPR06MB4949.apcprd06.prod.outlook.com>
 <0b995a34-28c4-4ba6-8ad2-e8413c6a63f5@web.de>
 <PSAPR06MB49491F8E0CE4069E9B9B1EA289442@PSAPR06MB4949.apcprd06.prod.outlook.com>
 <trinity-a5696b99-bf11-4ae3-8b00-20db116f86e4-1728911450361@3c-app-webde-bs22>
Message-ID: <PSAPR06MB49496CC4F25425753EA4252C89452@PSAPR06MB4949.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> 
> > > I propose to move selected variable definitions into corresponding
> > > compound statements (by using extra curly brackets).
> > > https://refactoring.com/catalog/reduceScopeOfVariable.html
> > OK. I moved these two local variables into scoped_guard.
> 
> Will development interests grow for further refactorings?
Do you have any example for this refactorings?

> 
> 
> > +static void aspeed_intc_ic_irq_handler(struct irq_desc *desc) {
> > +       struct aspeed_intc_ic *intc_ic =
> > +irq_desc_get_handler_data(desc);
> 
> Another update candidate (for scope reduction)?
Variable of intc_ic used in "scoped_guard(raw_spinlock, &intc_ic->gic_lock) {".
Or, how can I reduce the scope of intc_ic?

> 
> 
> > +
> > +       guard(chained_irq)(desc);
> 
> Using another macro call ?scoped_guard(?) { ? }??
Is it necessary to use scoped_guard(...) {...}?
In the end of aspeed_intc_ic_irq_handler, chained_irq_exit would be called as destructor.
Only one reason I thought is that the chained_irq_exit is needed to be called in the middle of aspeed_intc_ic_irq_handler.

> 
> 
> > +       scoped_guard(raw_spinlock, &intc_ic->gic_lock) {
> 
> Would you like to reconsider the proposed macro mixture once more?
Could I check the reason for once more?

> 
> 
> > +               unsigned long bit, status;
> ?
> 
> ?
> > +++ b/include/linux/irqchip/chained_irq.h
> > @@ -38,4 +38,6 @@ static inline void chained_irq_exit(struct irq_chip *chip,
> >                 chip->irq_unmask(&desc->irq_data);
> >  }
> >
> > +DEFINE_GUARD(chained_irq, struct irq_desc *,
> chained_irq_exit((_T->irq_data.chip), (_T)),
> > +            chained_irq_enter((_T->irq_data.chip), (_T)))
> 
> Would you like to add a #include directive in this header file accordingly?
Can you give me an example?

> 
> Regards,
> Markus
