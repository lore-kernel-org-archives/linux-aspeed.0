From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Fri, 26 Nov 2021 11:10:52 +0100
Subject: [v12 2/2] pwm: Add Aspeed ast2600 PWM support
In-Reply-To: <20210906024339.21124-3-billy_tsai@aspeedtech.com>
References: <20210906024339.21124-1-billy_tsai@aspeedtech.com>
 <20210906024339.21124-3-billy_tsai@aspeedtech.com>
Message-ID: <727777874f925c0d862887589a868859a95d3649.camel@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Billy,

On Mon, 2021-09-06 at 10:43 +0800, Billy Tsai wrote:
[...]
> +static int aspeed_pwm_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +	struct aspeed_pwm_data *priv;
> +	struct device_node *np;
> +	struct platform_device *parent_dev;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	np = pdev->dev.parent->of_node;
> +	if (!of_device_is_compatible(np, "aspeed,ast2600-pwm-tach"))
> +		return dev_err_probe(dev, -ENODEV,
> +				     "Unsupported pwm device binding\n");
> +
> +	priv->regmap = syscon_node_to_regmap(np);
> +	if (IS_ERR(priv->regmap))
> +		return dev_err_probe(dev, PTR_ERR(priv->regmap),
> +				     "Couldn't get regmap\n");
> +
> +	parent_dev = of_find_device_by_node(np);
> +	priv->clk = devm_clk_get(&parent_dev->dev, 0);
> +	if (IS_ERR(priv->clk))
> +		return dev_err_probe(dev, PTR_ERR(priv->clk),
> +				     "Couldn't get clock\n");
> +
> +	priv->reset = devm_reset_control_get_shared(&parent_dev->dev, NULL);
> +	if (IS_ERR(priv->reset)) {
> +		return dev_err_probe(dev, PTR_ERR(priv->reset),
> +				     "Couldn't get reset control\n");
> +	}

I'd remove these curly braces for consistency with the code above.

regards
Philipp
