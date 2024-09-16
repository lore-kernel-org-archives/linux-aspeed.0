From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Mon, 16 Sep 2024 12:30:07 +0930
Subject: [PATCH v3 3/6] gpio: aspeed: Create llops to handle hardware
 access
In-Reply-To: <20240913074325.239390-4-billy_tsai@aspeedtech.com>
References: <20240913074325.239390-1-billy_tsai@aspeedtech.com>
	 <20240913074325.239390-4-billy_tsai@aspeedtech.com>
Message-ID: <2be44ea18d15f1ecda22d867396671802be14ebf.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 2024-09-13 at 15:43 +0800, Billy Tsai wrote:
> 
> @@ -1218,15 +1206,17 @@ static int __init aspeed_gpio_probe(struct platform_device *pdev)
>  	 * Populate it with initial values read from the HW and switch
>  	 * all command sources to the ARM by default
>  	 */
> -	for (i = 0; i < banks; i++) {
> -		const struct aspeed_gpio_bank *bank = &aspeed_gpio_banks[i];
> -		void __iomem *addr = bank_reg(gpio, bank, reg_rdata);
> -		gpio->dcache[i] = ioread32(addr);
> -		aspeed_gpio_change_cmd_source(gpio, bank, 0, GPIO_CMDSRC_ARM);
> -		aspeed_gpio_change_cmd_source(gpio, bank, 1, GPIO_CMDSRC_ARM);
> -		aspeed_gpio_change_cmd_source(gpio, bank, 2, GPIO_CMDSRC_ARM);
> -		aspeed_gpio_change_cmd_source(gpio, bank, 3, GPIO_CMDSRC_ARM);
> -	}
> +	if (gpio->config->cmd_source_supoort)

This test only reflects the level of effort put into supporting the
AST2700 GPIO controllers so far, it doesn't reflect the actual
capability of the hardware...

> +		for (i = 0; i < banks; i++) {
> +			const struct aspeed_gpio_bank *bank = &aspeed_gpio_banks[i];
> +			void __iomem *addr = bank_reg(gpio, bank, reg_rdata);

... and I don' think this is correct if/when the command source support
is implemented for the AST2700. Can you please add a comment about the
bank/address calculation, and change the condition above to account for
this implementation being specific to SoCs earlier than the AST2700?

Andrew

> +
> +			gpio->dcache[i] = ioread32(addr);
> +			aspeed_gpio_change_cmd_source(gpio, i * 8 + 0, GPIO_CMDSRC_ARM);
> +			aspeed_gpio_change_cmd_source(gpio, i * 8 + 8, GPIO_CMDSRC_ARM);
> +			aspeed_gpio_change_cmd_source(gpio, i * 8 + 16, GPIO_CMDSRC_ARM);
> +			aspeed_gpio_change_cmd_source(gpio, i * 8 + 24, GPIO_CMDSRC_ARM);
> +		}
>  
>  	/* Set up an irqchip */
>  	irq = platform_get_irq(pdev, 0);

