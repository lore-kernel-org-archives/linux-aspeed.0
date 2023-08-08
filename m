From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Date: Tue,  8 Aug 2023 16:42:44 +0800
Subject: [PATCH v7 0/2] ARM: dts: Facebook Yosemite 4 platform
Message-ID: <20230808084248.1415678-1-Delphine_CC_Chiu@wiwynn.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add linux device tree entry related to
Yosemite 4 specific devices connected to BMC SoC.

Changelog:
v7 - Revise changelog format
v6 - Change project name from yosemitev4 to yosemite4
v5 - Revise rtc setting
   - Remove duplicated multi-master setting
v4 - Resend with cover letter
v3 - Revise the bootargs to stdout-path
   - Revise i2c devices
v2 - Revise the DTS node name
v1 - Add binding document

Delphine CC Chiu (2):
  dt-bindings: arm: aspeed: add Facebook Yosemite 4 board
  ARM: dts: aspeed: yosemitev4: add Facebook Yosemite 4 BMC

 .../bindings/arm/aspeed/aspeed.yaml           |   1 +
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 633 ++++++++++++++++++
 3 files changed, 635 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts

-- 
2.25.1

