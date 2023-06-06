From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 6 Jun 2023 12:56:31 +0200
Subject: [v5 5/5] hwmon: Add Aspeed ast2600 TACH support
In-Reply-To: <20230606094535.5388-6-billy_tsai@aspeedtech.com>
References: <20230606094535.5388-1-billy_tsai@aspeedtech.com>
 <20230606094535.5388-6-billy_tsai@aspeedtech.com>
Message-ID: <47d95067-12e0-4b19-6b6d-104532fae1e0@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 06/06/2023 11:45, Billy Tsai wrote:
> Add the support of Tachometer which can use to monitor the frequency of
> the input. The tach supports up to 16 channels and it's part function of
> multi-function device "pwm-tach controller".
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>


> +
> +static void aspeed_tach_reset_assert(void *data)
> +{
> +	struct reset_control *rst = data;
> +
> +	reset_control_assert(rst);
> +}
> +
> +static int aspeed_tach_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np, *child;
> +	struct aspeed_tach_data *priv;
> +	struct device *hwmon;
> +	int ret;
> +
> +	np = dev->parent->of_node;
> +	if (!of_device_is_compatible(np, "aspeed,ast2600-pwm-tach"))

Drop.

> +		return dev_err_probe(dev, -ENODEV,
> +				     "Unsupported tach device binding\n");
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +	priv->dev = &pdev->dev;
> +
> +	priv->regmap = syscon_node_to_regmap(np);
> +	if (IS_ERR(priv->regmap))
> +		return dev_err_probe(dev, PTR_ERR(priv->regmap),
> +				     "Couldn't get regmap\n");
> +
> +	priv->clk = devm_clk_get_enabled(dev->parent, NULL);

NAK. Parent is simple-mfd, means it must not have clock.


> +	if (IS_ERR(priv->clk))
> +		return dev_err_probe(dev, PTR_ERR(priv->clk),
> +				     "Couldn't get clock\n");
> +
> +	priv->clk_source = clk_get_rate(priv->clk);
> +
> +	priv->reset = devm_reset_control_get_shared(dev->parent, NULL);

NAK, same reasons.

Best regards,
Krzysztof

