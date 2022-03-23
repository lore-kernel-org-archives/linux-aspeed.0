From: ryan_chen <ryan_chen@aspeedtech.com>
Date: Wed, 23 Mar 2022 08:40:07 +0800
Subject: [PATCH 0/2] Add ASPEED AST2600 I2C new controller driver
Message-ID: <20220323004009.943298-1-ryan_chen@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This series add AST2600 i2c new register mode driver. The 
i2c new register mode have new clock divider option for
more flexibale generation. And also have separate i2c 
master and slave register set for control.

ryan_chen (2):
  dt-bindings: i2c-new: Add bindings for AST2600 i2C new controller
  i2c:aspeed:support ast2600 i2c new register mode driver

 .../bindings/i2c/aspeed,i2c-new.yaml          |   78 +
 drivers/i2c/busses/Kconfig                    |   11 +
 drivers/i2c/busses/Makefile                   |    1 +
 drivers/i2c/busses/aspeed-i2c-new-global.c    |   91 +
 drivers/i2c/busses/aspeed-i2c-new-global.h    |   19 +
 drivers/i2c/busses/i2c-new-aspeed.c           | 1698 +++++++++++++++++
 6 files changed, 1898 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/aspeed,i2c-new.yaml
 create mode 100644 drivers/i2c/busses/aspeed-i2c-new-global.c
 create mode 100644 drivers/i2c/busses/aspeed-i2c-new-global.h
 create mode 100644 drivers/i2c/busses/i2c-new-aspeed.c

-- 
2.25.1

