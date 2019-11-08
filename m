From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 8 Nov 2019 06:25:04 -0800
Subject: [PATCH] watchdog: aspeed: Fix clock behaviour for ast2600
In-Reply-To: <20191108032905.22463-1-joel@jms.id.au>
References: <20191108032905.22463-1-joel@jms.id.au>
Message-ID: <74f32d61-856d-623f-2f37-965d9331aba0@roeck-us.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 11/7/19 7:29 PM, Joel Stanley wrote:
> The ast2600 no longer uses bit 4 in the control register to indicate a
> 1MHz clock (It now controls weather this watchdog is reset by a SOC
> reset). This means we do not want to set it. It also does not need to be
> set for the ast2500, as it is read-only on that SoC.
> 
> The comment next to the clock rate selection wandered away from where it
> was set, so put it back next to the register setting it's describing.
> 
> Fixes: b3528b487448 ("watchdog: aspeed: Add support for AST2600")
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/aspeed_wdt.c | 16 ++++++++++------
>   1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
> index 4ec0906bf12c..7e00960651fa 100644
> --- a/drivers/watchdog/aspeed_wdt.c
> +++ b/drivers/watchdog/aspeed_wdt.c
> @@ -258,11 +258,6 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>   	if (IS_ERR(wdt->base))
>   		return PTR_ERR(wdt->base);
>   
> -	/*
> -	 * The ast2400 wdt can run at PCLK, or 1MHz. The ast2500 only
> -	 * runs at 1MHz. We chose to always run at 1MHz, as there's no
> -	 * good reason to have a faster watchdog counter.
> -	 */
>   	wdt->wdd.info = &aspeed_wdt_info;
>   	wdt->wdd.ops = &aspeed_wdt_ops;
>   	wdt->wdd.max_hw_heartbeat_ms = WDT_MAX_TIMEOUT_MS;
> @@ -278,7 +273,16 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>   		return -EINVAL;
>   	config = ofdid->data;
>   
> -	wdt->ctrl = WDT_CTRL_1MHZ_CLK;
> +	/*
> +	 * On clock rates:
> +	 *  - ast2400 wdt can run at PCLK, or 1MHz
> +	 *  - ast2500 only runs at 1MHz, hard coding bit 4 to 1
> +	 *  - ast2600 always runs at 1MHz
> +	 *
> +	 * Set the ast2400 to run at 1MHz as it simplifies the driver.
> +	 */
> +	if (of_device_is_compatible(np, "aspeed,ast2400-wdt"))
> +		wdt->ctrl = WDT_CTRL_1MHZ_CLK;
>   
>   	/*
>   	 * Control reset on a per-device basis to ensure the
> 

