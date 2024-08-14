From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 14 Aug 2024 16:06:00 +0200
Subject: [PATCH v2 2/2] irqchip/aspeed-intc: Add support for AST27XX INTC
In-Reply-To: <20240814114106.2809876-4-kevin_chen@aspeedtech.com>
References: <20240814114106.2809876-1-kevin_chen@aspeedtech.com>
 <20240814114106.2809876-4-kevin_chen@aspeedtech.com>
Message-ID: <4817e23e-a726-4557-b756-e0cbc54eebaa@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 14/08/2024 13:41, Kevin Chen wrote:
> Support for the Aspeed Interrupt Controller found on Aspeed Silicon SoCs,
> such as the AST2700, which is arm64 architecture.
> 
> To support ASPEED interrupt controller(INTC) maps the internal interrupt
> sources of the AST27XX device to an parent interrupt controller.
> ---
>  drivers/irqchip/Makefile          |   1 +
>  drivers/irqchip/irq-aspeed-intc.c | 137 ++++++++++++++++++++++++++++++
>  2 files changed, 138 insertions(+)
>  create mode 100644 drivers/irqchip/irq-aspeed-intc.c
> 
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index 15635812b2d6..5da3f2f4eede 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -84,6 +84,7 @@ obj-$(CONFIG_MVEBU_SEI)			+= irq-mvebu-sei.o
>  obj-$(CONFIG_LS_EXTIRQ)			+= irq-ls-extirq.o
>  obj-$(CONFIG_LS_SCFG_MSI)		+= irq-ls-scfg-msi.o
>  obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-vic.o irq-aspeed-i2c-ic.o irq-aspeed-scu-ic.o
> +obj-$(CONFIG_ASPEED_G7_INTC)		+= irq-aspeed-intc.o


There is no such config symbol.

You already got this exact comment. Replacing one broken code with other
broken code is not the solution.


Best regards,
Krzysztof

