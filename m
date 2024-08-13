From: Kevin Chen <kevin_chen@aspeedtech.com>
Date: Tue, 13 Aug 2024 09:44:03 +0000
Subject: =?big5?B?pl7C0DogW1BBVENIIHYxIDIvMl0gaXJxY2hpcC9hc3BlZWQtaW50YzogQWRkIHN1?=
 =?big5?Q?pport_for_10_INTC_interrupts_on_AST27XX_platforms?=
In-Reply-To: <315f9095-8928-44a9-bab7-a924a070eded@kernel.org>
References: <20240813074338.969883-1-kevin_chen@aspeedtech.com>
 <20240813074338.969883-3-kevin_chen@aspeedtech.com>
 <315f9095-8928-44a9-bab7-a924a070eded@kernel.org>
Message-ID: <PSAPR06MB4949680EBF66DCD47F2B4CF889862@PSAPR06MB4949.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Krzk,

In ASPEED, ast2400/2500/2600 use arm architecture with KCONFIG_ARCH_ASPEED which slect MACH_ASPEED_G4/G5/G6 in arch/arm/mach-aspeed/Kconfig.
In the fureture, there would be ast2800/2900/... using arm64. We need to clarify the IC generation between 7th/8th/9th/....

Maybe change ARCH_ASPEED/MACH_ASPEEDG7 to ARCH_ASPEED first.
Or, do you have better Kconfig usage?


> +config ARCH_ASPEED
> +     bool "Aspeed SoC family"
> +     select MACH_ASPEED_G7
> +     help
> +       Say yes if you intend to run on an Aspeed ast2700 or similar
> +       seventh generation Aspeed BMCs.
> +
> +config MACH_ASPEED_G7
> +     bool "Aspeed SoC AST2700"

There are no MACHines for arm64. Look at this code. Do you see MACH
anywhere else? No. Then why Aspeed must be different?

--
Best Regards,
Kevin. Chen

________________________________
???: Krzysztof Kozlowski <krzk@kernel.org>
????: 2024?8?13? ?? 04:50
???: Kevin Chen <kevin_chen@aspeedtech.com>; tglx at linutronix.de <tglx@linutronix.de>; robh at kernel.org <robh@kernel.org>; krzk+dt at kernel.org <krzk+dt@kernel.org>; conor+dt at kernel.org <conor+dt@kernel.org>; joel at jms.id.au <joel@jms.id.au>; andrew at codeconstruct.com.au <andrew@codeconstruct.com.au>; linux-kernel at vger.kernel.org <linux-kernel@vger.kernel.org>; devicetree at vger.kernel.org <devicetree@vger.kernel.org>; linux-arm-kernel at lists.infradead.org <linux-arm-kernel@lists.infradead.org>; linux-aspeed at lists.ozlabs.org <linux-aspeed@lists.ozlabs.org>
??: Re: [PATCH v1 2/2] irqchip/aspeed-intc: Add support for 10 INTC interrupts on AST27XX platforms

On 13/08/2024 09:43, Kevin Chen wrote:
> There are 10 interrupt source of soc0_intc in CPU die INTC.
>   1. 6 interrupt sources in IO die of soc1_intc0~soc1_intc5.
>   2. 2 interrupt sources in LTPI of ltpi0_intc0 and ltpi0_intc1.
>   3. 2 interrupt sources in LTPI of ltpi1_intc0 and ltpi1_intc1.
> Request GIC interrupt to check each bit in status register to do next
> level INTC handler.
>
> In next level INTC handler of IO die or LTPI INTC using soc1_intcX combining
> 32 interrupt sources into soc0_intc11 in CPU die. In soc1_intcX, handler
> would check 32 bit of status register to do the requested device
> handler.
> ---
>  drivers/irqchip/Makefile          |   1 +
>  drivers/irqchip/irq-aspeed-intc.c | 198 ++++++++++++++++++++++++++++++
>  2 files changed, 199 insertions(+)
>  create mode 100644 drivers/irqchip/irq-aspeed-intc.c
>
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index 15635812b2d6..d2fe686ae018 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -84,6 +84,7 @@ obj-$(CONFIG_MVEBU_SEI)                     += irq-mvebu-sei.o
>  obj-$(CONFIG_LS_EXTIRQ)                      += irq-ls-extirq.o
>  obj-$(CONFIG_LS_SCFG_MSI)            += irq-ls-scfg-msi.o
>  obj-$(CONFIG_ARCH_ASPEED)            += irq-aspeed-vic.o irq-aspeed-i2c-ic.o irq-aspeed-scu-ic.o
> +obj-$(CONFIG_MACH_ASPEED_G7)         += irq-aspeed-intc.o

