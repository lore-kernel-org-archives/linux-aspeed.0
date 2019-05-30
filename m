From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 30 May 2019 13:32:08 +0930
Subject: [PATCH] soc: aspeed: lpc-ctrl: make parameter optional
In-Reply-To: <20190529172103.1130525-1-vijaykhemka@fb.com>
References: <20190529172103.1130525-1-vijaykhemka@fb.com>
Message-ID: <fe36fbac-e29c-4210-9af2-defca62e9c2a@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Thu, 30 May 2019, at 02:51, Vijay Khemka wrote:
> Makiing

Typo here, but I'd prefer to see this patch go in, so

> memory-region and flash as optional parameter in device
> tree if user needs to use these parameter through ioctl then
> need to define in devicetree.
> 
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

> ---
>  drivers/soc/aspeed/aspeed-lpc-ctrl.c | 58 +++++++++++++++++-----------
>  1 file changed, 36 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/soc/aspeed/aspeed-lpc-ctrl.c 
> b/drivers/soc/aspeed/aspeed-lpc-ctrl.c
> index a024f8042259..aca13779764a 100644
> --- a/drivers/soc/aspeed/aspeed-lpc-ctrl.c
> +++ b/drivers/soc/aspeed/aspeed-lpc-ctrl.c
> @@ -68,6 +68,7 @@ static long aspeed_lpc_ctrl_ioctl(struct file *file, 
> unsigned int cmd,
>  		unsigned long param)
>  {
>  	struct aspeed_lpc_ctrl *lpc_ctrl = file_aspeed_lpc_ctrl(file);
> +	struct device *dev = file->private_data;
>  	void __user *p = (void __user *)param;
>  	struct aspeed_lpc_ctrl_mapping map;
>  	u32 addr;
> @@ -90,6 +91,12 @@ static long aspeed_lpc_ctrl_ioctl(struct file *file, 
> unsigned int cmd,
>  		if (map.window_id != 0)
>  			return -EINVAL;
>  
> +		/* If memory-region is not described in device tree */
> +		if (!lpc_ctrl->mem_size) {
> +			dev_dbg(dev, "Didn't find reserved memory\n");
> +			return -ENXIO;
> +		}
> +
>  		map.size = lpc_ctrl->mem_size;
>  
>  		return copy_to_user(p, &map, sizeof(map)) ? -EFAULT : 0;
> @@ -126,9 +133,18 @@ static long aspeed_lpc_ctrl_ioctl(struct file 
> *file, unsigned int cmd,
>  			return -EINVAL;
>  
>  		if (map.window_type == ASPEED_LPC_CTRL_WINDOW_FLASH) {
> +			if (!lpc_ctrl->pnor_size) {
> +				dev_dbg(dev, "Didn't find host pnor flash\n");
> +				return -ENXIO;
> +			}
>  			addr = lpc_ctrl->pnor_base;
>  			size = lpc_ctrl->pnor_size;
>  		} else if (map.window_type == ASPEED_LPC_CTRL_WINDOW_MEMORY) {
> +			/* If memory-region is not described in device tree */
> +			if (!lpc_ctrl->mem_size) {
> +				dev_dbg(dev, "Didn't find reserved memory\n");
> +				return -ENXIO;
> +			}
>  			addr = lpc_ctrl->mem_base;
>  			size = lpc_ctrl->mem_size;
>  		} else {
> @@ -196,17 +212,17 @@ static int aspeed_lpc_ctrl_probe(struct 
> platform_device *pdev)
>  	if (!lpc_ctrl)
>  		return -ENOMEM;
>  
> +	/* If flash is described in device tree then store */
>  	node = of_parse_phandle(dev->of_node, "flash", 0);
>  	if (!node) {
> -		dev_err(dev, "Didn't find host pnor flash node\n");
> -		return -ENODEV;
> -	}
> -
> -	rc = of_address_to_resource(node, 1, &resm);
> -	of_node_put(node);
> -	if (rc) {
> -		dev_err(dev, "Couldn't address to resource for flash\n");
> -		return rc;
> +		dev_dbg(dev, "Didn't find host pnor flash node\n");
> +	} else {
> +		rc = of_address_to_resource(node, 1, &resm);
> +		of_node_put(node);
> +		if (rc) {
> +			dev_err(dev, "Couldn't address to resource for flash\n");
> +			return rc;
> +		}
>  	}
>  
>  	lpc_ctrl->pnor_size = resource_size(&resm);
> @@ -214,22 +230,22 @@ static int aspeed_lpc_ctrl_probe(struct 
> platform_device *pdev)
>  
>  	dev_set_drvdata(&pdev->dev, lpc_ctrl);
>  
> +	/* If memory-region is described in device tree then store */
>  	node = of_parse_phandle(dev->of_node, "memory-region", 0);
>  	if (!node) {
> -		dev_err(dev, "Didn't find reserved memory\n");
> -		return -EINVAL;
> -	}
> +		dev_dbg(dev, "Didn't find reserved memory\n");
> +	} else {
> +		rc = of_address_to_resource(node, 0, &resm);
> +		of_node_put(node);
> +		if (rc) {
> +			dev_err(dev, "Couldn't address to resource for reserved memory\n");
> +			return -ENXIO;
> +		}
>  
> -	rc = of_address_to_resource(node, 0, &resm);
> -	of_node_put(node);
> -	if (rc) {
> -		dev_err(dev, "Couldn't address to resource for reserved memory\n");
> -		return -ENOMEM;
> +		lpc_ctrl->mem_size = resource_size(&resm);
> +		lpc_ctrl->mem_base = resm.start;
>  	}
>  
> -	lpc_ctrl->mem_size = resource_size(&resm);
> -	lpc_ctrl->mem_base = resm.start;
> -
>  	lpc_ctrl->regmap = syscon_node_to_regmap(
>  			pdev->dev.parent->of_node);
>  	if (IS_ERR(lpc_ctrl->regmap)) {
> @@ -258,8 +274,6 @@ static int aspeed_lpc_ctrl_probe(struct 
> platform_device *pdev)
>  		goto err;
>  	}
>  
> -	dev_info(dev, "Loaded at %pr\n", &resm);
> -
>  	return 0;
>  
>  err:
> -- 
> 2.17.1
> 
>
