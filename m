From: Joel Stanley <joel@jms.id.au>
Date: Fri, 3 May 2024 20:53:11 +0930
Subject: [GIT PULL] ARM: aspeed: devicetree changes for 6.10
Message-ID: <CACPK8Xd2Qc9MQUJ-8GuRjmyU50oMHpmmHPHLqAh9W_1Gyqi2ug@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Soc maintainers,

Here are the ASPEED device tree changes for 6.10. I've missed a few
releases as I was
on leave. Andrew Jeffery has stepped up and helped this cycle, some of the
patches were committed by him this time around.

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/bmc.git
tags/aspeed-6.10-devicetree

for you to fetch changes up to c44211af1aa9c6b93178a3993e18a7ebffab7488:

  ARM: dts: aspeed: Add ASRock E3C256D4I BMC (2024-05-02 17:57:16 +0930)

----------------------------------------------------------------
ASPEED device tree updates for 6.10

 - New and removed machines:

  * IBM System1 AST2600 BMC, a x86 server
  * ASUS X4TF AST2600 BMC, a x86 server
  * ASRock SPC621D8HM3 AST2500 BMC, a Intel Xeon system
  * ASRock E3C256D4I AST2500 BMC, a Intel Xeon system
  * Add ASRock X570D4U's AST2500 BMC, an AMD Ryzen 5000 system
  * Facebook Harma's AST2600 BMC
  * Facebook Cloudripper is removed

 - Updates to machines merged this cycle, as well as bonnell,
   yosemite4, minerva and others

----------------------------------------------------------------
Andrew Geissler (1):
      ARM: dts: aspeed: system1: IBM System1 BMC board

Delphine CC Chiu (2):
      ARM: dts: aspeed: yosemite4: Enable ipmb device for OCP debug card
      ARM: dts: aspeed: yosemite4: set bus13 frequency to 100k

Eddie James (2):
      ARM: dts: aspeed: FSI interrupt support
      ARM: dts: Aspeed: Bonnell: Fix NVMe LED labels

Kelly Hung (2):
      dt-bindings: arm: aspeed: add ASUS X4TF board
      ARM: dts: aspeed: x4tf: Add dts for asus x4tf project

Krzysztof Kozlowski (5):
      ARM: dts: aspeed: greatlakes: correct Mellanox multi-host property
      ARM: dts: aspeed: yosemite4: correct Mellanox multi-host property
      ARM: dts: aspeed: yosemitev2: correct Mellanox multi-host property
      ARM: dts: aspeed: harma: correct Mellanox multi-host property
      ARM: dts: aspeed: drop unused ref_voltage ADC property

Ninad Palsule (1):
      dt-bindings: arm: aspeed: add IBM system1-bmc

Peter Yin (14):
      dt-bindings: arm: aspeed: add Meta Harma board
      ARM: dts: aspeed: Harma: Add Meta Harma (AST2600) BMC
      ARM: dts: aspeed: Harma: Revise SGPIO line name.
      ARM: dts: aspeed: Harma: mapping ttyS2 to UART4.
      ARM: dts: aspeed: Harma: Remove Vuart
      ARM: dts: aspeed: Harma: Add cpu power good line name
      ARM: dts: aspeed: Harma: Add spi-gpio
      ARM: dts: aspeed: Harma: Add PDB temperature
      ARM: dts: aspeed: Harma: Revise max31790 address
      ARM: dts: aspeed: Harma: Add NIC Fru device
      ARM: dts: aspeed: Harma: Add ltc4286 device
      ARM: dts: aspeed: Harma: Revise node name
      ARM: dts: aspeed: Harma: Add retimer device
      ARM: dts: aspeed: Harma: Modify GPIO line name

Renze Nicolai (5):
      dt-bindings: arm: aspeed: add Asrock X570D4U board
      ARM: dts: aspeed: asrock: Add ASRock X570D4U BMC
      ARM: dts: aspeed: Modify GPIO table for Asrock X570D4U BMC
      ARM: dts: aspeed: Disable unused ADC channels for Asrock X570D4U BMC
      ARM: dts: aspeed: Modify I2C bus configuration

Tao Ren (1):
      ARM: dts: aspeed: Remove Facebook Cloudripper dts

Yang Chen (11):
      ARM: dts: aspeed: minerva: Revise the name of DTS
      ARM: dts: aspeed: minerva: Modify mac3 setting
      ARM: dts: aspeed: minerva: Change sgpio use
      ARM: dts: aspeed: minerva: Enable power monitor device
      ARM: dts: aspeed: minerva: Add temperature sensor
      ARM: dts: aspeed: minerva: correct the address of eeprom
      ARM: dts: aspeed: minerva: add bus labels and aliases
      ARM: dts: aspeed: minerva: add fan rpm controller
      ARM: dts: aspeed: minerva: Add led-fan-fault gpio
      ARM: dts: aspeed: minerva: add gpio line name
      ARM: dts: aspeed: minerva: add sgpio line name

Zev Weiss (8):
      dt-bindings: arm: aspeed: document ASRock SPC621D8HM3
      ARM: dts: aspeed: Add ASRock SPC621D8HM3 BMC
      ARM: dts: aspeed: asrock: Use MAC address from FRU EEPROM
      ARM: dts: aspeed: Add vendor prefixes to lm25066 compat strings
      ARM: dts: aspeed: ahe50dc: Update lm25066 regulator name
      dt-bindings: trivial-devices: add isil,isl69269
      dt-bindings: arm: aspeed: document ASRock E3C256D4I
      ARM: dts: aspeed: Add ASRock E3C256D4I BMC

 .../devicetree/bindings/arm/aspeed/aspeed.yaml     |    6 +
 .../devicetree/bindings/trivial-devices.yaml       |    2 +
 arch/arm/boot/dts/aspeed/Makefile                  |    9 +-
 .../dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts    |    1 -
 .../dts/aspeed/aspeed-bmc-asrock-e3c246d4i.dts     |    9 +
 .../dts/aspeed/aspeed-bmc-asrock-e3c256d4i.dts     |  322 ++++
 .../dts/aspeed/aspeed-bmc-asrock-romed8hm3.dts     |   13 +-
 .../dts/aspeed/aspeed-bmc-asrock-spc621d8hm3.dts   |  324 ++++
 .../boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts  |  360 +++++
 arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts  |  581 +++++++
 .../boot/dts/aspeed/aspeed-bmc-delta-ahe50dc.dts   |    4 +-
 .../dts/aspeed/aspeed-bmc-facebook-cloudripper.dts |  544 -------
 .../dts/aspeed/aspeed-bmc-facebook-greatlakes.dts  |    4 +-
 .../boot/dts/aspeed/aspeed-bmc-facebook-harma.dts  |  648 ++++++++
 .../dts/aspeed/aspeed-bmc-facebook-minerva-cmc.dts |  265 ----
 .../dts/aspeed/aspeed-bmc-facebook-minerva.dts     |  543 +++++++
 .../dts/aspeed/aspeed-bmc-facebook-yosemite4.dts   |   15 +-
 .../dts/aspeed/aspeed-bmc-facebook-yosemitev2.dts  |    2 +-
 .../arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts |    8 +-
 .../arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts | 1623 ++++++++++++++++++++
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi            |    4 +
 arch/arm/boot/dts/aspeed/ibm-power10-dual.dtsi     |    2 +
 22 files changed, 4460 insertions(+), 829 deletions(-)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c256d4i.dts
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-spc621d8hm3.dts
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts
 delete mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-cloudripper.dts
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
 delete mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva-cmc.dts
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
