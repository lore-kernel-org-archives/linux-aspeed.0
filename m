From: Joel Stanley <joel@jms.id.au>
Date: Wed, 2 Mar 2022 22:16:35 +0000
Subject: [PATCH v2 01/10] mtd: spi-nor: aspeed: Rename Kconfig option
In-Reply-To: <20220302173114.927476-2-clg@kaod.org>
References: <20220302173114.927476-1-clg@kaod.org>
 <20220302173114.927476-2-clg@kaod.org>
Message-ID: <CACPK8XcQfC6qfMDLzzLeK5BKmBnrspruvruJ9xGdydZgWefVOw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 2 Mar 2022 at 17:31, C?dric Le Goater <clg@kaod.org> wrote:
>
> To prepare transition to the new Aspeed SMC SPI controller driver using
> the spi-mem interface, change the kernel CONFIG option of the current
> driver to reflect that the implementation uses the MTD SPI-NOR interface.
> Once the new driver is sufficiently exposed, we should remove the old one.
>
> Signed-off-by: C?dric Le Goater <clg@kaod.org>

As the maintianer of the aspeed systems and the openbmc kernel, I
think this makes the most sense.

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  drivers/mtd/spi-nor/controllers/Kconfig  | 2 +-
>  drivers/mtd/spi-nor/controllers/Makefile | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mtd/spi-nor/controllers/Kconfig b/drivers/mtd/spi-nor/controllers/Kconfig
> index 5c0e0ec2e6d1..876a47042fec 100644
> --- a/drivers/mtd/spi-nor/controllers/Kconfig
> +++ b/drivers/mtd/spi-nor/controllers/Kconfig
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -config SPI_ASPEED_SMC
> +config SPI_ASPEED_SMC_MTD_SPI_NOR
>         tristate "Aspeed flash controllers in SPI mode"
>         depends on ARCH_ASPEED || COMPILE_TEST
>         depends on HAS_IOMEM && OF
> diff --git a/drivers/mtd/spi-nor/controllers/Makefile b/drivers/mtd/spi-nor/controllers/Makefile
> index e7abba491d98..1e28297fb1e8 100644
> --- a/drivers/mtd/spi-nor/controllers/Makefile
> +++ b/drivers/mtd/spi-nor/controllers/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> -obj-$(CONFIG_SPI_ASPEED_SMC)   += aspeed-smc.o
> +obj-$(CONFIG_SPI_ASPEED_SMC_MTD_SPI_NOR)       += aspeed-smc.o
>  obj-$(CONFIG_SPI_HISI_SFC)     += hisi-sfc.o
>  obj-$(CONFIG_SPI_NXP_SPIFI)    += nxp-spifi.o
>  obj-$(CONFIG_SPI_INTEL_SPI)    += intel-spi.o
> --
> 2.34.1
>
