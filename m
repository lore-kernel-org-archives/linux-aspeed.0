From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Wed, 1 Feb 2023 18:33:56 +0800
Subject: [PATCH v4 0/3] Add ASPEED AST2600 I2C new controller driver
Message-ID: <20230201103359.1742140-1-ryan_chen@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This series add AST2600 i2c new register set driver. The i2c new
register set have new clock divider option for more flexiable generation.
And also have separate i2c master and slave register set for control.

v4:
-fix i2c-ast2600.c driver buffer mode use single buffer conflit in
 master slave mode both enable.
-fix kmemleak issue when use dma mode.
-fix typo aspeed,i2c-ast2600.yaml compatible is "aspeed,ast2600-i2c"
-fix typo aspeed,i2c-ast2600.ymal to aspeed,i2c-ast2600.yaml

v3:
-fix i2c global clock divide default value.
-remove i2c slave no used dev_dbg info.

v2:
-add i2c global ymal file commit.
-rename file name from new to ast2600.
 aspeed-i2c-new-global.c -> i2c-ast2600-global.c
 aspeed-i2c-new-global.h -> i2c-ast2600-global.h
 i2c-new-aspeed.c -> i2c-ast2600.c
-rename all driver function name to ast2600.

Ryan Chen (3):
  dt-bindings: i2c-ast2600: Add support for AST2600 I2C global
    controller
  dt-bindings: i2c-ast2600: Add support for AST2600 i2C driver
  i2c: aspeed: support ast2600 i2c new register mode driver

 .../i2c/aspeed,i2c-ast2600-global.yaml        |   44 +
 .../bindings/i2c/aspeed,i2c-ast2600.yaml      |   78 +
 MAINTAINERS                                   |   10 +
 drivers/i2c/busses/Kconfig                    |   11 +
 drivers/i2c/busses/Makefile                   |    1 +
 drivers/i2c/busses/i2c-ast2600-global.c       |   94 +
 drivers/i2c/busses/i2c-ast2600-global.h       |   19 +
 drivers/i2c/busses/i2c-ast2600.c              | 1811 +++++++++++++++++
 8 files changed, 2068 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/aspeed,i2c-ast2600-global.yaml
 create mode 100644 Documentation/devicetree/bindings/i2c/aspeed,i2c-ast2600.yaml
 create mode 100644 drivers/i2c/busses/i2c-ast2600-global.c
 create mode 100644 drivers/i2c/busses/i2c-ast2600-global.h
 create mode 100644 drivers/i2c/busses/i2c-ast2600.c

-- 
2.34.1

