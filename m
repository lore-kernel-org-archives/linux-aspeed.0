From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Fri, 20 Sep 2024 12:26:38 +0930
Subject: [PATCH v4 3/6] gpio: aspeed: Create llops to handle hardware
 access
In-Reply-To: <20240919094339.2407641-4-billy_tsai@aspeedtech.com>
References: <20240919094339.2407641-1-billy_tsai@aspeedtech.com>
	 <20240919094339.2407641-4-billy_tsai@aspeedtech.com>
Message-ID: <7aaed8cf171b67300aa5b7e861628278de948a27.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Billy

On Thu, 2024-09-19 at 17:43 +0800, Billy Tsai wrote:
> Add low-level operations (llops) to abstract the register access for GPIO
> registers and the coprocessor request/release. With this abstraction
> layer, the driver can separate the hardware and software logic, making it
> easier to extend the driver to support different hardware register
> layouts.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  drivers/gpio/gpio-aspeed.c | 429 +++++++++++++++++++------------------
>  1 file changed, 220 insertions(+), 209 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
> index d20e15b2079d..8b334ce7b60a 100644
> --- a/drivers/gpio/gpio-aspeed.c
> +++ b/drivers/gpio/gpio-aspeed.c
> @@ -39,6 +39,10 @@ struct aspeed_bank_props {
>  struct aspeed_gpio_config {
>  	unsigned int nr_gpios;
>  	const struct aspeed_bank_props *props;
> +	const struct aspeed_gpio_llops *llops;
> +	const int *debounce_timers_array;
> +	int debounce_timers_num;
> +	bool dcache_require;

Bit of a nitpick, but if we must have it I'd prefer we call this
`require_dcache`.

>  
> +static void aspeed_g4_reg_bit_set(struct aspeed_gpio *gpio, unsigned int offset,
> +				  const enum aspeed_gpio_reg reg, bool val)
> +{
> +	const struct aspeed_gpio_bank *bank = to_bank(offset);
> +	void __iomem *addr = bank_reg(gpio, bank, reg);
> +	u32 temp;
> +
> +	if (reg == reg_val && gpio->config->dcache_require)

We know gpio->config->dcache_require will be true, because this is the
g4 handler, right?

> +		temp = gpio->dcache[GPIO_BANK(offset)];
> +	else
> +		temp = ioread32(addr);
> +
> +	if (val)
> +		temp |= GPIO_BIT(offset);
> +	else
> +		temp &= ~GPIO_BIT(offset);
> +
> +	if (reg == reg_val && gpio->config->dcache_require)
> +		gpio->dcache[GPIO_BANK(offset)] = temp;
> +	iowrite32(temp, addr);
> +}
> +
> +static u32 aspeed_g4_reg_bits_get(struct aspeed_gpio *gpio, unsigned int offset,
> +				  const enum aspeed_gpio_reg reg)
> +{
> +	const struct aspeed_gpio_bank *bank = to_bank(offset);
> +	void __iomem *addr = bank_reg(gpio, bank, reg);
> +
> +	if (reg == reg_rdata || reg == reg_irq_status)
> +		return ioread32(addr);
> +	return !!(ioread32(addr) & GPIO_BIT(offset));

Okay, the semantics here feel a bit concerning. I think we need one
behaviour or the other, not both.

Perhaps we have two callbacks:

1. get_bit()
2. get_bank()

where get_bank() is only defined for reg_rdata and reg_irq_status, and
get_bit() for all registers.

> +}
> +
> +static bool aspeed_g4_copro_request(struct aspeed_gpio *gpio, unsigned int offset)
> +{
> +	if (!copro_ops || !gpio->cf_copro_bankmap)
> +		return false;
> +	if (!gpio->cf_copro_bankmap[offset >> 3])
> +		return false;
> +	if (!copro_ops->request_access)
> +		return false;
> +
> +	/* Pause the coprocessor */
> +	copro_ops->request_access(copro_data);
> +
> +	/* Change command source back to ARM */
> +	aspeed_gpio_change_cmd_source(gpio, offset, GPIO_CMDSRC_ARM);

I don't think we need the indirection here, this is already a g4-
specific callback implementation, we can directly call
aspeed_g4_privilege_ctrl().

> +
> +	if (gpio->config->dcache_require)
> +		/* Update cache */
> +		gpio->dcache[GPIO_BANK(offset)] =
> +			gpio->config->llops->reg_bits_get(gpio, offset, reg_rdata);
> +
> +	return true;
> +}
> +
> +static void aspeed_g4_copro_release(struct aspeed_gpio *gpio, unsigned int offset)
> +{
> +	if (!copro_ops || !gpio->cf_copro_bankmap)
> +		return;
> +	if (!gpio->cf_copro_bankmap[offset >> 3])
> +		return;
> +	if (!copro_ops->release_access)
> +		return;
> +
> +	/* Change command source back to ColdFire */
> +	aspeed_gpio_change_cmd_source(gpio, offset, GPIO_CMDSRC_COLDFIRE);

As above for the request implementation, we can call
aspeed_g4_privilege_ctrl() directly here.

> +
> +	/* Restart the coprocessor */
> +	copro_ops->release_access(copro_data);
> +}
> +
> +static void aspeed_g4_privilege_ctrl(struct aspeed_gpio *gpio, unsigned int offset, int cmdsrc)
> +{
> +	/*
> +	 * The command source register is only valid in bits 0, 8, 16, and 24, so we use
> +	 * (offset & ~(0x7)) to ensure that reg_bits_set always targets a valid bit.
> +	 */
> +	/* Source 1 first to avoid illegal 11 combination */
> +	gpio->config->llops->reg_bit_set(gpio, offset & ~(0x7), reg_cmdsrc1, !!(cmdsrc & BIT(1)));
> +	/* Then Source 0 */
> +	gpio->config->llops->reg_bit_set(gpio, offset & ~(0x7), reg_cmdsrc0, !!(cmdsrc & BIT(0)));

Both of these can be direct calls to aspeed_g4_reg_bit_set().

> +}
> +
> +static void aspeed_g4_privilege_init(struct aspeed_gpio *gpio)
> +{
> +	u32 i;
> +
> +	/* Switch all command sources to the ARM by default */
> +	for (i = 0; i < DIV_ROUND_UP(gpio->chip.ngpio, 32); i++) {
> +		aspeed_gpio_change_cmd_source(gpio, (i << 5) + 0, GPIO_CMDSRC_ARM);
> +		aspeed_gpio_change_cmd_source(gpio, (i << 5) + 8, GPIO_CMDSRC_ARM);
> +		aspeed_gpio_change_cmd_source(gpio, (i << 5) + 16, GPIO_CMDSRC_ARM);
> +		aspeed_gpio_change_cmd_source(gpio, (i << 5) + 24, GPIO_CMDSRC_ARM);

Again as this is a g4-specific callback we can directly call
aspeed_g4_privilege_ctrl().

> +	}
> +}
> +
> +static const struct aspeed_gpio_llops aspeed_g4_llops = {
> +	.copro_request = aspeed_g4_copro_request,
> +	.copro_release = aspeed_g4_copro_release,
> +	.reg_bit_set = aspeed_g4_reg_bit_set,
> +	.reg_bits_get = aspeed_g4_reg_bits_get,
> +	.privilege_ctrl = aspeed_g4_privilege_ctrl,
> +	.privilege_init = aspeed_g4_privilege_init,
> +};
>  /*
>   * Any banks not specified in a struct aspeed_bank_props array are assumed to
>   * have the properties:
> @@ -1120,7 +1111,14 @@ static const struct aspeed_bank_props ast2400_bank_props[] = {
>  
>  static const struct aspeed_gpio_config ast2400_config =
>  	/* 220 for simplicity, really 216 with two 4-GPIO holes, four at end */
> -	{ .nr_gpios = 220, .props = ast2400_bank_props, };
> +	{
> +		.nr_gpios = 220,
> +		.props = ast2400_bank_props,
> +		.llops = &aspeed_g4_llops,
> +		.debounce_timers_array = debounce_timers,
> +		.debounce_timers_num = ARRAY_SIZE(debounce_timers),
> +		.dcache_require = true,
> +	};
>  
>  static const struct aspeed_bank_props ast2500_bank_props[] = {
>  	/*     input	  output   */
> @@ -1132,7 +1130,14 @@ static const struct aspeed_bank_props ast2500_bank_props[] = {
>  
>  static const struct aspeed_gpio_config ast2500_config =
>  	/* 232 for simplicity, actual number is 228 (4-GPIO hole in GPIOAB) */
> -	{ .nr_gpios = 232, .props = ast2500_bank_props, };
> +	{
> +		.nr_gpios = 232,
> +		.props = ast2500_bank_props,
> +		.llops = &aspeed_g4_llops,
> +		.debounce_timers_array = debounce_timers,
> +		.debounce_timers_num = ARRAY_SIZE(debounce_timers),
> +		.dcache_require = true,
> +	};
>  
>  static const struct aspeed_bank_props ast2600_bank_props[] = {
>  	/*     input	  output   */
> @@ -1148,7 +1153,14 @@ static const struct aspeed_gpio_config ast2600_config =
>  	 * We expect ngpio being set in the device tree and this is a fallback
>  	 * option.
>  	 */
> -	{ .nr_gpios = 208, .props = ast2600_bank_props, };
> +	{
> +		.nr_gpios = 208,
> +		.props = ast2600_bank_props,
> +		.llops = &aspeed_g4_llops,
> +		.debounce_timers_array = debounce_timers,
> +		.debounce_timers_num = ARRAY_SIZE(debounce_timers),
> +		.dcache_require = true,
> +	};
>  
>  static const struct of_device_id aspeed_gpio_of_table[] = {
>  	{ .compatible = "aspeed,ast2400-gpio", .data = &ast2400_config, },
> @@ -1191,6 +1203,9 @@ static int __init aspeed_gpio_probe(struct platform_device *pdev)
>  
>  	gpio->config = gpio_id->data;
>  
> +	if (!gpio->config->llops->reg_bit_set || !gpio->config->llops->reg_bits_get)
> +		return -EINVAL;
> +

This will need to clean up gpio->clk. Perhaps you could move it above
the of_clk_get() call instead?

However, looking through the rest it seems we have a few issues with
this leak :/

>  	gpio->chip.parent = &pdev->dev;
>  	err = of_property_read_u32(pdev->dev.of_node, "ngpios", &ngpio);
>  	gpio->chip.ngpio = (u16) ngpio;
> @@ -1207,27 +1222,23 @@ static int __init aspeed_gpio_probe(struct platform_device *pdev)
>  	gpio->chip.label = dev_name(&pdev->dev);
>  	gpio->chip.base = -1;
>  
> -	/* Allocate a cache of the output registers */
> -	banks = DIV_ROUND_UP(gpio->chip.ngpio, 32);
> -	gpio->dcache = devm_kcalloc(&pdev->dev,
> -				    banks, sizeof(u32), GFP_KERNEL);
> -	if (!gpio->dcache)
> -		return -ENOMEM;
> -
> -	/*
> -	 * Populate it with initial values read from the HW and switch
> -	 * all command sources to the ARM by default
> -	 */
> -	for (i = 0; i < banks; i++) {
> -		const struct aspeed_gpio_bank *bank = &aspeed_gpio_banks[i];
> -		void __iomem *addr = bank_reg(gpio, bank, reg_rdata);
> -		gpio->dcache[i] = ioread32(addr);
> -		aspeed_gpio_change_cmd_source(gpio, bank, 0, GPIO_CMDSRC_ARM);
> -		aspeed_gpio_change_cmd_source(gpio, bank, 1, GPIO_CMDSRC_ARM);
> -		aspeed_gpio_change_cmd_source(gpio, bank, 2, GPIO_CMDSRC_ARM);
> -		aspeed_gpio_change_cmd_source(gpio, bank, 3, GPIO_CMDSRC_ARM);
> +	if (gpio->config->dcache_require) {
> +		/* Allocate a cache of the output registers */
> +		banks = DIV_ROUND_UP(gpio->chip.ngpio, 32);
> +		gpio->dcache = devm_kcalloc(&pdev->dev, banks, sizeof(u32), GFP_KERNEL);
> +		if (!gpio->dcache)
> +			return -ENOMEM;

This should also clean up gpio->clk. I don't think you can move it to
avoid that.

Andrew

> +		/*
> +		 * Populate it with initial values read from the HW
> +		 */
> +		for (i = 0; i < banks; i++)
> +			gpio->dcache[i] =
> +				gpio->config->llops->reg_bits_get(gpio, (i << 5), reg_rdata);
>  	}
>  
> +	if (gpio->config->llops->privilege_init)
> +		gpio->config->llops->privilege_init(gpio);
> +
>  	/* Set up an irqchip */
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0)

