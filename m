From: Serge Semin <fancer.lancer@gmail.com>
Date: Tue, 22 Aug 2023 16:48:53 +0300
Subject: [PATCH -next 11/25] spi: dw-bt1: Use helper function
 devm_clk_get_enabled()
In-Reply-To: <20230822131237.1022815-12-lizetao1@huawei.com>
References: <20230822131237.1022815-1-lizetao1@huawei.com>
 <20230822131237.1022815-12-lizetao1@huawei.com>
Message-ID: <i2bjbilyzg22xas2zpuumnsb4rolv2tkb4vhx2kyryizf2775b@764f3gk56ttn>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Aug 22, 2023 at 09:12:23PM +0800, Li Zetao wrote:
> Since commit 7ef9651e9792 ("clk: Provide new devm_clk helpers for prepared
> and enabled clocks"), devm_clk_get() and clk_prepare_enable() can now be
> replaced by devm_clk_get_enabled() when driver enables (and possibly
> prepares) the clocks for the whole lifetime of the device. Moreover, it is
> no longer necessary to unprepare and disable the clocks explicitly.
> 
> Signed-off-by: Li Zetao <lizetao1@huawei.com>

LGTM. Thanks!
Acked-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> ---
>  drivers/spi/spi-dw-bt1.c | 23 +++++------------------
>  1 file changed, 5 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/spi/spi-dw-bt1.c b/drivers/spi/spi-dw-bt1.c
> index 5e1c01822967..5391bcac305c 100644
> --- a/drivers/spi/spi-dw-bt1.c
> +++ b/drivers/spi/spi-dw-bt1.c
> @@ -269,43 +269,32 @@ static int dw_spi_bt1_probe(struct platform_device *pdev)
>  
>  	dws->paddr = mem->start;
>  
> -	dwsbt1->clk = devm_clk_get(&pdev->dev, NULL);
> +	dwsbt1->clk = devm_clk_get_enabled(&pdev->dev, NULL);
>  	if (IS_ERR(dwsbt1->clk))
>  		return PTR_ERR(dwsbt1->clk);
>  
> -	ret = clk_prepare_enable(dwsbt1->clk);
> -	if (ret)
> -		return ret;
> -
>  	dws->bus_num = pdev->id;
>  	dws->reg_io_width = 4;
>  	dws->max_freq = clk_get_rate(dwsbt1->clk);
> -	if (!dws->max_freq) {
> -		ret = -EINVAL;
> -		goto err_disable_clk;
> -	}
> +	if (!dws->max_freq)
> +		return -EINVAL;
>  
>  	init_func = device_get_match_data(&pdev->dev);
>  	ret = init_func(pdev, dwsbt1);
>  	if (ret)
> -		goto err_disable_clk;
> +		return ret;
>  
>  	pm_runtime_enable(&pdev->dev);
>  
>  	ret = dw_spi_add_host(&pdev->dev, dws);
>  	if (ret) {
>  		pm_runtime_disable(&pdev->dev);
> -		goto err_disable_clk;
> +		return ret;
>  	}
>  
>  	platform_set_drvdata(pdev, dwsbt1);
>  
>  	return 0;
> -
> -err_disable_clk:
> -	clk_disable_unprepare(dwsbt1->clk);
> -
> -	return ret;
>  }
>  
>  static void dw_spi_bt1_remove(struct platform_device *pdev)
> @@ -315,8 +304,6 @@ static void dw_spi_bt1_remove(struct platform_device *pdev)
>  	dw_spi_remove_host(&dwsbt1->dws);
>  
>  	pm_runtime_disable(&pdev->dev);
> -
> -	clk_disable_unprepare(dwsbt1->clk);
>  }
>  
>  static const struct of_device_id dw_spi_bt1_of_match[] = {
> -- 
> 2.34.1
> 
