From: Jonathan Cameron <jic23@kernel.org>
Date: Mon, 14 Nov 2022 20:21:43 +0000
Subject: [v3 1/2] iio: adc: aspeed: Remove the trim valid dts property.
In-Reply-To: <20221114025057.10843-1-billy_tsai@aspeedtech.com>
References: <20221114025057.10843-1-billy_tsai@aspeedtech.com>
Message-ID: <20221114202143.6156b436@jic23-huawei>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 14 Nov 2022 10:50:56 +0800
Billy Tsai <billy_tsai@aspeedtech.com> wrote:

> The dts property "aspeed,trim-data-valid" is currently used to determine
> whether to read trimming data from the OTP register. If this is set on
> a device without valid trimming data in the OTP the ADC will not function
> correctly. This patch drops the use of this property and instead uses the
> default (unprogrammed) OTP value of 0 to detect when a fallback value of
> 0x8 should be used rather then the value read from the OTP.
> 
> Fixes: d0a4c17b4073 ("iio: adc: aspeed: Get and set trimming data.")
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
Series applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/aspeed_adc.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
> index 9341e0e0eb55..998e8bcc06e1 100644
> --- a/drivers/iio/adc/aspeed_adc.c
> +++ b/drivers/iio/adc/aspeed_adc.c
> @@ -202,6 +202,8 @@ static int aspeed_adc_set_trim_data(struct iio_dev *indio_dev)
>  				((scu_otp) &
>  				 (data->model_data->trim_locate->field)) >>
>  				__ffs(data->model_data->trim_locate->field);
> +			if (!trimming_val)
> +				trimming_val = 0x8;
>  		}
>  		dev_dbg(data->dev,
>  			"trimming val = %d, offset = %08x, fields = %08x\n",
> @@ -563,12 +565,9 @@ static int aspeed_adc_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	if (of_find_property(data->dev->of_node, "aspeed,trim-data-valid",
> -			     NULL)) {
> -		ret = aspeed_adc_set_trim_data(indio_dev);
> -		if (ret)
> -			return ret;
> -	}
> +	ret = aspeed_adc_set_trim_data(indio_dev);
> +	if (ret)
> +		return ret;
>  
>  	if (of_find_property(data->dev->of_node, "aspeed,battery-sensing",
>  			     NULL)) {

