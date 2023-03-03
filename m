From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Fri,  3 Mar 2023 18:19:14 +0100
Subject: [PATCH 00/87] spi: Convert to platform remove callback returning void
Message-ID: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

this patch series adapts the platform drivers below drivers/spi
to use the .remove_new() callback. Compared to the traditional .remove()
callback .remove_new() returns no value. This is a good thing because
the driver core doesn't (and cannot) cope for errors during remove. The
only effect of a non-zero return value in .remove() is that the driver
core emits a warning. The device is removed anyhow and an early return
from .remove() usually yields a resource leak.

By changing the remove callback to return void driver authors cannot
reasonably assume any more that there is some kind of cleanup later.

All drivers touched here returned zero unconditionally in their remove
callback, so they could all be converted trivially to .remove_new().

Note that this series depends on commit 5c5a7680e67b ("platform: Provide
a remove callback that returns no value") that is already in Linus' tree
but not yet included in a tagged version.

Best regards
Uwe

Uwe Kleine-K?nig (87):
  spi: ar934x: Convert to platform remove callback returning void
  spi: armada-3700: Convert to platform remove callback returning void
  spi: aspeed-smc: Convert to platform remove callback returning void
  spi: at91-usart: Convert to platform remove callback returning void
  spi: ath79: Convert to platform remove callback returning void
  spi: atmel: Convert to platform remove callback returning void
  spi: au1550: Convert to platform remove callback returning void
  spi: axi-spi-engine: Convert to platform remove callback returning void
  spi: bcm2835: Convert to platform remove callback returning void
  spi: bcm2835aux: Convert to platform remove callback returning void
  spi: bcm63xx-hsspi: Convert to platform remove callback returning void
  spi: bcm63xx: Convert to platform remove callback returning void
  spi: bcmbca-hsspi: Convert to platform remove callback returning void
  spi: brcmstb-qspi: Convert to platform remove callback returning void
  spi: cadence-quadspi: Convert to platform remove callback returning void
  spi: cadence: Convert to platform remove callback returning void
  spi: cavium-octeon: Convert to platform remove callback returning void
  spi: coldfire-qspi: Convert to platform remove callback returning void
  spi: davinci: Convert to platform remove callback returning void
  spi: dln2: Convert to platform remove callback returning void
  spi: dw-bt1: Convert to platform remove callback returning void
  spi: dw-mmio: Convert to platform remove callback returning void
  spi: ep93xx: Convert to platform remove callback returning void
  spi: fsl-dspi: Convert to platform remove callback returning void
  spi: fsl-espi: Convert to platform remove callback returning void
  spi: fsl-lpspi: Convert to platform remove callback returning void
  spi: fsl-qspi: Convert to platform remove callback returning void
  spi: fsl-spi: Convert to platform remove callback returning void
  spi: geni-qcom: Convert to platform remove callback returning void
  spi: hisi-kunpeng: Convert to platform remove callback returning void
  spi: img-spfi: Convert to platform remove callback returning void
  spi: iproc-qspi: Convert to platform remove callback returning void
  spi: lantiq-ssc: Convert to platform remove callback returning void
  spi: meson-spicc: Convert to platform remove callback returning void
  spi: meson-spifc: Convert to platform remove callback returning void
  spi: microchip-core-qspi: Convert to platform remove callback returning void
  spi: microchip-core: Convert to platform remove callback returning void
  spi: mpc512x-psc: Convert to platform remove callback returning void
  spi: mpc52xx-psc: Convert to platform remove callback returning void
  spi: mpc52xx: Convert to platform remove callback returning void
  spi: mtk-nor: Convert to platform remove callback returning void
  spi: mtk-snfi: Convert to platform remove callback returning void
  spi: mxic: Convert to platform remove callback returning void
  spi: mxs: Convert to platform remove callback returning void
  spi: npcm-fiu: Convert to platform remove callback returning void
  spi: npcm-pspi: Convert to platform remove callback returning void
  spi: nxp-fspi: Convert to platform remove callback returning void
  spi: oc-tiny: Convert to platform remove callback returning void
  spi: omap-uwire: Convert to platform remove callback returning void
  spi: omap2-mcspi: Convert to platform remove callback returning void
  spi: orion: Convert to platform remove callback returning void
  spi: pic32-sqi: Convert to platform remove callback returning void
  spi: pic32: Convert to platform remove callback returning void
  spi: ppc4xx: Convert to platform remove callback returning void
  spi: pxa2xx: Convert to platform remove callback returning void
  spi: qcom-qspi: Convert to platform remove callback returning void
  spi: rb4xx: Convert to platform remove callback returning void
  spi: rockchip-sfc: Convert to platform remove callback returning void
  spi: rockchip: Convert to platform remove callback returning void
  spi: rpc-if: Convert to platform remove callback returning void
  spi: rspi: Convert to platform remove callback returning void
  spi: s3c64xx: Convert to platform remove callback returning void
  spi: sh-hspi: Convert to platform remove callback returning void
  spi: sh-msiof: Convert to platform remove callback returning void
  spi: sh-sci: Convert to platform remove callback returning void
  spi: sh: Convert to platform remove callback returning void
  spi: sifive: Convert to platform remove callback returning void
  spi: slave-mt27xx: Convert to platform remove callback returning void
  spi: sn-f-ospi: Convert to platform remove callback returning void
  spi: sprd-adi: Convert to platform remove callback returning void
  spi: st-ssc4: Convert to platform remove callback returning void
  spi: stm32-qspi: Convert to platform remove callback returning void
  spi: stm32: Convert to platform remove callback returning void
  spi: sun4i: Convert to platform remove callback returning void
  spi: sun6i: Convert to platform remove callback returning void
  spi: sunplus-sp7021: Convert to platform remove callback returning void
  spi: synquacer: Convert to platform remove callback returning void
  spi: tegra114: Convert to platform remove callback returning void
  spi: tegra20-sflash: Convert to platform remove callback returning void
  spi: tegra20-slink: Convert to platform remove callback returning void
  spi: tegra210-quad: Convert to platform remove callback returning void
  spi: topcliff-pch: Convert to platform remove callback returning void
  spi: uniphier: Convert to platform remove callback returning void
  spi: xilinx: Convert to platform remove callback returning void
  spi: xtensa-xtfpga: Convert to platform remove callback returning void
  spi: zynq-qspi: Convert to platform remove callback returning void
  spi: zynqmp-gqspi: Convert to platform remove callback returning void

 drivers/spi/spi-ar934x.c              |  6 ++----
 drivers/spi/spi-armada-3700.c         |  6 ++----
 drivers/spi/spi-aspeed-smc.c          |  5 ++---
 drivers/spi/spi-at91-usart.c          |  6 ++----
 drivers/spi/spi-ath79.c               |  6 ++----
 drivers/spi/spi-atmel.c               |  6 ++----
 drivers/spi/spi-au1550.c              |  5 ++---
 drivers/spi/spi-axi-spi-engine.c      |  6 ++----
 drivers/spi/spi-bcm2835.c             | 12 +++---------
 drivers/spi/spi-bcm2835aux.c          |  6 ++----
 drivers/spi/spi-bcm63xx-hsspi.c       |  6 ++----
 drivers/spi/spi-bcm63xx.c             |  6 ++----
 drivers/spi/spi-bcmbca-hsspi.c        |  6 ++----
 drivers/spi/spi-brcmstb-qspi.c        |  6 ++----
 drivers/spi/spi-cadence-quadspi.c     |  6 ++----
 drivers/spi/spi-cadence.c             |  6 ++----
 drivers/spi/spi-cavium-octeon.c       |  6 ++----
 drivers/spi/spi-coldfire-qspi.c       |  6 ++----
 drivers/spi/spi-davinci.c             |  5 ++---
 drivers/spi/spi-dln2.c                |  6 ++----
 drivers/spi/spi-dw-bt1.c              |  6 ++----
 drivers/spi/spi-dw-mmio.c             |  6 ++----
 drivers/spi/spi-ep93xx.c              |  6 ++----
 drivers/spi/spi-fsl-dspi.c            |  6 ++----
 drivers/spi/spi-fsl-espi.c            |  6 ++----
 drivers/spi/spi-fsl-lpspi.c           |  5 ++---
 drivers/spi/spi-fsl-qspi.c            |  6 ++----
 drivers/spi/spi-fsl-spi.c             | 11 ++++-------
 drivers/spi/spi-geni-qcom.c           |  5 ++---
 drivers/spi/spi-hisi-kunpeng.c        |  6 ++----
 drivers/spi/spi-img-spfi.c            |  6 ++----
 drivers/spi/spi-iproc-qspi.c          |  6 ++----
 drivers/spi/spi-lantiq-ssc.c          |  6 ++----
 drivers/spi/spi-meson-spicc.c         |  6 ++----
 drivers/spi/spi-meson-spifc.c         |  6 ++----
 drivers/spi/spi-microchip-core-qspi.c |  6 ++----
 drivers/spi/spi-microchip-core.c      |  6 ++----
 drivers/spi/spi-mpc512x-psc.c         | 22 ++++++++--------------
 drivers/spi/spi-mpc52xx-psc.c         |  6 ++----
 drivers/spi/spi-mpc52xx.c             |  6 ++----
 drivers/spi/spi-mtk-nor.c             |  6 ++----
 drivers/spi/spi-mtk-snfi.c            |  5 ++---
 drivers/spi/spi-mxic.c                |  6 ++----
 drivers/spi/spi-mxs.c                 |  6 ++----
 drivers/spi/spi-npcm-fiu.c            |  5 ++---
 drivers/spi/spi-npcm-pspi.c           |  6 ++----
 drivers/spi/spi-nxp-fspi.c            |  6 ++----
 drivers/spi/spi-oc-tiny.c             |  5 ++---
 drivers/spi/spi-omap-uwire.c          |  5 ++---
 drivers/spi/spi-omap2-mcspi.c         |  6 ++----
 drivers/spi/spi-orion.c               |  6 ++----
 drivers/spi/spi-pic32-sqi.c           |  6 ++----
 drivers/spi/spi-pic32.c               |  6 ++----
 drivers/spi/spi-ppc4xx.c              |  5 ++---
 drivers/spi/spi-pxa2xx.c              |  6 ++----
 drivers/spi/spi-qcom-qspi.c           |  6 ++----
 drivers/spi/spi-rb4xx.c               |  6 ++----
 drivers/spi/spi-rockchip-sfc.c        |  6 ++----
 drivers/spi/spi-rockchip.c            |  6 ++----
 drivers/spi/spi-rpc-if.c              |  6 ++----
 drivers/spi/spi-rspi.c                |  6 ++----
 drivers/spi/spi-s3c64xx.c             |  6 ++----
 drivers/spi/spi-sh-hspi.c             |  6 ++----
 drivers/spi/spi-sh-msiof.c            |  5 ++---
 drivers/spi/spi-sh-sci.c              |  5 ++---
 drivers/spi/spi-sh.c                  |  6 ++----
 drivers/spi/spi-sifive.c              |  6 ++----
 drivers/spi/spi-slave-mt27xx.c        |  6 ++----
 drivers/spi/spi-sn-f-ospi.c           |  6 ++----
 drivers/spi/spi-sprd-adi.c            |  5 ++---
 drivers/spi/spi-st-ssc4.c             |  6 ++----
 drivers/spi/spi-stm32-qspi.c          |  6 ++----
 drivers/spi/spi-stm32.c               |  6 ++----
 drivers/spi/spi-sun4i.c               |  6 ++----
 drivers/spi/spi-sun6i.c               |  5 ++---
 drivers/spi/spi-sunplus-sp7021.c      |  5 ++---
 drivers/spi/spi-synquacer.c           |  6 ++----
 drivers/spi/spi-tegra114.c            |  6 ++----
 drivers/spi/spi-tegra20-sflash.c      |  6 ++----
 drivers/spi/spi-tegra20-slink.c       |  5 ++---
 drivers/spi/spi-tegra210-quad.c       |  6 ++----
 drivers/spi/spi-topcliff-pch.c        |  6 ++----
 drivers/spi/spi-uniphier.c            |  6 ++----
 drivers/spi/spi-xilinx.c              |  6 ++----
 drivers/spi/spi-xtensa-xtfpga.c       |  6 ++----
 drivers/spi/spi-zynq-qspi.c           |  6 ++----
 drivers/spi/spi-zynqmp-gqspi.c        |  6 ++----
 87 files changed, 183 insertions(+), 350 deletions(-)

base-commit: 2eb29d59ddf02e39774abfb60b2030b0b7e27c1f
-- 
2.39.1

