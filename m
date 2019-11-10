From: Marc Zyngier <maz@kernel.org>
Date: Sun, 10 Nov 2019 14:53:12 +0000
Subject: [PATCH 02/12] irqchip: Add Aspeed SCU interrupt controller
In-Reply-To: <1573244313-9190-3-git-send-email-eajames@linux.ibm.com>
References: <1573244313-9190-1-git-send-email-eajames@linux.ibm.com>
 <1573244313-9190-3-git-send-email-eajames@linux.ibm.com>
Message-ID: <20191110145312.3805b25b@why>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri,  8 Nov 2019 14:18:23 -0600
Eddie James <eajames@linux.ibm.com> wrote:

Hi Eddie,

> The Aspeed SOCs provide some interrupts through the System Control
> Unit registers. Add an interrupt controller that provides these
> interrupts to the system.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  MAINTAINERS                         |   1 +
>  drivers/irqchip/Makefile            |   2 +-
>  drivers/irqchip/irq-aspeed-scu-ic.c | 233 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 235 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/irqchip/irq-aspeed-scu-ic.c

[...]

> +static int aspeed_scu_ic_map(struct irq_domain *domain, unsigned int irq,
> +			     irq_hw_number_t hwirq)
> +{
> +	irq_set_chip_and_handler(irq, &aspeed_scu_ic_chip, handle_simple_irq);

handle_simple_irq is usually wrong, and works badly with threaded
interrupts. I suggest you'd change it to handle_level_irq, which
probably matches the behaviour of the controller.

Otherwise, this looks good.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
