From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Tue, 30 Nov 2021 10:52:17 +0100
Subject: [v13 2/2] pwm: Add Aspeed ast2600 PWM support
In-Reply-To: <20211129064329.27006-3-billy_tsai@aspeedtech.com>
References: <20211129064329.27006-1-billy_tsai@aspeedtech.com>
 <20211129064329.27006-3-billy_tsai@aspeedtech.com>
Message-ID: <e28a5d5de9b940717e6444f019eab63ab1bb0b75.camel@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 2021-11-29 at 14:43 +0800, Billy Tsai wrote:
[...]
> +	ret = clk_prepare_enable(priv->clk);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Couldn't enable clock\n");
> +
> +	ret = reset_control_deassert(priv->reset);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "Couldn't deassert reset control\n");
> +		goto err_disable_clk;
> +	}

Is there any reason to keep the clocks running and the controller out of
reset while the PWM outputs are disabled?

regards
Philipp
