From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Fri, 17 Sep 2021 01:12:13 +0000
Subject: [v6 07/11] iio: adc: aspeed: Fix the calculate error of clock.
In-Reply-To: <20210913075337.19991-8-billy_tsai@aspeedtech.com>
References: <20210913075337.19991-1-billy_tsai@aspeedtech.com>
 <20210913075337.19991-8-billy_tsai@aspeedtech.com>
Message-ID: <1A7A8472-1AAA-4F51-A9CF-08BF1837F9EB@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 2021/9/13, 3:51 PM, "Billy Tsai" <billy_tsai@aspeedtech.com> wrote:

    > The ADC clock formula is
    > ast2400/2500:
    > ADC clock period = PCLK * 2 * (ADC0C[31:17] + 1) * (ADC0C[9:0] + 1)
    > ast2600:
    > ADC clock period = PCLK * 2 * (ADC0C[15:0] + 1)
    > They all have one fixed divided 2 and the legacy driver didn't handle it.
    > This patch register the fixed factory clock device as the parent of ADC
    > clock scaler to fix this issue.

    > Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
    > ---
    >  drivers/iio/adc/aspeed_adc.c | 27 +++++++++++++++++++++++++++
    >  1 file changed, 27 insertions(+)

    > diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
    > index 3ec4e1a2ddd3..262b5f80c728 100644
    > --- a/drivers/iio/adc/aspeed_adc.c
    > +++ b/drivers/iio/adc/aspeed_adc.c
    > @@ -4,6 +4,12 @@
    >   *
    >   * Copyright (C) 2017 Google, Inc.
    >   * Copyright (C) 2021 Aspeed Technology Inc.
    > + *
    > + * ADC clock formula:
    > + * Ast2400/Ast2500:
    > + * clock period = period of PCLK * 2 * (ADC0C[31:17] + 1) * (ADC0C[9:0] + 1)
    > + * Ast2600:
    > + * clock period = period of PCLK * 2 * (ADC0C[15:0] + 1)
    >   */

    >  #include <linux/clk.h>
    > @@ -85,6 +91,7 @@ struct aspeed_adc_data {
    >  	struct regulator	*regulator;
    >  	void __iomem		*base;
    >  	spinlock_t		clk_lock;
    > +	struct clk_hw		*fixed_div_clk;
    >  	struct clk_hw		*clk_prescaler;
    >  	struct clk_hw		*clk_scaler;
    >  	struct reset_control	*rst;
    > @@ -197,6 +204,13 @@ static const struct iio_info aspeed_adc_iio_info = {
    >  	.debugfs_reg_access = aspeed_adc_reg_access,
    >  };
 
    > +static void aspeed_adc_unregister_fixed_divider(void *data)
    > +{
    > +	struct clk_hw *clk = data;
    > +
    > +	clk_hw_unregister_fixed_factor(clk);
    > +}
    > +
    >  static void aspeed_adc_reset_assert(void *data)
    >  {
    >  	struct reset_control *rst = data;
    > @@ -321,6 +335,19 @@ static int aspeed_adc_probe(struct platform_device *pdev)
    >  	spin_lock_init(&data->clk_lock);
    >  	snprintf(clk_parent_name, ARRAY_SIZE(clk_parent_name), "%s",
    >  		 of_clk_get_parent_name(pdev->dev.of_node, 0));
    > +	snprintf(clk_name, ARRAY_SIZE(clk_name), "%s-fixed-div",
    > +		 data->model_data->model_name);
    > +	data->fixed_div_clk = clk_hw_register_fixed_factor(
    > +		&pdev->dev, clk_name, clk_parent_name, 0, 1, 2);
    > +	if (IS_ERR(data->fixed_div_clk))
    > +		return PTR_ERR(data->fixed_div_clk);
    > +
    > +	ret = devm_add_action_or_reset(data->dev,
    > +				       aspeed_adc_unregister_fixed_divider,
    > +				       data->clk_prescaler);

I found that the parameter aspeed_adc_unregister_fixed_divider is wrong.
I will send patch v7 after the other patches are reviewed.

Thanks

    > +	if (ret)
    > +		return ret;
    > +	snprintf(clk_parent_name, ARRAY_SIZE(clk_parent_name), clk_name);

    >  	if (data->model_data->need_prescaler) {
    >  		snprintf(clk_name, ARRAY_SIZE(clk_name), "%s-prescaler",
    > -- 
    > 2.25.1

