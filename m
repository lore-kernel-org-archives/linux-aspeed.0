From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Wed,  1 May 2024 11:38:32 +0800
Subject: [PATCH] ARM: dts: aspeed-g6: Add nodes for i3c controllers
Message-ID: <20240501033832.1529340-1-jk@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add the i3c controller devices to the ast2600 g6 common dts. We add all
6 busses to the common g6 definition, but leave disabled through the
status property, to be enabled per-platform.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 93 +++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index 29f94696d8b1..f9d01599a965 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -866,6 +866,13 @@ i2c: bus at 1e78a000 {
 				ranges = <0 0x1e78a000 0x1000>;
 			};
 
+			i3c: bus at 1e7a0000 {
+				compatible = "simple-bus";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0x1e7a0000 0x8000>;
+			};
+
 			fsim0: fsi at 1e79b000 {
 				compatible = "aspeed,ast2600-fsi-master", "fsi-master";
 				reg = <0x1e79b000 0x94>;
@@ -1125,3 +1132,89 @@ i2c15: i2c-bus at 800 {
 		status = "disabled";
 	};
 };
+
+&i3c {
+	i3c_global: i3c-global {
+		compatible = "aspeed,ast2600-i3c-global", "syscon", "simple-mfd";
+		reg = <0x0 0x1000>;
+		resets = <&syscon ASPEED_RESET_I3C_DMA>;
+	};
+
+	i3c0: i3c at 2000 {
+		compatible = "aspeed,ast2600-i3c";
+		reg = <0x2000 0x1000>;
+		#address-cells = <3>;
+		#size-cells = <0>;
+		clocks = <&syscon ASPEED_CLK_GATE_I3C0CLK>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i3c1_default>;
+		interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+		aspeed,global-regs = <&i3c_global 0>;
+		status = "disabled";
+	};
+
+	i3c1: i3c at 3000 {
+		compatible = "aspeed,ast2600-i3c";
+		reg = <0x3000 0x1000>;
+		#address-cells = <3>;
+		#size-cells = <0>;
+		clocks = <&syscon ASPEED_CLK_GATE_I3C1CLK>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i3c2_default>;
+		interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+		aspeed,global-regs = <&i3c_global 1>;
+		status = "disabled";
+	};
+
+	i3c2: i3c at 4000 {
+		compatible = "aspeed,ast2600-i3c";
+		reg = <0x4000 0x1000>;
+		#address-cells = <3>;
+		#size-cells = <0>;
+		clocks = <&syscon ASPEED_CLK_GATE_I3C2CLK>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i3c3_default>;
+		interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
+		aspeed,global-regs = <&i3c_global 2>;
+		status = "disabled";
+	};
+
+	i3c3: i3c at 5000 {
+		compatible = "aspeed,ast2600-i3c";
+		reg = <0x5000 0x1000>;
+		#address-cells = <3>;
+		#size-cells = <0>;
+		clocks = <&syscon ASPEED_CLK_GATE_I3C3CLK>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i3c4_default>;
+		interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
+		aspeed,global-regs = <&i3c_global 3>;
+		status = "disabled";
+	};
+
+	i3c4: i3c at 6000 {
+		compatible = "aspeed,ast2600-i3c";
+		reg = <0x6000 0x1000>;
+		#address-cells = <3>;
+		#size-cells = <0>;
+		clocks = <&syscon ASPEED_CLK_GATE_I3C4CLK>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i3c5_default>;
+		interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
+		aspeed,global-regs = <&i3c_global 4>;
+		status = "disabled";
+	};
+
+	i3c5: i3c at 7000 {
+		compatible = "aspeed,ast2600-i3c";
+		reg = <0x7000 0x1000>;
+		#address-cells = <3>;
+		#size-cells = <0>;
+		clocks = <&syscon ASPEED_CLK_GATE_I3C5CLK>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i3c6_default>;
+		interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+		aspeed,global-regs = <&i3c_global 5>;
+		status = "disabled";
+	};
+};
-- 
2.39.2

