From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Date: Tue, 22 Aug 2023 16:55:24 +0100
Subject: [PATCH -next 02/25] spi: armada-3700: Use helper function
 devm_clk_get_prepared()
In-Reply-To: <20230822131237.1022815-3-lizetao1@huawei.com>
References: <20230822131237.1022815-1-lizetao1@huawei.com>
	<20230822131237.1022815-3-lizetao1@huawei.com>
Message-ID: <20230822165524.000062a8@Huawei.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


> @@ -909,10 +901,6 @@ static int a3700_spi_probe(struct platform_device *pdev)
>  
>  static void a3700_spi_remove(struct platform_device *pdev)
>  {
> -	struct spi_controller *host = platform_get_drvdata(pdev);
> -	struct a3700_spi *spi = spi_controller_get_devdata(host);
> -
> -	clk_unprepare(spi->clk);
Hi.

No point in keeping an empty remove function.  Drop the whole thing now
there is nothing to do.

Jonathan

>  }
>  
>  static struct platform_driver a3700_spi_driver = {

