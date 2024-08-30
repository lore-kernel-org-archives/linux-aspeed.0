From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Fri, 30 Aug 2024 11:40:43 +0800
Subject: [PATCH v2 0/4] Add Aspeed G7 gpio support 
Message-ID: <20240830034047.2251482-1-billy_tsai@aspeedtech.com>
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
This patch serial also add low-level operations (llops) to abstract the
register access for GPIO registers and the coprocessor request/release in
gpio-aspeed.c making it easier to extend the driver to support different
hardware register layouts.

Changes since v1:
- Merge the gpio-aspeed-g7.c into the gpio-aspeed.c.
- Create the llops in gpio-aspeed.c for flexibility.

Billy Tsai (4):
  dt-bindings: gpio: aspeed,ast2400-gpio: Support ast2700
  gpio: aspeed: Remove the name for bank array
  gpio: aspeed: Create llops to handle hardware access
  gpio: aspeed: Support G7 Aspeed gpio controller

 .../bindings/gpio/aspeed,ast2400-gpio.yaml    |  46 +-
 drivers/gpio/gpio-aspeed.c                    | 442 ++++++++++--------
 2 files changed, 303 insertions(+), 185 deletions(-)

-- 
2.25.1

