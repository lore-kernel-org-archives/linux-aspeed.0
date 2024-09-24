From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Tue, 24 Sep 2024 11:18:10 +0930
Subject: [PATCH v5 3/6] gpio: aspeed: Create llops to handle hardware
 access
In-Reply-To: <20240923100611.1597113-4-billy_tsai@aspeedtech.com>
References: <20240923100611.1597113-1-billy_tsai@aspeedtech.com>
	 <20240923100611.1597113-4-billy_tsai@aspeedtech.com>
Message-ID: <95d87d38cabccb04b82e66123d78137e9cb38958.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 2024-09-23 at 18:06 +0800, Billy Tsai wrote:
> Add low-level operations (llops) to abstract the register access for GPIO
> registers and the coprocessor request/release. With this abstraction
> layer, the driver can separate the hardware and software logic, making it
> easier to extend the driver to support different hardware register
> layouts.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  drivers/gpio/gpio-aspeed.c | 443 +++++++++++++++++++------------------
>  1 file changed, 233 insertions(+), 210 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
> index d20e15b2079d..d3994d833684 100644
> --- a/drivers/gpio/gpio-aspeed.c
> +++ b/drivers/gpio/gpio-aspeed.c
> @@ -39,6 +39,10 @@ struct aspeed_bank_props {
>  struct aspeed_gpio_config {
>  	unsigned int nr_gpios;
>  	const struct aspeed_bank_props *props;
> +	const struct aspeed_gpio_llops *llops;
> +	const int *debounce_timers_array;
> +	int debounce_timers_num;
> +	bool require_dcache;
>  };
>  
>  /*
> @@ -178,6 +182,19 @@ enum aspeed_gpio_reg {
>  	reg_cmdsrc1,
>  };
>  
> +struct aspeed_gpio_llops {
> +	bool (*copro_request)(struct aspeed_gpio *gpio, unsigned int offset);
> +	void (*copro_release)(struct aspeed_gpio *gpio, unsigned int offset);
> +	void (*reg_bit_set)(struct aspeed_gpio *gpio, unsigned int offset,
> +			    const enum aspeed_gpio_reg reg, bool val);
> +	bool (*reg_bit_get)(struct aspeed_gpio *gpio, unsigned int offset,
> +			    const enum aspeed_gpio_reg reg);
> +	int (*reg_bank_get)(struct aspeed_gpio *gpio, unsigned int offset,
> +			    const enum aspeed_gpio_reg reg);
> +	void (*privilege_ctrl)(struct aspeed_gpio *gpio, unsigned int offset, int owner);
> +	void (*privilege_init)(struct aspeed_gpio *gpio);

I made a request down below, so given that, do you mind re-arranging
the member ordering in this struct? It'd be nice to have some flow to
it. Probably just move the copro_* members down the bottom? So:

struct aspeed_gpio_llops {
	void (*reg_bit_set)(struct aspeed_gpio *gpio, unsigned int offset,
			    const enum aspeed_gpio_reg reg, bool val);
	bool (*reg_bit_get)(struct aspeed_gpio *gpio, unsigned int offset,
			    const enum aspeed_gpio_reg reg);
	int (*reg_bank_get)(struct aspeed_gpio *gpio, unsigned int offset,
			    const enum aspeed_gpio_reg reg);
	void (*privilege_ctrl)(struct aspeed_gpio *gpio, unsigned int offset, int owner);
	void (*privilege_init)(struct aspeed_gpio *gpio);
	bool (*copro_request)(struct aspeed_gpio *gpio, unsigned int offset);
	void (*copro_release)(struct aspeed_gpio *gpio, unsigned int offset);
};

*snip*


> @@ -1182,7 +1205,7 @@ static int __init aspeed_gpio_probe(struct platform_device *pdev)
>  	if (!gpio_id)
>  		return -EINVAL;
>  
> -	gpio->clk = of_clk_get(pdev->dev.of_node, 0);
> +	gpio->clk = devm_clk_get_enabled(&pdev->dev, 0);

Nice - however, can you please make this its own patch and add a Fixes:
tag?

Otherwise I think the patch is looking okay. I'll try to get some
testing done.

Andrew
