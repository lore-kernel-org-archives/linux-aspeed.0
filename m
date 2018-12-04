From: Joel Stanley <joel@jms.id.au>
Date: Wed, 5 Dec 2018 10:21:08 +1030
Subject: [GIT PULL] ARM: aspeed: dts changes for 4.21
Message-ID: <CACPK8XcioxMDmJpKxdA7xfSmvEy++LUtELGOxRaoBFB0cT0RSA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello ARM maintainers,

Here's the ASPEED pull request. A new system from Facebook and some
small updates that were being carried in the OpenBMC kernel tree.
Thanks!

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git \
    tags/aspeed-4.21-devicetree

for you to fetch changes up to 76d0bbd8a4ef1b1256d49e082a61a33eb0b004c7:

  ARM: dts: aspeed: Add Facebook Backpack-CMM BMC (2018-12-03 09:17:15 +1030)

----------------------------------------------------------------
ASPEED device tree updates for 4.20

 - New machine: Facebook Backpack-CMM BMC and flash layout

 - OpenPower reference systems (Palmetto P8, Romulus P9) move to the
   ColdFire based FSI driver

 - Misc device tree updates from the OpenBMC project

----------------------------------------------------------------
Benjamin Herrenschmidt (2):
      ARM: dts: aspeed: Romulus system can use coprocessor for FSI
      ARM: dts: aspeed: Palmetto system can use coprocessor for FSI

Joel Stanley (2):
      ARM: dts: aspeed-palmetto: Add LPC control node
      ARM: dts: aspeed: Enable VHUB on Romulus

Lei YU (1):
      ARM: dts: aspeed: romulus: Enable iio-hwmon-battery

Matt Spinler (1):
      ARM: dts: aspeed: wspoon: Enable iio-hwmon battery

Tao Ren (2):
      ARM: dts: Add Facebook BMC flash layout
      ARM: dts: aspeed: Add Facebook Backpack-CMM BMC

 arch/arm/boot/dts/Makefile                       |   1 +
 arch/arm/boot/dts/aspeed-bmc-facebook-cmm.dts    | 368 +++++++++++++++++++++++
 arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts    |  39 ++-
 arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts     |  24 +-
 arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts |   9 +
 arch/arm/boot/dts/facebook-bmc-flash-layout.dtsi |  42 +++
 6 files changed, 475 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-cmm.dts
 create mode 100644 arch/arm/boot/dts/facebook-bmc-flash-layout.dtsi
