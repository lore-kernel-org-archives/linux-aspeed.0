From: Joel Stanley <joel@jms.id.au>
Date: Tue, 22 Nov 2022 00:57:29 +0000
Subject: [GIT PULL] ARM: aspeed: devicetree changes for 6.2
Message-ID: <CACPK8Xfsc8BaL_qAgV+3Rk-AFcQoDVfTpMzHvq_rR-UYqwpNNQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello soc maintainers,

Here are the aspeed device tree changes for v6.2.

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/bmc.git
tags/aspeed-6.2-devicetree

for you to fetch changes up to 3973fc0f9f07fc4186bb581014404fbf77a659b5:

  ARM: dts: aspeed: mtjade: Add SMPro nodes (2022-11-20 20:47:32 +1030)

----------------------------------------------------------------
ASPEED device tree updates for 6.2

 - New machines

  * IBM Bonnell AST2600 BMC, for a Power10 server
  * Delta AHE-50DC AST1250 BMC, for a 1U Open19 power shelf

 - Removed machines

  * IBM Mihawk AST2500 BMC, a Power9 server similar to Witherspoon

 - Fixes and updates for bletchley, mtjade/mtmitchell, rainier/everest

----------------------------------------------------------------
Adriana Kobylak (1):
      ARM: dts: aspeed: rainier,everest: Move reserved memory regions

Eddie James (2):
      ARM: dts: aspeed: Add IBM Bonnell system BMC devicetree
      ARM: dts: aspeed: p10bmc: Add occ-hwmon nodes

Joel Stanley (1):
      ARM: dts: aspeed: Remove Mihawk

Potin Lai (7):
      ARM: dts: aspeed: bletchley: Change LED sys_log_id to active low
      ARM: dts: aspeed: bletchley: Disable GPIOV2 pull-down
      ARM: dts: aspeed: bletchley: Bind presence-sledX pins via gpio-keys
      ARM: dts: aspeed: bletchley: Update fusb302 nodes
      ARM: dts: aspeed: bletchley: Update and fix gpio-line-names
      ARM: dts: aspeed: bletchley: Enable emmc and ehci1
      ARM: dts: aspeed-g6: Add aliases for mdio nodes

Quan Nguyen (2):
      ARM: dts: aspeed: mtjade,mtmitchell: Add BMC SSIF nodes
      ARM: dts: aspeed: mtjade: Add SMPro nodes

Santosh Puranik (1):
      ARM: dts: aspeed: rainier: Fix pca9551 nodes

Zev Weiss (2):
      dt-bindings: arm: aspeed: document Delta AHE-50DC BMC
      ARM: dts: aspeed: Add Delta AHE-50DC BMC

 .../devicetree/bindings/arm/aspeed/aspeed.yaml     |    1 +
 arch/arm/boot/dts/Makefile                         |    3 +-
 arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts     |   12 +
 arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts |    4 +
 arch/arm/boot/dts/aspeed-bmc-delta-ahe50dc.dts     |  418 ++++++
 .../arm/boot/dts/aspeed-bmc-facebook-bletchley.dts |  213 ++-
 arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts       |  921 +++++++++++++
 arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts       |   57 +-
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts       |  244 ++--
 arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts        | 1381 --------------------
 arch/arm/boot/dts/aspeed-g6.dtsi                   |    4 +
 11 files changed, 1705 insertions(+), 1553 deletions(-)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-delta-ahe50dc.dts
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts
 delete mode 100644 arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts
