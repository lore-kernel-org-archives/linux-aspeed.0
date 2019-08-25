From: Joel Stanley <joel@jms.id.au>
Date: Sun, 25 Aug 2019 14:10:15 +0000
Subject: [GIT PULL] ARM: aspeed: devicetree changes for 5.4
Message-ID: <CACPK8XfKHpNYXNE_VRaLeGUQa7-hkmUS0nsPfaeSLE4sckKFHg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello ARM Maintainers,

Here are the APSEED device tree changes. No ast2600 support here
unfortunately as the clock driver wasn't quite ready in time.

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git \
    tags/aspeed-5.4-devicetree

for you to fetch changes up to 49b0f3be0b86292eed6f6aedadf4252131d9c111:

  ARM: dts: aspeed: swift: Add eMMC device (2019-08-22 15:34:20 +0930)

----------------------------------------------------------------
ASPEED device tree updates for 5.4

New machines:

 - Facebook Wedge100, Wedge40 and Minipack
 - Lenovo Hr855xg2
 - Wistron Mihawk

There's a few other updates, notably some changes to to use the newly
added SDHCI driver.

----------------------------------------------------------------
Andrew Jeffery (2):
      ARM: dts: aspeed: Describe SD controllers
      ARM: dts: aspeed: Enable first MMC slot on AST2500 EVB

Andrew Peng (1):
      ARM: dts: aspeed: Add Lenovo Hr855xg2 BMC

Ben Pai (1):
      ARM: dts: aspeed: Add Mihawk BMC platform

Hongwei Zhang (1):
      ARM: dts: aspeed: Add SGPM pinmux

Joel Stanley (1):
      ARM: dts: aspeed: swift: Add eMMC device

John Wang (1):
      ARM: dts: aspeed: fp5280g2: Fix power supply address

Matt Spinler (1):
      ARM: dts: aspeed: swift: Fix FSI GPIOs

Tao Ren (3):
      ARM: dts: aspeed: Add Facebook Minipack BMC
      ARM: dts: aspeed: Add Facebook Wedge40 BMC
      ARM: dts: aspeed: Add Facebook Wedge100 BMC

Vijay Khemka (3):
      ARM: dts: aspeed: tiogapass: Add VR devices
      ARM: dts: aspeed: tiogapass: Move battery sensor
      ARM: dts: aspeed: tiogapass: Add Riser card

 arch/arm/boot/dts/Makefile                         |   5 +
 arch/arm/boot/dts/aspeed-ast2500-evb.dts           |  11 +
 arch/arm/boot/dts/aspeed-bmc-facebook-minipack.dts | 429 ++++++++++
 .../arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts | 272 +++++-
 arch/arm/boot/dts/aspeed-bmc-facebook-wedge100.dts | 149 ++++
 arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts  | 141 ++++
 arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts   |   4 +-
 arch/arm/boot/dts/aspeed-bmc-lenovo-hr855xg2.dts   | 663 +++++++++++++++
 arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts        | 918 +++++++++++++++++++++
 arch/arm/boot/dts/aspeed-bmc-opp-swift.dts         |  15 +-
 arch/arm/boot/dts/aspeed-g4.dtsi                   |  28 +
 arch/arm/boot/dts/aspeed-g5.dtsi                   |  33 +
 12 files changed, 2659 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-minipack.dts
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-wedge100.dts
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-lenovo-hr855xg2.dts
 create mode 100755 arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts
