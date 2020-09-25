From: Joel Stanley <joel@jms.id.au>
Date: Fri, 25 Sep 2020 06:31:28 +0000
Subject: [GIT PULL] ARM: aspeed: soc changes for 5.10
Message-ID: <CACPK8XcP_j7q+jWN6_JGaEcfPy=zSQHyizp1LOw05zFB4L9iGQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Soc maintainers,

Here are some ASPEED changes for the 5.10 merge window.

The following changes since commit e55f541e51b5136fc0ced0bdf2b33ee3cca3bc96:

  soc: aspeed: xdma: Add reset ioctl (2020-09-25 15:32:57 +0930)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git
tags/aspeed-5.10-soc

for you to fetch changes up to e55f541e51b5136fc0ced0bdf2b33ee3cca3bc96:

  soc: aspeed: xdma: Add reset ioctl (2020-09-25 15:32:57 +0930)

----------------------------------------------------------------
ASPEED soc driver updates for 5.10

New drivers:

 - XDMA driver for the BMC to host PCIe DMA device
 - SoC info driver to expose revision information

New features:

 - AST2600 support for the LPC control driver. This includes
   setting the LPC2AHB bridge up in a backwards compatible manner.

Cleanups:

 - LPC control
 - Kconfig
 - Bindings updates for AST2600 strings

----------------------------------------------------------------
Andrew Jeffery (1):
      soc: aspeed-lpc-ctrl: Fail probe of lpc-ctrl if reserved memory
is not aligned

Brad Bishop (2):
      dt-bindings: aspeed-lpc: Add AST2600 compatible strings
      soc: aspeed: lpc: Add AST2600 compatible strings

Eddie James (4):
      dt-bindings: soc: Add Aspeed XDMA Engine
      soc: aspeed: Add XDMA Engine Driver
      soc: aspeed: xdma: Add user interface
      soc: aspeed: xdma: Add reset ioctl

Joel Stanley (7):
      soc: aspeed: Improve kconfig
      dt-bindings: aspeed: Add silicon id node to SCU
      soc: aspeed: Add soc info driver
      ARM: dts: aspeed: Add silicon id node
      soc: aspeed-lpc-ctrl: LPC to AHB mapping on ast2600
      soc: aspeed-lpc-ctrl: Fix whitespace
      soc: aspeed-lpc-ctrl: Fix driver name

 .../devicetree/bindings/mfd/aspeed-lpc.txt         |    8 +-
 .../devicetree/bindings/mfd/aspeed-scu.txt         |   26 +
 .../devicetree/bindings/soc/aspeed/xdma.yaml       |  103 ++
 MAINTAINERS                                        |    8 +
 arch/arm/boot/dts/aspeed-g4.dtsi                   |    5 +
 arch/arm/boot/dts/aspeed-g5.dtsi                   |    5 +
 arch/arm/boot/dts/aspeed-g6.dtsi                   |    5 +
 drivers/soc/Makefile                               |    2 +-
 drivers/soc/aspeed/Kconfig                         |   53 +-
 drivers/soc/aspeed/Makefile                        |    2 +
 drivers/soc/aspeed/aspeed-lpc-ctrl.c               |   37 +-
 drivers/soc/aspeed/aspeed-lpc-snoop.c              |    2 +
 drivers/soc/aspeed/aspeed-socinfo.c                |  133 +++
 drivers/soc/aspeed/aspeed-xdma.c                   | 1205 ++++++++++++++++++++
 include/uapi/linux/aspeed-xdma.h                   |   42 +
 15 files changed, 1615 insertions(+), 21 deletions(-)
