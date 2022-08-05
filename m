From: Ken Chen <j220584470k@gmail.com>
Date: Fri,  5 Aug 2022 17:09:57 +0800
Subject: [PATCH 1/1] ARM: dts: aspeed-g6: enable more UART controllers
Message-ID: <20220805090957.470434-1-j220584470k@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Setup the configuration of UART6, UART7, UART8, and UART9 in
aspeed-g6.dtsi.

Signed-off-by: Ken Chen <j220584470k@gmail.com>
---
 arch/arm/boot/dts/aspeed-g6.dtsi | 64 +++++++++++++++++++++++++++++++-
 1 file changed, 62 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index 8c0de3f27883b..fe7cef6b5e976 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -34,8 +34,12 @@ aliases {
 		serial2 = &uart3;
 		serial3 = &uart4;
 		serial4 = &uart5;
-		serial5 = &vuart1;
-		serial6 = &vuart2;
+		serial5 = &uart6;
+		serial6 = &uart7;
+		serial7 = &uart8;
+		serial8 = &uart9;
+		serial9 = &vuart1;
+		serial10 = &vuart2;
 	};
 
 
@@ -745,6 +749,62 @@ uart4: serial at 1e78f000 {
 				status = "disabled";
 			};
 
+			uart6: serial at 1e790000 {
+				compatible = "ns16550a";
+				reg = <0x1e790000 0x20>;
+				reg-shift = <2>;
+				reg-io-width = <4>;
+				interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&syscon ASPEED_CLK_GATE_UART6CLK>;
+				no-loopback-test;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_uart6_default>;
+
+				status = "disabled";
+			};
+
+			uart7: serial at 1e790100 {
+				compatible = "ns16550a";
+				reg = <0x1e790100 0x20>;
+				reg-shift = <2>;
+				reg-io-width = <4>;
+				interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&syscon ASPEED_CLK_GATE_UART7CLK>;
+				no-loopback-test;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_uart7_default>;
+
+				status = "disabled";
+			};
+
+			uart8: serial at 1e790200 {
+				compatible = "ns16550a";
+				reg = <0x1e790200 0x20>;
+				reg-shift = <2>;
+				reg-io-width = <4>;
+				interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&syscon ASPEED_CLK_GATE_UART8CLK>;
+				no-loopback-test;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_uart8_default>;
+
+				status = "disabled";
+			};
+
+			uart9: serial at 1e790300 {
+				compatible = "ns16550a";
+				reg = <0x1e790300 0x20>;
+				reg-shift = <2>;
+				reg-io-width = <4>;
+				interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&syscon ASPEED_CLK_GATE_UART9CLK>;
+				no-loopback-test;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_uart9_default>;
+
+				status = "disabled";
+			};
+
 			i2c: bus at 1e78a000 {
 				compatible = "simple-bus";
 				#address-cells = <1>;
-- 
2.31.1

