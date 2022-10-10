From: Damien Le Moal <Damien.LeMoal@wdc.com>
Date: Mon, 10 Oct 2022 22:33:10 +0000
Subject: [PATCH v2 12/36] pinctrl: k210: Add missed header(s)
In-Reply-To: <20221010201453.77401-13-andriy.shevchenko@linux.intel.com>
References: <20221010201453.77401-1-andriy.shevchenko@linux.intel.com>
 <20221010201453.77401-13-andriy.shevchenko@linux.intel.com>
Message-ID: <4630d457-2d3b-6f66-7be5-54c84bdf80b4@wdc.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 2022/10/11 5:15, Andy Shevchenko wrote:
> Do not imply that some of the generic headers may be always included.
> Instead, include explicitly what we are direct user of.
> 
> While at it, sort headers alphabetically.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Looks OK to me, but the patch title should be:

pinctrl: k210: Add missing header(s)

Same remark for the entire series. You need s/missed/missing in all patch titles.

With that fixed,

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  drivers/pinctrl/pinctrl-k210.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-k210.c b/drivers/pinctrl/pinctrl-k210.c
> index ecab6bf63dc6..288e44457fec 100644
> --- a/drivers/pinctrl/pinctrl-k210.c
> +++ b/drivers/pinctrl/pinctrl-k210.c
> @@ -3,18 +3,20 @@
>   * Copyright (C) 2020 Sean Anderson <seanga2@gmail.com>
>   * Copyright (c) 2020 Western Digital Corporation or its affiliates.
>   */
> -#include <linux/io.h>
> -#include <linux/of_device.h>
> +#include <linux/bitfield.h>
>  #include <linux/clk.h>
> +#include <linux/io.h>
>  #include <linux/mfd/syscon.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
> -#include <linux/bitfield.h>
>  #include <linux/regmap.h>
> +#include <linux/seq_file.h>
>  #include <linux/slab.h>
> +
> +#include <linux/pinctrl/pinconf-generic.h>
> +#include <linux/pinctrl/pinconf.h>
>  #include <linux/pinctrl/pinctrl.h>
>  #include <linux/pinctrl/pinmux.h>
> -#include <linux/pinctrl/pinconf.h>
> -#include <linux/pinctrl/pinconf-generic.h>
>  
>  #include <dt-bindings/pinctrl/k210-fpioa.h>
>  

-- 
Damien Le Moal
Western Digital Research

