From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 12 Jul 2019 10:26:26 +0930
Subject: [PATCH -next] pinctrl: aspeed: Make aspeed_pinmux_ips static
In-Reply-To: <20190711142457.37028-1-yuehaibing@huawei.com>
References: <20190711142457.37028-1-yuehaibing@huawei.com>
Message-ID: <8ed970e9-7062-4905-9d8e-d5f28a0a4919@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Thu, 11 Jul 2019, at 23:55, YueHaibing wrote:
> Fix sparse warning:
> 
> drivers/pinctrl/aspeed/pinmux-aspeed.c:8:12: warning:
>  symbol 'aspeed_pinmux_ips' was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

> ---
>  drivers/pinctrl/aspeed/pinmux-aspeed.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/aspeed/pinmux-aspeed.c 
> b/drivers/pinctrl/aspeed/pinmux-aspeed.c
> index 5b0fe17..839c01b 100644
> --- a/drivers/pinctrl/aspeed/pinmux-aspeed.c
> +++ b/drivers/pinctrl/aspeed/pinmux-aspeed.c
> @@ -5,7 +5,7 @@
>  
>  #include "pinmux-aspeed.h"
>  
> -const char *const aspeed_pinmux_ips[] = {
> +static const char *const aspeed_pinmux_ips[] = {
>  	[ASPEED_IP_SCU] = "SCU",
>  	[ASPEED_IP_GFX] = "GFX",
>  	[ASPEED_IP_LPC] = "LPC",
> -- 
> 2.7.4
> 
> 
>
