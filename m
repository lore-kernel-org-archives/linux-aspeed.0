From: Joel Stanley <joel@jms.id.au>
Date: Thu, 14 Nov 2019 04:09:19 +0000
Subject: [GIT PULL] ARM: aspeed: defconfig changes for 5.5
Message-ID: <CACPK8Xc3a=6irkTSfwyPrr=nWv_fa9nMxthtC2AyqFJEWvuMwg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello ARM maintainers,

Here are some defconfig changes for 5.5. There is a diffstat and shortlog below.

The following changes since commit b50a85c023f494047a3767398ca589d1c801f22b:

  ARM: config: multi_v5: ASPEED SDHCI, SGPIO (2019-11-13 14:38:39 +1030)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git
tags/aspeed-5.5-defconfig

for you to fetch changes up to b50a85c023f494047a3767398ca589d1c801f22b:

  ARM: config: multi_v5: ASPEED SDHCI, SGPIO (2019-11-13 14:38:39 +1030)

----------------------------------------------------------------
ASPEED device tree updates for 5.5

This adds recently merged drivers to the aspeed g4 and g5 defconfigs,
and to the multi v5 and v7 shared defconfigs.

----------------------------------------------------------------

Joel Stanley (5):
      ARM: config: aspeed-g5: Enable 8250_DW quirks
      ARM: config: aspeed-g5: Add SGPIO and FSI drivers
      ARM: config: aspeed-g4: Add MMC, and cleanup
      ARM: configs: multi_v7: ASPEED network, gpio, FSI
      ARM: config: multi_v5: ASPEED SDHCI, SGPIO

 arch/arm/configs/aspeed_g4_defconfig | 18 ++++++++++++------
 arch/arm/configs/aspeed_g5_defconfig |  4 ++++
 arch/arm/configs/multi_v5_defconfig  |  4 ++++
 arch/arm/configs/multi_v7_defconfig  |  9 +++++++++
 4 files changed, 29 insertions(+), 6 deletions(-)
