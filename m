From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 20 Sep 2019 15:24:01 +0930
Subject: [PATCH] ARM: aspeed: ast2500 is ARMv6K
In-Reply-To: <20190919142654.1578823-1-arnd@arndb.de>
References: <20190919142654.1578823-1-arnd@arndb.de>
Message-ID: <a26c90b8-8f85-4fe5-9dab-d7213f181efd@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Thu, 19 Sep 2019, at 23:56, Arnd Bergmann wrote:
> Linux supports both the original ARMv6 level (early ARM1136) and ARMv6K
> (later ARM1136, ARM1176 and ARM11mpcore).
> 
> ast2500 falls into the second categoy, being based on arm1176jzf-s.
> This is enabled by default when using ARCH_MULTI_V6, so we should
> not 'select CPU_V6'.
> 
> Removing this will lead to more efficient use of atomic instructions.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-aspeed/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/mach-aspeed/Kconfig b/arch/arm/mach-aspeed/Kconfig
> index a293137f5814..163931a03136 100644
> --- a/arch/arm/mach-aspeed/Kconfig
> +++ b/arch/arm/mach-aspeed/Kconfig
> @@ -26,7 +26,6 @@ config MACH_ASPEED_G4
>  config MACH_ASPEED_G5
>  	bool "Aspeed SoC 5th Generation"
>  	depends on ARCH_MULTI_V6
> -	select CPU_V6
>  	select PINCTRL_ASPEED_G5 if !CC_IS_CLANG

Unrelated, but I'm intrigued by this. Looks like I should try compile it with clang
and fix the fallout.

Andrew
