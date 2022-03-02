From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 02 Mar 2022 10:39:04 +1030
Subject: [PATCH] pinctrl: aspeed: fix null dereference in debug
In-Reply-To: <tencent_BBDF8D2C89ECC450F3349D6E46F8EAF87F0A@qq.com>
References: <tencent_BBDF8D2C89ECC450F3349D6E46F8EAF87F0A@qq.com>
Message-ID: <c51e5a79-168e-4189-ba8e-a426ab82cd89@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Wed, 2 Mar 2022, at 06:00, Weiguo Li wrote:
> "pdesc" is null checked, but already dereferenced ahead in debug.
> Swap their positions to avoid potential null dereference.
>
> Signed-off-by: Weiguo Li <liwg06@foxmail.com>

Thanks.

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

> ---
>  drivers/pinctrl/aspeed/pinctrl-aspeed.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed.c 
> b/drivers/pinctrl/aspeed/pinctrl-aspeed.c
> index c94e24aadf92..83d47ff1cea8 100644
> --- a/drivers/pinctrl/aspeed/pinctrl-aspeed.c
> +++ b/drivers/pinctrl/aspeed/pinctrl-aspeed.c
> @@ -236,11 +236,11 @@ int aspeed_pinmux_set_mux(struct pinctrl_dev 
> *pctldev, unsigned int function,
>  		const struct aspeed_sig_expr **funcs;
>  		const struct aspeed_sig_expr ***prios;
> 
> -		pr_debug("Muxing pin %s for %s\n", pdesc->name, pfunc->name);
> -
>  		if (!pdesc)
>  			return -EINVAL;
> 
> +		pr_debug("Muxing pin %s for %s\n", pdesc->name, pfunc->name);
> +
>  		prios = pdesc->prios;
> 
>  		if (!prios)
> -- 
> 2.25.1
