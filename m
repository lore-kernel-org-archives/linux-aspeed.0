From: Cédric Le Goater <clg@kaod.org>
Date: Fri,  4 Mar 2022 09:36:32 +0100
Subject: [PATCH v3 00/11] spi: spi-mem: Add driver for Aspeed SMC controllers
Message-ID: <20220304083643.1079142-1-clg@kaod.org>
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
There are some issues on the pinctrl to investigate first. 

The series does not remove the current Aspeed SMC driver but prepares
ground for its removal by changing its CONFIG option. This last step
can be addressed as a followup when the new driver using the spi-mem
interface has been sufficiently exposed. 

Tested on:
 
 * OpenPOWER Palmetto (AST2400)
 * Facebook Wedge 100 BMC (AST2400) by Tao Ren <rentao.bupt@gmail.com>
 * Evaluation board (AST2500) 
 * Inspur FP5280G2 BMC (AST2500) by John Wang <wangzq.jn@gmail.com>
 * Facebook Backpack CMM BMC (AST2500) by Tao Ren <rentao.bupt@gmail.com>
 * OpenPOWER Witherspoon (AST2500)
 * Evaluation board (AST2600 A0 and A3)
 * Rainier board (AST2600)
 
[1] https://github.com/openbmc/linux/blob/dev-5.15/drivers/mtd/spi-nor/controllers/aspeed-smc.c
[2] https://patchwork.ozlabs.org/project/linux-aspeed/list/?series=212394

Thanks,

C. 

Changes in v3:

 - Fixed compile warning on aspeed_spi_dirmap_read() prototype reported
   by kernel test robot 
 - Removed unnecessary entry in ast2600-fmc.yaml
 - New patch from Tao to set spi-max-frequency on all FMC devices

Changes in v2:

 - Fixed dt_binding_check warnings (Rob)
 - New entry in MAINTAINERS 
 - Addressed Lukas comments regarding the SPI controller registration
   and device removal. Checked with driver bind/unbind   
 - Introduced setup and cleanup handlers and removed routine looping
   on the DT children properties (Pratyush)
 - Clarified in commit log requirements for training.
 - Removed defconfig changes of patch 1 since they were reverted in
   the last patch (Joel)

C?dric Le Goater (10):
  mtd: spi-nor: aspeed: Rename Kconfig option
  ARM: dts: aspeed: Adjust "reg" property of FMC/SPI controllers
  dt-bindings: spi: Add Aspeed SMC controllers device tree binding
  spi: spi-mem: Add driver for Aspeed SMC controllers
  spi: aspeed: Add support for direct mapping
  spi: aspeed: Adjust direct mapping to device size
  spi: aspeed: Workaround AST2500 limitations
  spi: aspeed: Add support for the AST2400 SPI controller
  spi: aspeed: Calibrate read timings
  ARM: dts: aspeed: Enable Dual SPI RX transfers

Tao Ren (1):
  ARM: dts: aspeed-g4: Set spi-max-frequency for all flashes

 drivers/spi/spi-aspeed-smc.c                  | 1184 +++++++++++++++++
 .../bindings/spi/aspeed,ast2600-fmc.yaml      |   87 ++
 MAINTAINERS                                   |   10 +
 arch/arm/boot/dts/aspeed-g4.dtsi              |   16 +-
 arch/arm/boot/dts/aspeed-g5.dtsi              |   16 +-
 arch/arm/boot/dts/aspeed-g6.dtsi              |   17 +-
 drivers/mtd/spi-nor/controllers/Kconfig       |    4 +-
 drivers/mtd/spi-nor/controllers/Makefile      |    2 +-
 drivers/spi/Kconfig                           |   11 +
 drivers/spi/Makefile                          |    1 +
 10 files changed, 1329 insertions(+), 19 deletions(-)
 create mode 100644 drivers/spi/spi-aspeed-smc.c
 create mode 100644 Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml

-- 
2.34.1

