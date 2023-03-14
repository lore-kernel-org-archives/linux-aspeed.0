From: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Date: Tue, 14 Mar 2023 10:18:12 +0800
Subject: [PATCH v2 0/5] arm: aspeed: Add UART DMA support
Message-ID: <20230314021817.30446-1-chiawei_wang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch serias adds the 8250 driver with DMA support for AST26xx UART devices

v2 change:
 - re-write UDMA driver based on the DMAEngine framework
 - re-write 8250_aspeed driver with DMA support based on the 8250_dma implementation
 - remove virtual UART part as there is already a 8250_aspeed_vuart driver

Chia-Wei Wang (5):
  dt-bindings: serial: 8250: Add aspeed,ast2600-uart
  dt-bindings: dmaengine: Add AST2600 UDMA bindings
  dmaengine: aspeed: Add AST2600 UART DMA driver
  serial: 8250: Add AST2600 UART driver
  ARM: dts: aspeed-g6: Add UDMA node

 .../bindings/dma/aspeed,ast2600-udma.yaml     |  56 ++
 .../devicetree/bindings/serial/8250.yaml      |   1 +
 arch/arm/boot/dts/aspeed-g6.dtsi              |   9 +
 drivers/dma/Kconfig                           |   9 +
 drivers/dma/Makefile                          |   1 +
 drivers/dma/ast2600-udma.c                    | 528 ++++++++++++++++++
 drivers/tty/serial/8250/8250_aspeed.c         | 224 ++++++++
 drivers/tty/serial/8250/Kconfig               |   8 +
 drivers/tty/serial/8250/Makefile              |   1 +
 include/dt-bindings/dma/ast2600-udma.h        |  40 ++
 10 files changed, 877 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/aspeed,ast2600-udma.yaml
 create mode 100644 drivers/dma/ast2600-udma.c
 create mode 100644 drivers/tty/serial/8250/8250_aspeed.c
 create mode 100644 include/dt-bindings/dma/ast2600-udma.h

-- 
2.25.1

