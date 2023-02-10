From: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Date: Fri, 10 Feb 2023 15:26:39 +0800
Subject: [PATCH 0/4] arm: aspeed: Add UART with DMA support
Message-ID: <20230210072643.2772-1-chiawei_wang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch series add the serial driver with DMA support for
AST26xx UART and VUART devices.

Chia-Wei Wang (4):
  dt-bindings: aspeed: Add UART controller
  soc: aspeed: Add UART DMA support
  serial: 8250: Add Aspeed UART driver
  ARM: dts: aspeed-g6: Add UDMA node

 .../bindings/serial/aspeed,uart.yaml          |  81 +++
 arch/arm/boot/dts/aspeed-g6.dtsi              |   7 +
 drivers/soc/aspeed/Kconfig                    |   9 +
 drivers/soc/aspeed/Makefile                   |   1 +
 drivers/soc/aspeed/aspeed-udma.c              | 447 ++++++++++++++++
 drivers/tty/serial/8250/8250_aspeed.c         | 502 ++++++++++++++++++
 drivers/tty/serial/8250/Kconfig               |   8 +
 drivers/tty/serial/8250/Makefile              |   1 +
 include/linux/soc/aspeed/aspeed-udma.h        |  34 ++
 9 files changed, 1090 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/aspeed,uart.yaml
 create mode 100644 drivers/soc/aspeed/aspeed-udma.c
 create mode 100644 drivers/tty/serial/8250/8250_aspeed.c
 create mode 100644 include/linux/soc/aspeed/aspeed-udma.h

-- 
2.25.1

