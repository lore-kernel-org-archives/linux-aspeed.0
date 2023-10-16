From: Joel Stanley <joel@jms.id.au>
Date: Mon, 16 Oct 2023 12:17:46 +1030
Subject: [GIT PULL] ARM: aspeed: devicetree changes for 6.7
Message-ID: <CACPK8XebMAQvgQTRH+KoaTFg7CzRkS79Fz3Kn8p4mbaezWGkUQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello soc maintainers,

I've rejigged my gpg setup and I'm now signing with a new sub-key. Let
me know if that causes any issues.

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/bmc.git
tags/aspeed-6.7-devicetree

for you to fetch changes up to d024ca2792b17577c48f0cf23d648cea6f1a0b9a:

  ARM: dts: aspeed: mtmitchell: Add I2C NVMe alias port (2023-10-13
14:59:03 +1030)

----------------------------------------------------------------
ASPEED device tree updates for 6.7

 - New machine:

  * Facebook's Minevra, as Chassis Management Controller using the
    AST2600

 - Updates to Ampere's Mt Mitchell and Mt Jade systems, and IBM's
   Bonnell

----------------------------------------------------------------
Chanh Nguyen (6):
      ARM: dts: aspeed: mtjade, mtmitchell: Update gpio-line-names
      ARM: dts: aspeed: mtjade, mtmitchell: Add new gpio-line-names
      ARM: dts: aspeed: mtjade: Add the gpio-hog
      ARM: dts: aspeed: mtmitchell: Add inlet temperature sensor
      ARM: dts: aspeed: mtmitchell: Remove redundant ADC configurations
      ARM: dts: aspeed: mtmitchell: Add I2C NVMe alias port

Eddie James (1):
      ARM: dts: aspeed: bonnell: Add reserved memory for TPM event log

Yang Chen (2):
      dt-bindings: arm: aspeed: document board compatibles
      ARM: dts: aspeed: Minerva: Add Facebook Minerva CMC board

 .../devicetree/bindings/arm/aspeed/aspeed.yaml     |   1 +
 arch/arm/boot/dts/aspeed/Makefile                  |   1 +
 .../boot/dts/aspeed/aspeed-bmc-ampere-mtjade.dts   |  66 +++--
 .../dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts    | 302 +++++++++++++++++++--
 .../dts/aspeed/aspeed-bmc-facebook-minerva-cmc.dts | 265 ++++++++++++++++++
 .../arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts |   8 +-
 6 files changed, 595 insertions(+), 48 deletions(-)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva-cmc.dts
