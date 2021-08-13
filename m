From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Fri, 13 Aug 2021 12:02:15 +0200
Subject: [v11 2/2] pwm: Add Aspeed ast2600 PWM support
In-Reply-To: <20210812040942.5365-3-billy_tsai@aspeedtech.com>
References: <20210812040942.5365-1-billy_tsai@aspeedtech.com>
 <20210812040942.5365-3-billy_tsai@aspeedtech.com>
Message-ID: <5da35c2030e57621fa56795cd193e727f53205fe.camel@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Billy,

On Thu, 2021-08-12 at 12:09 +0800, Billy Tsai wrote:
> This patch add the support of PWM controller which can be found at aspeed
> ast2600 soc. The pwm supoorts up to 16 channels and it's part function
> of multi-function device "pwm-tach controller".
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
[...]
> diff --git a/drivers/pwm/pwm-aspeed-ast2600.c b/drivers/pwm/pwm-aspeed-ast2600.c
> new file mode 100644
> index 000000000000..f89ce1d4cd67
> --- /dev/null
> +++ b/drivers/pwm/pwm-aspeed-ast2600.c
> @@ -0,0 +1,327 @@
[...]
> +static int aspeed_pwm_probe(struct platform_device *pdev)
> +{
[...]
> +	priv->clk = devm_clk_get(&parent_dev->dev, 0);
> +	if (IS_ERR(priv->clk))
> +		return dev_err_probe(dev, PTR_ERR(priv->clk),
> +				     "Couldn't get clock\n");
> +
> +	ret = clk_prepare_enable(priv->clk);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Couldn't enable clock\n");
> +
> +	priv->reset = devm_reset_control_get_shared(&parent_dev->dev, NULL);
> +	if (IS_ERR(priv->reset)) {
> +		ret = dev_err_probe(dev, PTR_ERR(priv->reset),
> +				    "Get reset failed\n");
> +		goto err_disable_clk;
> +	}

I suggest to request the reset control before enabling the clock. That
way you can simplify the error path and avoid enabling the clock in case
of reset_control_get failure.

regards
Philipp
