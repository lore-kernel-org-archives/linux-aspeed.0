From: Joel Stanley <joel@jms.id.au>
Date: Thu, 21 Oct 2021 05:34:39 +0000
Subject: [GIT PULL] ARM: aspeed: defconfig changes for 5.16
Message-ID: <CACPK8Xd0mVn2Cy7d=VBTDMpU=WHrftsiihwH224ekFSDGKAbyA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Soc maintainers,

Here are aspeed defconfig changes for v5.16.

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/bmc.git
tags/aspeed-5.16-defconfig

for you to fetch changes up to 52a490e0efac02f236295cf43e136a1cb3a786f7:

  ARM: configs: aspeed: Remove unused USB gadget devices (2021-10-15
15:02:32 +1030)

----------------------------------------------------------------
ASPEED defconfig updates for 5.16

 - Add options that are enabled in the common OpenBMC kernel

 - Re-enable DRM_FBDEV_EMULATION

 - Turn on the various sensor drivers that are used in BMC systems,
 so we can boot test where they are modelled in Qemu

----------------------------------------------------------------
Joel Stanley (6):
      ARM: configs: aspeed_g5: Reneable DRM_FBDEV_EMULATION
      ARM: configs: aspeed: Disable IPV6 SIT device
      ARM: configs: aspeed: Enable commonly used drivers
      ARM: configs: aspeed: Enable pstore and lockup detectors
      ARM: config: aspeed: Enable Network Block Device
      ARM: configs: aspeed: Remove unused USB gadget devices

 arch/arm/configs/aspeed_g4_defconfig |  1 +
 arch/arm/configs/aspeed_g5_defconfig | 35 ++++++++++++++++++++++-------------
 2 files changed, 23 insertions(+), 13 deletions(-)
