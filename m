From: Baolin Wang <baolin.wang@linux.alibaba.com>
Date: Thu, 13 Oct 2022 09:23:27 +0800
Subject: [PATCH v2 23/36] pinctrl: sprd: Add missed header(s)
In-Reply-To: <20221010201453.77401-24-andriy.shevchenko@linux.intel.com>
References: <20221010201453.77401-1-andriy.shevchenko@linux.intel.com>
 <20221010201453.77401-24-andriy.shevchenko@linux.intel.com>
Message-ID: <b7c8afe1-af89-9b5a-2c2c-82a2810ca9f1@linux.alibaba.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 10/11/2022 4:14 AM, Andy Shevchenko wrote:
> Do not imply that some of the generic headers may be always included.
> Instead, include explicitly what we are direct user of.
> 
> While at it, sort headers alphabetically.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

LGTM. Thanks.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   drivers/pinctrl/sprd/pinctrl-sprd.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pinctrl/sprd/pinctrl-sprd.c b/drivers/pinctrl/sprd/pinctrl-sprd.c
> index dca7a505d413..c1806b7dcf78 100644
> --- a/drivers/pinctrl/sprd/pinctrl-sprd.c
> +++ b/drivers/pinctrl/sprd/pinctrl-sprd.c
> @@ -13,12 +13,14 @@
>   #include <linux/of.h>
>   #include <linux/of_device.h>
>   #include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#include <linux/pinctrl/consumer.h>
>   #include <linux/pinctrl/machine.h>
> -#include <linux/pinctrl/pinconf.h>
>   #include <linux/pinctrl/pinconf-generic.h>
> +#include <linux/pinctrl/pinconf.h>
>   #include <linux/pinctrl/pinctrl.h>
>   #include <linux/pinctrl/pinmux.h>
> -#include <linux/slab.h>
>   
>   #include "../core.h"
>   #include "../pinmux.h"
