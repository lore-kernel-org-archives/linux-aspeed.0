From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Wed, 24 Jan 2024 10:45:59 +0100
Subject: [PATCH v13 3/3] hwmon: (aspeed-g6-pwm-tacho): Support for
 ASPEED g6 PWM/Fan tach
In-Reply-To: <20240124060705.1342461-4-billy_tsai@aspeedtech.com>
References: <20240124060705.1342461-1-billy_tsai@aspeedtech.com>
	 <20240124060705.1342461-4-billy_tsai@aspeedtech.com>
Message-ID: <dccb808a2ba6ccb0fd0b4e7ccfe40cd871886b6b.camel@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mi, 2024-01-24 at 14:07 +0800, Billy Tsai wrote:
[...]
> +static int aspeed_pwm_tach_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev, *hwmon;
> +	int ret;
> +	struct device_node *child;
> +	struct aspeed_pwm_tach_data *priv;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +	priv->dev = dev;
> +	priv->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(priv->base))
> +		return PTR_ERR(priv->base);
> +
> +	priv->clk = devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(priv->clk))
> +		return dev_err_probe(dev, PTR_ERR(priv->clk),
> +				     "Couldn't get clock\n");
> +	priv->clk_rate = clk_get_rate(priv->clk);
> +	priv->reset = devm_reset_control_get_exclusive(dev, NULL);
> +	if (IS_ERR(priv->reset))
> +		return dev_err_probe(dev, PTR_ERR(priv->reset),
> +				     "Couldn't get reset control\n");
> +
> +	ret = reset_control_deassert(priv->reset);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Couldn't deassert reset control\n");

Consider using devm_add_action_or_reset() to assert the reset in the
error paths and on driver unbind.

> +
> +	priv->chip.dev = dev;
> +	priv->chip.ops = &aspeed_pwm_ops;
> +	priv->chip.npwm = PWM_ASPEED_NR_PWMS;
> +
> +	ret = devm_pwmchip_add(dev, &priv->chip);
> +	if (ret < 0) {
> +		reset_control_assert(priv->reset);

Then this ...

> +		return dev_err_probe(dev, ret, "Failed to add PWM chip\n");
> +	}
> +
> +	for_each_child_of_node(dev->of_node, child) {
> +		ret = aspeed_tach_create_fan(dev, child, priv);
> +		if (ret < 0) {
> +			of_node_put(child);
> +			dev_warn(dev, "Failed to create fan %d", ret);
> +			return 0;
> +		}
> +	}
> +
> +	of_platform_populate(dev->of_node, NULL, NULL, dev);
> +
> +	hwmon = devm_hwmon_device_register_with_info(dev, "aspeed_tach", priv,
> +						     &aspeed_tach_chip_info, NULL);
> +	ret = PTR_ERR_OR_ZERO(hwmon);
> +	if (ret) {
> +		reset_control_assert(priv->reset);

... and this ...

> +		return dev_err_probe(dev, ret,
> +				     "Failed to register hwmon device\n");
> +	}
> +
> +	return 0;
> +}
> +
> +static int aspeed_pwm_tach_remove(struct platform_device *pdev)
> +{
> +	struct aspeed_pwm_tach_data *priv = platform_get_drvdata(pdev);
> +
> +	reset_control_assert(priv->reset);
> +
> +	return 0;
> +}

... and this could be dropped.

regards
Philipp
