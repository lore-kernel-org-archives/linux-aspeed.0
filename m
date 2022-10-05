From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Date: Wed, 5 Oct 2022 08:28:56 +0000
Subject: [PATCH] spi: aspeed: Fix typo in mode_bits field for AST2600
 platform
In-Reply-To: <20221005080104.175769-1-chin-ting_kuo@aspeedtech.com>
References: <20221005080104.175769-1-chin-ting_kuo@aspeedtech.com>
Message-ID: <SG2PR06MB27941000292C6BF5BE7575F8B25D9@SG2PR06MB2794.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi All,

> -----Original Message-----
> From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> Sent: Wednesday, October 5, 2022 4:01 PM
> Subject: [PATCH] spi: aspeed: Fix typo in mode_bits field for AST2600 platform
> 
> Both quad SPI TX and RX modes can be supported on AST2600.
> Correct typo in mode_bits field in both ast2600_fmc_data ast2600_spi_data
> structs.

A missing "and" in "both ast2600_fmc_data ast2600_spi_data structs" in the commit message.
It will be updated in the next version later.


Chin-Ting

> 
> Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> ---
>  drivers/spi/spi-aspeed-smc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c index
> a334e89add86..33cefcf18392 100644
> --- a/drivers/spi/spi-aspeed-smc.c
> +++ b/drivers/spi/spi-aspeed-smc.c
> @@ -1163,7 +1163,7 @@ static const struct aspeed_spi_data
> ast2500_spi_data = {  static const struct aspeed_spi_data ast2600_fmc_data
> = {
>  	.max_cs	       = 3,
>  	.hastype       = false,
> -	.mode_bits     = SPI_RX_QUAD | SPI_RX_QUAD,
> +	.mode_bits     = SPI_RX_QUAD | SPI_TX_QUAD,
>  	.we0	       = 16,
>  	.ctl0	       = CE0_CTRL_REG,
>  	.timing	       = CE0_TIMING_COMPENSATION_REG,
> @@ -1178,7 +1178,7 @@ static const struct aspeed_spi_data
> ast2600_fmc_data = {  static const struct aspeed_spi_data ast2600_spi_data
> = {
>  	.max_cs	       = 2,
>  	.hastype       = false,
> -	.mode_bits     = SPI_RX_QUAD | SPI_RX_QUAD,
> +	.mode_bits     = SPI_RX_QUAD | SPI_TX_QUAD,
>  	.we0	       = 16,
>  	.ctl0	       = CE0_CTRL_REG,
>  	.timing	       = CE0_TIMING_COMPENSATION_REG,
> --
> 2.25.1

