From: Patrice CHOTARD <patrice.chotard@foss.st.com>
Date: Fri, 17 May 2024 06:53:30 -0000
Subject: [PATCH v2 03/20] pinctrl: stm32: Use scope based of_node_put()
 cleanups
In-Reply-To: <20240504-pinctrl-cleanup-v2-3-26c5f2dc1181@nxp.com>
References: <20240504-pinctrl-cleanup-v2-0-26c5f2dc1181@nxp.com>
 <20240504-pinctrl-cleanup-v2-3-26c5f2dc1181@nxp.com>
Message-ID: <124b75a6-d8da-4e29-8dce-79d18c355ba2@foss.st.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 5/4/24 15:20, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Use scope based of_node_put() cleanup to simplify code.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/pinctrl/stm32/pinctrl-stm32.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
> index 978ccdbaf3d3..a8673739871d 100644
> --- a/drivers/pinctrl/stm32/pinctrl-stm32.c
> +++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
> @@ -670,7 +670,6 @@ static int stm32_pctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
>  				 struct device_node *np_config,
>  				 struct pinctrl_map **map, unsigned *num_maps)
>  {
> -	struct device_node *np;
>  	unsigned reserved_maps;
>  	int ret;
>  
> @@ -678,12 +677,11 @@ static int stm32_pctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
>  	*num_maps = 0;
>  	reserved_maps = 0;
>  
> -	for_each_child_of_node(np_config, np) {
> +	for_each_child_of_node_scoped(np_config, np) {
>  		ret = stm32_pctrl_dt_subnode_to_map(pctldev, np, map,
>  				&reserved_maps, num_maps);
>  		if (ret < 0) {
>  			pinctrl_utils_free_map(pctldev, *map, *num_maps);
> -			of_node_put(np);
>  			return ret;
>  		}
>  	}
> 

Hi

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
