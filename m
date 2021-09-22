From: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Date: Wed, 22 Sep 2021 15:32:37 +0800
Subject: [PATCH v6 0/4] arm: aspeed: Add UART routing support
Message-ID: <20210922073241.14119-1-chiawei_wang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add UART routing driver and the device tree nodes.

v6:
 - Fix another typo in YAML file
 - Move sysfs description from bindings to ABI document

v5:
 - Fix typo in YAML file to solve the compatible string not found error

v4:
 - Convert aspeed-lpc bindings to YAML schema to resolve dependecy issues

v3:
 - Add individual bindings in YAML
 - Add support for AST24xx (AST25xx shares the same design)
 - Add more explanation for the sysfs ABI

v2:
 - Add dt-bindings
 - Add ABI documents for the exported sysfs interface
 - Revise driver implementation suggested by Joel

Chia-Wei Wang (4):
  dt-bindings: mfd: aspeed-lpc: Convert to YAML schema
  dt-bindings: aspeed: Add UART routing controller
  soc: aspeed: Add UART routing support
  ARM: dts: aspeed: Add uart routing to device tree

 .../testing/sysfs-driver-aspeed-uart-routing  |  27 +
 .../devicetree/bindings/mfd/aspeed-lpc.txt    | 157 -----
 .../devicetree/bindings/mfd/aspeed-lpc.yaml   | 191 ++++++
 .../bindings/soc/aspeed/uart-routing.yaml     |  56 ++
 arch/arm/boot/dts/aspeed-g4.dtsi              |   6 +
 arch/arm/boot/dts/aspeed-g5.dtsi              |   6 +
 arch/arm/boot/dts/aspeed-g6.dtsi              |   6 +
 drivers/soc/aspeed/Kconfig                    |  10 +
 drivers/soc/aspeed/Makefile                   |   9 +-
 drivers/soc/aspeed/aspeed-uart-routing.c      | 603 ++++++++++++++++++
 10 files changed, 910 insertions(+), 161 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-aspeed-uart-routing
 delete mode 100644 Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/aspeed/uart-routing.yaml
 create mode 100644 drivers/soc/aspeed/aspeed-uart-routing.c

-- 
2.17.1

