From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Wed, 01 May 2024 11:14:55 +0930
Subject: [PATCH v9 1/1] watchdog: aspeed: Revise handling of bootstatus
In-Reply-To: <20240430143114.1323686-2-peteryin.openbmc@gmail.com>
References: <20240430143114.1323686-1-peteryin.openbmc@gmail.com>
	 <20240430143114.1323686-2-peteryin.openbmc@gmail.com>
Message-ID: <4042d277a5200317254f6ab98b5ebf708c5a4f25.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Peter,

Overall this seems okay, however I have some follow-ups to my naming
nitpicks on v8. Broadly, my preferences are that:

 * It's clear from the macro name what SoC, controller and register
   each macro applies to
 * We have a consistent structure in the macro naming -
   <soc>_<controller>_<register>_<description> - i.e. the values for
   <soc> (AST, AST2400, AST2500, AST2600), <controller> (SCU), and
   <register> (SYS_RESET) are consistent across the macro names
 * I prefer consistent use of 'mask' instead of 'flag' for things that
   are used as masks, as to me flag implies a constraint of a single
   bit, where mask doesn't feel like it has such a constraint. However,
   it's fine if a mask consists of a single bit, it's still a mask.

On Tue, 2024-04-30 at 22:31 +0800, Peter Yin wrote:
> Regarding the AST2600 specification, the WDTn Timeout Status Register
> (WDT10) has bit 1 reserved. Bit 1 of the status register indicates
> on ast2500 if the boot was from the second boot source.
> It does not indicate that the most recent reset was triggered by
> the watchdog. The code should just be changed to set WDIOF_CARDRESET
> if bit 0 of the status register is set. However, this bit can be clear when
> watchdog register 0x0c bit1(Reset System after timeout) is enabled.
> Thereforce include SCU register to veriy WDIOF_EXTERN1 and WDIOF_CARDRESET
> in ast2600 SCU74 or ast2400/ast2500 SCU3C.
> 
> Fixes: 49d4d277ca54 ("aspeed: watchdog: Set bootstatus during probe")
> Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
> ---
>  drivers/watchdog/aspeed_wdt.c | 90 +++++++++++++++++++++++++++++++----
>  1 file changed, 82 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
> index b4773a6aaf8c..556493763793 100644
> --- a/drivers/watchdog/aspeed_wdt.c
> +++ b/drivers/watchdog/aspeed_wdt.c
> @@ -11,10 +11,12 @@
>  #include <linux/io.h>
>  #include <linux/kernel.h>
>  #include <linux/kstrtox.h>
> +#include <linux/mfd/syscon.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_irq.h>
>  #include <linux/platform_device.h>
> +#include <linux/regmap.h>
>  #include <linux/watchdog.h>
>  static bool nowayout = WATCHDOG_NOWAYOUT;
> @@ -22,10 +24,38 @@ module_param(nowayout, bool, 0);
>  MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
>  __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> +/* AST SCU Register for System Reset Event Log Register Set
> + * ast2600 is scu074 ast2400/2500 is scu03c
> + */
> +#define AST_SCU_SYS_RESET_POWERON_MASK BIT(0)
> +#define AST_SCU_SYS_RESET_EXTERN_FLAG BIT(1)

s/_FLAG/_MASK/ here too?

> +
> +#define AST2400_SYSTEM_RESET_STATUS 0x3C

You chose to use my suggestion of `..._SCU_SYS_RESET_...` for the
POWERON and EXTERN macros above, but here you've dropped `SCU` and also
used `SYSTEM_RESET` instead `SYS_RESET`. I'd prefer we pick a
consistent register name, so

```
#define AST2400_SCU_SYS_RESET_STATUS 0x3c
```

> +#define AST2400_WATCHDOG_RESET_MASK BIT(1)

Again, I'd prefer all these field macros at least have `SCU` in the
name, and preferably the register name too, so:

```
#define AST2400_SCU_SYS_RESET_WDT_MASK BIT(1)
```


> +#define AST2400_RESET_FLAG_CLEAR GENMASK(2, 0)

s/FLAG/FLAGS/ given it's defined over multiple bits? Also, to include
the register name in the macro name:

```
#define AST2400_SCU_SYS_RESET_FLAGS_CLEAR GENMASK(2, 0)
```

> +
> +#define AST2500_WATCHDOG_RESET_MASK GENMASK(4, 2)
> +#define AST2500_RESET_FLAG_CLEAR (AST2500_WATCHDOG_RESET_MASK | \
> + AST_SCU_SYS_RESET_POWERON_MASK | \
> + AST_SCU_SYS_RESET_EXTERN_FLAG)

The same comments above apply to the AST2500 macros.

> +
> +#define AST2600_SYSTEM_RESET_STATUS 0x74
> +#define AST2600_WATCHDOG_RESET_MASK GENMASK(31, 16)
> +#define AST2600_RESET_FLAG_CLEAR (AST2600_WATCHDOG_RESET_MASK | \
> + AST_SCU_SYS_RESET_POWERON_MASK | \
> + AST_SCU_SYS_RESET_EXTERN_FLAG)

... and the AST2600 macros.

> +
>  struct aspeed_wdt_config {
>  u32 ext_pulse_width_mask;
>  u32 irq_shift;
>  u32 irq_mask;
> + struct {
> + const char *compatible;
> + u32 reset_status_reg;
> + u32 watchdog_reset_mask;
> + u32 extern_reset_mask;
> + u32 reset_flag_clear;
> + } scu;
>  };
>  struct aspeed_wdt {
> @@ -39,18 +69,39 @@ static const struct aspeed_wdt_config ast2400_config = {
>  .ext_pulse_width_mask = 0xff,
>  .irq_shift = 0,
>  .irq_mask = 0,
> + .scu = {
> + .compatible = "aspeed,ast2400-scu",
> + .reset_status_reg = AST2400_SYSTEM_RESET_STATUS,
> + .watchdog_reset_mask = AST2400_WATCHDOG_RESET_MASK,
> + .extern_reset_mask = 0,
> + .reset_flag_clear = AST2400_RESET_FLAG_CLEAR,
> + }
>  };
>  static const struct aspeed_wdt_config ast2500_config = {
>  .ext_pulse_width_mask = 0xfffff,
>  .irq_shift = 12,
>  .irq_mask = GENMASK(31, 12),
> + .scu = {
> + .compatible = "aspeed,ast2500-scu",
> + .reset_status_reg = AST2400_SYSTEM_RESET_STATUS,
> + .watchdog_reset_mask = AST2500_WATCHDOG_RESET_MASK,
> + .extern_reset_mask = AST_SCU_SYS_RESET_EXTERN_FLAG,
> + .reset_flag_clear = AST2500_RESET_FLAG_CLEAR,
> + }
>  };
>  static const struct aspeed_wdt_config ast2600_config = {
>  .ext_pulse_width_mask = 0xfffff,
>  .irq_shift = 0,
>  .irq_mask = GENMASK(31, 10),
> + .scu = {
> + .compatible = "aspeed,ast2600-scu",
> + .reset_status_reg = AST2600_SYSTEM_RESET_STATUS,
> + .watchdog_reset_mask = AST2600_WATCHDOG_RESET_MASK,
> + .extern_reset_mask = AST_SCU_SYS_RESET_EXTERN_FLAG,
> + .reset_flag_clear = AST2600_RESET_FLAG_CLEAR,
> + }
>  };
>  static const struct of_device_id aspeed_wdt_of_table[] = {
> @@ -310,6 +361,7 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>  const struct of_device_id *ofdid;
>  struct aspeed_wdt *wdt;
>  struct device_node *np;
> + struct regmap *scu;
>  const char *reset_type;
>  u32 duration;
>  u32 status;
> @@ -458,14 +510,36 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>  writel(duration - 1, wdt->base + WDT_RESET_WIDTH);
>  }
> - status = readl(wdt->base + WDT_TIMEOUT_STATUS);
> - if (status & WDT_TIMEOUT_STATUS_BOOT_SECONDARY) {
> - wdt->wdd.bootstatus = WDIOF_CARDRESET;
> -
> - if (of_device_is_compatible(np, "aspeed,ast2400-wdt") ||
> - of_device_is_compatible(np, "aspeed,ast2500-wdt"))
> - wdt->wdd.groups = bswitch_groups;
> - }
> + /*
> + * Power on reset is set when triggered by AC or SRSRST.

s/SRSRST/SRST/

> + * Thereforce, we clear flag to ensure

s/Thereforce/Therefore/

Also the line-wrapping for the comment seems a bit aggressive?

> + * next boot cause is a real watchdog case.
> + * We use the external reset flag to determine
> + * if it is an external reset or card reset.
> + * However, The ast2400 watchdog flag is cleared by an external reset,
> + * so it only supports WDIOF_CARDRESET.
> + */
> + scu = syscon_regmap_lookup_by_compatible(wdt->cfg->scu.compatible);
> + if (IS_ERR(scu))
> + return PTR_ERR(scu);
> +
> + ret = regmap_read(scu, wdt->cfg->scu.reset_status_reg, &status);
> + if (ret)
> + return ret;
> +
> + if (!(status & AST_SCU_SYS_RESET_POWERON_MASK) &&
> + status & wdt->cfg->scu.watchdog_reset_mask)
> + wdt->wdd.bootstatus = (status & wdt->cfg->scu.extern_reset_mask)
> + ? WDIOF_EXTERN1 : WDIOF_CARDRESET;
> +
> + status = wdt->cfg->scu.reset_flag_clear;

Seems unnecessary to assign the mask to clear the reset state into
status?

Andrew

> + ret = regmap_write(scu, wdt->cfg->scu.reset_status_reg, status);
> + if (ret)
> + return ret;
> +
> + if (of_device_is_compatible(np, "aspeed,ast2400-wdt") ||
> + of_device_is_compatible(np, "aspeed,ast2500-wdt"))
> + wdt->wdd.groups = bswitch_groups;
>  dev_set_drvdata(dev, wdt);

