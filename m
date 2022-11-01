From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Tue, 1 Nov 2022 11:16:45 +0100
Subject: [v2 3/3] hwmon: Add Aspeed ast2600 TACH support
In-Reply-To: <20221101095156.30591-4-billy_tsai@aspeedtech.com>
References: <20221101095156.30591-1-billy_tsai@aspeedtech.com>
 <20221101095156.30591-4-billy_tsai@aspeedtech.com>
Message-ID: <4e7beec4-9b77-a125-6715-2699c453f5fe@wanadoo.fr>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Le 01/11/2022 ? 10:51, Billy Tsai a ?crit?:
> This patch add the support of Tachometer which can use to monitor the
> frequency of the input. The tach supports up to 16 channels and it's part
> function of multi-function device "pwm-tach controller".
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>

Hi,
a few nits below,

[...]

> +
> +	if (ret) {
> +		/* return 0 if we didn't get an answer because of timeout*/

Missing space at the end of the comment

> +		if (ret == -ETIMEDOUT)
> +			return 0;
> +		else
> +			return ret;

[...]

> +static int aspeed_tach_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np, *child;
> +	struct aspeed_tach_data *priv;
> +	struct device *hwmon;
> +	struct platform_device *parent_dev;
> +	int ret;
> +
> +	np = dev->parent->of_node;
> +	if (!of_device_is_compatible(np, "aspeed,ast2600-pwm-tach"))
> +		return dev_err_probe(dev, -ENODEV,
> +				     "Unsupported tach device binding\n");
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +	priv->dev = &pdev->dev;
> +	priv->tach_channel =
> +		devm_kzalloc(dev,
> +			     TACH_ASPEED_NR_TACHS * sizeof(*priv->tach_channel),
> +			     GFP_KERNEL);

use devm_kcalloc() instead of devm_kzalloc()?
Error handling?

> +
> +	priv->regmap = syscon_node_to_regmap(np);
> +	if (IS_ERR(priv->regmap)) {
> +		dev_err(priv->dev, "Couldn't get regmap\n");

In order to be conistent with the other error handling paths:
return dev_err_probe()?

> +		return -ENODEV;
> +	}

[...]

