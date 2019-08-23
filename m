From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 23 Aug 2019 07:19:30 -0700
Subject: [PATCH v1 3/3] watchdog/aspeed: add support for dual boot
In-Reply-To: <fafd757238e204b2566f216f1d6a4bef4b4906c5.camel@yadro.com>
References: <fafd757238e204b2566f216f1d6a4bef4b4906c5.camel@yadro.com>
Message-ID: <20190823141930.GA11610@roeck-us.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Aug 23, 2019 at 12:35:28PM +0300, Ivan Mikhaylov wrote:
> Set WDT_CLEAR_TIMEOUT_AND_BOOT_CODE_SELECTION into WDT_CLEAR_TIMEOUT_STATUS
> to clear out boot code source and re-enable access to the primary SPI flash
> chip while booted via wdt2 from the alternate chip.
> 
> AST2400 datasheet says:
> "In the 2nd flash booting mode, all the address mapping to CS0# would be
> re-directed to CS1#. And CS0# is not accessable under this mode. To access
> CS0#, firmware should clear the 2nd boot mode register in the WDT2 status
> register WDT30.bit[1]."
> 
> Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>
> ---
>  drivers/watchdog/aspeed_wdt.c | 44 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 43 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
> index cc71861e033a..62bf95cb741f 100644
> --- a/drivers/watchdog/aspeed_wdt.c
> +++ b/drivers/watchdog/aspeed_wdt.c
> @@ -53,6 +53,8 @@ MODULE_DEVICE_TABLE(of, aspeed_wdt_of_table);
>  #define   WDT_CTRL_ENABLE		BIT(0)
>  #define WDT_TIMEOUT_STATUS	0x10
>  #define   WDT_TIMEOUT_STATUS_BOOT_SECONDARY	BIT(1)
> +#define WDT_CLEAR_TIMEOUT_STATUS	0x14
> +#define   WDT_CLEAR_TIMEOUT_AND_BOOT_CODE_SELECTION	BIT(0)
>  
>  /*
>   * WDT_RESET_WIDTH controls the characteristics of the external pulse (if
> @@ -165,6 +167,42 @@ static int aspeed_wdt_restart(struct watchdog_device *wdd,
>  	return 0;
>  }
>  
> +/* access_cs0 shows if cs0 is accessible, hence the reverted bit */
> +static ssize_t access_cs0_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct aspeed_wdt *wdt = dev_get_drvdata(dev);
> +

Unnecessary empty line.

> +	uint32_t status = readl(wdt->base + WDT_TIMEOUT_STATUS);
> +
> +	return sprintf(buf, "%u\n",
> +			!(status & WDT_TIMEOUT_STATUS_BOOT_SECONDARY));
> +}
> +
> +static ssize_t access_cs0_store(struct device *dev,
> +			      struct device_attribute *attr,
> +			      const char *buf, size_t size)
> +{
> +	struct aspeed_wdt *wdt = dev_get_drvdata(dev);
> +	unsigned long val = 0;

Unnecessary initialization.

> +
> +	if (kstrtoul(buf, 10, &val))
> +		return -EINVAL;
> +
> +	if (val)
> +		writel(WDT_CLEAR_TIMEOUT_AND_BOOT_CODE_SELECTION,
> +			wdt->base + WDT_CLEAR_TIMEOUT_STATUS);
> +
> +	return size;
> +}
> +static DEVICE_ATTR_RW(access_cs0);
> +
> +static struct attribute *bswitch_attrs[] = {
> +	&dev_attr_access_cs0.attr,

The attribute needs to be documented.

> +	NULL
> +};
> +ATTRIBUTE_GROUPS(bswitch);
> +
>  static const struct watchdog_ops aspeed_wdt_ops = {
>  	.start		= aspeed_wdt_start,
>  	.stop		= aspeed_wdt_stop,
> @@ -306,8 +344,12 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>  	}
>  
>  	status = readl(wdt->base + WDT_TIMEOUT_STATUS);
> -	if (status & WDT_TIMEOUT_STATUS_BOOT_SECONDARY)
> +	if (status & WDT_TIMEOUT_STATUS_BOOT_SECONDARY) {
>  		wdt->wdd.bootstatus = WDIOF_CARDRESET;
> +		wdt->wdd.groups = bswitch_groups;
> +	}

So the attribute would only exist if the boot was from the secondary
flash, and it would exist even if it wasn't needed (ie on ast2500 /
ast2600) ? Well, if that is what you want, who am I to argue, but
you'll have to document it accordingly. When you do so, please also
document what happens on ast2500 / ast2600 when the attribute exists
and is written.

> +
> +	dev_set_drvdata(dev, wdt);
>  
>  	return devm_watchdog_register_device(dev, &wdt->wdd);
>  }
> -- 
> 2.20.1
> 
> 
