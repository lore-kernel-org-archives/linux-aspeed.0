From: Joel Stanley <joel@jms.id.au>
Date: Thu, 10 Mar 2022 10:36:27 +1030
Subject: [PATCH v2 0/2] ARM: aspeed: Add secure boot controller debugfs
Message-ID: <20220310000629.119699-1-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

We're creating a common API for a subset of this information in sysfs:

 https://lore.kernel.org/all/20220204072234.304543-1-joel at jms.id.au/

However, machines with an ASPEED soc need the detailed information from
the SBE that is not relevant for other systems, so expose it all in
debugfs.

v2 Moves the files to aspeed/sbc, and uses arch_debugfs_dir instead of a
driver specific directory.

v1: https://lore.kernel.org/linux-arm-kernel/20220304030336.1017197-1-joel at jms.id.au/

Joel Stanley (2):
  ARM: aspeed: Add debugfs directory
  ARM: soc: aspeed: Add secure boot controller support

 arch/arm/mach-aspeed/debugfs.c  | 16 ++++++++
 drivers/soc/aspeed/aspeed-sbc.c | 73 +++++++++++++++++++++++++++++++++
 arch/arm/mach-aspeed/Makefile   |  1 +
 drivers/soc/aspeed/Kconfig      |  7 ++++
 drivers/soc/aspeed/Makefile     |  1 +
 5 files changed, 98 insertions(+)
 create mode 100644 arch/arm/mach-aspeed/debugfs.c
 create mode 100644 drivers/soc/aspeed/aspeed-sbc.c

-- 
2.34.1

