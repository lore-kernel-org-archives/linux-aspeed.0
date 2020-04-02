From: Eddie James <eajames@linux.ibm.com>
Date: Thu,  2 Apr 2020 14:49:55 -0500
Subject: [PATCH v7 5/5] ARM: dts: Aspeed: AST2600: Add XDMA PCI-E root control
 reset
In-Reply-To: <20200402194955.16643-1-eajames@linux.ibm.com>
References: <20200402194955.16643-1-eajames@linux.ibm.com>
Message-ID: <20200402194955.16643-6-eajames@linux.ibm.com>
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
index 1ffc15177b79..65e2826fddb6 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -342,7 +342,8 @@ xdma: xdma at 1e6e7000 {
 				compatible = "aspeed,ast2600-xdma";
 				reg = <0x1e6e7000 0x100>;
 				clocks = <&syscon ASPEED_CLK_GATE_BCLK>;
-				resets = <&syscon ASPEED_RESET_DEV_XDMA>;
+				resets = <&syscon ASPEED_RESET_DEV_XDMA>, <&syscon ASPEED_RESET_RC_XDMA>;
+				reset-names = "dev", "rc";
 				interrupts-extended = <&gic GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
 						      <&scu_ic0 2>;
 				pcie-device = "bmc";
-- 
2.24.0

