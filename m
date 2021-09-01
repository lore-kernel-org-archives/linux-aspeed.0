From: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Date: Wed, 1 Sep 2021 14:22:14 +0800
Subject: [PATCH 0/2] arm: aspeed: Add LPC uart routing support
Message-ID: <20210901062216.32675-1-chiawei_wang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add LPC uart routing driver and the device tree nodes.

Chia-Wei Wang (2):
  soc: aspeed: Add LPC UART routing support
  ARM: dts: aspeed: Add uart routing to device tree

 arch/arm/boot/dts/aspeed-g5.dtsi             |   6 +
 arch/arm/boot/dts/aspeed-g6.dtsi             |   6 +
 drivers/soc/aspeed/Kconfig                   |  11 +
 drivers/soc/aspeed/Makefile                  |   9 +-
 drivers/soc/aspeed/aspeed-lpc-uart-routing.c | 621 +++++++++++++++++++
 5 files changed, 649 insertions(+), 4 deletions(-)
 create mode 100644 drivers/soc/aspeed/aspeed-lpc-uart-routing.c

-- 
2.17.1

