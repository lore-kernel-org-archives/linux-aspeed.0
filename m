From: PeterYin <peteryin.openbmc@gmail.com>
Date: Wed, 10 Apr 2024 00:28:44 +0800
Subject: [PATCH v6 4/4] drivers: watchdog: ast2500 and ast2600 support
 bootstatus
In-Reply-To: <20240328022231.3649741-5-peteryin.openbmc@gmail.com>
References: <20240328022231.3649741-1-peteryin.openbmc@gmail.com>
 <20240328022231.3649741-5-peteryin.openbmc@gmail.com>
Message-ID: <47835475-36de-4682-84ae-0163d45d0bac@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



Peter Yin ? 3/28/24 10:22 ??:
> Add WDIOF_EXTERN1 and WDIOF_CARDRESET bootstatus in ast2600
> 
> Regarding the AST2600 specification, the WDTn Timeout Status Register
> (WDT10) has bit 1 reserved. Bit 1 of the status register indicates
> on ast2500 if the boot was from the second boot source.
> It does not indicate that the most recent reset was triggered by
> the watchdog. The code should just be changed to set WDIOF_CARDRESET
> if bit 0 of the status register is set.
> 
> Include SCU register to veriy WDIOF_EXTERN1 in ast2600 SCU74 or
> ast2500 SCU3C when bit1 is set.
> 
> Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
> ---
>   drivers/watchdog/aspeed_wdt.c | 35 +++++++++++++++++++++++++++++++----
>   1 file changed, 31 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
> index b4773a6aaf8c..0e7ef860cbdc 100644
> --- a/drivers/watchdog/aspeed_wdt.c
> +++ b/drivers/watchdog/aspeed_wdt.c
> @@ -11,10 +11,12 @@
>   #include <linux/io.h>
>   #include <linux/kernel.h>
>   #include <linux/kstrtox.h>
> +#include <linux/mfd/syscon.h>
>   #include <linux/module.h>
>   #include <linux/of.h>
>   #include <linux/of_irq.h>
>   #include <linux/platform_device.h>
> +#include <linux/regmap.h>
>   #include <linux/watchdog.h>
>   
>   static bool nowayout = WATCHDOG_NOWAYOUT;
> @@ -77,11 +79,19 @@ MODULE_DEVICE_TABLE(of, aspeed_wdt_of_table);
>   #define WDT_TIMEOUT_STATUS	0x10
>   #define   WDT_TIMEOUT_STATUS_IRQ		BIT(2)
>   #define   WDT_TIMEOUT_STATUS_BOOT_SECONDARY	BIT(1)
> +#define   WDT_TIMEOUT_STATUS_EVENT		BIT(0)
>   #define WDT_CLEAR_TIMEOUT_STATUS	0x14
>   #define   WDT_CLEAR_TIMEOUT_AND_BOOT_CODE_SELECTION	BIT(0)
>   #define WDT_RESET_MASK1		0x1c
>   #define WDT_RESET_MASK2		0x20
>   
> +/*
> + * Ast2600 SCU74 bit1 is External reset flag
> + * Ast2500 SCU3C bit1 is External reset flag
> + */
> +#define AST2500_SYSTEM_RESET_EVENT	0x3C
> +#define AST2600_SYSTEM_RESET_EVENT	0x74
> +#define   EXTERN_RESET_FLAG		BIT(1)
>   /*
>    * WDT_RESET_WIDTH controls the characteristics of the external pulse (if
>    * enabled), specifically:
> @@ -330,6 +340,11 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>   	if (IS_ERR(wdt->base))
>   		return PTR_ERR(wdt->base);
>   
> +	struct regmap *scu_base = syscon_regmap_lookup_by_phandle(dev->of_node,
> +							     "aspeed,scu");
> +	if (IS_ERR(scu_base))
> +		return PTR_ERR(scu_base);
> +
>   	wdt->wdd.info = &aspeed_wdt_info;
>   
>   	if (wdt->cfg->irq_mask) {
> @@ -459,14 +474,26 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>   	}
>   
>   	status = readl(wdt->base + WDT_TIMEOUT_STATUS);
> -	if (status & WDT_TIMEOUT_STATUS_BOOT_SECONDARY) {
> +	if (status & WDT_TIMEOUT_STATUS_EVENT)
>   		wdt->wdd.bootstatus = WDIOF_CARDRESET;
>   
> -		if (of_device_is_compatible(np, "aspeed,ast2400-wdt") ||
> -		    of_device_is_compatible(np, "aspeed,ast2500-wdt"))
> -			wdt->wdd.groups = bswitch_groups;
> +	if (of_device_is_compatible(np, "aspeed,ast2600-wdt")) {
> +		ret = regmap_read(scu_base,
> +				  AST2600_SYSTEM_RESET_EVENT,
> +				  &status);
> +	} else {
> +		ret = regmap_read(scu_base,
> +				  AST2500_SYSTEM_RESET_EVENT,
> +				  &status);
> +		wdt->wdd.groups = bswitch_groups;
>   	}
>   
> +	/*
> +	 * Reset cause by Extern Reset
> +	 */
> +	if (status & EXTERN_RESET_FLAG && !ret)
> +		wdt->wdd.bootstatus |= WDIOF_EXTERN1;
> +
>   	dev_set_drvdata(dev, wdt);
>   
>   	return devm_watchdog_register_device(dev, &wdt->wdd);

Hi Guenter,
    Could you help me understand the definition of WDIOF_CARDRESET in 
the kernel? If it resets the CPU, should all values be reset to default? 
Should we check the POR (RstPwr Power on reset SRST# flag) flag in SCU 
0x74 register bit 0 in ast2600?


