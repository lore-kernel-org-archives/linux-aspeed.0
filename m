From: Joel Stanley <joel@jms.id.au>
Date: Mon, 28 Feb 2022 05:56:30 +0000
Subject: [GIT PULL v2] ARM: aspeed: devicetree changes for 5.18
Message-ID: <CACPK8XdUXy5cnEDKmNirtByNMBGCjXwZpdKqJ0ytc0f34vzbBA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Soc maintainers,

Here are the aspeed bits for v5.18, with the tag on the correct branch
this time.

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/bmc.git
tags/aspeed-5.18-devicetree-2

for you to fetch changes up to 09603f805ab69dbf18015363c2a00001647e89f2:

  ARM: dts: aspeed: p10bmc: Enable ftrace in ramoops buffer
(2022-02-28 15:46:12 +1030)

----------------------------------------------------------------
ASPEED device tree updates for 5.18

 - New machines

  * Quanta S6Q AST2600 BMC
  * ASRock ROMED8HM3 AST2500 BMC, a half-width, single-socket Epyc
    server board

 - Facebook's Bletchley has a large update for production hardware

 - Ampere's Mt Jade has a number of updates

 - Small clenaups and additions for Everest, Rainier and Tacoma, and the
   flash layout

----------------------------------------------------------------
Andrew Geissler (2):
      ARM: dts: aspeed: everest: Label reset-cause-pinhole GPIO
      ARM: dts: aspeed: rainier: Label reset-cause-pinhole GPIO

Andrew Jeffery (1):
      ARM: dts: aspeed: tacoma: Clean up KCS nodes

Eddie James (3):
      ARM: dts: aspeed: rainier and everest: Enable UHCI
      ARM: dts: aspeed: tacoma: Remove CFAM reset GPIO
      ARM: dts: aspeed: p10bmc: Enable ftrace in ramoops buffer

George Hung (1):
      ARM: dts: aspeed: Add device tree for Quanta S6Q BMC

Joel Stanley (3):
      ARM: dts: aspeed: rainier: Remove SPI NOR controllers
      ARM: dts: aspeed: rainer: Add RTC battery gpio name
      ARM: dts: aspeed: everest: Add RTC battery gpio name

Potin Lai (10):
      ARM: dts: aspeed: bletchley: Switch sled numbering to 1-based
      ARM: dts: aspeed: bletchley: Separate leds into multiple groups
      ARM: dts: aspeed: bletchley: Update gpio-line-names
      ARM: dts: aspeed: bletchley: Update fmc configurations
      ARM: dts: aspeed: bletchley: Switch to spi-gpio for spi2
      ARM: dts: aspeed: bletchley: Add interrupt support for sled io expander
      ARM: dts: aspeed: bletchley: Add shunt-resistor for ADM1278
      ARM: dts: aspeed: bletchley: Add INA230 sensor on each sled
      ARM: dts: aspeed: bletchley: Enable mdio3 bus
      ARM: dts: aspeed: bletchley: Cleanup redundant nodes

Quan Nguyen (5):
      ARM: dts: aspeed: mtjade: Enable secondary flash
      ARM: dts: aspeed: mtjade: Update rtc-battery-voltage-read-enable pin
      ARM: dts: aspeed: mtjade: Update host0-ready pin
      ARM: dts: aspeed: mtjade: Rename GPIO hog nodes to match schema.
      ARM: dts: aspeed: mtjade: Move all adc sensors into iio-hwmon node

Zev Weiss (2):
      ARM: dts: Fix OpenBMC flash layout label addresses
      ARM: dts: aspeed: Add ASRock ROMED8HM3 BMC

 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts     |  26 +-
 arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts  | 259 +++++++++
 .../arm/boot/dts/aspeed-bmc-facebook-bletchley.dts | 320 +++++++----
 arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts       |  11 +-
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts       |  33 +-
 arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts        |  12 +-
 arch/arm/boot/dts/aspeed-bmc-quanta-s6q.dts        | 610 +++++++++++++++++++++
 arch/arm/boot/dts/openbmc-flash-layout-64.dtsi     |   2 +-
 arch/arm/boot/dts/openbmc-flash-layout.dtsi        |   2 +-
 10 files changed, 1112 insertions(+), 165 deletions(-)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-quanta-s6q.dts
