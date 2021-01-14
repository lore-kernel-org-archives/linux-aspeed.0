From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 14 Jan 2021 13:44:27 +1030
Subject: [PATCH v7 0/6] mmc: sdhci-of-aspeed: Expose phase delay tuning
Message-ID: <20210114031433.2388532-1-andrew@aj.id.au>
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

v7 is just a small change to the the kunit testing in response to Adrian's
feedback.

I've just done a quick build test of v7 given the small change and more
extensive testing done with v5. 

v6 can be found here:

https://lore.kernel.org/linux-mmc/20201218035338.1130849-1-andrew at aj.id.au/

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
 drivers/mmc/core/host.c                      |  44 ++++
 drivers/mmc/host/Kconfig                     |  14 +
 drivers/mmc/host/sdhci-of-aspeed-test.c      |  98 +++++++
 drivers/mmc/host/sdhci-of-aspeed.c           | 255 ++++++++++++++++++-
 include/linux/mmc/host.h                     |  13 +
 7 files changed, 423 insertions(+), 11 deletions(-)
 create mode 100644 drivers/mmc/host/sdhci-of-aspeed-test.c

-- 
2.27.0

