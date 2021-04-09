From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 09 Apr 2021 14:44:54 +0930
Subject: =?UTF-8?Q?Re:_[PATCH_v5_3/4]_drivers/tty/serial/8250:_add_aspeed,
 _lpc-io?= =?UTF-8?Q?-reg_and_aspeed,_lpc-interrupts_DT_properties?=
In-Reply-To: <20210408011637.5361-4-zev@bewilderbeest.net>
References: <20210408011637.5361-1-zev@bewilderbeest.net>
 <20210408011637.5361-4-zev@bewilderbeest.net>
Message-ID: <3eef2478-c5b8-4f14-a937-16bbe0a3e05a@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Zev,

A couple of minor comments:

On Thu, 8 Apr 2021, at 10:46, Zev Weiss wrote:
> These allow describing all the Aspeed VUART attributes currently
> available via sysfs.  aspeed,sirq

aspeed,lpc-interrupts now

> provides a replacement for the
> deprecated aspeed,sirq-polarity-sense property.
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> ---
>  drivers/tty/serial/8250/8250_aspeed_vuart.c | 44 ++++++++++++++++++++-
>  1 file changed, 43 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c 
> b/drivers/tty/serial/8250/8250_aspeed_vuart.c
> index 8433f8dbb186..75ef006fa24b 100644
> --- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
> +++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
> @@ -28,6 +28,10 @@
>  #define ASPEED_VUART_ADDRL		0x28
>  #define ASPEED_VUART_ADDRH		0x2c
>  
> +#define ASPEED_VUART_DEFAULT_LPC_ADDR	0x3f8
> +#define ASPEED_VUART_DEFAULT_SIRQ	4
> +#define ASPEED_VUART_DEFAULT_SIRQ_POLARITY	IRQ_TYPE_LEVEL_LOW
> +
>  struct aspeed_vuart {
>  	struct device		*dev;
>  	void __iomem		*regs;
> @@ -393,7 +397,8 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
>  	struct aspeed_vuart *vuart;
>  	struct device_node *np;
>  	struct resource *res;
> -	u32 clk, prop;
> +	u32 clk, prop, sirq[2];
> +	bool sirq_polarity;
>  	int rc;
>  
>  	np = pdev->dev.of_node;
> @@ -501,6 +506,43 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
>  		of_node_put(sirq_polarity_sense_args.np);
>  	}
>  
> +	rc = of_property_read_u32(np, "aspeed,lpc-io-reg", &prop);
> +	if (rc < 0)
> +		prop = ASPEED_VUART_DEFAULT_LPC_ADDR;
> +
> +	rc = aspeed_vuart_set_lpc_address(vuart, prop);
> +	if (rc < 0) {
> +		dev_err(&pdev->dev, "invalid value in aspeed,lpc-io-reg property\n");
> +		goto err_clk_disable;
> +	}
> +
> +	rc = of_property_read_u32_array(np, "aspeed,lpc-interrupts", sirq, 2);
> +	if (rc < 0) {
> +		sirq[0] = ASPEED_VUART_DEFAULT_SIRQ;
> +		sirq[1] = ASPEED_VUART_DEFAULT_SIRQ_POLARITY;
> +	}
> +
> +	rc = aspeed_vuart_set_sirq(vuart, sirq[0]);
> +	if (rc < 0) {
> +		dev_err(&pdev->dev, "invalid sirq number in aspeed,lpc-interrupts > property\n");
> +		goto err_clk_disable;
> +	}
> +
> +	switch (sirq[1]) {
> +	case IRQ_TYPE_LEVEL_LOW:
> +		sirq_polarity = false;
> +		break;
> +	case IRQ_TYPE_LEVEL_HIGH:
> +		sirq_polarity = true;
> +		break;
> +	default:
> +		dev_err(&pdev->dev, "invalid sirq polarity in aspeed,lpc-interrupts 
> property\n");
> +		rc = -EINVAL;
> +		goto err_clk_disable;
> +	}

A bit ugly open-coding the mapping and error handling, maybe worth a helper?

Looks okay otherwise.

Cheers,

Andrew
