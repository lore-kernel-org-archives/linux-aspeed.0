From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Date: Wed, 23 Aug 2023 18:16:15 +0100
Subject: [PATCH -next v2 24/25] spi: spl022: Use helper function
 devm_clk_get_enabled()
In-Reply-To: <20230823133938.1359106-25-lizetao1@huawei.com>
References: <20230822131237.1022815-1-lizetao1@huawei.com>
	<20230823133938.1359106-1-lizetao1@huawei.com>
	<20230823133938.1359106-25-lizetao1@huawei.com>
Message-ID: <20230823181615.00007e9f@Huawei.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 23 Aug 2023 21:39:37 +0800
Li Zetao <lizetao1@huawei.com> wrote:

> Since commit 7ef9651e9792 ("clk: Provide new devm_clk helpers for prepared
> and enabled clocks"), devm_clk_get() and clk_prepare_enable() can now be
> replaced by devm_clk_get_enabled() when driver enables (and possibly
> prepares) the clocks for the whole lifetime of the device. Moreover, it is
> no longer necessary to unprepare and disable the clocks explicitly.
> Moreover, the label "err_no_clk_en" is no used, drop it for clean code.
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Li Zetao <lizetao1@huawei.com>
FWIW
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

If you want to follow up with a patch fixing that odd formatting (on it's own)
then that would be great.

Jonathan

> ---
> v1 -> v2: Delete the modification of odd formatting.
> 
>  drivers/spi/spi-pl022.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
> index bb347b6bb6f3..d1b6110b38fc 100644
> --- a/drivers/spi/spi-pl022.c
> +++ b/drivers/spi/spi-pl022.c
> @@ -2168,19 +2168,13 @@ static int pl022_probe(struct amba_device *adev, const struct amba_id *id)
>  	dev_info(&adev->dev, "mapped registers from %pa to %p\n",
>  		&adev->res.start, pl022->virtbase);
>  
> -	pl022->clk = devm_clk_get(&adev->dev, NULL);
> +	pl022->clk = devm_clk_get_enabled(&adev->dev, NULL);
>  	if (IS_ERR(pl022->clk)) {
>  		status = PTR_ERR(pl022->clk);
>  		dev_err(&adev->dev, "could not retrieve SSP/SPI bus clock\n");
>  		goto err_no_clk;
>  	}
>  
> -	status = clk_prepare_enable(pl022->clk);
> -	if (status) {
> -		dev_err(&adev->dev, "could not enable SSP/SPI bus clock\n");
> -		goto err_no_clk_en;
> -	}
> -
>  	/* Initialize transfer pump */
>  	tasklet_init(&pl022->pump_transfers, pump_transfers,
>  		     (unsigned long)pl022);
> @@ -2240,8 +2234,6 @@ static int pl022_probe(struct amba_device *adev, const struct amba_id *id)
>  	if (platform_info->enable_dma)
>  		pl022_dma_remove(pl022);
>   err_no_irq:
> -	clk_disable_unprepare(pl022->clk);
> - err_no_clk_en:
>   err_no_clk:
>   err_no_ioremap:
>  	amba_release_regions(adev);
> @@ -2268,7 +2260,6 @@ pl022_remove(struct amba_device *adev)
>  	if (pl022->host_info->enable_dma)
>  		pl022_dma_remove(pl022);
>  
> -	clk_disable_unprepare(pl022->clk);
>  	amba_release_regions(adev);
>  	tasklet_disable(&pl022->pump_transfers);
>  }

