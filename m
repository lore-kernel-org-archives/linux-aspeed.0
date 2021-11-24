From: Joel Stanley <joel@jms.id.au>
Date: Wed, 24 Nov 2021 09:50:01 +0000
Subject: [PATCH] irqchip: Replace update_bits with write_bits.
In-Reply-To: <20211124094348.11621-1-billy_tsai@aspeedtech.com>
References: <20211124094348.11621-1-billy_tsai@aspeedtech.com>
Message-ID: <CACPK8XeyCbKzjPF6sSj=CZOd3dYmyAzhZDFRRDERMHykwvSMAg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 24 Nov 2021 at 09:43, Billy Tsai <billy_tsai@aspeedtech.com> wrote:
>
> The interrupt status bits are cleared by writing 1, we should force a
> write to clear the interrupt without checking if the value has changed.
>
> Fixes: 04f605906ff0 ("irqchip: Add Aspeed SCU interrupt controller")
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>

Good catch. This should go to stable too.

Reviewed-by: Joel Stanley <joel@jms.id.au>

Is there any reason to use the regmap abstraction in this driver?
AFAICT the registers aren't shared, so we could replace the regmap
calls with readl/writel. Such a cleanup probably wouldn't be
backported, so this patch is still useful.

> ---
>  drivers/irqchip/irq-aspeed-scu-ic.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/irqchip/irq-aspeed-scu-ic.c b/drivers/irqchip/irq-aspeed-scu-ic.c
> index f3c6855a4cef..18b77c3e6db4 100644
> --- a/drivers/irqchip/irq-aspeed-scu-ic.c
> +++ b/drivers/irqchip/irq-aspeed-scu-ic.c
> @@ -76,8 +76,8 @@ static void aspeed_scu_ic_irq_handler(struct irq_desc *desc)
>                 generic_handle_domain_irq(scu_ic->irq_domain,
>                                           bit - scu_ic->irq_shift);
>
> -               regmap_update_bits(scu_ic->scu, scu_ic->reg, mask,
> -                                  BIT(bit + ASPEED_SCU_IC_STATUS_SHIFT));
> +               regmap_write_bits(scu_ic->scu, scu_ic->reg, mask,
> +                                 BIT(bit + ASPEED_SCU_IC_STATUS_SHIFT));
>         }
>
>         chained_irq_exit(chip, desc);
> --
> 2.25.1
>
