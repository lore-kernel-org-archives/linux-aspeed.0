From: Chanh Nguyen <chanh@os.amperecomputing.com>
Date: Fri, 19 May 2023 15:51:57 +0700
Subject: [PATCH v2 0/3] Update the device tree for Ampere's Mt.Mitchell BMC
Message-ID: <20230519085200.22020-1-chanh@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Updates the device tree to support some features on Ampere's
Mt.Mitchell BMC.

v2:
  - Drop 0002-ARM-dts-aspeed-mtmitchell-Add-I2C-Fan.patch because
    "maxim,max31790" is undocumented.                 [Krzysztof]
  - Update reg for mctp node.                         [Andrew]

Chanh Nguyen (3):
  ARM: dts: aspeed: mtmitchell: Enable the BMC UART8 and UART9
  ARM: dts: aspeed: mtmitchell: Update ADC sensors for Mt.Mitchell DVT
    systems
  ARM: dts: aspeed: mtmitchell: Add MCTP

 .../boot/dts/aspeed-bmc-ampere-mtmitchell.dts | 126 ++++++++++++------
 1 file changed, 85 insertions(+), 41 deletions(-)

-- 
2.17.1

