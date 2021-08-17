From: Joel Stanley <joel@jms.id.au>
Date: Tue, 17 Aug 2021 07:51:54 +0000
Subject: [GIT PULL] ARM: aspeed: devicetree changes for 5.15
Message-ID: <CACPK8XdWRBb9cuDWGQPfK8R8TsZuydJQHsL4_e2w=HvCKAMogg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Soc maintainers,

Here are the aspeed changes for 5.15.

The following changes since commit 2734d6c1b1a089fb593ef6a23d4b70903526fe0c:

  Linux 5.14-rc2 (2021-07-18 14:13:49 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/bmc.git
tags/aspeed-5.15-devicetree

for you to fetch changes up to 6b8b31269898b8891f1f3a95578ceeb109393e23:

  ARM: dts: aspeed: p10bmc: Add power control pins (2021-08-17 13:52:46 +0930)

----------------------------------------------------------------
ASPEED device tree updates for 5.15

 - New machines

  * Facebook's Cloudripper
  * Facebook's Elbert
  * Facebook's Fuji

  All three carry the description of "Facebook's next generation switch
  platform with an AST2600 BMC integrated for health monitoring
  purpose."

  They share a 128 MB SPI NOR flash layout that is also used by some
  older platforms.

  * Inspur's NF5280M6, an x86 platform server with an AST2500-based BMC

 - SGPIO updates including AST2600 support

 - GPIO descriptions for the IBM AST2600 machines

 - Pinctrl fix

 - Updates to Facebook's AST2500 based machines

----------------------------------------------------------------
Andrew Jeffery (1):
      ARM: dts: everest: Add phase corrections for eMMC

Dylan Hung (1):
      ARM: dts: aspeed-g6: Fix HVI3C function-group in pinctrl dtsi

Jim Wright (1):
      ARM: dts: aspeed: p10bmc: Add power control pins

Joel Stanley (3):
      ARM: dts: rainier, everest: Add TPM reset GPIO
      ARM: dts: aspeed: tacoma: Add TPM reset GPIO
      ARM: dts: aspeed: ast2500evb: Enable built in RTC

Ping Guo (1):
      ARM: dts: aspeed: Add Inspur NF5280M6 BMC machine

Steven Lee (4):
      dt-bindings: aspeed-sgpio: Convert txt bindings to yaml.
      dt-bindings: aspeed-sgpio: Add ast2600 sgpio
      ARM: dts: aspeed-g6: Add SGPIO node.
      ARM: dts: aspeed-g5: Remove ngpios from sgpio node.

Tao Ren (12):
      ARM: dts: aspeed: Enable ADC in Facebook AST2400 common dtsi
      ARM: dts: aspeed: wedge40: Remove redundant ADC device
      ARM: dts: aspeed: galaxy100: Remove redundant ADC device
      ARM: dts: aspeed: wedge100: Enable ADC channels
      ARM: dts: Add Facebook BMC 128MB flash layout
      ARM: dts: aspeed: wedge400: Use common flash layout
      ARM: dts: aspeed: Common dtsi for Facebook AST2600 Network BMCs
      ARM: dts: aspeed: Add Facebook Cloudripper (AST2600) BMC
      ARM: dts: aspeed: Add Facebook Elbert (AST2600) BMC
      ARM: dts: aspeed: Add Facebook Fuji (AST2600) BMC
      ARM: dts: aspeed: minipack: Update flash partition table
      ARM: dts: aspeed: cloudripper: Add comments for "mdio1"

 .../devicetree/bindings/gpio/aspeed,sgpio.yaml     |   77 ++
 .../devicetree/bindings/gpio/sgpio-aspeed.txt      |   46 -
 arch/arm/boot/dts/Makefile                         |    4 +
 arch/arm/boot/dts/aspeed-ast2500-evb.dts           |    4 +
 .../boot/dts/aspeed-bmc-facebook-cloudripper.dts   |  544 +++++++++
 arch/arm/boot/dts/aspeed-bmc-facebook-elbert.dts   |  185 +++
 arch/arm/boot/dts/aspeed-bmc-facebook-fuji.dts     | 1251 ++++++++++++++++++++
 .../arm/boot/dts/aspeed-bmc-facebook-galaxy100.dts |    4 -
 arch/arm/boot/dts/aspeed-bmc-facebook-minipack.dts |    8 +-
 arch/arm/boot/dts/aspeed-bmc-facebook-wedge100.dts |    5 +
 arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts  |    4 -
 arch/arm/boot/dts/aspeed-bmc-facebook-wedge400.dts |   48 +-
 arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts       |    4 +-
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts       |    2 +-
 arch/arm/boot/dts/aspeed-bmc-inspur-nf5280m6.dts   |  691 +++++++++++
 arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts        |    2 +-
 arch/arm/boot/dts/aspeed-g5.dtsi                   |    1 -
 arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi           |    4 +-
 arch/arm/boot/dts/aspeed-g6.dtsi                   |   28 +
 .../boot/dts/ast2400-facebook-netbmc-common.dtsi   |    4 +
 .../boot/dts/ast2600-facebook-netbmc-common.dtsi   |  169 +++
 .../boot/dts/facebook-bmc-flash-layout-128.dtsi    |   60 +
 22 files changed, 3033 insertions(+), 112 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/aspeed,sgpio.yaml
 delete mode 100644 Documentation/devicetree/bindings/gpio/sgpio-aspeed.txt
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-cloudripper.dts
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-elbert.dts
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-fuji.dts
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-inspur-nf5280m6.dts
 create mode 100644 arch/arm/boot/dts/ast2600-facebook-netbmc-common.dtsi
 create mode 100644 arch/arm/boot/dts/facebook-bmc-flash-layout-128.dtsilin
