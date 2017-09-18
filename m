From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 18 Sep 2017 06:25:02 -0700
Subject: [PATCH 1/4] watchdog: aspeed: Retain watchdog enabled state
In-Reply-To: <20170918054905.16470-2-andrew@aj.id.au>
References: <20170918054905.16470-1-andrew@aj.id.au>
 <20170918054905.16470-2-andrew@aj.id.au>
Message-ID: <bef08c5f-b0ae-a2e4-34a1-c9e1500b4234@roeck-us.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 09/17/2017 10:49 PM, Andrew Jeffery wrote:
> An unintended post-condition of probe() is that the watchdog is
> disabled. Rework probe() such that we retain the value of the "enabled"
> bit from the control register, and take the appropriate actions with
> respect to the watchdog core if so. Otherwise, just configure the
> watchdog as directed.
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
>   drivers/watchdog/aspeed_wdt.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
> index 79cc766cd30f..99bc6fbd8852 100644
> --- a/drivers/watchdog/aspeed_wdt.c
> +++ b/drivers/watchdog/aspeed_wdt.c
> @@ -221,7 +221,8 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>   		return -EINVAL;
>   	config = ofdid->data;
>   
> -	wdt->ctrl = WDT_CTRL_1MHZ_CLK;
> +	wdt->ctrl |= readl(wdt->base + WDT_CTRL) & WDT_CTRL_ENABLE;
> +	wdt->ctrl |= WDT_CTRL_1MHZ_CLK;
>   
>   	/*
>   	 * Control reset on a per-device basis to ensure the
> @@ -243,11 +244,11 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>   	if (of_property_read_bool(np, "aspeed,external-signal"))
>   		wdt->ctrl |= WDT_CTRL_WDT_EXT;
>   
> -	writel(wdt->ctrl, wdt->base + WDT_CTRL);
> -
> -	if (readl(wdt->base + WDT_CTRL) & WDT_CTRL_ENABLE)  {
> +	if (wdt->ctrl & WDT_CTRL_ENABLE) {
>   		aspeed_wdt_start(&wdt->wdd);

Why call the start function in this case ?

>   		set_bit(WDOG_HW_RUNNING, &wdt->wdd.status); > +	} else {
> +		writel(wdt->ctrl, wdt->base + WDT_CTRL);
>   	}
>   
>   	if (of_device_is_compatible(np, "aspeed,ast2500-wdt")) {
> 

