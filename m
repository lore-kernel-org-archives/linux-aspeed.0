From: Yang Chen <yangchen.openbmc@gmail.com>
Date: Tue, 12 Dec 2023 15:51:49 +0800
Subject: [PATCH 00/11] Modify DTS of META Minerva CMM BMC(AST2600)
Message-ID: <20231212075200.983536-1-yangchen.openbmc@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This series modifies the DTS of the Minerva CMM which is the board on the
META platform that uses the ASPEED SoC(AST2600).

Changelog:
- v1:
    - Rename the name of the DTS from aspeed-bmc-facebook-minerva-cmc.dts
      to aspeed-bmc-facebook-minerva.dts.
    - Revise the setting of the mac3.
    - Change the sgpio use from sgpiom1 to sgpiom0.
    - Enable power monitor device (INA230 and LTC2945) on the i2c bus 0.
    - Add one temperature sensor on the i2c bus 1.
    - Correct the address of the eeprom on the i2c bus 1.
    - Add bus labels and aliases for the Fan Controller Board connect to
      the i2c-mux on the i2c bus 2.
    - Add led of the fan for the fan fault.
    - Name the gpio and the sgpio.

Yang Chen (11):
  ARM: dts: aspeed: minerva: Revise the name of DTS
  ARM: dts: aspeed: minerva: Modify mac3 setting
  ARM: dts: aspeed: minerva: Change sgpio use
  ARM: dts: aspeed: minerva: Enable power monitor device
  ARM: dts: aspeed: minerva: Add temperature sensor
  ARM: dts: aspeed: minerva: correct the address of eeprom
  ARM: dts: aspeed: minerva: add bus labels and aliases
  ARM: dts: aspeed: minerva: add fan rpm controller
  ARM: dts: aspeed: minerva: Add led-fan-fault gpio
  ARM: dts: aspeed: minerva: add gpio line name
  ARM: dts: aspeed: minerva: add sgpio line name

 arch/arm/boot/dts/aspeed/Makefile             |   2 +-
 .../aspeed-bmc-facebook-minerva-cmc.dts       | 265 ---------
 .../aspeed/aspeed-bmc-facebook-minerva.dts    | 543 ++++++++++++++++++
 3 files changed, 544 insertions(+), 266 deletions(-)
 delete mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva-cmc.dts
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts

-- 
2.34.1

