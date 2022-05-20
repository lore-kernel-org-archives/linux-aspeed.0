From: Joel Stanley <joel@jms.id.au>
Date: Fri, 20 May 2022 03:34:50 +0000
Subject: [GIT PULL] ARM: aspeed: devicetree changes for 5.19
Message-ID: <CACPK8XfUmFxU8Y6C+aZ2+=dT7=fCfs2=2_aYqyRjoXCoeQaUWQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Soc maintainers,

Here is the (second) device tree pull request for aspeed socs. The
first ended up being the fixes I sent, which Arnd decided to put in
-next.

The following changes since commit 32e62d1beab70d485980013312e747a25c4e13f7:

  ARM: dts: aspeed: Add video engine to g6 (2022-04-13 11:53:53 +0930)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/bmc.git
tags/aspeed-5.19-devicetree

for you to fetch changes up to 8dc7aa0a7246ad0f718d91d09b4d48460508627b:

  ARM: dts: aspeed: ast2600-evb: Enable GFX device (2022-05-19 17:18:56 +0930)

----------------------------------------------------------------
ASPEED device tree updates for 5.19

 - New machine:

    * Nuvia's DC-SCM BMC

 - Enable AST2600 GFX, the BMC-driven graphics device

 - Add a bunch of devices for the AST2600 EVB

 - Updates to the AST2600 Bletchley machine

 - Backwards compatible changes to support the new spi-mem based SPI NOR
   driver

----------------------------------------------------------------
Brandon Wyman (1):
      ARM: dts: aspeed: everest, rainier: Add power-ffs-sync-history GPIO

C?dric Le Goater (2):
      ARM: dts: aspeed: Adjust "reg" property of FMC/SPI controllers
      ARM: dts: aspeed: Enable Dual SPI RX transfers

Graeme Gregory (1):
      ARM: dts: aspeed: Add Nuvia DC-SCM BMC

Howard Chiu (3):
      ARM: dts: aspeed: ast2600-evb: Enable RX delay for MAC0/MAC1
      ARM: dts: aspeed: ast2600-evb: Enable video engine
      ARM: dts: aspeed: ast2600-evb: Enable virtual hub

Joel Stanley (2):
      ARM: dts: aspeed: Add GFX node to AST2600
      ARM: dts: aspeed: ast2600-evb: Enable GFX device

Neal Liu (1):
      ARM: dts: aspeed: Add USB2.0 device controller node

Potin Lai (7):
      ARM: dts: aspeed: bletchley: enable ehci0 device node
      ARM: dts: aspeed: bletchley: switch spi2 driver to aspeed-smc
      ARM: dts: aspeed: bletchley: Enable mdio0 bus
      ARM: dts: aspeed: bletchley: update gpio0 line names
      ARM: dts: aspeed: bletchley: add pca9536 node on each sled
      ARM: dts: aspeed: bletchley: add eeprom node on each sled
      ARM: dts: aspeed: bletchley: add sample averaging for ADM1278

Tao Ren (1):
      ARM: dts: aspeed-g4: Set spi-max-frequency for all flashes

 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/aspeed-ast2600-evb.dts           |  39 ++++-
 .../arm/boot/dts/aspeed-bmc-facebook-bletchley.dts | 182 ++++++++++++++++----
 arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts       |   2 +-
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts       |   2 +-
 arch/arm/boot/dts/aspeed-bmc-nuvia-dc-scm.dts      | 190 +++++++++++++++++++++
 arch/arm/boot/dts/aspeed-g4.dtsi                   |  16 +-
 arch/arm/boot/dts/aspeed-g5.dtsi                   |  16 +-
 arch/arm/boot/dts/aspeed-g6.dtsi                   |  38 ++++-
 9 files changed, 431 insertions(+), 55 deletions(-)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-nuvia-dc-scm.dts
