From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 2 Nov 2022 13:59:51 -0700
Subject: [PATCH v2 1/2] watchdog: aspeed: Enable pre-timeout interrupt
In-Reply-To: <20221101205338.577427-2-eajames@linux.ibm.com>
References: <20221101205338.577427-1-eajames@linux.ibm.com>
 <20221101205338.577427-2-eajames@linux.ibm.com>
Message-ID: <20221102205951.GA2090175@roeck-us.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Nov 01, 2022 at 03:53:37PM -0500, Eddie James wrote:
> Enable the core pre-timeout interrupt on AST2500 and AST2600.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/aspeed_wdt.c | 104 ++++++++++++++++++++++++++++------
>  1 file changed, 88 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
> index 0cff2adfbfc9..86b5331bc491 100644
> --- a/drivers/watchdog/aspeed_wdt.c
> +++ b/drivers/watchdog/aspeed_wdt.c
> @@ -5,11 +5,14 @@
>   * Joel Stanley <joel@jms.id.au>
>   */
>  
> +#include <linux/bits.h>
>  #include <linux/delay.h>
> +#include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_irq.h>
>  #include <linux/platform_device.h>
>  #include <linux/watchdog.h>
>  
> @@ -18,28 +21,41 @@ module_param(nowayout, bool, 0);
>  MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
>  				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
>  
> +struct aspeed_wdt_config {
> +	u32 ext_pulse_width_mask;
> +	u32 irq_shift;
> +	u32 irq_mask;
> +};
> +
>  struct aspeed_wdt {
>  	struct watchdog_device	wdd;
>  	void __iomem		*base;
>  	u32			ctrl;
> -};
> -
> -struct aspeed_wdt_config {
> -	u32 ext_pulse_width_mask;
> +	const struct aspeed_wdt_config *cfg;
>  };
>  
>  static const struct aspeed_wdt_config ast2400_config = {
>  	.ext_pulse_width_mask = 0xff,
> +	.irq_shift = 0,
> +	.irq_mask = 0,
>  };
>  
>  static const struct aspeed_wdt_config ast2500_config = {
>  	.ext_pulse_width_mask = 0xfffff,
> +	.irq_shift = 12,
> +	.irq_mask = GENMASK(31, 12),
> +};
> +
> +static const struct aspeed_wdt_config ast2600_config = {
> +	.ext_pulse_width_mask = 0xfffff,
> +	.irq_shift = 0,
> +	.irq_mask = GENMASK(31, 10),
>  };
>  
>  static const struct of_device_id aspeed_wdt_of_table[] = {
>  	{ .compatible = "aspeed,ast2400-wdt", .data = &ast2400_config },
>  	{ .compatible = "aspeed,ast2500-wdt", .data = &ast2500_config },
> -	{ .compatible = "aspeed,ast2600-wdt", .data = &ast2500_config },
> +	{ .compatible = "aspeed,ast2600-wdt", .data = &ast2600_config },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, aspeed_wdt_of_table);
> @@ -58,6 +74,7 @@ MODULE_DEVICE_TABLE(of, aspeed_wdt_of_table);
>  #define   WDT_CTRL_RESET_SYSTEM		BIT(1)
>  #define   WDT_CTRL_ENABLE		BIT(0)
>  #define WDT_TIMEOUT_STATUS	0x10
> +#define   WDT_TIMEOUT_STATUS_IRQ		BIT(2)
>  #define   WDT_TIMEOUT_STATUS_BOOT_SECONDARY	BIT(1)
>  #define WDT_CLEAR_TIMEOUT_STATUS	0x14
>  #define   WDT_CLEAR_TIMEOUT_AND_BOOT_CODE_SELECTION	BIT(0)
> @@ -160,6 +177,26 @@ static int aspeed_wdt_set_timeout(struct watchdog_device *wdd,
>  	return 0;
>  }
>  
> +static int aspeed_wdt_set_pretimeout(struct watchdog_device *wdd,
> +				     unsigned int pretimeout)
> +{
> +	struct aspeed_wdt *wdt = to_aspeed_wdt(wdd);
> +	u32 actual = pretimeout * WDT_RATE_1MHZ;
> +	u32 s = wdt->cfg->irq_shift;
> +	u32 m = wdt->cfg->irq_mask;
> +
> +	wdd->pretimeout = pretimeout;
> +	wdt->ctrl &= ~m;
> +	if (pretimeout)
> +		wdt->ctrl |= ((actual << s) & m) | WDT_CTRL_WDT_INTR;
> +	else
> +		wdt->ctrl &= ~WDT_CTRL_WDT_INTR;
> +
> +	writel(wdt->ctrl, wdt->base + WDT_CTRL);
> +
> +	return 0;
> +}
> +
>  static int aspeed_wdt_restart(struct watchdog_device *wdd,
>  			      unsigned long action, void *data)
>  {
> @@ -232,6 +269,7 @@ static const struct watchdog_ops aspeed_wdt_ops = {
>  	.stop		= aspeed_wdt_stop,
>  	.ping		= aspeed_wdt_ping,
>  	.set_timeout	= aspeed_wdt_set_timeout,
> +	.set_pretimeout = aspeed_wdt_set_pretimeout,
>  	.restart	= aspeed_wdt_restart,
>  	.owner		= THIS_MODULE,
>  };
> @@ -243,10 +281,29 @@ static const struct watchdog_info aspeed_wdt_info = {
>  	.identity	= KBUILD_MODNAME,
>  };
>  
> +static const struct watchdog_info aspeed_wdt_pretimeout_info = {
> +	.options	= WDIOF_KEEPALIVEPING
> +			| WDIOF_PRETIMEOUT
> +			| WDIOF_MAGICCLOSE
> +			| WDIOF_SETTIMEOUT,
> +	.identity	= KBUILD_MODNAME,
> +};
> +
> +static irqreturn_t aspeed_wdt_irq(int irq, void *arg)
> +{
> +	struct watchdog_device *wdd = arg;
> +	struct aspeed_wdt *wdt = to_aspeed_wdt(wdd);
> +	u32 status = readl(wdt->base + WDT_TIMEOUT_STATUS);
> +
> +	if (status & WDT_TIMEOUT_STATUS_IRQ)
> +		watchdog_notify_pretimeout(wdd);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static int aspeed_wdt_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> -	const struct aspeed_wdt_config *config;
>  	const struct of_device_id *ofdid;
>  	struct aspeed_wdt *wdt;
>  	struct device_node *np;
> @@ -259,11 +316,33 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>  	if (!wdt)
>  		return -ENOMEM;
>  
> +	np = dev->of_node;
> +
> +	ofdid = of_match_node(aspeed_wdt_of_table, np);
> +	if (!ofdid)
> +		return -EINVAL;
> +	wdt->cfg = ofdid->data;
> +
>  	wdt->base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(wdt->base))
>  		return PTR_ERR(wdt->base);
>  
>  	wdt->wdd.info = &aspeed_wdt_info;
> +
> +	if (wdt->cfg->irq_mask) {
> +		int irq = platform_get_irq_optional(pdev, 0);
> +
> +		if (irq > 0) {
> +			ret = devm_request_irq(dev, irq, aspeed_wdt_irq,
> +					       IRQF_SHARED, dev_name(dev),
> +					       wdt);
> +			if (ret)
> +				return ret;
> +
> +			wdt->wdd.info = &aspeed_wdt_pretimeout_info;
> +		}
> +	}
> +
>  	wdt->wdd.ops = &aspeed_wdt_ops;
>  	wdt->wdd.max_hw_heartbeat_ms = WDT_MAX_TIMEOUT_MS;
>  	wdt->wdd.parent = dev;
> @@ -273,13 +352,6 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>  
>  	watchdog_set_nowayout(&wdt->wdd, nowayout);
>  
> -	np = dev->of_node;
> -
> -	ofdid = of_match_node(aspeed_wdt_of_table, np);
> -	if (!ofdid)
> -		return -EINVAL;
> -	config = ofdid->data;
> -
>  	/*
>  	 * On clock rates:
>  	 *  - ast2400 wdt can run at PCLK, or 1MHz
> @@ -331,7 +403,7 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>  		(of_device_is_compatible(np, "aspeed,ast2600-wdt"))) {
>  		u32 reg = readl(wdt->base + WDT_RESET_WIDTH);
>  
> -		reg &= config->ext_pulse_width_mask;
> +		reg &= wdt->cfg->ext_pulse_width_mask;
>  		if (of_property_read_bool(np, "aspeed,ext-active-high"))
>  			reg |= WDT_ACTIVE_HIGH_MAGIC;
>  		else
> @@ -339,7 +411,7 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>  
>  		writel(reg, wdt->base + WDT_RESET_WIDTH);
>  
> -		reg &= config->ext_pulse_width_mask;
> +		reg &= wdt->cfg->ext_pulse_width_mask;
>  		if (of_property_read_bool(np, "aspeed,ext-push-pull"))
>  			reg |= WDT_PUSH_PULL_MAGIC;
>  		else
> @@ -349,7 +421,7 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>  	}
>  
>  	if (!of_property_read_u32(np, "aspeed,ext-pulse-duration", &duration)) {
> -		u32 max_duration = config->ext_pulse_width_mask + 1;
> +		u32 max_duration = wdt->cfg->ext_pulse_width_mask + 1;
>  
>  		if (duration == 0 || duration > max_duration) {
>  			dev_err(dev, "Invalid pulse duration: %uus\n",
