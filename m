From: Tudor.Ambarus@microchip.com <Tudor.Ambarus@microchip.com>
Date: Wed, 23 Oct 2019 21:25:36 +0000
Subject: [PATCH v2 03/22] mtd: spi-nor: cadence-quadspi: Fix
 cqspi_command_read() definition
In-Reply-To: <20190924074533.6618-4-tudor.ambarus@microchip.com>
References: <20190924074533.6618-1-tudor.ambarus@microchip.com>
 <20190924074533.6618-4-tudor.ambarus@microchip.com>
Message-ID: <fd618129-2844-290a-64a2-b68e7d03ee1f@microchip.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 09/24/2019 10:45 AM, Tudor Ambarus - M18064 wrote:
> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> n_tx was never used, drop it. Replace 'const u8 *txbuf' with 'u8 opcode',
> to comply with the SPI NOR int (*read_reg)() method. The 'const'
> qualifier has no meaning for parameters passed by value, drop it.
> Going furher, the opcode was passed to cqspi_calc_rdreg() and never used,
> drop it.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  drivers/mtd/spi-nor/cadence-quadspi.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)

Applied to spi-nor/next.
