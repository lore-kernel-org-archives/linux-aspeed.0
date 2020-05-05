From: Eddie James <eajames@linux.ibm.com>
Date: Tue,  5 May 2020 11:58:17 -0500
Subject: [PATCH v11 0/8] soc: aspeed: Add XDMA engine driver
Message-ID: <1588697905-23444-1-git-send-email-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This series adds a driver to control the Aspeed XDMA engine embedded in the
AST2500 and AST2600. The XDMA engine performs automatic DMA operations
over PCI-E between the Aspeed SOC (acting as a BMC) and a host processor.

Changes since v10:
 - Fix devicetree binding documentation
 - Add patches to enable the device on witherspoon and tacoma systems
 - Fix the driver to actually use the updated bindings
 - Remove the device managed memory in favor of manually allocating and freeing
   This adds considerable complexity to the probe function and requires the
   use of a kobject and associated release method, but it fixes the problem of
   the device context being deleted during an operation or with memory still
   mapped if the device is unbound from the driver
 - Remove the client kref system
 - Reset the device when a user closes a file handle with an on-going operation

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

Eddie James (8):
  dt-bindings: soc: Add Aspeed XDMA Engine
  soc: aspeed: Add XDMA Engine Driver
  soc: aspeed: xdma: Add user interface
  soc: aspeed: xdma: Add reset ioctl
  ARM: dts: Aspeed: AST2600: Update XDMA engine node
  ARM: dts: Aspeed: AST2500: Update XDMA engine node
  ARM: dts: Aspeed: Witherspoon: Enable XDMA engine
  ARM: dts: Aspeed: Tacoma: Enable XDMA engine

 .../devicetree/bindings/soc/aspeed/xdma.yaml       |  103 ++
 MAINTAINERS                                        |    8 +
 arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts        |   11 +
 arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts   |   11 +
 arch/arm/boot/dts/aspeed-g5.dtsi                   |    5 +-
 arch/arm/boot/dts/aspeed-g6.dtsi                   |    8 +-
 drivers/soc/aspeed/Kconfig                         |    8 +
 drivers/soc/aspeed/Makefile                        |    1 +
 drivers/soc/aspeed/aspeed-xdma.c                   | 1205 ++++++++++++++++++++
 include/uapi/linux/aspeed-xdma.h                   |   42 +
 10 files changed, 1397 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/aspeed/xdma.yaml
 create mode 100644 drivers/soc/aspeed/aspeed-xdma.c
 create mode 100644 include/uapi/linux/aspeed-xdma.h

-- 
1.8.3.1

