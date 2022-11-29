From: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
Date: Tue, 29 Nov 2022 14:38:05 -0800
Subject: [PATCH] ARM: dts: aspeed-g6: Add more UART controller nodes
Message-ID: <20221129223805.815027-1-quic_jaehyoo@quicinc.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add nodes for UART10, UART11, UART12 and UART13 into aspeed-g6.dtsi.

UART12 and UART13 have two mappable pin groups so their pinmux setting
should be specified in a board dts instead like below.

UART12:
  pinctrl-0 = <&pinctrl_uart12g0_default>;
  or
  pinctrl-0 = <&pinctrl_uart12g1_default>;

UART13:
  pinctrl-0 = <&pinctrl_uart13g0_default>;
  or
  pinctrl-0 = <&pinctrl_uart13g1_default>;

Signed-off-by: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
---
 arch/arm/boot/dts/aspeed-g6.dtsi | 52 ++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index b94ccdb5213d..afc356416d53 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -816,6 +816,58 @@ uart9: serial at 1e790300 {
 				status = "disabled";
 			};
 
+			uart10: serial at 1e790400 {
+				compatible = "ns16550a";
+				reg = <0x1e790400 0x20>;
+				reg-shift = <2>;
+				reg-io-width = <4>;
+				interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&syscon ASPEED_CLK_GATE_UART10CLK>;
+				no-loopback-test;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_uart10_default>;
+
+				status = "disabled";
+			};
+
+			uart11: serial at 1e790500 {
+				compatible = "ns16550a";
+				reg = <0x1e790500 0x20>;
+				reg-shift = <2>;
+				reg-io-width = <4>;
+				interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&syscon ASPEED_CLK_GATE_UART11CLK>;
+				no-loopback-test;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_uart11_default>;
+
+				status = "disabled";
+			};
+
+			uart12: serial at 1e790600 {
+				compatible = "ns16550a";
+				reg = <0x1e790600 0x20>;
+				reg-shift = <2>;
+				reg-io-width = <4>;
+				interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&syscon ASPEED_CLK_GATE_UART12CLK>;
+				no-loopback-test;
+
+				status = "disabled";
+			};
+
+			uart13: serial at 1e790700 {
+				compatible = "ns16550a";
+				reg = <0x1e790700 0x20>;
+				reg-shift = <2>;
+				reg-io-width = <4>;
+				interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&syscon ASPEED_CLK_GATE_UART13CLK>;
+				no-loopback-test;
+
+				status = "disabled";
+			};
+
 			i2c: bus at 1e78a000 {
 				compatible = "simple-bus";
 				#address-cells = <1>;
-- 
2.34.1

