From: Chanh Nguyen <chanh@os.amperecomputing.com>
Date: Tue, 25 Apr 2023 13:57:11 +0700
Subject: [PATCH 0/4] Update the device tree for Ampere's Mt.Mitchell BMC
Message-ID: <20230425065715.21871-1-chanh@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Updates the device tree to support some features on Ampere's
Mt.Mitchell BMC.

Chanh Nguyen (4):
  ARM: dts: aspeed: mtmitchell: Enable the BMC UART8 and UART9
  ARM: dts: aspeed: mtmitchell: Add I2C Fan
  ARM: dts: aspeed: mtmitchell: Update ADC sensors for Mt.Mitchell DVT
    systems
  ARM: dts: aspeed: mtmitchell: Add MCTP

 .../boot/dts/aspeed-bmc-ampere-mtmitchell.dts | 138 ++++++++++++------
 1 file changed, 97 insertions(+), 41 deletions(-)

-- 
2.17.1

