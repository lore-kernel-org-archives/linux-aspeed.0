From: Markus Elfring <Markus.Elfring@web.de>
Date: Tue, 15 Oct 2024 17:07:24 +0200
Subject: [PATCH v3 2/2] irqchip/aspeed-intc: Add support for AST27XX
 INTC
In-Reply-To: <PSAPR06MB49496CC4F25425753EA4252C89452@PSAPR06MB4949.apcprd06.prod.outlook.com>
References: <20241009115813.2908803-3-kevin_chen@aspeedtech.com>
 <f65dd139-1021-47d6-93a1-1477d6b4ca1d@web.de>
 <PSAPR06MB4949904D1FA95DBD3EF5288A89792@PSAPR06MB4949.apcprd06.prod.outlook.com>
 <0b995a34-28c4-4ba6-8ad2-e8413c6a63f5@web.de>
 <PSAPR06MB49491F8E0CE4069E9B9B1EA289442@PSAPR06MB4949.apcprd06.prod.outlook.com>
 <trinity-a5696b99-bf11-4ae3-8b00-20db116f86e4-1728911450361@3c-app-webde-bs22>
 <PSAPR06MB49496CC4F25425753EA4252C89452@PSAPR06MB4949.apcprd06.prod.outlook.com>
Message-ID: <trinity-8fef4ba2-f5ab-4b78-b3de-aa1dc7d2fa33-1729004844102@3c-app-webde-bap19>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

?
> > > +static void aspeed_intc_ic_irq_handler(struct irq_desc *desc) {
?
> > > +       guard(chained_irq)(desc);
> > 
> > Using another macro call ?scoped_guard(?) { ? }??
> Is it necessary to use scoped_guard(...) {...}?

It depends on corresponding case disintions.


> > > +       scoped_guard(raw_spinlock, &intc_ic->gic_lock) {
> > 
> > Would you like to reconsider the proposed macro mixture once more?
> Could I check the reason for once more?

Coding style concerns ??


> > > +++ b/include/linux/irqchip/chained_irq.h
> > > @@ -38,4 +38,6 @@ static inline void chained_irq_exit(struct irq_chip *chip,
> > >                 chip->irq_unmask(&desc->irq_data);
> > >  }
> > >
> > > +DEFINE_GUARD(chained_irq, struct irq_desc *,
> > chained_irq_exit((_T->irq_data.chip), (_T)),
> > > +            chained_irq_enter((_T->irq_data.chip), (_T)))
> > 
> > Would you like to add a #include directive in this header file accordingly?
> Can you give me an example?

See also:
https://elixir.bootlin.com/linux/v6.12-rc3/source/include/linux/device.h#L33

Regards,
Markus
