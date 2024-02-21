From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Wed, 21 Feb 2024 14:14:51 +0100
Subject: [PATCH v14 3/3] hwmon: (aspeed-g6-pwm-tacho): Support for
 ASPEED g6 PWM/Fan tach
In-Reply-To: <20240221104025.1306227-4-billy_tsai@aspeedtech.com>
References: <20240221104025.1306227-1-billy_tsai@aspeedtech.com>
	 <20240221104025.1306227-4-billy_tsai@aspeedtech.com>
Message-ID: <d203819f09749f0ff9e08a80471b7fed3dad67a8.camel@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mi, 2024-02-21 at 18:40 +0800, Billy Tsai wrote:
> The driver support two functions: PWM and Tachometer. The PWM feature can
> handle up to 16 output ports, while the Tachometer can monitor to up to 16
> input ports as well. This driver implements them by exposing two kernel
> subsystems: PWM and HWMON. The PWM subsystem can be utilized alongside
> existing drivers for controlling elements such as fans (pwm-fan.c),
> beepers (pwm-beeper.c) and so on. Through the HWMON subsystem, the driver
> provides sysfs interfaces for fan.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  Documentation/hwmon/aspeed-g6-pwm-tach.rst |  26 +
>  Documentation/hwmon/index.rst              |   1 +
>  drivers/hwmon/Kconfig                      |  11 +
>  drivers/hwmon/Makefile                     |   1 +
>  drivers/hwmon/aspeed-g6-pwm-tach.c         | 549 +++++++++++++++++++++
>  5 files changed, 588 insertions(+)
>  create mode 100644 Documentation/hwmon/aspeed-g6-pwm-tach.rst
>  create mode 100644 drivers/hwmon/aspeed-g6-pwm-tach.c
> 
[...]
> diff --git a/drivers/hwmon/aspeed-g6-pwm-tach.c b/drivers/hwmon/aspeed-g6-pwm-tach.c
> new file mode 100644
> index 000000000000..597b3b019d49
> --- /dev/null
> +++ b/drivers/hwmon/aspeed-g6-pwm-tach.c
> @@ -0,0 +1,549 @@
[...]
> +static void aspeed_pwm_tach_reset_assert(void *data)
> +{
> +	struct reset_control *rst = data;
> +
> +	reset_control_assert(rst);
> +}
> +
> +static int aspeed_pwm_tach_probe(struct platform_device *pdev)
> +{
[...]
> +	priv->reset = devm_reset_control_get_exclusive(dev, NULL);
> +	if (IS_ERR(priv->reset))
> +		return dev_err_probe(dev, PTR_ERR(priv->reset),
> +				     "Couldn't get reset control\n");
> +
> +	ret = reset_control_deassert(priv->reset);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Couldn't deassert reset control\n");
> +	ret = devm_add_action_or_reset(dev, aspeed_pwm_tach_reset_assert,
> +				       priv->reset);
[...]
> +}
> +
> +static int aspeed_pwm_tach_remove(struct platform_device *pdev)
> +{
> +	struct aspeed_pwm_tach_data *priv = platform_get_drvdata(pdev);
> +
> +	reset_control_assert(priv->reset);

This is already done by aspeed_pwm_tach_reset_assert(), looks like
aspeed_pwm_tach_remove() can be removed. With that, priv->reset can
become a local variable in aspeed_pwm_tach_probe().

regards
Philipp
