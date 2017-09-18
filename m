From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 18 Sep 2017 07:45:17 -0700
Subject: [PATCH 2/4] watchdog: aspeed: Fix 'Apseed' typo in Kconfig
In-Reply-To: <20170918054905.16470-3-andrew@aj.id.au>
References: <20170918054905.16470-1-andrew@aj.id.au>
 <20170918054905.16470-3-andrew@aj.id.au>
Message-ID: <20170918144517.GB11868@roeck-us.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Sep 18, 2017 at 03:19:03PM +0930, Andrew Jeffery wrote:
> Apseed sounds like a good name for a web/mobile start-up incubator, but
> isn't a reflection of Aspeed themselves.
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Reviewed-by: Guenter Rocek <linux@roeck-us.net>

> ---
>  drivers/watchdog/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index c722cbfdc7e6..b562d2e03eb9 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -746,7 +746,7 @@ config ASPEED_WATCHDOG
>  	select WATCHDOG_CORE
>  	help
>  	  Say Y here to include support for the watchdog timer
> -	  in Apseed BMC SoCs.
> +	  in Aspeed BMC SoCs.
>  
>  	  This driver is required to reboot the SoC.
>  
> -- 
> 2.11.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
