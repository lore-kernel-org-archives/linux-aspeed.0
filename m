From: Eddie James <eajames@linux.ibm.com>
Date: Mon,  4 Mar 2019 15:36:54 -0600
Subject: [PATCH 0/6] drivers/misc: Add XDMA engine driver
Message-ID: <1551735420-16202-1-git-send-email-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The XDMA engine embedded in the AST2500 SOC performs PCI DMA operations
between the SOC (acting as a BMC) and a host processor in a server.

This series adds a driver to control the XDMA engine in order to easily
perform DMA operations to and from the host processor.

Eddie James (6):
  dt-bindings: misc: Add Aspeed XDMA engine binding documentation
  drivers/misc: Add Aspeed XDMA engine driver
  drivers/misc: xdma: Add user interface
  drivers/misc: xdma: Add PCI device configuration sysfs
  drivers/misc: xdma: Add debugfs entries
  ARM: dts: aspeed: Add XDMA engine

 .../devicetree/bindings/misc/aspeed,xdma.txt       |  23 +
 MAINTAINERS                                        |   9 +
 arch/arm/boot/dts/aspeed-g5.dtsi                   |   8 +
 drivers/misc/Kconfig                               |   8 +
 drivers/misc/Makefile                              |   1 +
 drivers/misc/aspeed-xdma.c                         | 924 +++++++++++++++++++++
 include/uapi/linux/aspeed-xdma.h                   |  26 +
 7 files changed, 999 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/aspeed,xdma.txt
 create mode 100644 drivers/misc/aspeed-xdma.c
 create mode 100644 include/uapi/linux/aspeed-xdma.h

-- 
1.8.3.1

