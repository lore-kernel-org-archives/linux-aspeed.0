From: Pratyush Yadav <p.yadav@ti.com>
Date: Tue, 7 Jun 2022 14:58:56 +0530
Subject: [PATCH 02/14] mtd: spi-nor: aspeed-smc: Make
 aspeed_smc_unregister() return void
In-Reply-To: <20220603210758.148493-3-u.kleine-koenig@pengutronix.de>
References: <20220603210758.148493-1-u.kleine-koenig@pengutronix.de>
 <20220603210758.148493-3-u.kleine-koenig@pengutronix.de>
Message-ID: <20220607092856.jh7jj4snlobx2kae@ti.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Uwe,

On 03/06/22 11:07PM, Uwe Kleine-K?nig wrote:
> The function returns zero unconditionally, so simplify to make it
> obvious there is no error to handle in the callers.
> 
> This is a preparation for making platform remove callbacks return void.

Cedric recently ported the driver to SPI MEM and it has now hit the 
linux-next tree [0]. This driver is planned to be removed. Can you 
please check if the new driver has this issue, and fix it there?

[0] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit?id=9c63b846e6df43e5b3d31263f7db545f32deeda3

> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/mtd/spi-nor/controllers/aspeed-smc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/controllers/aspeed-smc.c b/drivers/mtd/spi-nor/controllers/aspeed-smc.c
> index acfe010f9dd7..bd149104533a 100644
> --- a/drivers/mtd/spi-nor/controllers/aspeed-smc.c
> +++ b/drivers/mtd/spi-nor/controllers/aspeed-smc.c
> @@ -399,7 +399,7 @@ static ssize_t aspeed_smc_write_user(struct spi_nor *nor, loff_t to,
>  	return len;
>  }
>  
> -static int aspeed_smc_unregister(struct aspeed_smc_controller *controller)
> +static void aspeed_smc_unregister(struct aspeed_smc_controller *controller)
>  {
>  	struct aspeed_smc_chip *chip;
>  	int n;
> @@ -409,13 +409,13 @@ static int aspeed_smc_unregister(struct aspeed_smc_controller *controller)
>  		if (chip)
>  			mtd_device_unregister(&chip->nor.mtd);
>  	}
> -
> -	return 0;
>  }
>  
>  static int aspeed_smc_remove(struct platform_device *dev)
>  {
> -	return aspeed_smc_unregister(platform_get_drvdata(dev));
> +	aspeed_smc_unregister(platform_get_drvdata(dev));
> +
> +	return 0;
>  }
>  
>  static const struct of_device_id aspeed_smc_matches[] = {
> -- 
> 2.36.1
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
