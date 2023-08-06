From: Jisheng Zhang <jszhang@kernel.org>
Date: Sun, 6 Aug 2023 17:26:09 +0800
Subject: [PATCH v2 04/23] ARM: berlin: Drop unused includes
In-Reply-To: <20230803-dt-header-cleanups-for-soc-v2-4-d8de2cc88bff@kernel.org>
References: <20230803-dt-header-cleanups-for-soc-v2-0-d8de2cc88bff@kernel.org>
 <20230803-dt-header-cleanups-for-soc-v2-4-d8de2cc88bff@kernel.org>
Message-ID: <ZM9nMTHTFEY8JcC/@xhacker>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Aug 03, 2023 at 04:42:44PM -0600, Rob Herring wrote:
> Several includes are not needed, so drop them.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Jisheng Zhang <jszhang@kernel.org>

Thanks!

PS: what would be the better merge path? Arnd take it directly with each
sub-maintainers' ack or something else?
> ---
>  arch/arm/mach-berlin/berlin.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/arch/arm/mach-berlin/berlin.c b/arch/arm/mach-berlin/berlin.c
> index 2424ad40190c..13d5c899f09e 100644
> --- a/arch/arm/mach-berlin/berlin.c
> +++ b/arch/arm/mach-berlin/berlin.c
> @@ -8,11 +8,6 @@
>   *  (c) Marvell International Ltd.
>   */
>  
> -#include <linux/init.h>
> -#include <linux/io.h>
> -#include <linux/kernel.h>
> -#include <linux/of_platform.h>
> -#include <asm/hardware/cache-l2x0.h>
>  #include <asm/mach/arch.h>
>  
>  static const char * const berlin_dt_compat[] = {
> 
> -- 
> 2.40.1
> 
