From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Fri, 02 Aug 2024 13:55:21 +0930
Subject: [PATCH 4/7] ARM: dts: aspeed: Remove undocumented XDMA nodes
In-Reply-To: <20240802-dt-warnings-bmc-dts-cleanups-v1-0-1cb1378e5fcd@codeconstruct.com.au>
References: <20240802-dt-warnings-bmc-dts-cleanups-v1-0-1cb1378e5fcd@codeconstruct.com.au>
Message-ID: <20240802-dt-warnings-bmc-dts-cleanups-v1-4-1cb1378e5fcd@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

There's no binding defined for the device, so remove it from the
devicetrees until someone has the motivation to write one.

Squash warnings such as:

```
arch/arm/boot/dts/aspeed/aspeed-ast2500-evb.dtb: /ahb/apb at 1e6e0000/xdma at 1e6e7000: failed to match any schema with compatible: ['aspeed,ast2500-xdma']
```

Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts     |  5 -----
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts     |  5 -----
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts     |  5 -----
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts      |  5 -----
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-witherspoon.dts |  5 -----
 arch/arm/boot/dts/aspeed/aspeed-g5.dtsi                 | 11 -----------
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi                 | 13 -------------
 7 files changed, 49 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts
index 6fdda42575df..7364adc6b80d 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts
@@ -570,11 +570,6 @@ &wdt2 {
 	status = "okay";
 };
 
-&xdma {
-	status = "okay";
-	memory-region = <&vga_memory>;
-};
-
 &kcs2 {
 	status = "okay";
 	aspeed,lpc-io-reg = <0xca8 0xcac>;
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts
index 214b2e6a4c6d..513077a1f4be 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts
@@ -2486,11 +2486,6 @@ &wdt2 {
 	status = "okay";
 };
 
-&xdma {
-	status = "okay";
-	memory-region = <&vga_memory>;
-};
-
 &kcs2 {
 	status = "okay";
 	aspeed,lpc-io-reg = <0xca8 0xcac>;
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts
index 5cb0094e21e0..0776b72c2199 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts
@@ -1722,11 +1722,6 @@ &wdt2 {
 	status = "okay";
 };
 
-&xdma {
-	status = "okay";
-	memory-region = <&vga_memory>;
-};
-
 &kcs2 {
 	status = "okay";
 	aspeed,lpc-io-reg = <0xca8 0xcac>;
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts
index 213023bc5aec..b31eb8e58c6b 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts
@@ -870,11 +870,6 @@ &pinctrl {
 		    <&pinctrl_lsirq_default>;
 };
 
-&xdma {
-	status = "okay";
-	memory-region = <&vga_memory>;
-};
-
 &kcs2 {
 	status = "okay";
 	aspeed,lpc-io-reg = <0xca8 0xcac>;
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-witherspoon.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-witherspoon.dts
index a20a532fc280..7820bc829dff 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-witherspoon.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-witherspoon.dts
@@ -696,9 +696,4 @@ &video {
 	memory-region = <&video_engine_memory>;
 };
 
-&xdma {
-	status = "okay";
-	memory-region = <&vga_memory>;
-};
-
 #include "ibm-power9-dual.dtsi"
diff --git a/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
index 100380417f99..57a699a7c149 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
@@ -281,17 +281,6 @@ gfx: display at 1e6e6000 {
 				interrupts = <0x19>;
 			};
 
-			xdma: xdma at 1e6e7000 {
-				compatible = "aspeed,ast2500-xdma";
-				reg = <0x1e6e7000 0x100>;
-				clocks = <&syscon ASPEED_CLK_GATE_BCLK>;
-				resets = <&syscon ASPEED_RESET_XDMA>;
-				interrupts-extended = <&vic 6>, <&scu_ic ASPEED_AST2500_SCU_IC_PCIE_RESET_LO_TO_HI>;
-				aspeed,pcie-device = "bmc";
-				aspeed,scu = <&syscon>;
-				status = "disabled";
-			};
-
 			adc: adc at 1e6e9000 {
 				compatible = "aspeed,ast2500-adc";
 				reg = <0x1e6e9000 0xb0>;
diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index 0c00882f111a..6505eebf91af 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -398,19 +398,6 @@ gfx: display at 1e6e6000 {
 				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
-			xdma: xdma at 1e6e7000 {
-				compatible = "aspeed,ast2600-xdma";
-				reg = <0x1e6e7000 0x100>;
-				clocks = <&syscon ASPEED_CLK_GATE_BCLK>;
-				resets = <&syscon ASPEED_RESET_DEV_XDMA>, <&syscon ASPEED_RESET_RC_XDMA>;
-				reset-names = "device", "root-complex";
-				interrupts-extended = <&gic GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
-						      <&scu_ic0 ASPEED_AST2600_SCU_IC0_PCIE_PERST_LO_TO_HI>;
-				aspeed,pcie-device = "bmc";
-				aspeed,scu = <&syscon>;
-				status = "disabled";
-			};
-
 			adc0: adc at 1e6e9000 {
 				compatible = "aspeed,ast2600-adc0";
 				reg = <0x1e6e9000 0x100>;

-- 
2.39.2

