From: Chanh Nguyen <chanh@os.amperecomputing.com>
Date: Thu,  5 Sep 2024 06:35:19 +0000
Subject: [PATCH 0/2] Update the device tree for Mt.Mitchell's BMC platform
Message-ID: <20240905063521.319416-1-chanh@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Updates the device tree to support some features on Ampere's
Mt.Mitchell BMC.

Chanh Nguyen (2):
  ARM: dts: aspeed: mtmitchell: Add I2C FAN controllers
  ARM: dts: aspeed: mtmitchell: Add gpio line names for io expanders

 .../aspeed/aspeed-bmc-ampere-mtmitchell.dts    | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

-- 
2.43.0

