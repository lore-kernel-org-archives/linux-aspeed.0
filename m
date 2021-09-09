From: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Date: Thu, 9 Sep 2021 18:29:04 +0800
Subject: [PATCH v3 0/3] arm: aspeed: Add UART routing support
Message-ID: <20210909102907.32037-1-chiawei_wang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add UART routing driver and the device tree nodes.

v3:
 - Add individual bindings in YAML
 - Add support for AST24xx (AST25xx shares the same design)
 - Add more explanation for the sysfs ABI

v2:
 - Add dt-bindings
 - Add ABI documents for the exported sysfs interface
 - Revise driver implementation suggested by Joel

Chia-Wei Wang (3):
  dt-bindings: aspeed: Add UART routing controller
  soc: aspeed: Add UART routing support
  ARM: dts: aspeed: Add uart routing to device tree

 .../testing/sysfs-driver-aspeed-uart-routing  |  15 +
 .../bindings/soc/aspeed/uart-routing.yaml     |  70 ++
 arch/arm/boot/dts/aspeed-g4.dtsi              |   6 +
 arch/arm/boot/dts/aspeed-g5.dtsi              |   6 +
 arch/arm/boot/dts/aspeed-g6.dtsi              |   6 +
 drivers/soc/aspeed/Kconfig                    |  10 +
 drivers/soc/aspeed/Makefile                   |   9 +-
 drivers/soc/aspeed/aspeed-uart-routing.c      | 603 ++++++++++++++++++
 8 files changed, 721 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-aspeed-uart-routing
 create mode 100644 Documentation/devicetree/bindings/soc/aspeed/uart-routing.yaml
 create mode 100644 drivers/soc/aspeed/aspeed-uart-routing.c

-- 
2.17.1

