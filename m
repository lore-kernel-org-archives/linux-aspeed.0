From: Joel Stanley <joel@jms.id.au>
Date: Fri, 5 Apr 2019 03:47:38 +0000
Subject: [GIT PULL] ARM: aspeed: dts changes for 5.2
Message-ID: <CACPK8XdevZ9LHtVVu=fHbTxSKfDugym3jT0ueKEpa9qhLYbFnw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello ARM Maintainers,

Here's the first ASPEED device tree pull request for 5.2. There might be a
second one later as I pushed out a pair of patches for review today.

The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git \
    tags/aspeed-5.2-devicetree

for you to fetch changes up to 6d00c6f8d2e781e3c821fc9c614f404cc981804d:

  ARM: dts: aspeed: Add RTC node (2019-04-05 14:08:20 +1030)

----------------------------------------------------------------
ASPEED device tree updates for 5.2

 - RTC and GFX DRM driver went upstream this cycle

 - Miscellaneous board updates for Facebook and IBM BMCs

----------------------------------------------------------------
Eddie James (2):
      ARM: dts: aspeed: witherspoon: Enable vhub
      ARM: dts: aspeed-g5: Add video engine

Edward A. James (1):
      ARM: dts: aspeed: witherspoon: Update BMC partitioning

Joel Stanley (4):
      ARM: dts: aspeed: ast2500: Update flash layout
      ARM: dts: aspeed-g5: Add resets and clocks to GFX node
      ARM: dts: aspeed: Enable the GFX IP
      ARM: dts: aspeed: Add RTC node

Lei YU (1):
      ARM: dts: aspeed: palmetto: Fix flash_memory region

Tao Ren (1):
      ARM: dts: aspeed: cmm: enable iio-hwmon-adc

Vijay Khemka (1):
      ARM: dts: aspeed: tiogapass: Enable VUART

 arch/arm/boot/dts/aspeed-ast2500-evb.dts           | 21 ++++++++-
 arch/arm/boot/dts/aspeed-bmc-facebook-cmm.dts      |  6 +++
 .../arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts |  5 +++
 arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts      |  4 +-
 arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts       |  8 ++++
 arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts   | 52 +++++++++++++++++++++-
 arch/arm/boot/dts/aspeed-g4.dtsi                   |  6 +++
 arch/arm/boot/dts/aspeed-g5.dtsi                   | 20 +++++++++
 8 files changed, 117 insertions(+), 5 deletions(-)
