From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Mon, 21 Feb 2022 00:47:15 +0000
Subject: [PATCH] iio: adc: aspeed: Add divider flag to fix incorrect
 voltage reading.
In-Reply-To: <20220219160002.46e301b8@jic23-huawei>
References: <20220218085708.8194-1-billy_tsai@aspeedtech.com>
 <20220219160002.46e301b8@jic23-huawei>
Message-ID: <E53FFC04-41C9-446C-8D11-7A1937D8674D@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Jonathan,

On 2022/2/19, 11:53 PM, "Jonathan Cameron" <jic23@kernel.org> wrote:

    On Fri, 18 Feb 2022 16:57:08 +0800
    Billy Tsai <billy_tsai@aspeedtech.com> wrote:

    >   > The formula for the ADC sampling period in ast2400/ast2500 is:
    >   > ADC clock period = PCLK * 2 * (ADC0C[31:17] + 1) * (ADC0C[9:0])
    >   > When ADC0C[9:0] is set to 0 the sampling voltage will be lower than
    >   > expected, because the hardware may not have enough time to
    >   > charge/discharge to a stable voltage.
    >   > 
    >   > Reported-by: Konstantin Klubnichkin <kitsok@yandex-team.ru>
    >   > Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
    >   Hi Billy,
   
    >   Fixes tag?
   
    >   Also, would be good to call out in the patch description that
    >   CLK_DIVIDER_ONE_BASED rules at 0 as a valid value and hence
    >   avoids the ADC0C[9:0] value of 0 that is causing problems.
   
    >   That may be obvious to people who make frequent use of clk dividers
    >   but it's not locally obvious when looking at this patch.
   
    >   Otherwise looks good to me.
   
    >   Thanks,
   
    >   Jonathan

I will add fixes tag and add more description about the CLK_DIVIDER_ONE_BASED flag in v2.

Thanks,

Billy

    >   > ---
    >   >  drivers/iio/adc/aspeed_adc.c | 4 +++-
    >   >  1 file changed, 3 insertions(+), 1 deletion(-)
    >   > 
    >   > diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
    >   > index a957cad1bfab..ffae64f39221 100644
    >   > --- a/drivers/iio/adc/aspeed_adc.c
    >   > +++ b/drivers/iio/adc/aspeed_adc.c
    >   > @@ -539,7 +539,9 @@ static int aspeed_adc_probe(struct platform_device *pdev)
    >   >  	data->clk_scaler = devm_clk_hw_register_divider(
    >   >  		&pdev->dev, clk_name, clk_parent_name, scaler_flags,
    >   >  		data->base + ASPEED_REG_CLOCK_CONTROL, 0,
    >   > -		data->model_data->scaler_bit_width, 0, &data->clk_lock);
    >   > +		data->model_data->scaler_bit_width,
    >   > +		data->model_data->need_prescaler ? CLK_DIVIDER_ONE_BASED : 0,
    >   > +		&data->clk_lock);
    >   >  	if (IS_ERR(data->clk_scaler))
    >   >  		return PTR_ERR(data->clk_scaler);
    >   >  


