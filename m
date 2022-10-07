From: Cédric Le Goater <clg@kaod.org>
Date: Fri, 7 Oct 2022 22:29:59 +0200
Subject: [v2] spi: aspeed: Fix typo in mode_bits field for AST2600
 platform
In-Reply-To: <20221005083209.222272-1-chin-ting_kuo@aspeedtech.com>
References: <20221005083209.222272-1-chin-ting_kuo@aspeedtech.com>
Message-ID: <c1bfbadf-0989-329b-308e-1a3c79ca2caa@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 10/5/22 10:32, Chin-Ting Kuo wrote:
> Both quad SPI TX and RX modes can be supported on AST2600.
> Correct typo in mode_bits field in both ast2600_fmc_data
> and ast2600_spi_data structs.
> 
> Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>

Reviewed-by: C?dric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>   drivers/spi/spi-aspeed-smc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
> index a334e89add86..33cefcf18392 100644
> --- a/drivers/spi/spi-aspeed-smc.c
> +++ b/drivers/spi/spi-aspeed-smc.c
> @@ -1163,7 +1163,7 @@ static const struct aspeed_spi_data ast2500_spi_data = {
>   static const struct aspeed_spi_data ast2600_fmc_data = {
>   	.max_cs	       = 3,
>   	.hastype       = false,
> -	.mode_bits     = SPI_RX_QUAD | SPI_RX_QUAD,
> +	.mode_bits     = SPI_RX_QUAD | SPI_TX_QUAD,
>   	.we0	       = 16,
>   	.ctl0	       = CE0_CTRL_REG,
>   	.timing	       = CE0_TIMING_COMPENSATION_REG,
> @@ -1178,7 +1178,7 @@ static const struct aspeed_spi_data ast2600_fmc_data = {
>   static const struct aspeed_spi_data ast2600_spi_data = {
>   	.max_cs	       = 2,
>   	.hastype       = false,
> -	.mode_bits     = SPI_RX_QUAD | SPI_RX_QUAD,
> +	.mode_bits     = SPI_RX_QUAD | SPI_TX_QUAD,
>   	.we0	       = 16,
>   	.ctl0	       = CE0_CTRL_REG,
>   	.timing	       = CE0_TIMING_COMPENSATION_REG,

