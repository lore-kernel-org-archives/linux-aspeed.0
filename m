From: Joel Stanley <joel@jms.id.au>
Date: Tue, 7 Feb 2023 03:51:08 +0000
Subject: [GIT PULL] ARM: aspeed: devicetree changes for 6.3
Message-ID: <CACPK8XdbffU5yRSZF-zR2xv-+6aJK+hEXP8TOkW=SvS+nNTGxg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Soc maintainers,

Here are the aspeed device tree changes for 6.3

The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/bmc.git
tags/aspeed-6.3-devicetree

for you to fetch changes up to 1480bcf074d34e754990204240f8473cdbef0072:

  ARM: dts: aspeed: p10bmc: Enable UART2 (2023-02-01 15:10:18 +1030)

----------------------------------------------------------------
ASPEED device tree updates for 6.3

 - New machines

   * Ufispace NCPLite AST2600 BMC
   * Facebook Greatlakes AST2600 BMC

 - Updates for ethanolx, bletchley and tyan s8036

----------------------------------------------------------------
Ali El-Haj-Mahmoud (1):
      arm: dts: aspeed: tyan s8036: Enable kcs interrupts

Delphine CC Chiu (2):
      dt-bindings: arm: aspeed: add Facebook Greatlakes board
      ARM: dts: aspeed: greatlakes: Add Facebook greatlakes (AST2600) BMC

Eddie James (1):
      ARM: dts: aspeed: p10bmc: Enable UART2

Jordan Chang (3):
      dt-bindings: vendor-prefixes: Add prefix for Ufi Space
      dt-bindings: arm: aspeed: document Ufispace NCPLite BMC
      ARM: dts: aspeed: Add device tree for Ufispace NCPLite BMC

Konstantin Aladyshev (5):
      ARM: dts: aspeed: ethanolx: Enable VUART
      ARM: dts: aspeed: ethanolx: Correct EEPROM device name
      ARM: dts: aspeed: ethanolx: Add label for the master partition
      ARM: dts: aspeed: ethanolx: Enable CTS/RTS pins on UART1
      ARM: dts: aspeed: ethanolx: Add BIOS flash chip

Potin Lai (2):
      ARM: dts: aspeed: bletchley: Rename flash1 label
      ARM: dts: aspeed: bletchley: Enable wdtrst1

 .../devicetree/bindings/arm/aspeed/aspeed.yaml     |   2 +
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts      |  25 +-
 .../arm/boot/dts/aspeed-bmc-facebook-bletchley.dts |  13 +-
 .../boot/dts/aspeed-bmc-facebook-greatlakes.dts    | 241 ++++++++++++++
 arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts       |   4 +
 arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts       |   4 +
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts       |   4 +
 arch/arm/boot/dts/aspeed-bmc-tyan-s8036.dts        |   1 +
 arch/arm/boot/dts/aspeed-bmc-ufispace-ncplite.dts  | 360 +++++++++++++++++++++
 11 files changed, 655 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-ufispace-ncplite.dts
