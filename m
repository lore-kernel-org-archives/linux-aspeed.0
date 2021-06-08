From: Joel Stanley <joel@jms.id.au>
Date: Tue, 8 Jun 2021 02:31:19 +0000
Subject: [GIT PULL] ARM: aspeed: devicetree changes for 5.14
Message-ID: <CACPK8XduV9F=piu1qh56g+YNOZOBYTW7b2Y=XVYafpYDwWmDYA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Soc maintainers,

A normal looking Aspeed pull request for the next merge window.

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/bmc.git
tags/aspeed-5.14-devicetree

for you to fetch changes up to dd87684c7c9b82ad450cf063c58b4131074ad8f2:

  ARM: dts: aspeed: everest: Add pcie cable card indicator leds
(2021-06-07 13:38:55 +0930)

----------------------------------------------------------------
ASPEED device tree updates for 5.14

 - IBM Rainier and Everest LED descriptions. These systems have a large
   number of LEDs attached via expanders.

 - Ampere Mt Jade updates, as OpenBMC bringup continues for this
   machine.

 - Updated 64MB flash layout for systems using OpenBMC on NOR root file
   systems.

 - Support for HS200 MMC on AST2600 EVB. This is only supported from A2,
   so a new device tree is added to support A0 and A1.

 - Update all command lines for early serial output.

----------------------------------------------------------------
Eddie James (1):
      ARM: dts: aspeed: Rainier 4U: Remove fan updates

Joel Stanley (2):
      ARM: dts: aspeed: Set earlycon boot argument
      ARM: dts: aspeed-g5: Add SCU phandle to GFX node

Quan Nguyen (3):
      ARM: dts: aspeed: mtjade: Enable OCP card support via NC-SI
      ARM: dts: aspeed: mtjade: Add PSU support
      ARM: dts: aspeed: mtjade: switch to 64MB flash layout

Santosh Puranik (1):
      ARM: dts: aspeed: Everest: Fix cable card PCA chips

Steven Lee (4):
      ARM: dts: aspeed: ast2600evb: Add sdhci node and gpio regulator
for A2 evb.
      ARM: dts: aspeed: ast2600evb: Add phase correction for emmc controller.
      ARM: dts: aspeed: ast2600evb: Add dts file for A1 and A0
      ARM: dts: aspeed-g6: Add pinctrl settings

Troy Lee (1):
      ARM: dts: aspeed: Grow u-boot partition 64MiB OpenBMC flash layout

Vishwanatha Subbanna (7):
      ARM: dts: aspeed: Everest: Add directly controlled LEDs
      ARM: dts: aspeed: everest: Add system level indicator leds
      ARM: dts: aspeed: everest: Add nvme and fan indicator leds
      ARM: dts: aspeed: everest: Add pcie slot indicator leds
      ARM: dts: aspeed: everest: Add dimm indicator leds
      ARM: dts: aspeed: everest: Add vrm and other indicator leds
      ARM: dts: aspeed: everest: Add pcie cable card indicator leds

 arch/arm/boot/dts/Makefile                         |    1 +
 arch/arm/boot/dts/aspeed-ast2500-evb.dts           |    2 +-
 arch/arm/boot/dts/aspeed-ast2600-evb-a1.dts        |   15 +
 arch/arm/boot/dts/aspeed-ast2600-evb.dts           |  119 +-
 arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts      |    2 +-
 arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts     |   59 +-
 .../boot/dts/aspeed-bmc-arm-centriq2400-rep.dts    |    2 +-
 .../dts/aspeed-bmc-arm-stardragon4800-rep2.dts     |    2 +-
 arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts  |    2 +-
 arch/arm/boot/dts/aspeed-bmc-bytedance-g220a.dts   |    2 +-
 arch/arm/boot/dts/aspeed-bmc-facebook-cmm.dts      |    2 +-
 .../arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts |    2 +-
 arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts       | 2060 ++++++++++++++++++--
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier-4u.dts    |   30 -
 arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts   |    2 +-
 arch/arm/boot/dts/aspeed-bmc-inspur-on5263m5.dts   |    2 +-
 arch/arm/boot/dts/aspeed-bmc-intel-s2600wf.dts     |    2 +-
 arch/arm/boot/dts/aspeed-bmc-lenovo-hr630.dts      |    2 +-
 arch/arm/boot/dts/aspeed-bmc-lenovo-hr855xg2.dts   |    2 +-
 arch/arm/boot/dts/aspeed-bmc-microsoft-olympus.dts |    2 +-
 arch/arm/boot/dts/aspeed-bmc-opp-lanyang.dts       |    2 +-
 arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts        |    2 +-
 arch/arm/boot/dts/aspeed-bmc-opp-mowgli.dts        |    2 +-
 arch/arm/boot/dts/aspeed-bmc-opp-nicole.dts        |    2 +-
 arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts      |    2 +-
 arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts       |    2 +-
 arch/arm/boot/dts/aspeed-bmc-opp-swift.dts         |    2 +-
 arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts        |    2 +-
 arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts        |    2 +-
 arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts   |    2 +-
 arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts         |    2 +-
 arch/arm/boot/dts/aspeed-bmc-portwell-neptune.dts  |    2 +-
 arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dts       |    2 +-
 arch/arm/boot/dts/aspeed-bmc-supermicro-x11spi.dts |    2 +-
 arch/arm/boot/dts/aspeed-g5.dtsi                   |    1 +
 arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi           |   10 +
 arch/arm/boot/dts/openbmc-flash-layout-64.dtsi     |   18 +-
 37 files changed, 2116 insertions(+), 253 deletions(-)
 create mode 100644 arch/arm/boot/dts/aspeed-ast2600-evb-a1.dts
