From: Jamin Lin <jamin_lin@aspeedtech.com>
Date: Thu, 17 Jun 2021 17:43:37 +0800
Subject: [PATCH 0/3] *** Support ASPEED AST2600 I2C ***
Message-ID: <20210617094424.27123-1-jamin_lin@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Support I2C controller of ASPEED AST2600 and
enable the new register set

Jamin Lin (3):
  dts: aspeed: Add node for AST2600 I2C and I2CS
  dt-bindings: i2c-new: Add bindings for AST2600 I2C
  i2c:support new register set for ast2600

 .../bindings/i2c/aspeed,new-i2c.yaml          |  107 +
 arch/arm/boot/dts/aspeed-g6.dtsi              |  150 +-
 drivers/i2c/busses/Kconfig                    |   11 +
 drivers/i2c/busses/Makefile                   |    1 +
 drivers/i2c/busses/ast2600-i2c-global.c       |  205 ++
 drivers/i2c/busses/ast2600-i2c-global.h       |   25 +
 drivers/i2c/busses/i2c-new-aspeed.c           | 1796 +++++++++++++++++
 7 files changed, 2263 insertions(+), 32 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/aspeed,new-i2c.yaml
 create mode 100644 drivers/i2c/busses/ast2600-i2c-global.c
 create mode 100644 drivers/i2c/busses/ast2600-i2c-global.h
 create mode 100644 drivers/i2c/busses/i2c-new-aspeed.c

-- 
2.17.1

