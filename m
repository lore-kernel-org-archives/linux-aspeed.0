From: Neal Liu <neal_liu@aspeedtech.com>
Date: Thu, 18 Aug 2022 11:59:54 +0800
Subject: [PATCH v10 3/5] ARM: dts: aspeed: Add HACE device controller node
In-Reply-To: <20220818035956.1160585-1-neal_liu@aspeedtech.com>
References: <20220818035956.1160585-1-neal_liu@aspeedtech.com>
Message-ID: <20220818035956.1160585-4-neal_liu@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add hace node to device tree for AST2500/AST2600.

Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
Signed-off-by: Johnny Huang <johnny_huang@aspeedtech.com>
Reviewed-by: Dhananjay Phadke <dphadke@linux.microsoft.com>
---
 arch/arm/boot/dts/aspeed-g5.dtsi | 8 ++++++++
 arch/arm/boot/dts/aspeed-g6.dtsi | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index c89092c3905b..04f98d1dbb97 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -262,6 +262,14 @@ rng: hwrng at 1e6e2078 {
 				quality = <100>;
 			};
 
+			hace: crypto at 1e6e3000 {
+				compatible = "aspeed,ast2500-hace";
+				reg = <0x1e6e3000 0x100>;
+				interrupts = <4>;
+				clocks = <&syscon ASPEED_CLK_GATE_YCLK>;
+				resets = <&syscon ASPEED_RESET_HACE>;
+			};
+
 			gfx: display at 1e6e6000 {
 				compatible = "aspeed,ast2500-gfx", "syscon";
 				reg = <0x1e6e6000 0x1000>;
diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index 6660564855ff..095cf8d03616 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -323,6 +323,14 @@ apb {
 			#size-cells = <1>;
 			ranges;
 
+			hace: crypto at 1e6d0000 {
+				compatible = "aspeed,ast2600-hace";
+				reg = <0x1e6d0000 0x200>;
+				interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&syscon ASPEED_CLK_GATE_YCLK>;
+				resets = <&syscon ASPEED_RESET_HACE>;
+			};
+
 			syscon: syscon at 1e6e2000 {
 				compatible = "aspeed,ast2600-scu", "syscon", "simple-mfd";
 				reg = <0x1e6e2000 0x1000>;
-- 
2.25.1

