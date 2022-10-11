From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue, 11 Oct 2022 08:26:36 +0530
Subject: [PATCH v2 22/36] pinctrl: spear: Add missed header(s)
In-Reply-To: <20221010201453.77401-23-andriy.shevchenko@linux.intel.com>
References: <20221010201453.77401-1-andriy.shevchenko@linux.intel.com>
 <20221010201453.77401-23-andriy.shevchenko@linux.intel.com>
Message-ID: <20221011025636.glm7wxtg4oo6c2j2@vireshk-i7>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 10-10-22, 23:14, Andy Shevchenko wrote:
> Do not imply that some of the generic headers may be always included.
> Instead, include explicitly what we are direct user of.
> 
> While at it, sort headers alphabetically.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pinctrl/spear/pinctrl-spear.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pinctrl/spear/pinctrl-spear.c b/drivers/pinctrl/spear/pinctrl-spear.c
> index e0543c1ad641..18de2e70ea50 100644
> --- a/drivers/pinctrl/spear/pinctrl-spear.c
> +++ b/drivers/pinctrl/spear/pinctrl-spear.c
> @@ -19,11 +19,13 @@
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/of_gpio.h>
> +#include <linux/platform_device.h>
> +#include <linux/seq_file.h>
> +#include <linux/slab.h>
> +
>  #include <linux/pinctrl/machine.h>
>  #include <linux/pinctrl/pinctrl.h>
>  #include <linux/pinctrl/pinmux.h>
> -#include <linux/platform_device.h>
> -#include <linux/slab.h>
>  
>  #include "pinctrl-spear.h"

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
