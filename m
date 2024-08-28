From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Wed, 28 Aug 2024 14:27:37 +0800
Subject: [PATCH v2 0/3] Add support for AST2700 clk driver
Message-ID: <20240828062740.1614744-1-ryan_chen@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch series is add clk driver for AST2700.

AST2700 is the 8th generation of Integrated Remote Management Processor
introduced by ASPEED Technology Inc. Which is Board Management controller
(BMC) SoC family. AST2700 have two SoC connected, one is SoC0, another
is SoC1, it has it's own scu, this driver inlcude SCU0 and SCU1 driver.

v2:
-yaml: drop 64bits address example.
-yaml: add discription about soc0 and soc1
-dt-bindings: remove (), *_NUMS, reserved.
-dt-bindings: remove dulipated define number
-clk-ast2700: drop WARN_ON, weird comment.

Ryan Chen (3):
  dt-bindings: reset Add AST2700 reset bindings
  dt-bindings: clock: Add AST2700 clock bindings
  clk: aspeed: add AST2700 clk driver

 drivers/clk/Kconfig                           |   10 +
 drivers/clk/Makefile                          |    1 +
 drivers/clk/clk-ast2700.c                     | 1198 +++++++++++++++++
 .../dt-bindings/clock/aspeed,ast2700-clk.h    |  165 +++
 .../dt-bindings/reset/aspeed,ast2700-reset.h  |  125 ++
 5 files changed, 1499 insertions(+)
 create mode 100644 drivers/clk/clk-ast2700.c
 create mode 100644 include/dt-bindings/clock/aspeed,ast2700-clk.h
 create mode 100644 include/dt-bindings/reset/aspeed,ast2700-reset.h

-- 
2.34.1

