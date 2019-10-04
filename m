From: Cédric Le Goater <clg@kaod.org>
Date: Fri, 4 Oct 2019 18:23:37 +0200
Subject: [PATCH 06/16] mtd: spi-nor: fix options for mx66l51235f
In-Reply-To: <20191004115919.20788-7-clg@kaod.org>
References: <20191004115919.20788-1-clg@kaod.org>
 <20191004115919.20788-7-clg@kaod.org>
Message-ID: <f3be7794-f157-5872-b540-6474c516beb4@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 04/10/2019 13:59, C?dric Le Goater wrote:
> From: Alexander Soldatov <a.soldatov@yadro.com>
> 
> Currently in driver spi-nor there is a line for mx66l51235l.
> According to Macronix site there is no such part number.
> The chip detected as such is actually mx66l51235f.
> 
> According to the datasheet for mx66l51235f,
> "The device default is in 24-bit address mode" (section 9-10).
> Hence we removed SPI_NOR_4B_OPCODES option with this commit.

This patch has been discussed already on the list and it was decided 
that it should not be merged. Please drop it. 

Sorry for the noise,

C.  

> OpenBMC-Staging-Count: 7
> Fixes: d342b6a973af ("mtd: spi-nor: enable 4B opcodes for mx66l51235l")
> Cc: Alexander Amelkin <a.amelkin@yadro.com>
> Signed-off-by: Alexander Soldatov <a.soldatov@yadro.com>
> Reviewed-by: C?dric Le Goater <clg@kaod.org>
> Reviewed-by: Lei YU <mine260309@gmail.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> Signed-off-by: C?dric Le Goater <clg@kaod.org>
> ---
>  drivers/mtd/spi-nor/spi-nor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 1d8621d43160..b1165673cd93 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -2294,7 +2294,7 @@ static const struct flash_info spi_nor_ids[] = {
>  	{ "mx25v8035f",  INFO(0xc22314, 0, 64 * 1024,  16,
>  			 SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>  	{ "mx25l25655e", INFO(0xc22619, 0, 64 * 1024, 512, 0) },
> -	{ "mx66l51235l", INFO(0xc2201a, 0, 64 * 1024, 1024, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
> +	{ "mx66l51235f", INFO(0xc2201a, 0, 64 * 1024, 1024, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>  	{ "mx66u51235f", INFO(0xc2253a, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
>  	{ "mx66l1g45g",  INFO(0xc2201b, 0, 64 * 1024, 2048, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>  	{ "mx66l1g55g",  INFO(0xc2261b, 0, 64 * 1024, 2048, SPI_NOR_QUAD_READ) },
> 

