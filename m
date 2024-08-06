From: Chanh Nguyen <chanh@os.amperecomputing.com>
Date: Tue,  6 Aug 2024 07:18:01 +0000
Subject: [PATCH v2 0/5] Update the device tree for Ampere's BMC platform
Message-ID: <20240806071806.1666550-1-chanh@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Updates the device tree to support some features on Ampere's
Mt.Mitchell BMC and Ampere's Mt.Jade BMC.

Changes in v2:
 - Add eeprom nodes to the riser cards and update commit message   [Chanh]
 - Remove the "Add I2C Fan controllers"                            [Andrew]
   
Chanh Nguyen (5):
  ARM: dts: aspeed: mtjade, mtmitchell: Add OCP temperature sensors
  ARM: dts: aspeed: mtmitchell: Add I2C temperature sensor alias ports
  ARM: dts: aspeed: mtmitchell: Add Riser cards
  ARM: dts: aspeed: mtmitchell: Enable i2c10 and i2c15
  ARM: dts: aspeed: mtmitchell: Add LEDs

 .../dts/aspeed/aspeed-bmc-ampere-mtjade.dts   |  16 ++
 .../aspeed/aspeed-bmc-ampere-mtmitchell.dts   | 154 ++++++++++++++++++
 2 files changed, 170 insertions(+)

-- 
2.43.0

