From: Joel Stanley <joel@jms.id.au>
Date: Tue, 20 Apr 2021 07:14:07 +0000
Subject: [RESEND GIT PULL] ARM: bmc: devicetree changes for 5.13, v2
Message-ID: <CACPK8XeJdHmxyJn43Ju5hmxJ7+rJgHmx=ANFaL17YUmp+gOtJg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Arnd,

Here we go! The second try at a second set of changes for v5.13. I
think I've sorted out the gremlins, thank you for your patience.

The following changes since commit ee33e2fb3d70267de00f7c0b09e7e3b309a686df:

  ARM: dts: nuvoton: Add Quanta GBS BMC Device Tree (2021-04-08 11:21:05 +0930)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/bmc.git
tags/bmc-5.13-devicetree-2

for you to fetch changes up to f0145db24e65f6cf13347a90ffb86e5ef2ff2ca2:

  ARM: dts: aspeed: tiogapass: add hotplug controller (2021-04-16
12:28:38 +0930)

----------------------------------------------------------------
BMC device tree updates for 5.13, round two

 - Fixes to the first pull request for Rainier

 - Small changes for Rainier, EthanolX and Tiogapass

----------------------------------------------------------------
Eddie James (4):
      ARM: dts: aspeed: Rainier: Fix PCA9552 on bus 8
      ARM: dts: aspeed: Rainier: Fix humidity sensor bus address
      ARM: dts: aspeed: Rainier 1S4U: Fix fan nodes
      ARM: dts: aspeed: Rainier: Update to pass 2 hardware

Konstantin Aladyshev (1):
      ARM: dts: aspeed: amd-ethanolx: Enable all used I2C busses

Paul Fertser (1):
      ARM: dts: aspeed: tiogapass: add hotplug controller

 arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts      |  30 ++
 .../arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts |   5 +
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier-1s4u.dts  |   2 +-
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts       | 306 +++++++++++----------
 4 files changed, 201 insertions(+), 142 deletions(-)
