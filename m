From: Brendan Higgins <brendanhiggins@google.com>
Date: Wed, 11 Dec 2019 11:27:35 -0800
Subject: [PATCH v1 0/7] uml: add unspecified HAS_IOMEM dependencies
Message-ID: <20191211192742.95699-1-brendanhiggins@google.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

# TL;DR

This patchset adds a missing HAS_IOMEM dependency to several drivers in
an attempt to get allyesconfig closer to working for ARCH=um.

# What am I trying to do?

This patchset is part of my attempt to get `make ARCH=um allyesconfig`
to produce a config that will build *and* boot to init, so that I can
use it as a mechanism to run tests[1].

This patchset is attempting to deal with

CONFIG_PINCTRL_EQUILIBRIUM=y
CONFIG_MTD_NAND_CADENCE=y
CONFIG_FSI_MASTER_ASPEED=y
CONFIG_CRYPTO_DEV_SAFEXCEL=y
CONFIG_XIL_AXIS_FIFO=y
CONFIG_CRYPTO_DEV_AMLOGIC_GXL=y
CONFIG_XILINX_AXI_EMAC=y

which are selected by `make ARCH=um allyesconfig`, but prevent it from
building.

# How far away are we from an allyesconfig UML kernel?

I have identified 33 Kconfigs that are selected by allyesconfig, but
will either not build on UML, or prevent it from booting. They are:

CONFIG_STATIC_LINK=y
CONFIG_UML_NET_PCAP=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_IP_VS=y
CONFIG_BRIDGE_EBT_BROUTE=y
CONFIG_BRIDGE_EBT_T_FILTER=y
CONFIG_BRIDGE_EBT_T_NAT=y
CONFIG_MTD_NAND_CADENCE=y
CONFIG_MTD_NAND_NANDSIM=y
CONFIG_BLK_DEV_NULL_BLK=y
CONFIG_BLK_DEV_RAM=y
CONFIG_SCSI_DEBUG=y
CONFIG_NET_VENDOR_XILINX=y
CONFIG_NULL_TTY=y
CONFIG_PTP_1588_CLOCK=y
CONFIG_PINCTRL_EQUILIBRIUM=y
CONFIG_DMABUF_SELFTESTS=y
CONFIG_COMEDI=y
CONFIG_XIL_AXIS_FIFO=y
CONFIG_EXFAT_FS=y
CONFIG_STM_DUMMY=y
CONFIG_FSI_MASTER_ASPEED=y
CONFIG_JFS_FS=y
CONFIG_UBIFS_FS=y
CONFIG_CRAMFS=y
CONFIG_CRYPTO_DEV_SAFEXCEL=y
CONFIG_CRYPTO_DEV_AMLOGIC_GXL=y
CONFIG_KCOV=y
CONFIG_LKDTM=y
CONFIG_REED_SOLOMON_TEST=y
CONFIG_TEST_RHASHTABLE=y
CONFIG_TEST_MEMINIT=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y

CONFIG_STATIC_LINK=y and CONFIG_UML_NET_PCAP=y already have fixes on
their way.

I also have a patchset that just got accepted to fix
CONFIG_EXFAT_FS=y[2].

So with this patchset and these other three fixes mentioned here, we
will be about a third of the way there. There is only one more broken
config that prevents UML from building, CONFIG_LKDTM=y. After this there
will still be 22 broken configs which will prevent the UML allyesconfig
kernel from reaching the end of init; nevertheless, this is a good
milestone where, once reached, we can stop some of this bleeding by
adding a build test.

# Why won't allyesconfig break again after this series of fixes?

As I mentioned above, I am using UML for testing the kernel, and I am
currently working on getting my tests to run on KernelCI. As part of our
testing procedure for KernelCI, we are planning on building a UML kernel
using allyesconfig and running our tests on it. Thus, we will find out
very quickly once someone breaks allyesconfig again once we get this all
working.

Brendan Higgins (7):
  pinctrl: equilibrium: add unspecified HAS_IOMEM dependency
  mtd: rawnand: add unspecified HAS_IOMEM dependency
  net: axienet: add unspecified HAS_IOMEM dependency
  crypto: inside-secure: add unspecified HAS_IOMEM dependency
  crypto: amlogic: add unspecified HAS_IOMEM dependency
  staging: axis-fifo: add unspecified HAS_IOMEM dependency
  fsi: aspeed: add unspecified HAS_IOMEM dependency

 drivers/crypto/Kconfig              | 2 +-
 drivers/crypto/amlogic/Kconfig      | 1 +
 drivers/fsi/Kconfig                 | 1 +
 drivers/mtd/nand/raw/Kconfig        | 2 +-
 drivers/net/ethernet/xilinx/Kconfig | 1 +
 drivers/pinctrl/Kconfig             | 1 +
 drivers/staging/axis-fifo/Kconfig   | 2 +-
 7 files changed, 7 insertions(+), 3 deletions(-)

[1] https://bugzilla.kernel.org/show_bug.cgi?id=205223
[2] https://patchwork.kernel.org/patch/11273771/

-- 
2.24.0.525.g8f36a354ae-goog

