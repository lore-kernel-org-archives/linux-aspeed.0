From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Date: Tue, 24 Sep 2024 17:44:28 +0800
Subject: [PATCH v2 0/2] Adjust the setting for SPI flash of yosemite4
Message-ID: <20240924094430.272074-1-Delphine_CC_Chiu@wiwynn.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

- v2
  - Split the patches for different targets.
- v1
  - Revise SPI flash to dual mode.
  - Revise flash layout to 128MB.

Ricky CX Wu (2):
  ARM: dts: aspeed: yosemite4: Revise quad mode to dual mode
  ARM: dts: aspeed: yosemite4: revise flash layout to 128MB

 .../arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

-- 
2.25.1

