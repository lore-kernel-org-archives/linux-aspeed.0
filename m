From: Jonathan Cameron <jic23@kernel.org>
Date: Sun, 6 Nov 2022 14:49:49 +0000
Subject: [PATCH 1/2] iio: adc: aspeed: Remove the trim valid dts
 property.
In-Reply-To: <20221031113208.19194-1-billy_tsai@aspeedtech.com>
References: <20221031113208.19194-1-billy_tsai@aspeedtech.com>
Message-ID: <20221106144949.61731d8e@jic23-huawei>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 31 Oct 2022 19:32:07 +0800
Billy Tsai <billy_tsai@aspeedtech.com> wrote:

> The dts property "aspeed,trim-data-valid" is used to determin whether to
> read the OTP register. If the image with the aspeed,trim-data-vali
> install to the chip without valid trimming data the adc controller will
> become confused. This patch use the default otp value 0 as a criterion
> for determining whether trimming data is valid instead of the dts
> property. The chip with actually trimming value is 0 should be filter out.

Hi Billy,

I'm not sure I correctly follow the patch description.  Would the following
be an accurate description?

The dts property "aspeed,trim-data-valid" is currently used to determine
whether to read trimming data from the OTP register. If this is set on
a device without valid trimming data in the OTP the ADC will not function
correctly. This patch drops he use of this property and instead uses the
default (unprogrammed) OTP value of 0 to detect when a fallback value of
0x8 should be used rather then the value read from the OTP.

Also, is this a bug fix we need to backport?  If so please provide a fixes
tag.

Thanks,

Jonathan

> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  drivers/iio/adc/aspeed_adc.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
> index ffae64f39221..0f065f0bb8e7 100644
> --- a/drivers/iio/adc/aspeed_adc.c
> +++ b/drivers/iio/adc/aspeed_adc.c
> @@ -201,6 +201,8 @@ static int aspeed_adc_set_trim_data(struct iio_dev *indio_dev)
>  				((scu_otp) &
>  				 (data->model_data->trim_locate->field)) >>
>  				__ffs(data->model_data->trim_locate->field);
> +			if (!trimming_val)
> +				trimming_val = 0x8;
>  		}
>  		dev_dbg(data->dev,
>  			"trimming val = %d, offset = %08x, fields = %08x\n",
> @@ -562,12 +564,9 @@ static int aspeed_adc_probe(struct platform_device *pdev)
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

