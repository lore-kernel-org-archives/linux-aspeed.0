From: Joel Stanley <joel@jms.id.au>
Date: Fri, 20 Sep 2019 05:51:18 +0000
Subject: [PATCH] ARM: aspeed: ast2500 is ARMv6K
In-Reply-To: <20190919142654.1578823-1-arnd@arndb.de>
References: <20190919142654.1578823-1-arnd@arndb.de>
Message-ID: <CACPK8XcsegR5R0nkiZ-UEMgCqNMggCXjAr2N-6J1S6mEhGLrBQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 19 Sep 2019 at 14:27, Arnd Bergmann <arnd@arndb.de> wrote:
>
> Linux supports both the original ARMv6 level (early ARM1136) and ARMv6K
> (later ARM1136, ARM1176 and ARM11mpcore).
>
> ast2500 falls into the second categoy, being based on arm1176jzf-s.
> This is enabled by default when using ARCH_MULTI_V6, so we should
> not 'select CPU_V6'.
>
> Removing this will lead to more efficient use of atomic instructions.

Wow, nice find.

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
>         bool "Aspeed SoC 5th Generation"
>         depends on ARCH_MULTI_V6
> -       select CPU_V6
>         select PINCTRL_ASPEED_G5 if !CC_IS_CLANG

I can't find any trees with !CC_IS_CLANG here. Is there a problem
building our pinmux driver with Clang?

I tested with this patch:

--- a/arch/arm/mach-aspeed/Kconfig
+++ b/arch/arm/mach-aspeed/Kconfig
@@ -25,8 +25,8 @@ config MACH_ASPEED_G4

 config MACH_ASPEED_G5
        bool "Aspeed SoC 5th Generation"
+       # This implies ARMv6K which covers the ARM1176
        depends on ARCH_MULTI_V6
-       select CPU_V6
        select PINCTRL_ASPEED_G5
        select FTTMR010_TIMER
        help

If you want to apply that as a fix for 5.4 I would be happy with that.

Fixes: 8c2ed9bcfbeb ("arm: Add Aspeed machine")
Reviewed-by: Joel Stanley <joel@jms.id.au>

Cheers,

Joel
