From: Joel Stanley <joel@jms.id.au>
Date: Mon, 16 Oct 2023 12:18:24 +1030
Subject: [GIT PULL] ARM: aspeed: defconfig changes for 6.7
Message-ID: <CACPK8XezpL-4bx0S-9t999_qde5Hik9BnuUZHcnmDHTd0KWBLA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello soc maintainers,

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/bmc.git
tags/aspeed-6.7-defconfig

for you to fetch changes up to f1538805cf9da7a1be38c78690a0d3809e330acd:

  ARM: config: aspeed: Remove FIRMWARE_MEMMAP (2023-10-13 14:56:11 +1030)

----------------------------------------------------------------
ASPEED defconfig updates for 6.7

 * Enable SMPro and FSI drivers, the BMC to host interfaces for Ampere
   and IBM's server processors
 * Enable IPMI SSIF, the smbus transport for IPMI
 * Disable FIRMWARE_MEMMAP, an x86 only thing

----------------------------------------------------------------
Joel Stanley (4):
      ARM: config: aspeed: Add new FSI drivers
      ARM: config: aspeed: Add Ampere SMPro drivers
      ARM: config: aspeed_g5: Enable SSIF BMC driver
      ARM: config: aspeed: Remove FIRMWARE_MEMMAP

 arch/arm/configs/aspeed_g4_defconfig | 1 -
 arch/arm/configs/aspeed_g5_defconfig | 8 +++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)
