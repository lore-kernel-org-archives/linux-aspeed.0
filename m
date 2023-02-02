From: Jernej Škrabec <jernej.skrabec@gmail.com>
Date: Thu, 02 Feb 2023 17:40:35 +0100
Subject: [PATCH v3 01/13] spi: Replace all spi->chip_select and spi->cs_gpiod
 references with function call
In-Reply-To: <20230202152258.512973-2-amit.kumar-mahapatra@amd.com>
References: <20230202152258.512973-1-amit.kumar-mahapatra@amd.com>
 <20230202152258.512973-2-amit.kumar-mahapatra@amd.com>
Message-ID: <4802797.31r3eYUQgx@jernej-laptop>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi!

Dne ?etrtek, 02. februar 2023 ob 16:22:46 CET je Amit Kumar Mahapatra 
napisal(a):
> Supporting multi-cs in spi drivers would require the chip_select & cs_gpiod
> members of struct spi_device to be an array. But changing the type of these
> members to array would break the spi driver functionality. To make the
> transition smoother introduced four new APIs to get/set the
> spi->chip_select & spi->cs_gpiod and replaced all spi->chip_select and
> spi->cs_gpiod references with get or set API calls.
> While adding multi-cs support in further patches the chip_select & cs_gpiod
> members of the spi_device structure would be converted to arrays & the
> "idx" parameter of the APIs would be used as array index i.e.,
> spi->chip_select[idx] & spi->cs_gpiod[idx] respectively.
> 
> Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
> Acked-by: Heiko Stuebner <heiko@sntech.de> # Rockchip drivers
> Reviewed-by: Michal Simek <michal.simek@amd.com>
> Reviewed-by: C?dric Le Goater <clg@kaod.org> # Aspeed driver
> Reviewed-by: Dhruva Gole <d-gole@ti.com> # SPI Cadence QSPI
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com> # spi-stm32-qspi
> Acked-by: William Zhang <william.zhang@broadcom.com> # bcm63xx-hsspi driver
> ---
>  drivers/spi/spi-altera-core.c     |  2 +-
>  drivers/spi/spi-amd.c             |  4 ++--
>  drivers/spi/spi-ar934x.c          |  2 +-
>  drivers/spi/spi-armada-3700.c     |  4 ++--
>  drivers/spi/spi-aspeed-smc.c      | 13 +++++++------
>  drivers/spi/spi-at91-usart.c      |  2 +-
>  drivers/spi/spi-ath79.c           |  4 ++--
>  drivers/spi/spi-atmel.c           | 26 +++++++++++++-------------
>  drivers/spi/spi-au1550.c          |  4 ++--
>  drivers/spi/spi-axi-spi-engine.c  |  2 +-
>  drivers/spi/spi-bcm-qspi.c        | 10 +++++-----
>  drivers/spi/spi-bcm2835.c         | 19 ++++++++++---------
>  drivers/spi/spi-bcm2835aux.c      |  4 ++--
>  drivers/spi/spi-bcm63xx-hsspi.c   | 22 +++++++++++-----------
>  drivers/spi/spi-bcm63xx.c         |  2 +-
>  drivers/spi/spi-cadence-quadspi.c |  5 +++--
>  drivers/spi/spi-cadence-xspi.c    |  4 ++--
>  drivers/spi/spi-cadence.c         |  4 ++--
>  drivers/spi/spi-cavium.c          |  8 ++++----
>  drivers/spi/spi-coldfire-qspi.c   |  8 ++++----
>  drivers/spi/spi-davinci.c         | 18 +++++++++---------
>  drivers/spi/spi-dln2.c            |  6 +++---
>  drivers/spi/spi-dw-core.c         |  2 +-
>  drivers/spi/spi-dw-mmio.c         |  4 ++--
>  drivers/spi/spi-falcon.c          |  2 +-
>  drivers/spi/spi-fsi.c             |  2 +-
>  drivers/spi/spi-fsl-dspi.c        | 16 ++++++++--------
>  drivers/spi/spi-fsl-espi.c        |  6 +++---
>  drivers/spi/spi-fsl-lpspi.c       |  2 +-
>  drivers/spi/spi-fsl-qspi.c        |  6 +++---
>  drivers/spi/spi-fsl-spi.c         |  2 +-
>  drivers/spi/spi-geni-qcom.c       |  6 +++---
>  drivers/spi/spi-gpio.c            |  4 ++--
>  drivers/spi/spi-gxp.c             |  4 ++--
>  drivers/spi/spi-hisi-sfc-v3xx.c   |  2 +-
>  drivers/spi/spi-img-spfi.c        | 14 +++++++-------
>  drivers/spi/spi-imx.c             | 30 +++++++++++++++---------------
>  drivers/spi/spi-ingenic.c         |  4 ++--
>  drivers/spi/spi-intel.c           |  2 +-
>  drivers/spi/spi-jcore.c           |  4 ++--
>  drivers/spi/spi-lantiq-ssc.c      |  6 +++---
>  drivers/spi/spi-mem.c             |  4 ++--
>  drivers/spi/spi-meson-spicc.c     |  2 +-
>  drivers/spi/spi-microchip-core.c  |  6 +++---
>  drivers/spi/spi-mpc512x-psc.c     |  8 ++++----
>  drivers/spi/spi-mpc52xx.c         |  2 +-
>  drivers/spi/spi-mt65xx.c          |  6 +++---
>  drivers/spi/spi-mt7621.c          |  2 +-
>  drivers/spi/spi-mux.c             |  8 ++++----
>  drivers/spi/spi-mxic.c            | 10 +++++-----
>  drivers/spi/spi-mxs.c             |  2 +-
>  drivers/spi/spi-npcm-fiu.c        | 20 ++++++++++----------
>  drivers/spi/spi-nxp-fspi.c        | 10 +++++-----
>  drivers/spi/spi-omap-100k.c       |  2 +-
>  drivers/spi/spi-omap-uwire.c      |  8 ++++----
>  drivers/spi/spi-omap2-mcspi.c     | 24 ++++++++++++------------
>  drivers/spi/spi-orion.c           |  4 ++--
>  drivers/spi/spi-pci1xxxx.c        |  4 ++--
>  drivers/spi/spi-pic32-sqi.c       |  2 +-
>  drivers/spi/spi-pic32.c           |  4 ++--
>  drivers/spi/spi-pl022.c           |  4 ++--
>  drivers/spi/spi-pxa2xx.c          |  6 +++---
>  drivers/spi/spi-qcom-qspi.c       |  2 +-
>  drivers/spi/spi-rb4xx.c           |  2 +-
>  drivers/spi/spi-rockchip-sfc.c    |  2 +-
>  drivers/spi/spi-rockchip.c        | 26 ++++++++++++++------------
>  drivers/spi/spi-rspi.c            | 10 +++++-----
>  drivers/spi/spi-s3c64xx.c         |  2 +-
>  drivers/spi/spi-sc18is602.c       |  4 ++--
>  drivers/spi/spi-sh-msiof.c        |  6 +++---
>  drivers/spi/spi-sh-sci.c          |  2 +-
>  drivers/spi/spi-sifive.c          |  6 +++---
>  drivers/spi/spi-sn-f-ospi.c       |  2 +-
>  drivers/spi/spi-st-ssc4.c         |  2 +-
>  drivers/spi/spi-stm32-qspi.c      | 12 ++++++------
>  drivers/spi/spi-sun4i.c           |  2 +-
>  drivers/spi/spi-sun6i.c           |  2 +-

For sun4i, sun6i:
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

>  drivers/spi/spi-synquacer.c       |  6 +++---
>  drivers/spi/spi-tegra114.c        | 28 ++++++++++++++--------------
>  drivers/spi/spi-tegra20-sflash.c  |  2 +-
>  drivers/spi/spi-tegra20-slink.c   |  6 +++---
>  drivers/spi/spi-tegra210-quad.c   |  8 ++++----
>  drivers/spi/spi-ti-qspi.c         | 16 ++++++++--------
>  drivers/spi/spi-topcliff-pch.c    |  4 ++--
>  drivers/spi/spi-wpcm-fiu.c        | 12 ++++++------
>  drivers/spi/spi-xcomm.c           |  2 +-
>  drivers/spi/spi-xilinx.c          |  6 +++---
>  drivers/spi/spi-xlp.c             |  4 ++--
>  drivers/spi/spi-zynq-qspi.c       |  2 +-
>  drivers/spi/spi-zynqmp-gqspi.c    |  2 +-
>  drivers/spi/spidev.c              |  6 +++---
>  include/trace/events/spi.h        | 10 +++++-----
>  92 files changed, 315 insertions(+), 310 deletions(-)



