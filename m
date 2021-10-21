From: Joel Stanley <joel@jms.id.au>
Date: Thu, 21 Oct 2021 06:59:10 +0000
Subject: [GIT PULL] ARM: aspeed: devicetree changes for 5.16, round 2
Message-ID: <CACPK8Xd=eAMk-S3akhGgL4i_K190Nz9t=_CrdHQMJ+nbW172mg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello soc maintainers,

Hot on the heels of you merging my first pull request, here's a second
one with some changes I missed the first time, and some patches that
came in since.

Of note the two IBM P10 platforms now have all of their device tree
changes in mainline, so that's a milestone for them. They are our
biggest Aspeed BMC device trees, coming in at 2400 and 3600 lines of
description.

The following changes since commit 4eb7fe3333a021c8d0f35bcb5cd7c4e42800df62:

  ARM: dts: aspeed: fp5280g2: Use the 64M layout (2021-10-14 18:25:17 +1030)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/bmc.git
tags/aspeed-5.16-devicetree-2

for you to fetch changes up to f9241fe8b9652e6751f4ae684efe0148e3c157c7:

  ARM: dts: aspeed: Add uart routing to device tree (2021-10-21 16:59:53 +1030)

----------------------------------------------------------------
ASPEED device tree updates for 5.16, round 2

 - New machines:

  * Inventec Transformers, an x86 family server with an AST2600 BMC

 - Updates to the Everest and Rainier sensors, gpios and KCS devices

 - New UART routing device tree description

----------------------------------------------------------------
Andrew Jeffery (2):
      ARM: dts: aspeed: p10bmc: Use KCS 3 for MCTP binding
      ARM: dts: aspeed: p10bmc: Enable KCS channel 2

B. J. Wyman (1):
      ARM: dts: aspeed: rainier: Remove PSU gpio-keys

Chia-Wei Wang (1):
      ARM: dts: aspeed: Add uart routing to device tree

Eddie James (7):
      ARM: dts: aspeed: p10bmc: Fix ADC iio-hwmon battery node name
      ARM: dts: aspeed: rainier and everest: Remove PCA gpio specification
      ARM: dts: aspeed: everest: Add I2C switch on bus 8
      ARM: dts: aspeed: everest: Add IBM Operation Panel I2C device
      ARM: dts: aspeed: everest: Fix bus 15 muxed eeproms
      ARM: dts: aspeed: rainier: Add eeprom on bus 12
      ARM: dts: aspeed: rainier: Remove gpio hog for GPIOP7

Isaac Kurth (1):
      ARM: dts: aspeed: rainier: Add 'factory-reset-toggle' as GPIOF6

Joel Stanley (2):
      ARM: dts: aspeed: rainier: Add front panel LEDs
      ARM: dts: aspeed: rainier: Enable earlycon

Lin.TommySC ??? TAO (1):
      ARM: dts: aspeed: Adding Inventec Transformers BMC

 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts       | 735 ++-------------------
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts       | 634 ++----------------
 .../boot/dts/aspeed-bmc-inventec-transformers.dts  | 328 +++++++++
 arch/arm/boot/dts/aspeed-g4.dtsi                   |   6 +
 arch/arm/boot/dts/aspeed-g5.dtsi                   |   6 +
 arch/arm/boot/dts/aspeed-g6.dtsi                   |   6 +
 7 files changed, 470 insertions(+), 1246 deletions(-)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-inventec-transformers.dts
