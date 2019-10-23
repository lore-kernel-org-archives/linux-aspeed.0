From: Tudor.Ambarus@microchip.com <Tudor.Ambarus@microchip.com>
Date: Wed, 23 Oct 2019 21:24:57 +0000
Subject: [PATCH v2 02/22] mtd: spi-nor: Introduce 'struct
 spi_nor_controller_ops'
In-Reply-To: <20190924074533.6618-3-tudor.ambarus@microchip.com>
References: <20190924074533.6618-1-tudor.ambarus@microchip.com>
 <20190924074533.6618-3-tudor.ambarus@microchip.com>
Message-ID: <18ad9382-b081-9945-f981-5bf5ba1cde56@microchip.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 09/24/2019 10:45 AM, Tudor Ambarus - M18064 wrote:
> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> Move all SPI NOR controller driver specific ops in a dedicated
> structure. 'struct spi_nor' becomes lighter.
> 
> Use size_t for lengths in 'int (*write_reg)()' and 'int (*read_reg)()'.
> Rename wite/read_buf to buf, the name of the functions are
> suggestive enough. Constify buf in int (*write_reg). Comply with these
> changes in the SPI NOR controller drivers.
> 
> Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  drivers/mtd/spi-nor/aspeed-smc.c      | 23 ++++++-----
>  drivers/mtd/spi-nor/cadence-quadspi.c | 39 ++++++++++--------
>  drivers/mtd/spi-nor/hisi-sfc.c        | 22 +++++-----
>  drivers/mtd/spi-nor/intel-spi.c       | 24 ++++++-----
>  drivers/mtd/spi-nor/mtk-quadspi.c     | 25 +++++++-----
>  drivers/mtd/spi-nor/nxp-spifi.c       | 23 +++++++----
>  drivers/mtd/spi-nor/spi-nor.c         | 76 ++++++++++++++++++++---------------
>  include/linux/mtd/spi-nor.h           | 51 +++++++++++++----------
>  8 files changed, 166 insertions(+), 117 deletions(-)

Applied to spi-nor/next.
