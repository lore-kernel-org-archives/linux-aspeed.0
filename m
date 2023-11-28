From: Renze Nicolai <renze@rnplus.nl>
Date: Wed, 29 Nov 2023 00:23:15 +0100
Subject: [PATCH v2 0/2] ARM: dts: aspeed: asrock: Add ASRock X570D4U BMC
Message-ID: <20231128232456.2932350-1-renze@rnplus.nl>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

These patches add a device-tree (and a bindings update) for the
Aspeed BMC on the ASRock X570D4U, so that it can be added as a
supported OpenBMC platform.

Changes since v1:
  - Fixed indentation
  - Added "aspeed,ast2500" compatible
  - Switched to lower case hex values
  - Added function and color attributes to the LEDs
  - Renamed LEDs to led0 and led1
  - Removed hogging of output-bmc-ready GPIO (should be set from userland instead)
  - Get MAC addresses of the ethernet interfaces from the FRU EEPROM
  - Add descriptions to the busses exposed by the I2C switch (i2c-1 at 70)
  - Add blank lines between nodes in fan section
  - Drop bootargs from chosen section

Greetings,
Renze Nicolai

Renze Nicolai (2):
  dt-bindings: arm: aspeed: add Asrock X570D4U board
  ARM: dts: aspeed: asrock: Add ASRock X570D4U BMC

 .../bindings/arm/aspeed/aspeed.yaml           |   1 +
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../dts/aspeed/aspeed-bmc-asrock-x570d4u.dts  | 359 ++++++++++++++++++
 3 files changed, 361 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts

-- 
2.43.0

