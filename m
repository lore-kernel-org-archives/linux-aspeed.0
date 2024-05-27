From: Markus Elfring <Markus.Elfring@web.de>
Date: Mon, 27 May 2024 14:27:27 -0000
Subject: [PATCH v2 04/20] pinctrl: starfive: Use scope based of_node_put()
 cleanups
In-Reply-To: <20240504-pinctrl-cleanup-v2-4-26c5f2dc1181@nxp.com>
References: <20240504-pinctrl-cleanup-v2-4-26c5f2dc1181@nxp.com>
Message-ID: <96beb071-ec2c-475f-8fa2-d519a1b1dc28@web.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> Use scope based of_node_put() cleanup to simplify code.

I see opportunities to improve affected function implementations another bit.


?
> +++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c
?
> @@ -543,18 +540,18 @@ static int starfive_dt_node_to_map(struct pinctrl_dev *pctldev,
>  			pins = devm_kcalloc(dev, npins, sizeof(*pins), GFP_KERNEL);
>  			if (!pins) {
>  				ret = -ENOMEM;
> -				goto put_child;
> +				goto free_map;
>  			}
>
>  			pinmux = devm_kcalloc(dev, npins, sizeof(*pinmux), GFP_KERNEL);
>  			if (!pinmux) {
>  				ret = -ENOMEM;
> -				goto put_child;
> +				goto free_map;
>  			}
?
> @@ -623,8 +620,6 @@ static int starfive_dt_node_to_map(struct pinctrl_dev *pctldev,
>  	mutex_unlock(&sfp->mutex);
>  	return 0;
>
> -put_child:
> -	of_node_put(child);
>  free_map:
>  	pinctrl_utils_free_map(pctldev, map, nmaps);
>  	mutex_unlock(&sfp->mutex);
?
> +++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
?
> @@ -175,18 +175,18 @@ static int jh7110_dt_node_to_map(struct pinctrl_dev *pctldev,
>  		pins = devm_kcalloc(dev, npins, sizeof(*pins), GFP_KERNEL);
>  		if (!pins) {
>  			ret = -ENOMEM;
> -			goto put_child;
> +			goto free_map;
>  		}
>
>  		pinmux = devm_kcalloc(dev, npins, sizeof(*pinmux), GFP_KERNEL);
>  		if (!pinmux) {
>  			ret = -ENOMEM;
> -			goto put_child;
> +			goto free_map;
>  		}
?
> @@ -233,8 +233,6 @@ static int jh7110_dt_node_to_map(struct pinctrl_dev *pctldev,
>  	*num_maps = nmaps;
>  	return 0;
>
> -put_child:
> -	of_node_put(child);
>  free_map:
>  	pinctrl_utils_free_map(pctldev, map, nmaps);
>  	mutex_unlock(&sfp->mutex);


1. Exception handling is repeated a few times also according to memory allocation failures.
   How do you think about to use a corresponding label like ?e_nomem?
   so that another bit of duplicate source code can be avoided?
   https://wiki.sei.cmu.edu/confluence/display/c/MEM12-C.+Consider+using+a+goto+chain+when+leaving+a+function+on+error+when+using+and+releasing+resources

2. Will development interests grow for the usage of a statement like ?guard(mutex)(&sfp->mutex);??


Regards,
Markus
