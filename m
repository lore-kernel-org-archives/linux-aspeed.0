From: Eddie James <eajames@linux.ibm.com>
Date: Thu,  2 Apr 2020 14:49:50 -0500
Subject: [PATCH v7 0/5] soc: aspeed: Add XDMA engine driver
Message-ID: <20200402194955.16643-1-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This series adds a driver to control the Aspeed XDMA engine embedded in the
AST2500 and AST2600. The XDMA engine performs automatic DMA operations
over PCI-E between the Aspeed SOC (acting as a BMC) and a host processor.

Changes since v6:
 - See individual patches

Eddie James (5):
  dt-bindings: soc: Add Aspeed XDMA engine
  soc: aspeed: Add XDMA Engine Driver
  soc: aspeed: xdma: Add user interface
  soc: aspeed: xdma: Add reset ioctl
  ARM: dts: Aspeed: AST2600: Add XDMA PCI-E root control reset

 .../devicetree/bindings/soc/aspeed/xdma.txt   |   44 +
 MAINTAINERS                                   |    8 +
 arch/arm/boot/dts/aspeed-g6.dtsi              |    3 +-
 drivers/soc/aspeed/Kconfig                    |    8 +
 drivers/soc/aspeed/Makefile                   |    1 +
 drivers/soc/aspeed/aspeed-xdma.c              | 1084 +++++++++++++++++
 include/uapi/linux/aspeed-xdma.h              |   42 +
 7 files changed, 1189 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/soc/aspeed/xdma.txt
 create mode 100644 drivers/soc/aspeed/aspeed-xdma.c
 create mode 100644 include/uapi/linux/aspeed-xdma.h

-- 
2.24.0

