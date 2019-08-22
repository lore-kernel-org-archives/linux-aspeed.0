From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 22 Aug 2019 10:57:22 +0930
Subject: [PATCH 2/7] ARM: aspeed: Select timer in each SoC
In-Reply-To: <20190821055530.8720-3-joel@jms.id.au>
References: <20190821055530.8720-1-joel@jms.id.au>
 <20190821055530.8720-3-joel@jms.id.au>
Message-ID: <0e9c483f-4f12-45a4-8d2c-1aa3ae34fa7a@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Wed, 21 Aug 2019, at 15:26, Joel Stanley wrote:
> In preparation for adding the ast2600 which does not use this timer.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

> ---
>  arch/arm/mach-aspeed/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-aspeed/Kconfig b/arch/arm/mach-aspeed/Kconfig
> index a15c3a291386..2979aa4daeea 100644
> --- a/arch/arm/mach-aspeed/Kconfig
> +++ b/arch/arm/mach-aspeed/Kconfig
> @@ -5,7 +5,6 @@ menuconfig ARCH_ASPEED
>  	select SRAM
>  	select WATCHDOG
>  	select ASPEED_WATCHDOG
> -	select FTTMR010_TIMER
>  	select MFD_SYSCON
>  	select PINCTRL
>  	help
> @@ -18,6 +17,7 @@ config MACH_ASPEED_G4
>  	depends on ARCH_MULTI_V5
>  	select CPU_ARM926T
>  	select PINCTRL_ASPEED_G4
> +	select FTTMR010_TIMER
>  	help
>  	 Say yes if you intend to run on an Aspeed ast2400 or similar
>  	 fourth generation BMCs, such as those used by OpenPower Power8
> @@ -28,6 +28,7 @@ config MACH_ASPEED_G5
>  	depends on ARCH_MULTI_V6
>  	select CPU_V6
>  	select PINCTRL_ASPEED_G5
> +	select FTTMR010_TIMER
>  	help
>  	 Say yes if you intend to run on an Aspeed ast2500 or similar
>  	 fifth generation Aspeed BMCs.
> -- 
> 2.23.0.rc1
> 
>
