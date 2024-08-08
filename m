From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Thu, 8 Aug 2024 15:59:33 +0800
Subject: [PATCH 0/4] Add support for AST2700 clk driver
Message-ID: <20240808075937.2756733-1-ryan_chen@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch series is add clk driver for AST2700.

AST2700 is the 8th generation of Integrated Remote Management Processor
introduced by ASPEED Technology Inc. Which is Board Management controller
(BMC) SoC family.

Ryan Chen (4):
  dt-bindings: mfd: aspeed: support for AST2700
  dt-bindings: reset Add AST2700 reset bindings
  dt-bindings: clock: Add AST2700 clock bindings
  dt-bindings: clock: Add AST2700 clock bindings

 .../bindings/mfd/aspeed,ast2x00-scu.yaml      |   31 +-
 drivers/clk/Makefile                          |    1 +
 drivers/clk/clk-ast2700.c                     | 1091 +++++++++++++++++
 .../dt-bindings/clock/aspeed,ast2700-clk.h    |  175 +++
 .../dt-bindings/reset/aspeed,ast2700-reset.h  |  132 ++
 5 files changed, 1428 insertions(+), 2 deletions(-)
 create mode 100644 drivers/clk/clk-ast2700.c
 create mode 100644 include/dt-bindings/clock/aspeed,ast2700-clk.h
 create mode 100644 include/dt-bindings/reset/aspeed,ast2700-reset.h

-- 
2.34.1

