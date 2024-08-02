From: Kevin Chen <kevin_chen@aspeedtech.com>
Date: Fri, 02 Aug 2024 09:06:29 -0000
Subject: [PATCH v2 0/9] Introduce ASPEED AST27XX BMC SoC
In-Reply-To: <20240802090544.2741206-1-kevin_chen@aspeedtech.com>
References: <20240802090544.2741206-1-kevin_chen@aspeedtech.com>
Message-ID: <20240802090544.2741206-2-kevin_chen@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patchset adds initial support for the ASPEED.
AST27XX Board Management controller (BMC) SoC family.

AST2700 is ASPEED's 8th-generation server management processor.
Featuring a quad-core ARM Cortex A35 64-bit processor and two
independent ARM Cortex M4 processors

This patchset adds minimal architecture and drivers such as:
Clocksource, Clock and Reset

This patchset was tested on the ASPEED AST2700 evaluation board.

Kevin Chen (9):
  dt-bindings: mfd: aspeed,ast2x00-scu: Add ASPEED AST2700-SCUX schema
  dt-bindings: reset: ast2700: Add ASPEED AST27xx Reset schema
  dt-bindings: clk: ast2700: Add ASPEED AST27XX Clock schema
  clk: ast2700: add clock controller
  dt-bindings: arm: aspeed: Add ASPEED AST27XX SoC
  arm64: aspeed: Add support for ASPEED AST27XX BMC SoC
  arm64: defconfig: Add ASPEED AST2700 family support
  arm64: dts: aspeed: Add initial AST27XX device tree
  arm64: dts: aspeed: Add initial AST2700 EVB device tree

 .../bindings/arm/aspeed/aspeed.yaml           |    7 +
 .../bindings/mfd/aspeed,ast2x00-scu.yaml      |   70 +-
 MAINTAINERS                                   |    3 +
 arch/arm64/Kconfig.platforms                  |   14 +
 arch/arm64/boot/dts/Makefile                  |    1 +
 arch/arm64/boot/dts/aspeed/Makefile           |    4 +
 arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi     |  185 +++
 arch/arm64/boot/dts/aspeed/ast2700-evb.dts    |   58 +
 arch/arm64/configs/defconfig                  |    1 +
 drivers/clk/Makefile                          |    1 +
 drivers/clk/clk-ast2700.c                     | 1173 +++++++++++++++++
 .../dt-bindings/clock/aspeed,ast2700-clk.h    |  175 +++
 .../dt-bindings/reset/aspeed,ast2700-reset.h  |  132 ++
 13 files changed, 1804 insertions(+), 20 deletions(-)
 create mode 100644 arch/arm64/boot/dts/aspeed/Makefile
 create mode 100644 arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi
 create mode 100644 arch/arm64/boot/dts/aspeed/ast2700-evb.dts
 create mode 100644 drivers/clk/clk-ast2700.c
 create mode 100644 include/dt-bindings/clock/aspeed,ast2700-clk.h
 create mode 100644 include/dt-bindings/reset/aspeed,ast2700-reset.h

-- 
2.34.1

