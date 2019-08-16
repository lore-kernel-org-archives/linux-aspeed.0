From: Joel Stanley <joel@jms.id.au>
Date: Sat, 17 Aug 2019 01:28:04 +0930
Subject: [PATCH 0/2] clk: Add driver for ast2600
Message-ID: <20190816155806.22869-1-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello clock maintainers,

This adds a new driver for the ast2600 BMC's clocks. It's a separate
from the existing aspeed one as the ast2600 changes enough from the
previous generation to make it hard to support with one driver.

It has been tested on the ast2600 evaluation board.

Joel Stanley (2):
  clk: aspeed: Move structures to header
  clk: Add support for AST2600 SoC

 drivers/clk/Makefile                      |   1 +
 drivers/clk/clk-aspeed.c                  |  63 +-
 drivers/clk/clk-aspeed.h                  |  76 +++
 drivers/clk/clk-ast2600.c                 | 711 ++++++++++++++++++++++
 include/dt-bindings/clock/ast2600-clock.h | 116 ++++
 5 files changed, 906 insertions(+), 61 deletions(-)
 create mode 100644 drivers/clk/clk-aspeed.h
 create mode 100644 drivers/clk/clk-ast2600.c
 create mode 100644 include/dt-bindings/clock/ast2600-clock.h

-- 
2.23.0.rc1

