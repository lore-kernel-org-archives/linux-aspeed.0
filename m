From: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 15 Oct 2024 23:42:22 +0200
Subject: [PATCH v3 2/2] irqchip/aspeed-intc: Add support for AST27XX INTC
In-Reply-To: <f65dd139-1021-47d6-93a1-1477d6b4ca1d@web.de>
References: <20241009115813.2908803-3-kevin_chen@aspeedtech.com>
 <f65dd139-1021-47d6-93a1-1477d6b4ca1d@web.de>
Message-ID: <874j5ddow1.ffs@tglx>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Oct 09 2024 at 14:32, Markus Elfring wrote:
>> +
>> +	chained_irq_enter(chip, desc);
>
> Would you become interested to collaborate with another scoped guard
> for this programming interface?

Collaborate in which way? What are you collaborating on?

You are merely asking people to do work which you think is useful. You
can do that, but that does not make it useful.

Making a guard variant of chained_irq_enter/exit needs some thought and
a general plan for cleaning the whole chained irq usage up. It's on the
cleanup list already with quite some other items.

We are not adhoc adding a guard variant because guards are hip right
now. And no this does not need a scoped variant ever.

guards are not the panacea for everything.

> https://elixir.bootlin.com/linux/v6.12-rc2/source/include/linux/irqchip/chained_irq.h#L13

Please refrain from these silly links. People know to find the functions
on their own.

Kevin, please update the change log, add your SOB and move the local
variables (unsigned long bit, status;) into the scoped_guard() zone.

Leave chained_irq_enter/exit() alone and resubmit.

Thanks,

        tglx
