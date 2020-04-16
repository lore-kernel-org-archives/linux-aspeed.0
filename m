From: Eddie James <eajames@linux.ibm.com>
Date: Thu, 16 Apr 2020 15:03:39 -0500
Subject: [PATCH v9 5/5] ARM: dts: Aspeed: AST2600: Add XDMA PCI-E root control
 reset
In-Reply-To: <1587067419-5107-1-git-send-email-eajames@linux.ibm.com>
References: <1587067419-5107-1-git-send-email-eajames@linux.ibm.com>
Message-ID: <1587067419-5107-6-git-send-email-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The AST2600 XDMA engine requires the PCI-E root control reset be cleared
as well, so add a phandle to that syscon reset.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed-g6.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index 1ffc1517..19f3287 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -342,7 +342,8 @@
 				compatible = "aspeed,ast2600-xdma";
 				reg = <0x1e6e7000 0x100>;
 				clocks = <&syscon ASPEED_CLK_GATE_BCLK>;
-				resets = <&syscon ASPEED_RESET_DEV_XDMA>;
+				resets = <&syscon ASPEED_RESET_DEV_XDMA>, <&syscon ASPEED_RESET_RC_XDMA>;
+				reset-names = "device", "root-complex";
 				interrupts-extended = <&gic GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
 						      <&scu_ic0 2>;
 				pcie-device = "bmc";
-- 
1.8.3.1

