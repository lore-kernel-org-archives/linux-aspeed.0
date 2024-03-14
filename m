From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 14 Mar 2024 06:50:27 -0700
Subject: [PATCH v1] drivers: watchdog: ast2600 support bootstatus
In-Reply-To: <20240314065744.1182701-1-peteryin.openbmc@gmail.com>
References: <20240314065744.1182701-1-peteryin.openbmc@gmail.com>
Message-ID: <257fa47f-f1de-49ec-9ebf-c33d4de736e1@roeck-us.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 3/13/24 23:57, Peter Yin wrote:
> Add WDIOF_EXTERN1 bootstatus in ast2600
> 

This does a bit more than that because it replaces
WDIOF_CARDRESET with WDIOF_EXTERN1 for ast2600.

> Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
> ---
> Change log:
> 
> v1
>    - Patch 0001 - Add WDIOF_EXTERN1 bootstatus
> ---
>   drivers/watchdog/aspeed_wdt.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
> index b4773a6aaf8c..8adadd394be6 100644
> --- a/drivers/watchdog/aspeed_wdt.c
> +++ b/drivers/watchdog/aspeed_wdt.c
> @@ -81,6 +81,7 @@ MODULE_DEVICE_TABLE(of, aspeed_wdt_of_table);
>   #define   WDT_CLEAR_TIMEOUT_AND_BOOT_CODE_SELECTION	BIT(0)
>   #define WDT_RESET_MASK1		0x1c
>   #define WDT_RESET_MASK2		0x20
> +#define   WDT_EVENT_COUNTER_MASK       (0xFFF << 8)
>   
>   /*
>    * WDT_RESET_WIDTH controls the characteristics of the external pulse (if
> @@ -459,8 +460,17 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>   	}
>   
>   	status = readl(wdt->base + WDT_TIMEOUT_STATUS);/BOOT_SECON
> -	if (status & WDT_TIMEOUT_STATUS_BOOT_SECONDARY) {
> -		wdt->wdd.bootstatus = WDIOF_CARDRESET;
> +
> +	if (of_device_is_compatible(np, "aspeed,ast2600-wdt")) {
> +		if (status & WDT_EVENT_COUNTER_MASK) {
> +			/*
> +			 * Reset cause by WatchDog
> +			 */
> +			wdt->wdd.bootstatus |= WDIOF_EXTERN1;
> +		}
> +	} else {
> +		if (status & WDT_TIMEOUT_STATUS_BOOT_SECONDARY)
> +			wdt->wdd.bootstatus = WDIOF_CARDRESET;
>   
>   		if (of_device_is_compatible(np, "aspeed,ast2400-wdt") ||
>   		    of_device_is_compatible(np, "aspeed,ast2500-wdt"))

This check is now unnecessary since it matches the else case.

Either case, it needs to be explained why WDIOF_CARDRESET ("Card previously
reset the CPU") is replaced by WDIOF_EXTERN1 ("External relay 1") for ast2600,
and why WDT_TIMEOUT_STATUS_BOOT_SECONDARY does not apply for ast2600 but
(status & WDT_EVENT_COUNTER_MASK) does.

Guenter

