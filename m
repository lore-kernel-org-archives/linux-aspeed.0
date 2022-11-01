From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Tue, 1 Nov 2022 11:03:52 +0100
Subject: [v2 2/3] pwm: Add Aspeed ast2600 PWM support
In-Reply-To: <20221101095156.30591-3-billy_tsai@aspeedtech.com>
References: <20221101095156.30591-1-billy_tsai@aspeedtech.com>
 <20221101095156.30591-3-billy_tsai@aspeedtech.com>
Message-ID: <5b2fea37-b790-d209-27b3-12c2a6830822@wanadoo.fr>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Le 01/11/2022 ? 10:51, Billy Tsai a ?crit?:
> This patch add the support of PWM controller which can be found at aspeed
> ast2600 soc. The pwm supoorts up to 16 channels and it's part function
> of multi-function device "pwm-tach controller".
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>

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

Hi,

if this helps, using devm_clk_get_enabled() would save a few lines of code.

CJ

> +	if (IS_ERR(priv->clk))
> +		return dev_err_probe(dev, PTR_ERR(priv->clk),
> +				     "Couldn't get clock\n");
> +

[...]
