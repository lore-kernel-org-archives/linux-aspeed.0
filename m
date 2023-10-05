From: Chanh Nguyen <chanh@os.amperecomputing.com>
Date: Thu,  5 Oct 2023 10:55:18 +0700
Subject: [PATCH 0/7] Update the device tree for Ampere's BMC platform
Message-ID: <20231005035525.19036-1-chanh@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Updates the device tree to support some features on Ampere's
Mt.Mitchell BMC and Ampere's Mt.Jade BMC.

Chanh Nguyen (7):
  ARM: dts: aspeed: mtjade, mtmitchell: Update gpio-line-names
  ARM: dts: aspeed: mtjade, mtmitchell: Add new gpio-line-names
  ARM: dts: aspeed: mtjade: Add the gpio-hog
  ARM: dts: aspeed: mtmitchell: Add LEDs
  ARM: dts: aspeed: mtmitchell: Add inlet temperature sensor
  ARM: dts: aspeed: mtmitchell: Remove redundant ADC configurations
  ARM: dts: aspeed: mtmitchell: Add I2C NVMe alias port

 .../dts/aspeed/aspeed-bmc-ampere-mtjade.dts   |  66 ++--
 .../aspeed/aspeed-bmc-ampere-mtmitchell.dts   | 315 ++++++++++++++++--
 2 files changed, 334 insertions(+), 47 deletions(-)

-- 
2.17.1

