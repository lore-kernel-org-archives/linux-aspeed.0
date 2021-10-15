From: Joel Stanley <joel@jms.id.au>
Date: Fri, 15 Oct 2021 04:01:30 +0000
Subject: [GIT PULL] ARM: aspeed: devicetree changes for 5.16
Message-ID: <CACPK8XdrMzY9tzdof7KpzxKquTo7GcWW4N9Zqwtmmu73C7htXA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Soc maintainers,

Here are the aspeed device tree changes for v5.16.

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/bmc.git
tags/aspeed-5.16-devicetree

for you to fetch changes up to 4eb7fe3333a021c8d0f35bcb5cd7c4e42800df62:

  ARM: dts: aspeed: fp5280g2: Use the 64M layout (2021-10-14 18:25:17 +1030)

----------------------------------------------------------------
ASPEED device tree updates for 5.15

 - New machines:

  * TYAN S7106 BMC, a x86 server from about four years ago

 - Descriptions for the AST2600 ADC, which now has an upstream driver

 - Lots of GPIO line names. The OpenBMC project has adopted a scheme for
   naming the lines, and new additions will follow this guide

 - New I2C devices for Rainier, Everest, EthanolX, Mt Jade

 - Fixes for fp5280g2 which has seen some recent development, including
   the addtion of a QEmu machine for testing

----------------------------------------------------------------
Adriana Kobylak (1):
      ARM: dts: aspeed: rainier: Add power-config-full-load gpio

Ben Tyner (3):
      ARM: dts: rainier: Define name for gpio line Q2
      ARM: dts: everest: Define name for gpio line Q2
      ARM: dts: everest: Define name for gpio line B6

Eddie James (3):
      ARM: dts: aspeed: rainier: Add system LEDs
      ARM: dts: aspeed: everest: Add I2C bus 15 muxes
      ARM: dts: aspeed: Add ADC for AST2600 and enable for Rainier and Everest

George Liu (1):
      ARM: dts: fp5280g2: Enable KCS 3 for MCTP binding

Isaac Kurth (1):
      ARM: dts: everest: Add 'factory-reset-toggle' as GPIOF6

Joel Stanley (1):
      ARM: dts: aspeed: p10bmc: Define secure boot gpio

John Wang (1):
      ARM: dts: aspeed: fp5280g2: Use the 64M layout

Konstantin Aladyshev (1):
      ARM: dts: aspeed: amd-ethanolx: Add FRU EEPROM

Oskar Senft (1):
      ARM: dts: aspeed: Add TYAN S7106 BMC machine

Quan Nguyen (1):
      ARM: dts: aspeed: mtjade: Add some gpios

 arch/arm/boot/dts/Makefile                       |    3 +-
 arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts    |    5 +
 arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts   |   21 +-
 arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts     |  182 ++-
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts     | 1571 +++++++++++++++++++---
 arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts |    9 +-
 arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts      |  488 +++++++
 arch/arm/boot/dts/aspeed-g6.dtsi                 |   20 +
 8 files changed, 2075 insertions(+), 224 deletions(-)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts
