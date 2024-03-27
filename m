From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 27 Mar 2024 08:47:53 -0700
Subject: [PATCH v4 4/4] drivers: watchdog: ast2500 and ast2600 support
 bootstatus
In-Reply-To: <20240327085330.3281697-5-peteryin.openbmc@gmail.com>
References: <20240327085330.3281697-1-peteryin.openbmc@gmail.com>
 <20240327085330.3281697-5-peteryin.openbmc@gmail.com>
Message-ID: <f0b03c0b-eb54-420e-a4f7-8286e20b9df6@roeck-us.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 3/27/24 01:53, Peter Yin wrote:
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
>   drivers/watchdog/aspeed_wdt.c | 60 +++++++++++++++++++++++++----------
>   1 file changed, 44 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
> index b4773a6aaf8c..29e9afdee619 100644
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
> @@ -65,23 +67,32 @@ MODULE_DEVICE_TABLE(of, aspeed_wdt_of_table);
>   #define WDT_RELOAD_VALUE	0x04
>   #define WDT_RESTART		0x08
>   #define WDT_CTRL		0x0C
> -#define   WDT_CTRL_BOOT_SECONDARY	BIT(7)
> -#define   WDT_CTRL_RESET_MODE_SOC	(0x00 << 5)
> -#define   WDT_CTRL_RESET_MODE_FULL_CHIP	(0x01 << 5)
> -#define   WDT_CTRL_RESET_MODE_ARM_CPU	(0x10 << 5)
> -#define   WDT_CTRL_1MHZ_CLK		BIT(4)
> -#define   WDT_CTRL_WDT_EXT		BIT(3)
> -#define   WDT_CTRL_WDT_INTR		BIT(2)
> -#define   WDT_CTRL_RESET_SYSTEM		BIT(1)
> -#define   WDT_CTRL_ENABLE		BIT(0)
> +#define WDT_CTRL_BOOT_SECONDARY	BIT(7)
> +#define WDT_CTRL_RESET_MODE_SOC	(0x00 << 5)
> +#define WDT_CTRL_RESET_MODE_FULL_CHIP	(0x01 << 5)
> +#define WDT_CTRL_RESET_MODE_ARM_CPU	(0x10 << 5)
> +#define WDT_CTRL_1MHZ_CLK		BIT(4)
> +#define WDT_CTRL_WDT_EXT		BIT(3)
> +#define WDT_CTRL_WDT_INTR		BIT(2)
> +#define WDT_CTRL_RESET_SYSTEM		BIT(1)
> +#define WDT_CTRL_ENABLE		BIT(0)
>   #define WDT_TIMEOUT_STATUS	0x10
> -#define   WDT_TIMEOUT_STATUS_IRQ		BIT(2)
> -#define   WDT_TIMEOUT_STATUS_BOOT_SECONDARY	BIT(1)
> +#define WDT_TIMEOUT_STATUS_IRQ		BIT(2)
> +#define WDT_TIMEOUT_STATUS_BOOT_SECONDARY	BIT(1)
> +#define WDT_TIMEOUT_STATUS_EVENT		BIT(0)
>   #define WDT_CLEAR_TIMEOUT_STATUS	0x14
> -#define   WDT_CLEAR_TIMEOUT_AND_BOOT_CODE_SELECTION	BIT(0)
> +#define WDT_CLEAR_TIMEOUT_AND_BOOT_CODE_SELECTION	BIT(0)
>   #define WDT_RESET_MASK1		0x1c
>   #define WDT_RESET_MASK2		0x20
>   

The above bit value defines were indented to show what is
registers and what is register bit values. Why are you
changing that other than for personal preference ?

Guenter

