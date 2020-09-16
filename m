From: Joel Stanley <joel@jms.id.au>
Date: Wed, 16 Sep 2020 18:17:00 +0930
Subject: [PATCH 0/3] ARM: aspeed: Add socinfo driver
Message-ID: <20200916084703.778386-1-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This adds a socinfo driver for the ASPEED BMCs. Please review!

Joel Stanley (3):
  dt-bindings: aspeed: Add silicon id node to SCU
  soc: aspeed: Add soc info driver
  ARM: dts: aspeed: Add silicon id node

 .../devicetree/bindings/mfd/aspeed-scu.txt    |  23 +++
 arch/arm/boot/dts/aspeed-g4.dtsi              |   5 +
 arch/arm/boot/dts/aspeed-g5.dtsi              |   5 +
 arch/arm/boot/dts/aspeed-g6.dtsi              |   5 +
 drivers/soc/aspeed/Kconfig                    |   7 +
 drivers/soc/aspeed/Makefile                   |   1 +
 drivers/soc/aspeed/aspeed-socinfo.c           | 141 ++++++++++++++++++
 7 files changed, 187 insertions(+)
 create mode 100644 drivers/soc/aspeed/aspeed-socinfo.c

-- 
2.28.0

