From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Date: Tue, 22 Aug 2023 17:14:14 +0100
Subject: [PATCH -next 24/25] spi: spl022: Use helper function
 devm_clk_get_enabled()
In-Reply-To: <20230822131237.1022815-25-lizetao1@huawei.com>
References: <20230822131237.1022815-1-lizetao1@huawei.com>
	<20230822131237.1022815-25-lizetao1@huawei.com>
Message-ID: <20230822171414.00003a69@Huawei.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 22 Aug 2023 21:12:36 +0800
Li Zetao <lizetao1@huawei.com> wrote:

> Since commit 7ef9651e9792 ("clk: Provide new devm_clk helpers for prepared
> and enabled clocks"), devm_clk_get() and clk_prepare_enable() can now be
> replaced by devm_clk_get_enabled() when driver enables (and possibly
> prepares) the clocks for the whole lifetime of the device. Moreover, it is
> no longer necessary to unprepare and disable the clocks explicitly.
> Moreover, the label "err_no_clk_en" is no used, drop it for clean code.
> 
> Signed-off-by: Li Zetao <lizetao1@huawei.com>
Hi.

There is some odd formatting in the existing file, but cleaning that up
should probably be a separate patch.

Thanks,

Jonathan

> ---
>  drivers/spi/spi-pl022.c | 21 ++++++---------------
>  1 file changed, 6 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
> index 1af75eff26b6..468a7fea9091 100644
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
> @@ -2236,16 +2230,14 @@ static int pl022_probe(struct amba_device *adev, const struct amba_id *id)
>  
>  	return 0;
>  
> - err_spi_register:
> +err_spi_register:
>  	if (platform_info->enable_dma)
>  		pl022_dma_remove(pl022);
> - err_no_irq:
> -	clk_disable_unprepare(pl022->clk);
> - err_no_clk_en:
> - err_no_clk:
> - err_no_ioremap:
> +err_no_irq:
> +err_no_clk:
> +err_no_ioremap:
>  	amba_release_regions(adev);
> - err_no_ioregion:
> +err_no_ioregion:
>  	spi_master_put(master);
>  	return status;
>  }
> @@ -2268,7 +2260,6 @@ pl022_remove(struct amba_device *adev)
>  	if (pl022->master_info->enable_dma)
>  		pl022_dma_remove(pl022);
>  
> -	clk_disable_unprepare(pl022->clk);
>  	amba_release_regions(adev);
>  	tasklet_disable(&pl022->pump_transfers);
>  }

