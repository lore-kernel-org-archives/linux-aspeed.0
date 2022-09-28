From: Joel Stanley <joel@jms.id.au>
Date: Wed, 28 Sep 2022 04:44:08 +0000
Subject: [GIT PULL] ARM: aspeed: defconfig changes for 6.1
Message-ID: <CACPK8XeLzL3hT8fwVw9fV7Ccduz_PNhZn_67z2yXefCEha6jJg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Soc maintainers,

After a brief hiatus that saw me absent for the past merge window, I'm
back on deck and catching up. This branch has a long awaited sync of
the openbmc defconfig (where most of the aspeed code is consumed) with
the one in mainline.

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/bmc.git
tags/aspeed-6.1-defconfig

for you to fetch changes up to e0d468427882556b8815e09769bbbc3281478b1e:

  ARM: config: aspeed_g5: Enable PECI (2022-09-28 12:34:02 +0930)

----------------------------------------------------------------
ASPEED defconfig updates for 6.1

 - A long awaited sync to make the config closer to that used by OpenBMC
   machines

 - Enable PECI to provide defconfig coverage for the subsystem

----------------------------------------------------------------
Adriana Kobylak (1):
      ARM: configs: aspeed: Add support for USB flash drives

Joel Stanley (10):
      ARM: configs: aspeed_g5: Add mp5023 driver
      ARM: configs: aspeed_g5: Add TPM TIS I2C driver
      ARM: configs: aspeed_g5: Add PL2303 USB serial driver
      ARM: configs: aspeed_g5: Enable MCTP stack
      ARM: configs: aspeed_g4: Enable OCC and NBD drivers
      ARM: configs: aspeed_g4: Enable IPV6 options
      ARM: config: aspeed: Enable namespaces
      ARM: configs: aspeed: Refresh defconfigs
      ARM: configs: aspeed_g4: Remove appended DTB and ATAG
      ARM: config: aspeed_g5: Enable PECI

 arch/arm/configs/aspeed_g4_defconfig | 10 +++++++---
 arch/arm/configs/aspeed_g5_defconfig | 20 +++++++++++++++++++-
 2 files changed, 26 insertions(+), 4 deletions(-)
