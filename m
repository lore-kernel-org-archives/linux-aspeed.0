From: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Date: Thu, 2 Sep 2021 10:18:13 +0800
Subject: [PATCH v2 0/3] arm: aspeed: Add UART routing support
Message-ID: <20210902021817.17506-1-chiawei_wang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add UART routing driver and the device tree nodes.

v2:
 - Add dt-bindings
 - Add ABI documents for the exported sysfs interface
 - Revise driver implementation suggested by Joel

Chia-Wei Wang (3):
  dt-bindings: aspeed-lpc: Add UART routing compatible string
  soc: aspeed: Add UART routing support
  ARM: dts: aspeed: Add uart routing to device tree

 .../testing/sysfs-driver-aspeed-uart-routing  |  15 +
 .../devicetree/bindings/mfd/aspeed-lpc.txt    |  22 +
 arch/arm/boot/dts/aspeed-g5.dtsi              |   6 +
 arch/arm/boot/dts/aspeed-g6.dtsi              |   6 +
 drivers/soc/aspeed/Kconfig                    |  10 +
 drivers/soc/aspeed/Makefile                   |   9 +-
 drivers/soc/aspeed/aspeed-uart-routing.c      | 601 ++++++++++++++++++
 7 files changed, 665 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-aspeed-uart-routing
 create mode 100644 drivers/soc/aspeed/aspeed-uart-routing.c

-- 
2.17.1

