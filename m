From: Eddie James <eajames@linux.ibm.com>
Date: Mon,  1 Jul 2019 14:53:51 -0500
Subject: [PATCH v4 0/8] drivers/soc: Add Aspeed XDMA Engine Driver
Message-ID: <1562010839-1113-1-git-send-email-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The XDMA engine embedded in the AST2500 SOC performs PCI DMA operations
between the SOC (acting as a BMC) and a host processor in a server.

This series adds a driver to control the XDMA engine in order to easily
perform DMA operations to and from the host processor.

Changes since v3:
 - Added a few comments.
 - Change DMA reservation/allocation/mmap to iomap operations.
 - Change miscdevice to "aspeed-xdma".
 - Change default PCI device to the BMC device, not the VGA.
 - Use length-limited string functions (strncpy, strncasecmp)
 - Added more debugfs registers

Changes since v2:
 - Switch to one pci device config sysfs file
 - Add documentation for pci device config sysfs file
 - Add module parameter for pci device config
 - Switch to genalloc instead of custom allocator
 - Fix alignment of user structure
 - Cleaned up debugfs functions

I previously sent this series v1 to drivers/misc, but I'm now fairly certain
it belongs in drivers/soc, especially since the other Aspeed drivers have been
moved to soc.

Changes since v1:
 - Correct the XDMA command pitch
 - Don't use packed for the aspeed_xdma_op structure
 - Correct the SCU PCI config change

Eddie James (8):
  dt-bindings: soc: Add Aspeed XDMA engine binding documentation
  drivers/soc: Add Aspeed XDMA Engine Driver
  drivers/soc: xdma: Add user interface
  Documentation: ABI: Add aspeed-xdma sysfs documentation
  drivers/soc: xdma: Add PCI device configuration sysfs
  drivers/soc: xdma: Add debugfs entries
  ARM: dts: aspeed: Add XDMA Engine
  ARM: dts: aspeed: witherspoon: Enable XDMA Engine

 .../ABI/testing/sysfs-devices-platform-aspeed-xdma |  11 +
 .../devicetree/bindings/soc/aspeed/xdma.txt        |  23 +
 MAINTAINERS                                        |   9 +
 arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts   |   4 +
 arch/arm/boot/dts/aspeed-g5.dtsi                   |   8 +
 drivers/soc/aspeed/Kconfig                         |   8 +
 drivers/soc/aspeed/Makefile                        |   1 +
 drivers/soc/aspeed/aspeed-xdma.c                   | 953 +++++++++++++++++++++
 include/uapi/linux/aspeed-xdma.h                   |  26 +
 9 files changed, 1043 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-platform-aspeed-xdma
 create mode 100644 Documentation/devicetree/bindings/soc/aspeed/xdma.txt
 create mode 100644 drivers/soc/aspeed/aspeed-xdma.c
 create mode 100644 include/uapi/linux/aspeed-xdma.h

-- 
1.8.3.1

