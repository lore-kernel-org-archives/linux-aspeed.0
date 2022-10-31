From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 31 Oct 2022 09:32:58 -0700
Subject: [PATCH 3/3] hwmon: Add Aspeed ast2600 TACH support
In-Reply-To: <20221031103809.20225-4-billy_tsai@aspeedtech.com>
References: <20221031103809.20225-1-billy_tsai@aspeedtech.com>
 <20221031103809.20225-4-billy_tsai@aspeedtech.com>
Message-ID: <20221031163258.GC2462187@roeck-us.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Oct 31, 2022 at 06:38:08PM +0800, Billy Tsai wrote:
> This patch add the support of Tachometer which can use to monitor the
> frequency of the input. The tach supports up to 16 channels and it's part
> function of multi-function device "pwm-tach controller".
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  drivers/hwmon/Kconfig               |   9 +
>  drivers/hwmon/Makefile              |   1 +
>  drivers/hwmon/tach-aspeed-ast2600.c | 692 ++++++++++++++++++++++++++++

Please also provide Documentation/hwmon/tach-aspeed-ast2600.rst.

[ ... ]

> +	hwmon = devm_hwmon_device_register_with_groups(dev, "aspeed_tach", priv,
> +						       priv->groups);

Please use the new hwmon api (devm_hwmon_device_register_with_info).

> +	ret = PTR_ERR_OR_ZERO(hwmon);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "Failed to register hwmon device\n");
> +		goto err_assert_reset;
> +	}
> +	platform_set_drvdata(pdev, priv);
> +	return 0;
> +err_assert_reset:
> +	reset_control_assert(priv->reset);
> +err_disable_clk:
> +	clk_disable_unprepare(priv->clk);

You should be able to use devm_clk_get_enabled() to handle
the clock. If reset handling has to come first, you could use
devm_add_action_or_reset() for it. This way you would
not need the remove function, and error cleanup would
be much simplified.

Thanks,
Guenter

> +	return ret;
> +}
> +
> +static int aspeed_tach_remove(struct platform_device *pdev)
> +{
> +	struct aspeed_tach_data *priv = platform_get_drvdata(pdev);
> +
> +	reset_control_assert(priv->reset);
> +	clk_disable_unprepare(priv->clk);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id of_stach_match_table[] = {
> +	{
> +		.compatible = "aspeed,ast2600-tach",
> +	},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, of_stach_match_table);
> +
> +static struct platform_driver aspeed_tach_driver = {
> +	.probe		= aspeed_tach_probe,
> +	.remove		= aspeed_tach_remove,
> +	.driver		= {
> +		.name	= "aspeed_tach",
> +		.of_match_table = of_stach_match_table,
> +	},
> +};
> +
> +module_platform_driver(aspeed_tach_driver);
> +
> +MODULE_AUTHOR("Billy Tsai <billy_tsai@aspeedtech.com>");
> +MODULE_DESCRIPTION("Aspeed ast2600 TACH device driver");
> +MODULE_LICENSE("GPL v2");
> +
> -- 
> 2.25.1
> 
