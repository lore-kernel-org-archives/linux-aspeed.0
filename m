From: Jamin Lin <jamin_lin@aspeedtech.com>
Date: Wed, 19 May 2021 16:04:26 +0800
Subject: [PATCH 0/3] i2c: aspeed: avoid new registers definition of AST2600
Message-ID: <20210519080436.18975-1-jamin_lin@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Jamin Lin (3):
  i2c: aspeed: avoid new registers definition of AST2600
  ARM: dts: aspeed: Add node for AST2600 I2C
  dt-bindings: aspeed-i2c: Convert txt to yaml format

 .../devicetree/bindings/i2c/aspeed,i2c.yaml   | 89 +++++++++++++++++++
 .../devicetree/bindings/i2c/i2c-aspeed.txt    | 49 ----------
 arch/arm/boot/dts/aspeed-g6.dtsi              |  8 ++
 drivers/i2c/busses/i2c-aspeed.c               | 22 +++++
 4 files changed, 119 insertions(+), 49 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-aspeed.txt

-- 
2.17.1

