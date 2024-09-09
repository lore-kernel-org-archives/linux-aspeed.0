From: Joel Stanley <joel@jms.id.au>
Date: Mon, 9 Sep 2024 20:41:17 +0930
Subject: [GIT PULL] ARM: aspeed: soc changes for 6.12
Message-ID: <CACPK8XeGDUrbJ-OaxqQBR=aVVYyrKGnvT1ZKXO0vPHpsjQ_i9g@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Arnd,

Here are some aspeed changes for v6.12. They are late because I forgot the pin
for my yubikey, so I couldn't sign a tag. All sorted now. I've missed
a few merge
windows so I sent this along just in case you had time to put it in this window.

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/bmc.git
tags/aspeed-6.12-devicetree

for you to fetch changes up to b4c322c2783aedd652183bcec6d545ad45eba6d9:

  ARM: dts: aspeed: catalina: Update io expander line names
(2024-08-27 13:00:49 +0930)

----------------------------------------------------------------
ASPEED device tree updates for 6.12

 - New machines

  * IBM P11 AST2600 BMC machines, named Blueridge and Fuji
  * Meta's Catalina AST2600 BMC

 - Updates to harma, minerva, mtmitchell, mtjade, system1, SPC621D8HM3

 - Various changes to the dtsi to keep the YAML checker happy

----------------------------------------------------------------
Andrew Jeffery (7):
      ARM: dts: aspeed: Fix coprocessor interrupt controller node name
      ARM: dts: aspeed: Specify correct generic compatible for CVIC
      ARM: dts: aspeed: Specify required properties for sram node
      ARM: dts: aspeed: Remove undocumented XDMA nodes
      ARM: dts: aspeed: Clean up AST2500 pinctrl properties
      ARM: dts: aspeed-g6: Use generic 'ethernet' for ftgmac100 nodes
      ARM: dts: aspeed-g6: Drop cells properties from ethernet nodes

Chanh Nguyen (5):
      ARM: dts: aspeed: mtjade, mtmitchell: Add OCP temperature sensors
      ARM: dts: aspeed: mtmitchell: Add I2C temperature sensor alias ports
      ARM: dts: aspeed: mtmitchell: Add Riser cards
      ARM: dts: aspeed: mtmitchell: Enable i2c10 and i2c15
      ARM: dts: aspeed: mtmitchell: Add LEDs

Eddie James (5):
      dt-bindings: arm: aspeed: add IBM P11 BMC boards
      ARM: dts: aspeed: Add IBM P11 FSI devices
      ARM: dts: aspeed: Add IBM P11 Blueridge BMC system
      ARM: dts: aspeed: Add IBM P11 Blueridge 4U BMC system
      ARM: dts: aspeed: Add IBM P11 Fuji BMC system

Ninad Palsule (1):
      ARM: dts: aspeed: System1: Updates to BMC board

Peter Yin (11):
      ARM: dts: aspeed: harma: Revise hsc chip
      ARM: dts: aspeed: harma: Add VR devices
      ARM: dts: aspeed: harma: Add sgpio name
      ARM: dts: aspeed: harma: Add ina238
      ARM: dts: aspeed: harma: Add power monitor xdp710
      ARM: dts: aspeed: harma: Remove multi-host property
      ARM: dts: aspeed: harma: Add fru device
      ARM: dts: aspeed: harma: Add temperature device
      ARM: dts: aspeed: harma: Enable mctp controller
      ARM: dts: aspeed: harma: Fix spi-gpio dtb_check warnings
      ARM: dts: aspeed: harma: Remove pca9546

Potin Lai (4):
      dt-bindings: arm: aspeed: add Meta Catalina board
      ARM: dts: aspeed: catalina: add Meta Catalina BMC
      ARM: dts: aspeed: catalina: Add pdb cpld io expander
      ARM: dts: aspeed: catalina: Update io expander line names

