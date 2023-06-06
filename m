From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 6 Jun 2023 12:55:45 +0200
Subject: [v5 4/5] pwm: Add Aspeed ast2600 PWM support
In-Reply-To: <20230606094535.5388-5-billy_tsai@aspeedtech.com>
References: <20230606094535.5388-1-billy_tsai@aspeedtech.com>
 <20230606094535.5388-5-billy_tsai@aspeedtech.com>
Message-ID: <676e5c04-e13c-417b-5a2a-73ee339fbbd3@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 06/06/2023 11:45, Billy Tsai wrote:
> Add the support of PWM controller which can be found at aspeed ast2600
> soc. The pwm supoorts up to 16 channels and it's part function of
> multi-function device "pwm-tach controller".
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> Reviewed-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---


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

No, don't embed compatibles in your code. This is useless, so drop it.

> +
> +	priv->regmap = syscon_node_to_regmap(np);
> +	if (IS_ERR(priv->regmap))
> +		return dev_err_probe(dev, PTR_ERR(priv->regmap),
> +				     "Couldn't get regmap\n");
> +
> +	parent_dev = of_find_device_by_node(np);

Why? You already have parent!

> +	priv->clk = devm_clk_get_enabled(&parent_dev->dev, NULL);
> +	if (IS_ERR(priv->clk))
> +		return dev_err_probe(dev, PTR_ERR(priv->clk),
> +				     "Couldn't get clock\n");

NAK. This is purely broken. You cannot play with parent's clock and I
told you this last time. Parent is simple-mfd so this code is a hacky
workaround over using simple-mfd even though I told you that yuo cannot
use simple-mfd.

> +
> +	priv->reset = devm_reset_control_get_shared(&parent_dev->dev, NULL);

NAK.


Best regards,
Krzysztof

