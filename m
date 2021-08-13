From: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Date: Fri, 13 Aug 2021 13:47:56 +0800
Subject: [PATCH 0/2] aspeed: Add LPC mailbox support
Message-ID: <20210813054758.13189-1-chiawei_wang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add driver support for the LPC mailbox controller of ASPEED SoCs.

Chia-Wei Wang (2):
  soc: aspeed: Add LPC mailbox support
  ARM: dts: aspeed: Add mailbox to device tree

 arch/arm/boot/dts/aspeed-g4.dtsi     |   7 +
 arch/arm/boot/dts/aspeed-g5.dtsi     |   8 +-
 arch/arm/boot/dts/aspeed-g6.dtsi     |   7 +
 drivers/soc/aspeed/Kconfig           |  10 +
 drivers/soc/aspeed/Makefile          |   9 +-
 drivers/soc/aspeed/aspeed-lpc-mbox.c | 415 +++++++++++++++++++++++++++
 6 files changed, 451 insertions(+), 5 deletions(-)
 create mode 100644 drivers/soc/aspeed/aspeed-lpc-mbox.c

-- 
2.17.1

