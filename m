From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Mon, 19 Feb 2018 12:46:19 +0100
Subject: [PATCH 3/3] reset: simple: Allow user selection of driver
In-Reply-To: <20180219065438.19933-4-joel@jms.id.au>
References: <20180219065438.19933-1-joel@jms.id.au>
 <20180219065438.19933-4-joel@jms.id.au>
Message-ID: <1519040779.3408.7.camel@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 2018-02-19 at 17:24 +1030, Joel Stanley wrote:
> Currently this driver is only user selectable if COMPILE_TEST is turned
> on. Users may wish to select (and deselect) it, so remove this
> restriction.

I would like to keep user visible options to a minimum unless there is a
good reason. What is the scenario in which a user would decide to
disable the default-enabled reset-simple driver, or the other way
around? This should be mentioned in the commit message.

Maybe this is an indication that there could be a better default than
just ARCH_ASPEED.

regards
Philipp

> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  drivers/reset/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 18f152d251d7..7490a4370900 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -82,7 +82,7 @@ config RESET_PISTACHIO
>  	  This enables the reset driver for ImgTec Pistachio SoCs.
>  
>  config RESET_SIMPLE
> -	bool "Simple Reset Controller Driver" if COMPILE_TEST
> +	bool "Simple Reset Controller Driver"
>  	default ARCH_SOCFPGA || ARCH_STM32 || ARCH_STRATIX10 || ARCH_SUNXI || ARCH_ZX || ARCH_ASPEED
>  	help
>  	  This enables a simple reset controller driver for reset lines that
