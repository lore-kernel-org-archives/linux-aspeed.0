From: Eddie James <eajames@linux.ibm.com>
Date: Wed,  9 Sep 2020 15:30:54 -0500
Subject: [PATCH v3 0/5] input: misc: Add IBM Operation Panel driver
Message-ID: <20200909203059.23427-1-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This series adds support for input from the IBM Operation Panel, which is
a simple controller with three buttons and an LCD display meant for
interacting with a server. It's connected over I2C, typically to a service
processor. This series only supports the input from the panel, in which the
panel masters the I2C bus and sends data to the host system when someone
presses a button on the controller.

Changes since v2:
 - Add "additionalProperties: false" to dts doc
 - Refactor switch statement in the input driver; check command size and call
   the processing function within the STOP case
 - Use a different definition name for Aspeed interrupt status mask

Changes since v1:
 - Redo DTS documentation example to use I2C_OWN_SLAVE_ADDRESS
 - Reject commands received in the input driver that are too long
 - Add a definition for the interrupt status mask in the Aspeed I2C driver
 - Use I2C_OWN_SLAVE_ADDRESS for both dts additions

Eddie James (5):
  dt-bindings: input: Add documentation for IBM Operation Panel
  input: misc: Add IBM Operation Panel driver
  i2c: aspeed: Mask IRQ status to relevant bits
  ARM: dts: Aspeed: Tacoma: Add IBM Operation Panel I2C device
  ARM: dts: Aspeed: Rainier: Add IBM Operation Panel I2C device

 .../bindings/input/ibm,op-panel.yaml          |  41 ++++
 MAINTAINERS                                   |   7 +
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts  |   7 +
 arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts   |   7 +
 drivers/i2c/busses/i2c-aspeed.c               |   2 +
 drivers/input/misc/Kconfig                    |  18 ++
 drivers/input/misc/Makefile                   |   1 +
 drivers/input/misc/ibm-panel.c                | 189 ++++++++++++++++++
 8 files changed, 272 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/ibm,op-panel.yaml
 create mode 100644 drivers/input/misc/ibm-panel.c

-- 
2.26.2

