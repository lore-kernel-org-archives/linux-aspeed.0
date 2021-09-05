From: Jonathan Cameron <jic23@kernel.org>
Date: Sun, 5 Sep 2021 15:25:01 +0100
Subject: [v5 01/15] iio: adc: aspeed: set driver data when adc probe.
In-Reply-To: <20210831071458.2334-2-billy_tsai@aspeedtech.com>
References: <20210831071458.2334-1-billy_tsai@aspeedtech.com>
 <20210831071458.2334-2-billy_tsai@aspeedtech.com>
Message-ID: <20210905152501.2c45d43a@jic23-huawei>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 31 Aug 2021 15:14:44 +0800
Billy Tsai <billy_tsai@aspeedtech.com> wrote:

> Fix the issue when adc remove will get the null driver data.
> 
> Fixed: commit 573803234e72 ("iio: Aspeed ADC")
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
Thanks Billy

Applied to the fixes-togreg branch of iio.git and marked for stable.

Jonathan

> ---
>  drivers/iio/adc/aspeed_adc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
> index 19efaa41bc34..34ec0c28b2df 100644
> --- a/drivers/iio/adc/aspeed_adc.c
> +++ b/drivers/iio/adc/aspeed_adc.c
> @@ -183,6 +183,7 @@ static int aspeed_adc_probe(struct platform_device *pdev)
>  
>  	data = iio_priv(indio_dev);
>  	data->dev = &pdev->dev;
> +	platform_set_drvdata(pdev, indio_dev);
>  
>  	data->base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(data->base))

