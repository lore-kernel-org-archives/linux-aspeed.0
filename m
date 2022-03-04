From: Weiguo Li <liwg06@foxmail.com>
Date: Fri,  4 Mar 2022 17:04:04 +0800
Subject: [PATCH v2] pinctrl: aspeed: fix null dereference in debug
In-Reply-To: <tencent_68563A6FDF372313228831913CC3A7041108@qq.com>
References: <tencent_68563A6FDF372313228831913CC3A7041108@qq.com>
Message-ID: <tencent_5F734C284FE3294244B94EDA77CA088AC806@qq.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 02 Mar 2022 15:12:24 Weiguo Li wrote:
> "pdesc" is null checked, but already dereferenced ahead in debug.
> Swap their positions to avoid potential null dereference.
> 
> Signed-off-by: Weiguo Li <liwg06@foxmail.com>
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
> ---
> v2:
> * resend it after registering an account in aspeed patchwork
> ---
>  drivers/pinctrl/aspeed/pinctrl-aspeed.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed.c b/drivers/pinctrl/aspeed/pinctrl-aspeed.c
> index c94e24aadf92..83d47ff1cea8 100644
> --- a/drivers/pinctrl/aspeed/pinctrl-aspeed.c
> +++ b/drivers/pinctrl/aspeed/pinctrl-aspeed.c
> @@ -236,11 +236,11 @@ int aspeed_pinmux_set_mux(struct pinctrl_dev *pctldev, unsigned int function,
>   const struct aspeed_sig_expr **funcs;
>   const struct aspeed_sig_expr ***prios;
>  
> - pr_debug("Muxing pin %s for %s\n", pdesc->name, pfunc->name);
> -
>   if (!pdesc)
>   return -EINVAL;
>  
> + pr_debug("Muxing pin %s for %s\n", pdesc->name, pfunc->name);
> +
>   prios = pdesc->prios;
>  
>   if (!prios)
> 

Moving Petr's review from previous version:

Reviewed-by: Petr Vorel <pvorel@suse.cz>

-Weiguo

