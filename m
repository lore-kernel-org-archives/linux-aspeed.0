From: Jonathan Cameron <jic23@kernel.org>
Date: Sun, 29 Aug 2021 16:39:23 +0100
Subject: [RESEND v4 13/15] iio: adc: aspeed: Add compensation phase.
In-Reply-To: <202108250006.17P066YP096721@twspam01.aspeedtech.com>
References: <20210824091243.9393-1-billy_tsai@aspeedtech.com>
 <202108250006.17P066YP096721@twspam01.aspeedtech.com>
Message-ID: <20210829163923.107f4027@jic23-huawei>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 24 Aug 2021 17:12:41 +0800
Billy Tsai <billy_tsai@aspeedtech.com> wrote:

> This patch adds a compensation phase to improve the accurate of ADC

accuracy of the ADC measurement.

> measurement. This is the built-in function though input half of the
> reference voltage to get the ADC offset.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
This looks like fairly standard calibration which is good to have.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/aspeed_adc.c | 54 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 53 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
> index 4d979dd7fe88..20caf28dff18 100644
> --- a/drivers/iio/adc/aspeed_adc.c
> +++ b/drivers/iio/adc/aspeed_adc.c
> @@ -95,6 +95,7 @@ struct aspeed_adc_data {
>  	struct reset_control	*rst;
>  	int			vref;
>  	u32			sample_period_ns;
> +	int			cv;
>  };
>  
>  #define ASPEED_CHAN(_idx, _data_reg_addr) {			\
> @@ -104,7 +105,8 @@ struct aspeed_adc_data {
>  	.address = (_data_reg_addr),				\
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
>  	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
> -				BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +				BIT(IIO_CHAN_INFO_SAMP_FREQ) |	\
> +				BIT(IIO_CHAN_INFO_OFFSET),	\
>  }
>  
>  static const struct iio_chan_spec aspeed_adc_iio_channels[] = {
> @@ -126,6 +128,51 @@ static const struct iio_chan_spec aspeed_adc_iio_channels[] = {
>  	ASPEED_CHAN(15, 0x2E),
>  };
>  
> +static int aspeed_adc_compensation(struct iio_dev *indio_dev)
> +{
> +	struct aspeed_adc_data *data = iio_priv(indio_dev);
> +	u32 index, adc_raw = 0;
> +	u32 adc_engine_control_reg_val;
> +
> +	adc_engine_control_reg_val =
> +		readl(data->base + ASPEED_REG_ENGINE_CONTROL);
> +	adc_engine_control_reg_val &= ~ASPEED_ADC_OP_MODE;
> +	adc_engine_control_reg_val |=
> +		(FIELD_PREP(ASPEED_ADC_OP_MODE, ASPEED_ADC_OP_MODE_NORMAL) |
> +		 ASPEED_ADC_ENGINE_ENABLE);
> +	/*
> +	 * Enable compensating sensing:
> +	 * After that, the input voltage of ADC will force to half of the reference
> +	 * voltage. So the expected reading raw data will become half of the max
> +	 * value. We can get compensating value = 0x200 - ADC read raw value.
> +	 * It is recommended to average at least 10 samples to get a final CV.
> +	 */
> +	writel(adc_engine_control_reg_val | ASPEED_ADC_CTRL_COMPENSATION |
> +		       ASPEED_ADC_CTRL_CHANNEL_ENABLE(0),
> +	       data->base + ASPEED_REG_ENGINE_CONTROL);
> +	/*
> +	 * After enable compensating sensing mode need to wait some time for ADC stable
> +	 * Experiment result is 1ms.
> +	 */
> +	mdelay(1);
> +
> +	for (index = 0; index < 16; index++) {
> +		/*
> +		 * Waiting for the sampling period ensures that the value acquired
> +		 * is fresh each time.
> +		 */
> +		ndelay(data->sample_period_ns);
> +		adc_raw += readw(data->base + aspeed_adc_iio_channels[0].address);
> +	}
> +	adc_raw >>= 4;
> +	data->cv = BIT(ASPEED_RESOLUTION_BITS - 1) - adc_raw;
> +	writel(adc_engine_control_reg_val,
> +	       data->base + ASPEED_REG_ENGINE_CONTROL);
> +	dev_dbg(data->dev, "Compensating value = %d\n", data->cv);
> +
> +	return 0;
> +}
> +
>  static int aspeed_adc_set_sampling_rate(struct iio_dev *indio_dev, u32 rate)
>  {
>  	struct aspeed_adc_data *data = iio_priv(indio_dev);
> @@ -155,6 +202,10 @@ static int aspeed_adc_read_raw(struct iio_dev *indio_dev,
>  		*val = readw(data->base + chan->address);
>  		return IIO_VAL_INT;
>  
> +	case IIO_CHAN_INFO_OFFSET:
> +		*val = data->cv;
> +		return IIO_VAL_INT;
> +
>  	case IIO_CHAN_INFO_SCALE:
>  		*val = data->vref;
>  		*val2 = ASPEED_RESOLUTION_BITS;
> @@ -444,6 +495,7 @@ static int aspeed_adc_probe(struct platform_device *pdev)
>  			return ret;
>  	}
>  
> +	aspeed_adc_compensation(indio_dev);
>  	/* Start all channels in normal mode. */
>  	adc_engine_control_reg_val =
>  		readl(data->base + ASPEED_REG_ENGINE_CONTROL);

