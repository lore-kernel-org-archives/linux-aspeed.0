From: Cédric Le Goater <clg@kaod.org>
Date: Fri, 23 Sep 2022 11:51:41 +0200
Subject: [PATCH -next] spi: aspeed: Remove redundant dev_err call
In-Reply-To: <20220923101632.19170-1-shangxiaojing@huawei.com>
References: <20220923101632.19170-1-shangxiaojing@huawei.com>
Message-ID: <a51f9a8a-23aa-3795-3fce-963f2888b73c@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 9/23/22 12:16, Shang XiaoJing wrote:
> devm_ioremap_resource() prints error message in itself. Remove the
> dev_err call to avoid redundant error message.
> 
> Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>

Reviewed-by: C?dric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>   drivers/spi/spi-aspeed-smc.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
> index 3e891bf22470..a334e89add86 100644
> --- a/drivers/spi/spi-aspeed-smc.c
> +++ b/drivers/spi/spi-aspeed-smc.c
> @@ -736,10 +736,8 @@ static int aspeed_spi_probe(struct platform_device *pdev)
>   
>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>   	aspi->regs = devm_ioremap_resource(dev, res);
> -	if (IS_ERR(aspi->regs)) {
> -		dev_err(dev, "missing AHB register window\n");
> +	if (IS_ERR(aspi->regs))
>   		return PTR_ERR(aspi->regs);
> -	}
>   
>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>   	aspi->ahb_base = devm_ioremap_resource(dev, res);

