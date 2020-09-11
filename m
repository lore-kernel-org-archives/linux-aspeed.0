From: Joel Stanley <joel@jms.id.au>
Date: Fri, 11 Sep 2020 05:52:20 +0000
Subject: [GIT PULL] ARM: aspeed: devicetree changes for 5.10
Message-ID: <CACPK8XcDNBYAHzW6NYB4LFm3YbN63AprgW75ZqS+6uXn2b3kug@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Soc maintainers,

Please pull these ASPEED device tree changes for incusion in 5.10.

The following changes since commit e89570584d2bcf188af4baaebacfb6998e6326dc:

  ARM: dts: aspeed: Add Mowgli BMC platform (2020-09-11 15:08:16 +0930)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git
tags/aspeed-5.10-devicetree

for you to fetch changes up to e89570584d2bcf188af4baaebacfb6998e6326dc:

  ARM: dts: aspeed: Add Mowgli BMC platform (2020-09-11 15:08:16 +0930)

----------------------------------------------------------------
ASPEED device tree updates for 5.10

 - New machines

  * Wistron Mowgli, an AST2500 BMC for a Power9 OpenPower server

  * Facebook Wedge400, an AST2500 BMC system which we can assume is 4
    times better than the existing Wedge100 top of rack network switch

 - Add a new device, the IBM Operation Panel

 - Fixes for Facebook's collection of BMCs

 - eMMC and vuart fixes

----------------------------------------------------------------
Andrew Jeffery (1):
      ARM: dts: rainier: Disable internal pull-downs on eMMC pins

Ben Pai (1):
      ARM: dts: aspeed: Add Mowgli BMC platform

Eddie James (3):
      ARM: dts: aspeed: rainier: Enable XDMA engine
      ARM: dts: aspeed: tacoma: Add IBM Operation Panel I2C device
      ARM: dts: aspeed: rainier: Add IBM Operation Panel I2C device

Joel Stanley (1):
      ARM: aspeed: g5: Do not set sirq polarity

Tao Ren (7):
      ARM: dts: aspeed: Remove flash layout from Facebook AST2500 Common dtsi
      ARM: dts: aspeed: cmm: Set 32MB FMC flash layout
      ARM: dts: aspeed: yamp: Set 32MB FMC flash layout
      ARM: dts: aspeed: minipack: Update 64MB FMC flash layout
      ARM: dts: aspeed: Add Facebook Wedge400 BMC
      ARM: dts: aspeed: wedge40: Update FMC flash0 label
      ARM: dts: aspeed: wedge40: Update UART4 pin settings

 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/aspeed-bmc-facebook-cmm.dts      |  17 +
 arch/arm/boot/dts/aspeed-bmc-facebook-minipack.dts |  47 +-
 arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts  |   5 +-
 arch/arm/boot/dts/aspeed-bmc-facebook-wedge400.dts | 420 +++++++++++++
 arch/arm/boot/dts/aspeed-bmc-facebook-yamp.dts     |  17 +
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts       |  23 +-
 arch/arm/boot/dts/aspeed-bmc-opp-mowgli.dts        | 662 +++++++++++++++++++++
 arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts        |   7 +
 arch/arm/boot/dts/aspeed-g5.dtsi                   |   1 -
 .../boot/dts/ast2500-facebook-netbmc-common.dtsi   |  13 -
 11 files changed, 1193 insertions(+), 21 deletions(-)
