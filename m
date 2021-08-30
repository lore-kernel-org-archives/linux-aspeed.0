From: Jonathan Cameron <jic23@kernel.org>
Date: Mon, 30 Aug 2021 10:52:13 +0100
Subject: [RESEND v4 12/15] iio: adc: aspeed: Add func to set sampling rate.
In-Reply-To: <FE947284-E67B-49DB-B538-3ECAD8317BD4@aspeedtech.com>
References: <20210824091243.9393-1-billy_tsai@aspeedtech.com>
 <202108250003.17P03KRU092474@twspam01.aspeedtech.com>
 <20210829163659.2f7f5974@jic23-huawei>
 <FE947284-E67B-49DB-B538-3ECAD8317BD4@aspeedtech.com>
Message-ID: <20210830105213.25ee20a2@jic23-huawei>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 30 Aug 2021 08:35:53 +0000
Billy Tsai <billy_tsai@aspeedtech.com> wrote:

> Hi Jonathan,
> 
> On 2021/8/29, 11:33 PM, "Jonathan Cameron" <jic23@kernel.org> wrote:
> 
>     On Tue, 24 Aug 2021 17:12:40 +0800
>     Billy Tsai <billy_tsai@aspeedtech.com> wrote:
> 
>     >> Add the function to set the sampling rate and keep the sampling period
>     >> for a driver used to wait the lastest value.
>     >> 
>     >> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>  
> 
>     > Why move the code as well as factoring out the setter function?
>     > I doubt it does any harm, but I'd like to understand why you did it.  
> 
>     > Jonathan  
> 
>     >> +	ret = clk_prepare_enable(data->clk_scaler->clk);
>     >> +	if (ret)
>     >> +		return ret;
>     >> +
>     >> +	ret = devm_add_action_or_reset(data->dev,
>     >> +				       aspeed_adc_clk_disable_unprepare,
>     >> +				       data->clk_scaler->clk);
>     >> +	if (ret)
>     >> +		return ret;
>     >> +
>     >> +	ret = aspeed_adc_set_sampling_rate(indio_dev, ASPEED_ADC_DEF_SAMPLING_RATE);
>     >> +	if (ret)
>     >> +		return ret;
>     >> +
>     >>  	ret = aspeed_adc_vref_config(indio_dev);
>     >>  	if (ret)
>     >>  		return ret;
>     >> @@ -413,16 +445,6 @@ static int aspeed_adc_probe(struct platform_device *pdev)
>     >>  	}
>     >>  
>     >>  	/* Start all channels in normal mode. */  
> 
>     > Why move this code up?  
> 
> Because the ADC clock is required when initializing the ADC device.
> In our system, the clock is always on. Thus, the legacy driver won't encounter any issues.
> I move the clk_prepare_enable ahead of initializing phase for making the driver probe logically closer to the hardware. 

Thanks. Please add something to the patch description to say this.

Jonathan

> 
>     >> -	ret = clk_prepare_enable(data->clk_scaler->clk);
>     >> -	if (ret)
>     >> -		return ret;
>     >> -
>     >> -	ret = devm_add_action_or_reset(data->dev,
>     >> -				       aspeed_adc_clk_disable_unprepare,
>     >> -				       data->clk_scaler->clk);
>     >> -	if (ret)
>     >> -		return ret;
>     >> -
>     >>  	adc_engine_control_reg_val =
>     >>  		readl(data->base + ASPEED_REG_ENGINE_CONTROL);
>     >>  	adc_engine_control_reg_val |=  
> 
> 
> Best Regards,
> Billy Tsai
> 

