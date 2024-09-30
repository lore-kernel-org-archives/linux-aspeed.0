From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Mon, 30 Sep 2024 13:30:25 +0930
Subject: [PATCH v6 3/7] gpio: aspeed: Create llops to handle hardware
 access
In-Reply-To: <20240927111744.3511373-4-billy_tsai@aspeedtech.com>
References: <20240927111744.3511373-1-billy_tsai@aspeedtech.com>
	 <20240927111744.3511373-4-billy_tsai@aspeedtech.com>
Message-ID: <ff05349166eac044a05d74d969749c5d144cd5b0.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 2024-09-27 at 19:17 +0800, Billy Tsai wrote:
> 
> +
> +static const struct aspeed_gpio_llops aspeed_g4_llops = {
> +	.copro_request = aspeed_g4_copro_request,
> +	.copro_release = aspeed_g4_copro_release,
> +	.reg_bit_set = aspeed_g4_reg_bit_set,
> +	.reg_bit_get = aspeed_g4_reg_bit_get,
> +	.reg_bank_get = aspeed_g4_reg_bank_get,
> +	.privilege_ctrl = aspeed_g4_privilege_ctrl,
> +	.privilege_init = aspeed_g4_privilege_init,
> +};

A brief nitpick as I have another comment below - can you order these
assignments in the same order as the member declarations in the struct
(you re-ordered that in v6)?

> @@ -1191,6 +1214,10 @@ static int __init aspeed_gpio_probe(struct platform_device *pdev)
>  
>  	gpio->config = gpio_id->data;
>  
> +	if (!gpio->config->llops->reg_bit_set || !gpio->config->llops->reg_bit_get ||
> +	    !gpio->config->llops->reg_bank_get)
> +		return -EINVAL;
> +

I think the patch is largely in good shape. I've given it some light
testing. The only concern I have is this is introducing another
resource cleanup bug right now, but that's only because you've ordered
the devm_clk_get_enabled() patch as the last in the series. If you
order it before this patch then the direct return above should no-
longer be a concern.

Andrew
