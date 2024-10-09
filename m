From: Markus Elfring <Markus.Elfring@web.de>
Date: Wed, 9 Oct 2024 14:32:10 +0200
Subject: [PATCH v3 2/2] irqchip/aspeed-intc: Add support for AST27XX INTC
In-Reply-To: <20241009115813.2908803-3-kevin_chen@aspeedtech.com>
References: <20241009115813.2908803-3-kevin_chen@aspeedtech.com>
Message-ID: <f65dd139-1021-47d6-93a1-1477d6b4ca1d@web.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

?
> To support ASPEED interrupt controller(INTC) maps the internal interrupt
> sources of the AST27XX device to an parent interrupt controller.
> ---

* I miss your tag ?Signed-off-by?.
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.12-rc2#n396

* How do you think about to choose an additional imperative wording
  for an improved change description?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.12-rc2#n94


?
> +++ b/drivers/irqchip/irq-aspeed-intc.c
> @@ -0,0 +1,139 @@
?
> +static void aspeed_intc_ic_irq_handler(struct irq_desc *desc)
+{
> +	struct aspeed_intc_ic *intc_ic = irq_desc_get_handler_data(desc);
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	unsigned long bit, status;

I suggest to reduce the scopes for three local variables.


> +
> +	chained_irq_enter(chip, desc);

Would you become interested to collaborate with another scoped guard
for this programming interface?
https://elixir.bootlin.com/linux/v6.12-rc2/source/include/linux/irqchip/chained_irq.h#L13


> +
> +	scoped_guard(raw_spinlock, &intc_ic->gic_lock) {
> +		status = readl(intc_ic->base + INTC_INT_STATUS_REG);
> +		for_each_set_bit(bit, &status, IRQS_PER_WORD) {
> +			generic_handle_domain_irq(intc_ic->irq_domain, bit);
> +			writel(BIT(bit), intc_ic->base + INTC_INT_STATUS_REG);
> +		}
> +	}
> +
> +	chained_irq_exit(chip, desc);
> +}


Regards,
Markus
