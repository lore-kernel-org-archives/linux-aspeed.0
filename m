From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Date: Mon, 11 Dec 2023 10:49:31 +0800
Subject: [PATCH v2 00/14] Add i2c-mux and eeprom devices for Meta Yosemite 4
Message-ID: <20231211024947.3990898-1-Delphine_CC_Chiu@wiwynn.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Changelog:
  - v2
    - Revise mx31790 fan tach config
    - Add mctp config for NIC
    - Support mux to cpld
    - Revise gpio name
  - v1
    - Add gpio and eeprom behind i2c-mux
    - Remove redundant idle-state setting for i2c-mux
    - Enable adc 15, wdt2,spi gpio for yosemite4 use
    - Revise quad mode to dual mode to avoid WP pin influnece the SPI
    - Revise power sensor adm1281 for yosemite4 schematic change
    - Add gpio pca9506 I/O expander for yosemite4 use
    - remove space for adm1272 compatible
    - enable interrupt setting for pca9555
    - add eeprom for yosemite4 medusa board/BSM use
    - remove temperature sensor for yosemite4 schematic change
    - add power sensor for power module reading
    - Revise adc128d818 adc mode for yosemite4 schematic change
    - Revise ina233 for yosemite4 schematic change
    - Remove idle state setting for yosemite4 NIC connection
    - Initialize bmc gpio state

Delphine CC Chiu (14):
  ARM: dts: aspeed: yosemite4: Revise i2c-mux devices
  ARM: dts: aspeed: yosemite4: Enable adc15
  ARM: dts: aspeed: yosemite4: Enable spi-gpio setting
  ARM: dts: aspeed: yosemite4: Enable watchdog2
  ARM: dts: aspeed: yosemite4: Revise quad mode to dual mode
  ARM: dts: aspeed: yosemite4: Revise power sensor adm1281 for schematic
    change
  ARM: dts: aspeed: yosemite4: Add gpio pca9506
  ARM: dts: aspeed: yosemite4: Revise i2c11 and i2c12 schematic change
  ARM: dts: aspeed: yosemite4: Revise i2c14 and i2c15 schematic change
  ARM: dts: aspeed: yosemite4: Initialize bmc gpio state
  ARM: dts: aspeed: yosemite4: Revise mx31790 fan tach config
  ARM: dts: aspeed: yosemite4: add mctp config for NIC
  ARM: dts: aspeed: yosemite4: support mux to cpld
  ARM: dts: aspeed: yosemite4: Revise gpio name

 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 1215 +++++++++++++++--
 1 file changed, 1091 insertions(+), 124 deletions(-)

-- 
2.25.1

