From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Wed, 30 Sep 2020 13:11:13 +0800
Subject: [PATCH] ARM: dts: aspeed-g6: Add sgpiom/sgpios node
Message-ID: <20200930051113.32465-1-billy_tsai@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This commit add two sgpiom and two sgpios node into aspeed-g6.dtsi
and change the register range of gpio0 to fix the hardware design.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed-g6.dtsi | 51 +++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index 97ca743363d7..00237daec2a1 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -357,7 +357,7 @@
 				#gpio-cells = <2>;
 				gpio-controller;
 				compatible = "aspeed,ast2600-gpio";
-				reg = <0x1e780000 0x800>;
+				reg = <0x1e780000 0x500>;
 				interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
 				gpio-ranges = <&pinctrl 0 0 208>;
 				ngpios = <208>;
@@ -365,6 +365,55 @@
 				interrupt-controller;
 				#interrupt-cells = <2>;
 			};
+			sgpiom0: sgpiom at 1e780500 {
+				#gpio-cells = <2>;
+				gpio-controller;
+				compatible = "aspeed,ast2600-sgpiom";
+				reg = <0x1e780500 0x100>;
+				interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
+				ngpios = <128>;
+				clocks = <&syscon ASPEED_CLK_APB2>;
+				interrupt-controller;
+				bus-frequency = <12000000>;
+
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_sgpm1_default>;
+				status = "disabled";
+			};
+
+			sgpiom1: sgpiom at 1e780600 {
+				#gpio-cells = <2>;
+				gpio-controller;
+				compatible = "aspeed,ast2600-sgpiom";
+				reg = <0x1e780600 0x100>;
+				interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
+				ngpios = <80>;
+				clocks = <&syscon ASPEED_CLK_APB2>;
+				interrupt-controller;
+				bus-frequency = <12000000>;
+
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_sgpm2_default>;
+				status = "disabled";
+			};
+
+			sgpios0: sgpios at 1e780700 {
+				#gpio-cells = <2>;
+				gpio-controller;
+				compatible = "aspeed,ast2600-sgpios";
+				reg = <0x1e780700 0x40>;
+				interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&syscon ASPEED_CLK_APB2>;
+			};
+
+			sgpios1: sgpios at 1e780740 {
+				#gpio-cells = <2>;
+				gpio-controller;
+				compatible = "aspeed,ast2600-sgpios";
+				reg = <0x1e780740 0x40>;
+				interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&syscon ASPEED_CLK_APB2>;
+			};
 
 			gpio1: gpio at 1e780800 {
 				#gpio-cells = <2>;
-- 
2.17.1

