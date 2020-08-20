From: Eddie James <eajames@linux.ibm.com>
Date: Thu, 20 Aug 2020 11:11:47 -0500
Subject: [PATCH 0/5] input: misc: Add IBM Operation Panel driver
Message-ID: <20200820161152.22751-1-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This series adds support for input from the IBM Operation Panel, which is
a simple controller with three buttons and an LCD display meant for
interacting with a server. It's connected over I2C. This series only
supports the input from the panel, in which the panel masters the I2C bus
and sends data to the host system when someone presses a button on the
controller.

Eddie James (5):
  dt-bindings: input: Add documentation for IBM Operation Panel
  input: misc: Add IBM Operation Panel driver
  i2c: aspeed: Mask IRQ status to relevant bits
  ARM: dts: Aspeed: Tacoma: Add IBM Operation Panel I2C device
  ARM: dts: Aspeed: Rainier: Add IBM Operation Panel I2C device

 .../bindings/input/ibm,op-panel.yaml          |  38 ++++
 MAINTAINERS                                   |   7 +
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts  |   6 +
 arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts   |   6 +
 drivers/i2c/busses/i2c-aspeed.c               |   1 +
 drivers/input/misc/Kconfig                    |  10 +
 drivers/input/misc/Makefile                   |   1 +
 drivers/input/misc/ibm-panel.c                | 186 ++++++++++++++++++
 8 files changed, 255 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/ibm,op-panel.yaml
 create mode 100644 drivers/input/misc/ibm-panel.c

-- 
2.26.2

