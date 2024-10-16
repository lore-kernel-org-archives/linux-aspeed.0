From: Markus Elfring <Markus.Elfring@web.de>
Date: Wed, 16 Oct 2024 11:54:14 +0200
Subject: [v3 2/2] irqchip/aspeed-intc: Add support for AST27XX INTC
In-Reply-To: <874j5ddow1.ffs@tglx>
References: <20241009115813.2908803-3-kevin_chen@aspeedtech.com>
 <f65dd139-1021-47d6-93a1-1477d6b4ca1d@web.de> <874j5ddow1.ffs@tglx>
Message-ID: <42c7dfe1-451b-4f70-8358-725cf3eed549@web.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> Making a guard variant of chained_irq_enter/exit needs some thought and
> a general plan for cleaning the whole chained irq usage up. It's on the
> cleanup list already with quite some other items.

I became also curious how API usage will evolve further here.


> We are not adhoc adding a guard variant because guards are hip right now.

Application interests are growing, aren't they?


> And no this does not need a scoped variant ever.

There are subsystems which seem to prefer such a programming interface occasionally.


> guards are not the panacea for everything.
Their usage might become more popular.

Regards,
Markus
