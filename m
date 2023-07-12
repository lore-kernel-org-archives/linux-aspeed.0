From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Date: Wed, 12 Jul 2023 15:37:48 +0800
Subject: [PATCH v1 0/2] Add Facebook Yosemite V4 (AST2600) BMC
Message-ID: <20230712073752.54624-1-Delphine_CC_Chiu@wiwynn.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

v1 - Add Facebook Yosemite V4 (AST2600) BMC

Delphine CC Chiu (2):
  dt-bindings: arm: aspeed: add Facebook Yosemite V4 board
  ARM: dts: aspeed: yosemitev4: add Facebook Yosemite V4 BMC

 .../bindings/arm/aspeed/aspeed.yaml           |   1 +
 arch/arm/boot/dts/Makefile                    |   1 +
 .../dts/aspeed-bmc-facebook-yosemitev4.dts    | 570 ++++++++++++++++++
 3 files changed, 572 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev4.dts

-- 
2.25.1

