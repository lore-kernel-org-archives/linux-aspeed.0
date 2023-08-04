From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Date: Fri,  4 Aug 2023 18:04:34 +0800
Subject: [PATCH v5 0/2] ARM: dts: Facebook Yosemite V4 platform
Message-ID: <20230804100438.1983745-1-Delphine_CC_Chiu@wiwynn.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add linux device tree entry related to
Yosemite V4 specific devices connected to BMC SoC.

Changelog:
v5 - Revise rtc setting
   - Remove duplicated multi-master setting
v4 - Resend with cover letter
v3 - Revise the bootargs to stdout-path
   - Revise i2c devices
v2 - Revise the DTS node name
v1 - Add binding document

Delphine CC Chiu (2):
  dt-bindings: arm: aspeed: add Facebook Yosemite V4 board
  ARM: dts: aspeed: yosemitev4: add Facebook Yosemite V4 BMC

 .../bindings/arm/aspeed/aspeed.yaml           |   1 +
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../aspeed/aspeed-bmc-facebook-yosemitev4.dts | 633 ++++++++++++++++++
 3 files changed, 635 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemitev4.dts

-- 
2.25.1

