From: Chanh Nguyen <chanh@os.amperecomputing.com>
Date: Thu,  1 Aug 2024 09:12:10 +0000
Subject: [PATCH 0/6] Update the device tree for Ampere's BMC platform
Message-ID: <20240801091217.1408809-1-chanh@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Updates the device tree to support some features on Ampere's
Mt.Mitchell BMC and Ampere's Mt.Jade BMC.

Chanh Nguyen (6):
  ARM: dts: aspeed: mtjade, mtmitchell: Add OCP temperature sensors
  ARM: dts: aspeed: mtmitchell: Add I2C temperature sensor alias ports
  ARM: dts: aspeed: mtmitchell: Add I2C Riser card alias ports
  ARM: dts: aspeed: mtmitchell: Enable i2c10 and i2c15
  ARM: dts: aspeed: mtmitchell: Add LEDs
  ARM: dts: aspeed: mtmitchell: Add I2C FAN controllers

 .../dts/aspeed/aspeed-bmc-ampere-mtjade.dts   |  16 ++
 .../aspeed/aspeed-bmc-ampere-mtmitchell.dts   | 152 ++++++++++++++++++
 2 files changed, 168 insertions(+)

-- 
2.43.0

