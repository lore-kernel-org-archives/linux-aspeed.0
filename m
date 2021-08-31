From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Tue, 31 Aug 2021 09:51:23 +0200
Subject: [v5 09/15] iio: adc: aspeed: Use devm_add_action_or_reset.
In-Reply-To: <20210831071458.2334-10-billy_tsai@aspeedtech.com>
References: <20210831071458.2334-1-billy_tsai@aspeedtech.com>
 <20210831071458.2334-10-billy_tsai@aspeedtech.com>
Message-ID: <4bc2bf196efd540933e6a781a44af20142e3d5d3.camel@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Billy,

On Tue, 2021-08-31 at 15:14 +0800, Billy Tsai wrote:
> This patch use devm_add_action_or_reset to handle the error in probe
> phase.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  drivers/iio/adc/aspeed_adc.c | 112 +++++++++++++++++++++--------------
>  1 file changed, 66 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
> index e53d1541ad1d..af00d9752c1e 100644
> --- a/drivers/iio/adc/aspeed_adc.c
> +++ b/drivers/iio/adc/aspeed_adc.c
[...]
> @@ -242,6 +271,11 @@ static int aspeed_adc_probe(struct platform_device *pdev)
>  			&data->clk_lock);
>  		if (IS_ERR(data->clk_prescaler))
>  			return PTR_ERR(data->clk_prescaler);
> +		ret = devm_add_action_or_reset(data->dev,
> +					       aspeed_adc_unregister_divider,
> +					       data->clk_prescaler);
> +		if (ret)
> +			return ret;

I think here you could switch to devm_clk_hw_register_divider() instead.


>  		snprintf(clk_parent_name, ARRAY_SIZE(clk_parent_name),
>  			 clk_name);
>  		scaler_flags = CLK_SET_RATE_PARENT;
> @@ -256,23 +290,30 @@ static int aspeed_adc_probe(struct platform_device *pdev)
>  		&pdev->dev, clk_name, clk_parent_name, scaler_flags,
>  		data->base + ASPEED_REG_CLOCK_CONTROL, 0,
>  		data->model_data->scaler_bit_width, 0, &data->clk_lock);
> -	if (IS_ERR(data->clk_scaler)) {
> -		ret = PTR_ERR(data->clk_scaler);
> -		goto scaler_error;
> -	}
> +	if (IS_ERR(data->clk_scaler))
> +		return PTR_ERR(data->clk_scaler);
> +
> +	ret = devm_add_action_or_reset(data->dev, aspeed_adc_unregister_divider,
> +				       data->clk_scaler);
> +	if (ret)
> +		return ret;

Same as above.

[...]
> @@ -281,6 +322,10 @@ static int aspeed_adc_probe(struct platform_device *pdev)
>  			       ASPEED_ADC_ENGINE_ENABLE,
>  		       data->base + ASPEED_REG_ENGINE_CONTROL);
>  
> +		ret = devm_add_action_or_reset(data->dev, aspeed_adc_power_down,
> +					       data);
> +		if (ret)
> +			return ret;
>  		/* Wait for initial sequence complete. */
>  		ret = readl_poll_timeout(data->base + ASPEED_REG_ENGINE_CONTROL,
>  					 adc_engine_control_reg_val,
[...]
> @@ -303,6 +354,11 @@ static int aspeed_adc_probe(struct platform_device *pdev)
>  		ASPEED_ADC_ENGINE_ENABLE;
>  	writel(adc_engine_control_reg_val,
>  	       data->base + ASPEED_REG_ENGINE_CONTROL);
> +	ret = devm_add_action_or_reset(data->dev,
> +				       aspeed_adc_power_down,
> +				       data);
> +	if (ret)
> +		return ret;

Should this be if (!model_dta->wait_init_sequence) ? Otherwise it looks
like you've already registered the same aspeed_adc_power_down action
above.

regards
Philipp
