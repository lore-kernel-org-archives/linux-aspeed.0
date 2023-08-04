From: Patrice CHOTARD <patrice.chotard@foss.st.com>
Date: Fri, 4 Aug 2023 17:02:57 +0200
Subject: [PATCH v2 02/23] ARM: sti: Drop unused includes
In-Reply-To: <20230803-dt-header-cleanups-for-soc-v2-2-d8de2cc88bff@kernel.org>
References: <20230803-dt-header-cleanups-for-soc-v2-0-d8de2cc88bff@kernel.org>
 <20230803-dt-header-cleanups-for-soc-v2-2-d8de2cc88bff@kernel.org>
Message-ID: <baaebecd-d3d9-c3b1-dd7c-f5a39c194d4b@foss.st.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 8/4/23 00:42, Rob Herring wrote:
> Several includes are not needed, so drop them.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  arch/arm/mach-sti/board-dt.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm/mach-sti/board-dt.c b/arch/arm/mach-sti/board-dt.c
> index ffecbf29646f..488084b61b4a 100644
> --- a/arch/arm/mach-sti/board-dt.c
> +++ b/arch/arm/mach-sti/board-dt.c
> @@ -4,8 +4,6 @@
>   * Author(s): Srinivas Kandagatla <srinivas.kandagatla@st.com>
>   */
>  
> -#include <linux/irq.h>
> -#include <linux/of_platform.h>
>  #include <asm/hardware/cache-l2x0.h>
>  #include <asm/mach/arch.h>
>  
> 
Acked-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
