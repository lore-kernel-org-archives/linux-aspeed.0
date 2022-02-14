From: Cédric Le Goater <clg@kaod.org>
Date: Mon, 14 Feb 2022 10:42:21 +0100
Subject: [PATCH 00/10] spi: spi-mem: Add driver for Aspeed SMC controllers
Message-ID: <20220214094231.3753686-1-clg@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

This series adds a new SPI driver using the spi-mem interface for the
Aspeed static memory controllers of the AST2600, AST2500 and AST2400
SoCs.

 * AST2600 Firmware SPI Memory Controller (FMC)
 * AST2600 SPI Flash Controller (SPI1 and SPI2)
 * AST2500 Firmware SPI Memory Controller (FMC)
 * AST2500 SPI Flash Controller (SPI1 and SPI2)
 * AST2400 New Static Memory Controller (also referred as FMC)
 * AST2400 SPI Flash Controller (SPI)

It is based on the current OpenBMC kernel driver [1], using directly
the MTD SPI-NOR interface and on a patchset [2] previously proposed
adding support for the AST2600 only. This driver takes a slightly
different approach to cover all 6 controllers.

It does not make use of the controller register disabling Address and
Data byte lanes because is not available on the AST2400 SoC. We could
introduce a specific handler for new features available on recent SoCs
if needed. As there is not much difference on performance, the driver
chooses the common denominator: "User mode" which has been heavily
tested in [1]. "User mode" is also used as a fall back method when
flash device mapping window is too small.

Problems to address with spi-mem were the configuration of the mapping
windows and the calibration of the read timings. The driver handles
them in the direct mapping handler when some knowledge on the size of
the flash device is know. It is not perfect but not incorrect either.
The algorithm is one from [1] because it doesn't require the DMA
registers which are not available on all controllers.

Direct mapping for writes is not supported (yet). I have seen some
corruption with writes and I preferred to use the safer and proven
method of the initial driver [1]. We can improve that later.

The driver supports Quad SPI RX transfers on the AST2600 SoC but it
didn't have the expected results. Therefore it is not activated yet.
This needs more tests.

The series does not remove the current Aspeed SMC driver but prepares
ground for its removal by changing its CONFIG option. This last step
can be addressed as a followup when the new driver using the spi-mem
interface has been sufficiently exposed. 

Tested on:
 
 * OpenPOWER Palmetto (AST2400)
 * Evaluation board (AST2500) 
 * OpenPOWER Witherspoon (AST2500)
 * Evaluation board (AST2600 A0)
 * Rainier board (AST2600)
 
[1] https://github.com/openbmc/linux/blob/dev-5.15/drivers/mtd/spi-nor/controllers/aspeed-smc.c
[2] https://patchwork.ozlabs.org/project/linux-aspeed/list/?series=212394

Thanks,

C. 

C?dric Le Goater (10):
  mtd: spi-nor: aspeed: Rename Kconfig option
  dt-bindings: spi: Add Aspeed SMC controllers device tree binding
  spi: spi-mem: Add driver for Aspeed SMC controllers
  spi: aspeed: Add support for direct mapping
  spi: aspeed: Adjust direct mapping to device size
  spi: aspeed: Workaround AST2500 limitations
  spi: aspeed: Add support for the AST2400 SPI controller
  spi: aspeed: Calibrate read timings
  ARM: dts: aspeed: Enable Dual SPI RX transfers
  spi: aspeed: Activate new spi-mem driver

 drivers/spi/spi-aspeed-smc.c                  | 1241 +++++++++++++++++
 .../bindings/spi/aspeed,ast2600-fmc.yaml      |   92 ++
 arch/arm/boot/dts/aspeed-g4.dtsi              |    6 +
 arch/arm/boot/dts/aspeed-g5.dtsi              |    7 +
 arch/arm/boot/dts/aspeed-g6.dtsi              |    8 +
 drivers/mtd/spi-nor/controllers/Kconfig       |    4 +-
 drivers/mtd/spi-nor/controllers/Makefile      |    2 +-
 drivers/spi/Kconfig                           |   11 +
 drivers/spi/Makefile                          |    1 +
 9 files changed, 1369 insertions(+), 3 deletions(-)
 create mode 100644 drivers/spi/spi-aspeed-smc.c
 create mode 100644 Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml

-- 
2.34.1

