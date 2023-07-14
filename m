From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Date: Fri, 14 Jul 2023 10:34:58 +0800
Subject: [PATCH v2 0/2] Add Facebook Yosemite V4 (AST2600) BMC
In-Reply-To: <20230712073752.54624-3-Delphine_CC_Chiu@wiwynn.com>
References: <20230712073752.54624-3-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <20230714023502.3225096-1-Delphine_CC_Chiu@wiwynn.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

v2 - Add Facebook Yosemite V4 (AST2600) BMC

Delphine CC Chiu (2):
  dt-bindings: arm: aspeed: add Facebook Yosemite V4 board
  ARM: dts: aspeed: yosemitev4: add Facebook Yosemite V4 BMC

 .../bindings/arm/aspeed/aspeed.yaml           |   1 +
 arch/arm/boot/dts/Makefile                    |   1 +
 .../dts/aspeed-bmc-facebook-yosemitev4.dts    | 577 ++++++++++++++++++
 3 files changed, 579 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev4.dts

-- 
2.25.1

