From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 16 Aug 2019 09:15:23 -0700
Subject: [PATCH 2/2] watchdog: aspeed: Add support for AST2600
In-Reply-To: <20190816160347.23393-3-joel@jms.id.au>
References: <20190816160347.23393-1-joel@jms.id.au>
 <20190816160347.23393-3-joel@jms.id.au>
Message-ID: <20190816161523.GB5396@roeck-us.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, Aug 17, 2019 at 01:33:47AM +0930, Joel Stanley wrote:
> From: Ryan Chen <ryan_chen@aspeedtech.com>
> 
> The ast2600 can be supported by the same code as the ast2500.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  drivers/watchdog/aspeed_wdt.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
> index cc71861e033a..94f73796ba9d 100644
> --- a/drivers/watchdog/aspeed_wdt.c
> +++ b/drivers/watchdog/aspeed_wdt.c
> @@ -31,9 +31,14 @@ static const struct aspeed_wdt_config ast2500_config = {
>  	.ext_pulse_width_mask = 0xfffff,
>  };
>  
> +static const struct aspeed_wdt_config ast2600_config = {
> +	.ext_pulse_width_mask = 0xfffff,
> +};
> +

Why not just reuse ast2500_config ?

Guenter

>  static const struct of_device_id aspeed_wdt_of_table[] = {
>  	{ .compatible = "aspeed,ast2400-wdt", .data = &ast2400_config },
>  	{ .compatible = "aspeed,ast2500-wdt", .data = &ast2500_config },
> +	{ .compatible = "aspeed,ast2600-wdt", .data = &ast2600_config },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, aspeed_wdt_of_table);
> @@ -259,7 +264,8 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>  		set_bit(WDOG_HW_RUNNING, &wdt->wdd.status);
>  	}
>  
> -	if (of_device_is_compatible(np, "aspeed,ast2500-wdt")) {
> +	if ((of_device_is_compatible(np, "aspeed,ast2500-wdt")) ||
> +		(of_device_is_compatible(np, "aspeed,ast2600-wdt"))) {
>  		u32 reg = readl(wdt->base + WDT_RESET_WIDTH);
>  
>  		reg &= config->ext_pulse_width_mask;
> -- 
> 2.23.0.rc1
> 