Rafa? Mi?ecki (1):
      ARM: dts: aspeed: convert ASRock SPC621D8HM3 NVMEM content to
layout syntax

Yang Chen (18):
      ARM: dts: aspeed: minerva: change the address of tmp75
      ARM: dts: aspeed: minerva: change aliases for uart
      ARM: dts: aspeed: minerva: add eeprom on i2c bus
      ARM: dts: aspeed: minerva: change RTC reference
      ARM: dts: aspeed: minerva: enable mdio3
      ARM: dts: aspeed: minerva: remove unused bus and device
      ARM: dts: aspeed: minerva: Define the LEDs node name
      ARM: dts: aspeed: minerva: Add adc sensors for fan board
      ARM: dts: aspeed: minerva: add linename of two pins
      ARM: dts: aspeed: minerva: enable ehci0 for USB
      ARM: dts: aspeed: minerva: add tmp75 sensor
      ARM: dts: aspeed: minerva: add power monitor xdp710
      ARM: dts: aspeed: minerva: revise sgpio line name
      ARM: dts: aspeed: minerva: Switch the i2c bus number
      ARM: dts: aspeed: minerva: remove unused power device
      ARM: dts: aspeed: minerva: add ltc4287 device
      ARM: dts: aspeed: minerva: Add spi-gpio
      ARM: dts: aspeed: minerva: add host0-ready pin

 .../devicetree/bindings/arm/aspeed/aspeed.yaml     |    3 +
 arch/arm/boot/dts/aspeed/Makefile                  |    3 +
 .../boot/dts/aspeed/aspeed-bmc-ampere-mtjade.dts   |   20 +-
 .../dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts    |  154 +
 .../aspeed/aspeed-bmc-arm-stardragon4800-rep2.dts  |    4 -
 .../dts/aspeed/aspeed-bmc-asrock-spc621d8hm3.dts   |   12 +-
 .../boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts  |    4 -
 .../dts/aspeed/aspeed-bmc-facebook-catalina.dts    | 1110 ++++++
 .../boot/dts/aspeed/aspeed-bmc-facebook-harma.dts  |  177 +-
 .../dts/aspeed/aspeed-bmc-facebook-minerva.dts     |  518 ++-
 .../dts/aspeed/aspeed-bmc-ibm-blueridge-4u.dts     |   21 +
 .../boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dts   | 1686 +++++++++
 .../arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts |    5 -
 .../arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts |    5 -
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dts   | 3876 ++++++++++++++++++++
 .../arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts |    5 -
 .../arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts |    6 +-
 .../boot/dts/aspeed/aspeed-bmc-inspur-fp5280g2.dts |    4 -
 .../boot/dts/aspeed/aspeed-bmc-inspur-on5263m5.dts |    4 -
 .../boot/dts/aspeed/aspeed-bmc-intel-s2600wf.dts   |    4 -
 .../arm/boot/dts/aspeed/aspeed-bmc-opp-lanyang.dts |    4 -
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-nicole.dts |    4 -
 .../arm/boot/dts/aspeed/aspeed-bmc-opp-romulus.dts |    4 -
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-swift.dts  |    4 -
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts |    5 -
 .../boot/dts/aspeed/aspeed-bmc-opp-witherspoon.dts |    9 -
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-zaius.dts  |    2 -
 .../dts/aspeed/aspeed-bmc-supermicro-x11spi.dts    |    4 -
 arch/arm/boot/dts/aspeed/aspeed-g4.dtsi            |    7 +-
 arch/arm/boot/dts/aspeed/aspeed-g5.dtsi            |   18 +-
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi            |   29 +-
 arch/arm/boot/dts/aspeed/ibm-power11-quad.dtsi     | 1539 ++++++++
 32 files changed, 8939 insertions(+), 311 deletions(-)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge-4u.dts
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dts
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dts
 create mode 100644 arch/arm/boot/dts/aspeed/ibm-power11-quad.dtsi
