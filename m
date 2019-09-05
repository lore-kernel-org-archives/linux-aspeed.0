From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 05 Sep 2019 13:17:33 +0930
Subject: [PATCH v2 1/4] gpio/aspeed: Fix incorrect number of banks
In-Reply-To: <20190905011635.15902-1-rashmica.g@gmail.com>
References: <20190905011635.15902-1-rashmica.g@gmail.com>
Message-ID: <5f3ec58f-d83b-41f9-80ed-35a5434bb985@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Thu, 5 Sep 2019, at 10:46, Rashmica Gupta wrote:
> The current calculation for the number of GPIO banks is only correct if
> the number of GPIOs is a multiple of 32 (if there were 31 GPIOs we would
> currently say there are 0 banks, which is incorrect).
> 
> Fixes: 361b79119a4b7 ('gpio: Add Aspeed driver')
> 
> Signed-off-by: Rashmica Gupta <rashmica.g@gmail.com>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

> ---
>  drivers/gpio/gpio-aspeed.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
> index 9defe25d4721..b83e23aecd18 100644
> --- a/drivers/gpio/gpio-aspeed.c
> +++ b/drivers/gpio/gpio-aspeed.c
> @@ -1165,7 +1165,7 @@ static int __init aspeed_gpio_probe(struct 
> platform_device *pdev)
>  	gpio->chip.base = -1;
>  
>  	/* Allocate a cache of the output registers */
> -	banks = gpio->config->nr_gpios >> 5;
> +	banks = DIV_ROUND_UP(gpio->config->nr_gpios, 32);
>  	gpio->dcache = devm_kcalloc(&pdev->dev,
>  				    banks, sizeof(u32), GFP_KERNEL);
>  	if (!gpio->dcache)
> -- 
> 2.20.1
> 
>
