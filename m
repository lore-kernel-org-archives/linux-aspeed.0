From: ryan_chen <ryan_chen@aspeedtech.com>
Date: Mon, 16 May 2022 14:48:57 +0800
Subject: [PATCH v3 0/3] Add ASPEED AST2600 I2C new controller driver
Message-ID: <20220516064900.30517-1-ryan_chen@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This series add AST2600 i2c new register set driver. The i2c new
register set have new clock divider option for more flexiable generation.
And also have separate i2c master and slave register set for control.

v3:
-fix i2c global clock divide default value
-remove i2c slave no used dev_dbg info.
 
v2:
-add i2c global ymal file commit
-rename file name from new to ast2600.
 aspeed-i2c-new-global.c -> i2c-ast2600-global.c
 aspeed-i2c-new-global.h -> i2c-ast2600-global.h
 i2c-new-aspeed.c -> i2c-ast2600.c
-rename all driver function name to ast2600

ryan_chen (3):
  dt-bindings: i2c-ast2600: Add bindings for AST2600 i2C global register
    controller
  dt-bindings: i2c-ast2600: Add bindings for AST2600 i2C driver
  i2c:aspeed:support ast2600 i2c new register mode driver

 .../i2c/aspeed,i2c-ast2600-global.ymal        |   44 +
 .../bindings/i2c/aspeed,i2c-ast2600.ymal      |   78 +
 drivers/i2c/busses/Kconfig                    |   11 +
 drivers/i2c/busses/Makefile                   |    1 +
 drivers/i2c/busses/i2c-ast2600-global.c       |   94 +
 drivers/i2c/busses/i2c-ast2600-global.h       |   19 +
 drivers/i2c/busses/i2c-ast2600.c              | 1703 +++++++++++++++++
 7 files changed, 1950 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/aspeed,i2c-ast2600-global.ymal
 create mode 100644 Documentation/devicetree/bindings/i2c/aspeed,i2c-ast2600.ymal
 create mode 100644 drivers/i2c/busses/i2c-ast2600-global.c
 create mode 100644 drivers/i2c/busses/i2c-ast2600-global.h
 create mode 100644 drivers/i2c/busses/i2c-ast2600.c

-- 
2.17.1

