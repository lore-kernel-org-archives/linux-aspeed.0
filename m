From: Joel Stanley <joel@jms.id.au>
Date: Mon, 21 Sep 2020 18:46:41 +0930
Subject: [PATCH v3 0/3] ARM: aspeed: Add socinfo driver
Message-ID: <20200921091644.133107-1-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This adds a socinfo driver for the ASPEED BMCs. Please review!

v3 removes some unncessary frees
v2 addresses Andrew's review comments

Joel Stanley (3):
  dt-bindings: aspeed: Add silicon id node to SCU
  soc: aspeed: Add soc info driver
  ARM: dts: aspeed: Add silicon id node

 .../devicetree/bindings/mfd/aspeed-scu.txt    |  26 ++++
 arch/arm/boot/dts/aspeed-g4.dtsi              |   5 +
 arch/arm/boot/dts/aspeed-g5.dtsi              |   5 +
 arch/arm/boot/dts/aspeed-g6.dtsi              |   5 +
 drivers/soc/aspeed/Kconfig                    |   7 +
 drivers/soc/aspeed/Makefile                   |   1 +
 drivers/soc/aspeed/aspeed-socinfo.c           | 133 ++++++++++++++++++
 7 files changed, 182 insertions(+)
 create mode 100644 drivers/soc/aspeed/aspeed-socinfo.c

-- 
2.28.0

