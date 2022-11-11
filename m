From: Delphine CC Chiu <Delphine_CC_Chiu@Wiwynn.com>
Date: Fri, 11 Nov 2022 11:48:24 +0800
Subject: [PATCH v4 0/2] ARM: dts: Facebook Greatlakes platform
In-Reply-To: <20221007055346.3484180-1-Delphine_CC_Chiu@Wiwynn.com>
References: <20221007055346.3484180-1-Delphine_CC_Chiu@Wiwynn.com>
Message-ID: <20221111034828.2377-1-Delphine_CC_Chiu@Wiwynn.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add linux device tree entry related to
greatlakes specific devices connected to BMC SoC.

v4 - Resend as series
v3 - Add documentation of board compatible (bindings)
   - Add board compatible
   - Remove the bootargs
   - Revise the DTS node name
v2 - Add binding document
v1 - Initial draft

Delphine CC Chiu (2):
  dt-bindings: arm: aspeed: add Facebook Greatlakes board
  ARM: dts: aspeed: greatlakes: Add Facebook greatlakes (AST2600) BMC

 .../bindings/arm/aspeed/aspeed.yaml           |   1 +
 arch/arm/boot/dts/Makefile                    |   1 +
 .../dts/aspeed-bmc-facebook-greatlakes.dts    | 241 ++++++++++++++++++
 3 files changed, 243 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts

-- 
2.17.1

