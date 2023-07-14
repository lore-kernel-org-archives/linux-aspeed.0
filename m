From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Fri, 14 Jul 2023 08:08:48 +0000
Subject: [PATCH v12 2/2] i2c: aspeed: support ast2600 i2c new register
 mode driver
In-Reply-To: <eda7789d-a603-d565-c9da-edfe9493a05d@linaro.org>
References: <20230714074522.23827-1-ryan_chen@aspeedtech.com>
 <20230714074522.23827-3-ryan_chen@aspeedtech.com>
 <eda7789d-a603-d565-c9da-edfe9493a05d@linaro.org>
Message-ID: <SEZPR06MB5269EB586319B3333CD96010F234A@SEZPR06MB5269.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

On 14/07/2023 09:45, Ryan Chen wrote:
> Add i2c new register mode driver to support AST2600 i2c new register 
> mode. AST2600 i2c controller have legacy and new register mode. The 
> new register mode have global register support 4 base clock for scl 
> clock selection, and new clock divider mode. The i2c new register mode 
> have separate register set to control i2c master and slave.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---

...

> +	ret = devm_i2c_add_adapter(dev, &i2c_bus->adap);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int ast2600_i2c_remove(struct platform_device *pdev) {
> +	struct ast2600_i2c_bus *i2c_bus = platform_get_drvdata(pdev);
> +
> +	/* Disable everything. */
> +	writel(0, i2c_bus->reg_base + AST2600_I2CC_FUN_CTRL);
> +	writel(0, i2c_bus->reg_base + AST2600_I2CM_IER);
> +
> +	i2c_del_adapter(&i2c_bus->adap);

> I have doubts that you tested this. I think you have here double free/del of the adapter.
Sorry, i can't catch your point for double free the adapter.
It should use i2c_del_adapter in driver remove function.
All the driver doing this 
https://github.com/torvalds/linux/blob/master/drivers/i2c/busses/i2c-npcm7xx.c#L2373
https://github.com/torvalds/linux/blob/master/drivers/i2c/busses/i2c-altera.c#L473

Do you mean it is not necessary? 

> +	devm_free_irq(&pdev->dev, i2c_bus->irq, i2c_bus);
> +


Best regards,
Krzysztof