There is no such thing as CONFIG_MACH_ASPEED_G7. And there will never be.

You already received feedback on this, so why do you keep pushing your
solution? You did not respond to any feedback given, just send the same
and the same till we agree?

NAK.

>  obj-$(CONFIG_STM32MP_EXTI)           += irq-stm32mp-exti.o
>  obj-$(CONFIG_STM32_EXTI)              += irq-stm32-exti.o
>  obj-$(CONFIG_QCOM_IRQ_COMBINER)              += qcom-irq-combiner.o
> diff --git a/drivers/irqchip/irq-aspeed-intc.c b/drivers/irqchip/irq-aspeed-intc.c
> new file mode 100644
> index 000000000000..71407475fb27

...

> +static int __init aspeed_intc_ic_of_init_v2(struct device_node *node,
> +                                         struct device_node *parent)
> +{
> +     struct aspeed_intc_ic *intc_ic;
> +     int ret = 0;
> +     int irq, i;
> +
> +     intc_ic = kzalloc(sizeof(*intc_ic), GFP_KERNEL);
> +     if (!intc_ic)
> +             return -ENOMEM;
> +
> +     intc_ic->base = of_iomap(node, 0);
> +     if (!intc_ic->base) {
> +             pr_err("Failed to iomap intc_ic base\n");
> +             ret = -ENOMEM;
> +             goto err_free_ic;
> +     }
> +     writel(0xffffffff, intc_ic->base + INTC_INT_STATUS_REG);
> +     writel(0x0, intc_ic->base + INTC_INT_ENABLE_REG);
> +
> +     intc_ic->irq_domain = irq_domain_add_linear(node, 32,
> +                                                 &aspeed_intc_ic_irq_domain_ops, intc_ic);
> +     if (!intc_ic->irq_domain) {
> +             ret = -ENOMEM;
> +             goto err_iounmap;
> +     }
> +
> +     raw_spin_lock_init(&intc_ic->gic_lock);
> +     raw_spin_lock_init(&intc_ic->intc_lock);
> +
> +     intc_ic->irq_domain->name = "aspeed-intc-domain";
> +
> +     for (i = 0; i < of_irq_count(node); i++) {
> +             irq = irq_of_parse_and_map(node, i);
> +             if (!irq) {
> +                     pr_err("Failed to get irq number\n");
> +                     ret = -EINVAL;
> +                     goto err_iounmap;
> +             } else {
> +                     irq_set_chained_handler_and_data(irq, aspeed_intc_ic_irq_handler, intc_ic);
> +             }
> +     }
> +
> +     return 0;
> +
> +err_iounmap:
> +     iounmap(intc_ic->base);
> +err_free_ic:
> +     kfree(intc_ic);
> +     return ret;
> +}

Don't duplicate code. These are almost the same, so define one function
which is then called by aspeed_intc_ic_of_init and
aspeed_intc_ic_of_init_v2.

> +
> +IRQCHIP_DECLARE(ast2700_intc_ic, "aspeed,ast2700-intc-1.0", aspeed_intc_ic_of_init);
> +IRQCHIP_DECLARE(ast2700_intc_icv2, "aspeed,ast2700-intc-2.0", aspeed_intc_ic_of_init_v2);

Best regards,
Krzysztof

************* Email Confidentiality Notice ********************
????:
???(????)????????????????? ???????????????????????????, ??????????????????????????????!

DISCLAIMER:
This message (and any attachments) may contain legally privileged and/or other confidential information. If you have received it in error, please notify the sender by reply e-mail and immediately delete the e-mail and any attachments without copying or disclosing the contents. Thank you.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20240813/82333479/attachment-0001.htm>
