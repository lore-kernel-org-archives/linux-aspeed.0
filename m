From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Thu, 02 May 2024 00:54:15 -0000
Subject: [PATCH 20/21] pinctrl: aspeed: g5: Use scope based
 of_node_put() cleanups
In-Reply-To: <20240501-pinctrl-cleanup-v1-20-797ceca46e5c@nxp.com>
References: <20240501-pinctrl-cleanup-v1-0-797ceca46e5c@nxp.com>
	 <20240501-pinctrl-cleanup-v1-20-797ceca46e5c@nxp.com>
Message-ID: <eda5b1da03d4adfa5761c49527a9232ec7facae3.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 2024-05-01 at 20:56 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Use scope based of_node_put() cleanup to simplify code.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c b/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
> index 5bb8fd0d1e41..61fbfddb5938 100644
> --- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
> +++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
> @@ -2629,14 +2629,13 @@ static struct regmap *aspeed_g5_acquire_regmap(struct aspeed_pinmux_data *ctx,
>  		return ctx->maps[ip];
>  
>  	if (ip == ASPEED_IP_GFX) {
> -		struct device_node *node;
> +		struct device_node *node __free(device_node) = NULL;
>  		struct regmap *map;
>  
>  		node = of_parse_phandle(ctx->dev->of_node,
>  					"aspeed,external-nodes", 0);
>  		if (node) {
>  			map = syscon_node_to_regmap(node);
> -			of_node_put(node);
>  			if (IS_ERR(map))
>  				return map;
>  		} else
> @@ -2648,7 +2647,7 @@ static struct regmap *aspeed_g5_acquire_regmap(struct aspeed_pinmux_data *ctx,
>  	}
>  
>  	if (ip == ASPEED_IP_LPC) {
> -		struct device_node *np;
> +		struct device_node *np __free(device_node) = NULL;
>  		struct regmap *map;
>  
>  		np = of_parse_phandle(ctx->dev->of_node,
> @@ -2660,7 +2659,6 @@ static struct regmap *aspeed_g5_acquire_regmap(struct aspeed_pinmux_data *ctx,
>  				return ERR_PTR(-ENODEV);
>  
>  			map = syscon_node_to_regmap(np->parent);
> -			of_node_put(np);
>  			if (IS_ERR(map))
>  				return map;

I think I agree with Krzysztof's feedback on the Samsung patch[1], and
that I prefer the existing approach for the Aspeed driver. My reasoning
suggests the existing implementation does the right thing. That said,
the code could be adjusted to use early returns and consistent variable
names, which might make it easier to reason about. I'll consider a
follow-up patch to address that.

Regardless, thanks for taking the time to explore the cleanup.

Andrew

[1]: https://lore.kernel.org/lkml/34193501-5b7b-4ffd-8549-a04c6930d02d at kernel.org/

>  		} else
> 

