From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Date: Fri, 22 Sep 2023 14:41:25 +0800
Subject: [PATCH v1 0/1] Add devicetree changes for Meta Yosemite 4
Message-ID: <20230922064127.283625-1-Delphine_CC_Chiu@wiwynn.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add devicetree changes for Meta Yosemite 4,
binding documents will be sent from corresponding driver patches.

Changelog:
 v1 - Add gpio and eeprom devices
    - Enable adc 15, tpm, wdt2
    - Change spi-tx/rx-bus-width to duo mode
    - Add device mp5023, pmbus for Flex power module
    - Change ina230 to ina233, pca9846 to pca9546
    - Set adc128d818 and max31790 config
    - Add jtag1 and gpio0 config
    - Separate binding dosument to corresponding driver patches

Delphine CC Chiu (1):
  ARM: dts: aspeed: yosemite4: Add i2c-mux/eeprom devices

 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 897 ++++++++++++++++--
 1 file changed, 843 insertions(+), 54 deletions(-)

-- 
2.25.1

