From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 18 Mar 2024 08:58:24 +0100
Subject: [PATCH v2] drivers: watchdog: ast2600 support bootstatus
In-Reply-To: <20240318055219.3460121-1-peteryin.openbmc@gmail.com>
References: <20240318055219.3460121-1-peteryin.openbmc@gmail.com>
Message-ID: <d94a4833-3fe2-4dfa-be88-9508971d12bd@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 18/03/2024 06:52, Peter Yin wrote:
> Add WDIOF_EXTERN1 and WDIOF_CARDRESET bootstatus in ast2600
> 
> Regarding the AST2600 specification, the WDTn Timeout Status Register
> (WDT10) has bit 1 reserved. To verify the second boot source,
> we need to check SEC14 bit 12 and bit 13.
> The bits 8-23 in the WDTn Timeout Status Register are the Watchdog
> Event Count, which we can use to verify WDIOF_EXTERN1.
> 
> Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
> ---
> Change log:
> 
> v1 -> v2
>   - Add comment and support WDIOF_CARDRESET in ast2600
> 
> v1
>   - Patch 0001 - Add WDIOF_EXTERN1 bootstatus
> ---
>  arch/arm/boot/dts/aspeed/aspeed-g6.dtsi |  8 ++---

No, DTS is always separate patchset.

>  drivers/watchdog/aspeed_wdt.c           | 45 ++++++++++++++++++++++---
>  2 files changed, 44 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
> index e0b44498269f..23ae7f0430e9 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
> +++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
> @@ -556,24 +556,24 @@ uart5: serial at 1e784000 {
>  
>  			wdt1: watchdog at 1e785000 {
>  				compatible = "aspeed,ast2600-wdt";
> -				reg = <0x1e785000 0x40>;
> +				reg = <0x1e785000 0x40>, <0x1e6f2000 0x20>;

And how does it pass dtbs_check? Where did you update the bindings?

>  			};
>  
>  			wdt2: watchdog at 1e785040 {
>  				compatible = "aspeed,ast2600-wdt";
> -				reg = <0x1e785040 0x40>;
> +				reg = <0x1e785040 0x40>, <0x1e6f2000 0x020>;
>  				status = "disabled";
>  			};
>  
>  			wdt3: watchdog at 1e785080 {
>  				compatible = "aspeed,ast2600-wdt";
> -				reg = <0x1e785080 0x40>;
> +				reg = <0x1e785080 0x40>, <0x1e6f2000 0x020>;
>  				status = "disabled";
>  			};
>  
>  			wdt4: watchdog at 1e7850c0 {
>  				compatible = "aspeed,ast2600-wdt";
> -				reg = <0x1e7850C0 0x40>;
> +				reg = <0x1e7850C0 0x40>, <0x1e6f2000 0x020>;
>  				status = "disabled";
>  			};
>  
> diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
> index b4773a6aaf8c..65118e461130 100644
> --- a/drivers/watchdog/aspeed_wdt.c
> +++ b/drivers/watchdog/aspeed_wdt.c
> @@ -33,6 +33,7 @@ struct aspeed_wdt {
>  	void __iomem		*base;
>  	u32			ctrl;
>  	const struct aspeed_wdt_config *cfg;
> +	void __iomem		*sec_base;
>  };
>  
>  static const struct aspeed_wdt_config ast2400_config = {
> @@ -82,6 +83,15 @@ MODULE_DEVICE_TABLE(of, aspeed_wdt_of_table);
>  #define WDT_RESET_MASK1		0x1c
>  #define WDT_RESET_MASK2		0x20
>  
> +/*
> + * Only Ast2600 support
> + */
> +#define   WDT_EVENT_COUNTER_MASK	(0xFFF << 8)
> +#define   WDT_SECURE_ENGINE_STATUS	(0x14)
> +#define   ABR_IMAGE_SOURCE		BIT(12)
> +#define   ABR_IMAGE_SOURCE_SPI		BIT(13)
> +#define   SECOND_BOOT_ENABLE		BIT(14)
> +
>  /*
>   * WDT_RESET_WIDTH controls the characteristics of the external pulse (if
>   * enabled), specifically:
> @@ -313,6 +323,7 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>  	const char *reset_type;
>  	u32 duration;
>  	u32 status;
> +	u32 sec_st;
>  	int ret;
>  
>  	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
> @@ -330,6 +341,12 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>  	if (IS_ERR(wdt->base))
>  		return PTR_ERR(wdt->base);
>  
> +	if (of_device_is_compatible(np, "aspeed,ast2600-wdt")) {


> +		wdt->sec_base = devm_platform_ioremap_resource(pdev, 1);
> +		if (IS_ERR(wdt->sec_base))
> +			return PTR_ERR(wdt->sec_base);
> +	}

NAK, ABI break without clear reason.

Best regards,
Krzysztof

