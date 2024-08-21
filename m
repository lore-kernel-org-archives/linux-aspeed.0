From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Wed, 21 Aug 2024 15:07:38 +0800
Subject: [PATCH v1 0/2] Add Aspeed G7 gpio support 
Message-ID: <20240821070740.2378602-1-billy_tsai@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The Aspeed 7th generation SoC features two GPIO controllers: one with 12
GPIO pins and another with 216 GPIO pins. The main difference from the
previous generation is that the control logic has been updated to support
per-pin control, allowing each pin to have its own 32-bit register for
configuring value, direction, interrupt type, and more.

Billy Tsai (2):
  dt-bindings: gpio: aspeed,ast2400-gpio: Support ast2700
  gpio: Add G7 Aspeed gpio controller driver

 .../bindings/gpio/aspeed,ast2400-gpio.yaml    |  46 +-
 drivers/gpio/Kconfig                          |   7 +
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-aspeed-g7.c                 | 831 ++++++++++++++++++
 4 files changed, 884 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpio/gpio-aspeed-g7.c

-- 
2.25.1

