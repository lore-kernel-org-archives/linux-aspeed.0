From: Joel Stanley <joel@jms.id.au>
Date: Wed, 28 Sep 2022 04:44:12 +0000
Subject: [GIT PULL] ARM: aspeed: devicetree changes for 6.1
Message-ID: <CACPK8Xepnci+f+7Pi1jtXod8Jmt+OnJYfDRENjiP-xDBQwFCVg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello soc maintainers,

Here are the aspeed device tree changes for v6.1.

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/bmc.git
tags/aspeed-6.1-devicetree

for you to fetch changes up to 73b4476562de2a26debc076801ca28148076c79f:

  ARM: dts: aspeed: ast2600-evb-a1: Add compatible (2022-09-28 12:31:40 +0930)

----------------------------------------------------------------
ASPEED device tree updates for 6.1

 - New machines

  * AMD's DaytonaX AST2600 BMC, for the amd64 server
  * Ampre's Mt. Mitchell AST2600 BMC, for the AmpereOne arm64 server

 - Fixes and updates for bletchley, mtjade, yosemitev2 and the ast2600-evb

----------------------------------------------------------------
C?dric Le Goater (1):
      ARM: dts: aspeed: ast2600-evb: Enable Quad SPI RX tranfers

Joel Stanley (3):
      ARM: dts: aspeed: ast2600-evb: Update I2C devices
      ARM: dts: aspeed: ast2600evb: Fix compatible string
      ARM: dts: aspeed: ast2600-evb-a1: Add compatible

Karthikeyan Pasupathi (2):
      ARM: dts: aspeed: Yosemite V2: Enable OCP debug card
      ARM: dts: aspeed: yosemitev2: Disable the EEPROM driver

Ken Chen (1):
      ARM: dts: aspeed-g6: Enable more UART controllers

Konstantin Aladyshev (2):
      dt-bindings: arm: aspeed: document AMD DaytonaX
      ARM: dts: aspeed: Add AMD DaytonaX BMC

Potin Lai (2):
      ARM: dts: aspeed: bletchley: Add USB debug card IPMB node
      ARM: dts: aspeed: bletchley: Remove hdc1080 node

Quan Nguyen (3):
      dt-bindings: arm: aspeed: document Ampere Mt.Mitchell BMC compatibles
      ARM: dts: aspeed: Add device tree for Ampere's Mt. Mitchell BMC
      ARM: dts: aspeed: mtjade: Remove gpio-keys entries

 .../devicetree/bindings/arm/aspeed/aspeed.yaml     |   2 +
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/aspeed-ast2600-evb-a1.dts        |   2 +-
 arch/arm/boot/dts/aspeed-ast2600-evb.dts           |  25 +-
 arch/arm/boot/dts/aspeed-bmc-amd-daytonax.dts      | 319 ++++++++++++
 arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts     |  95 ----
 arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts | 546 +++++++++++++++++++++
 .../arm/boot/dts/aspeed-bmc-facebook-bletchley.dts |  13 +-
 .../boot/dts/aspeed-bmc-facebook-yosemitev2.dts    |  15 +-
 arch/arm/boot/dts/aspeed-g6.dtsi                   |  56 +++
 10 files changed, 963 insertions(+), 112 deletions(-)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-amd-daytonax.dts
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
