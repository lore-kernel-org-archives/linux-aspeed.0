From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue,  8 Dec 2020 00:55:50 +1030
Subject: [PATCH v4 0/6] mmc: sdhci-of-aspeed: Expose phase delay tuning
Message-ID: <20201207142556.2045481-1-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

This series implements support for the MMC core clk-phase-* devicetree bindings
in the Aspeed SD/eMMC driver. The relevant register was exposed on the AST2600
and is present for both the SD/MMC controller and the dedicated eMMC
controller.

There are a couple of prominent changes from v3 in v4 of the series:

1. The devicetree phase parsing helper has been moved to the MMC core
2. KUnit tests have been added for the phase calculations in the ASPEED driver

Other than that I've updated MAINTAINERS to add myself as the maintainer of the
driver.

v3 can be found here:

https://lore.kernel.org/linux-mmc/20201123063004.337345-1-andrew at aj.id.au/

The series has had light testing on an AST2600-based platform which requires
180deg of input and output clock phase correction at HS200, as well as some
synthetic testing under qemu and KUnit.

Please review!

Cheers,

Andrew

Andrew Jeffery (6):
  mmc: core: Add helper for parsing clock phase properties
  mmc: sdhci-of-aspeed: Expose clock phase controls
  mmc: sdhci-of-aspeed: Add AST2600 bus clock support
  mmc: sdhci-of-aspeed: Add KUnit tests for phase calculations
  MAINTAINERS: Add entry for the ASPEED SD/MMC driver
  ARM: dts: rainier: Add eMMC clock phase compensation

 MAINTAINERS                                  |   9 +
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts |   1 +
 drivers/mmc/core/host.c                      |  43 ++++
 drivers/mmc/host/Kconfig                     |  14 ++
 drivers/mmc/host/Makefile                    |   1 +
 drivers/mmc/host/sdhci-of-aspeed-test.c      | 100 ++++++++
 drivers/mmc/host/sdhci-of-aspeed.c           | 251 ++++++++++++++++++-
 include/linux/mmc/host.h                     |  17 ++
 8 files changed, 425 insertions(+), 11 deletions(-)
 create mode 100644 drivers/mmc/host/sdhci-of-aspeed-test.c

-- 
2.27.0

