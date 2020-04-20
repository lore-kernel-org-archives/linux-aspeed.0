From: Eddie James <eajames@linux.ibm.com>
Date: Mon, 20 Apr 2020 15:26:04 -0500
Subject: [PATCH v10 0/7] soc: aspeed: Add XDMA engine driver
Message-ID: <20200420202611.17776-1-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This series adds a driver to control the Aspeed XDMA engine embedded in the
AST2500 and AST2600. The XDMA engine performs automatic DMA operations
over PCI-E between the Aspeed SOC (acting as a BMC) and a host processor.

Changes since v9:
 - Remove the kernel command queue
 - Use memcpy_toio instead to copy commands to the buffer
 - Free the client's genalloc'd memory in the release method
 - Switch the bindings documentation to yaml
 - Add patches to fix SCU interrupt controller include

Changes since v8:
 - Use DMA API to allocate memory from reserved region.
 - Fix the driver for the AST2500 by keeping the command queue in kernel
   memory and copying the whole buffer to the reserved memory area before
   starting the operation.
 - Add krefs to the client structure to prevent use-after-free.
 - Switch reset-names binding to "device", "root-complex"

Eddie James (7):
  dt-bindings: soc: Add Aspeed XDMA Engine
  soc: aspeed: Add XDMA Engine Driver
  soc: aspeed: xdma: Add user interface
  soc: aspeed: xdma: Add reset ioctl
  ARM: dts: Aspeed: AST2600: Add XDMA PCI-E root control reset
  ARM: dts: Aspeed: AST2500: Add missing SCU interrupt controller
    include
  ARM: dts: Aspeed: AST2600: Add missing SCU interrupt controller
    include

 .../devicetree/bindings/soc/aspeed/xdma.yaml  |  108 ++
 MAINTAINERS                                   |    8 +
 arch/arm/boot/dts/aspeed-g5.dtsi              |    1 +
 arch/arm/boot/dts/aspeed-g6.dtsi              |    4 +-
 drivers/soc/aspeed/Kconfig                    |    8 +
 drivers/soc/aspeed/Makefile                   |    1 +
 drivers/soc/aspeed/aspeed-xdma.c              | 1106 +++++++++++++++++
 include/uapi/linux/aspeed-xdma.h              |   42 +
 8 files changed, 1277 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/soc/aspeed/xdma.yaml
 create mode 100644 drivers/soc/aspeed/aspeed-xdma.c
 create mode 100644 include/uapi/linux/aspeed-xdma.h

-- 
2.24.0

