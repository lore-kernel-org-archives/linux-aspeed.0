From: Jonathan Cameron <jic23@kernel.org>
Date: Sun, 27 Feb 2022 11:49:44 +0000
Subject: [PATCH v2] iio: adc: aspeed: Add divider flag to fix incorrect
 voltage reading.
In-Reply-To: <CACPK8XdsRorJvMjUMNYGAYNLGLzhYJEZSQMTk1ZywwY+SyqDbQ@mail.gmail.com>
References: <20220221012705.22008-1-billy_tsai@aspeedtech.com>
 <CACPK8XdsRorJvMjUMNYGAYNLGLzhYJEZSQMTk1ZywwY+SyqDbQ@mail.gmail.com>
Message-ID: <20220227114944.4706bea1@jic23-huawei>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 21 Feb 2022 05:45:16 +0000
Joel Stanley <joel@jms.id.au> wrote:

> On Mon, 21 Feb 2022 at 01:26, Billy Tsai <billy_tsai@aspeedtech.com> wrote:
> >
> > The formula for the ADC sampling period in ast2400/ast2500 is:
> > ADC clock period = PCLK * 2 * (ADC0C[31:17] + 1) * (ADC0C[9:0])
> > When ADC0C[9:0] is set to 0 the sampling voltage will be lower than
> > expected, because the hardware may not have enough time to
> > charge/discharge to a stable voltage. This patch use the flag
> > CLK_DIVIDER_ONE_BASED which will use the raw value read from the
> > register, with the value of zero considered invalid to conform to the
> > corrected formula.  
> 
> (to answer my own question)
> 
> ..and this is okay on the 2600, because we do not set need_prescaler =
> true on that platform.
> 
> Reviewed-by: Joel Stanley <joel@jms.id.au>

Applied to the fixes-togreg branch of iio.git.

Depending on how timing works out in the coming week I might just pull
all the fixes in for the next merge window rather than doing a separate
pull request.

Thanks,

Jonathan

> 
> >
> > Fixes: 573803234e72 ("iio: Aspeed ADC")
> > Reported-by: Konstantin Klubnichkin <kitsok@yandex-team.ru>
> > Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> > ---
> >  drivers/iio/adc/aspeed_adc.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
> > index a957cad1bfab..ffae64f39221 100644
> > --- a/drivers/iio/adc/aspeed_adc.c
> > +++ b/drivers/iio/adc/aspeed_adc.c
> > @@ -539,7 +539,9 @@ static int aspeed_adc_probe(struct platform_device *pdev)
> >         data->clk_scaler = devm_clk_hw_register_divider(
> >                 &pdev->dev, clk_name, clk_parent_name, scaler_flags,
> >                 data->base + ASPEED_REG_CLOCK_CONTROL, 0,
> > -               data->model_data->scaler_bit_width, 0, &data->clk_lock);
> > +               data->model_data->scaler_bit_width,
> > +               data->model_data->need_prescaler ? CLK_DIVIDER_ONE_BASED : 0,
> > +               &data->clk_lock);
> >         if (IS_ERR(data->clk_scaler))
> >                 return PTR_ERR(data->clk_scaler);
> >
> > --
> > 2.25.1
> >  

