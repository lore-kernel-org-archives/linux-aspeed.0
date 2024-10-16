From: Kevin Chen <kevin_chen@aspeedtech.com>
Date: Wed, 16 Oct 2024 00:31:00 +0000
Subject: [PATCH v3 2/2] irqchip/aspeed-intc: Add support for AST27XX INTC
In-Reply-To: <874j5ddow1.ffs@tglx>
References: <20241009115813.2908803-3-kevin_chen@aspeedtech.com>
 <f65dd139-1021-47d6-93a1-1477d6b4ca1d@web.de> <874j5ddow1.ffs@tglx>
Message-ID: <PSAPR06MB49496AB83001EDA4A51F263189462@PSAPR06MB4949.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> >> +
> >> +	chained_irq_enter(chip, desc);
> >
> > Would you become interested to collaborate with another scoped guard
> > for this programming interface?
> 
> Collaborate in which way? What are you collaborating on?
> 
> You are merely asking people to do work which you think is useful. You can do
> that, but that does not make it useful.
> 
> Making a guard variant of chained_irq_enter/exit needs some thought and a
> general plan for cleaning the whole chained irq usage up. It's on the cleanup
> list already with quite some other items.
> 
> We are not adhoc adding a guard variant because guards are hip right now.
> And no this does not need a scoped variant ever.
> 
> guards are not the panacea for everything.
> 
> > https://elixir.bootlin.com/linux/v6.12-rc2/source/include/linux/irqchi
> > p/chained_irq.h#L13
> 
> Please refrain from these silly links. People know to find the functions on their
> own.
> 
> Kevin, please update the change log, add your SOB and move the local
> variables (unsigned long bit, status;) into the scoped_guard() zone.
OK. I will do this change.

> 
> Leave chained_irq_enter/exit() alone and resubmit.
OK. I will send the v4 patch with chained_irq_enter/exit() alone.

Thanks a lot.

> 
> Thanks,
> 
>         tglx
