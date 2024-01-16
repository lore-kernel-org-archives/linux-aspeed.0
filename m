From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Date: Tue, 16 Jan 2024 14:50:49 +0800
Subject: [PATCH v1] ARM: dts: aspeed-g6: Add I3C controller nodes
Message-ID: <20240116065050.3657049-1-Delphine_CC_Chiu@wiwynn.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add default device tree settings for the 6 I3C controllers embedded in
the aspeed-g6 family SOCs.

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 148 ++++++++++++++++++++++++
 1 file changed, 148 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index c4d1faade8be..ed5021001e7f 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -13,6 +13,12 @@ / {
 	interrupt-parent = <&gic>;
 
 	aliases {
+		i3c0 = &i3c0;
+		i3c1 = &i3c1;
+		i3c2 = &i3c2;
+		i3c3 = &i3c3;
+		i3c4 = &i3c4;
+		i3c5 = &i3c5;
 		i2c0 = &i2c0;
 		i2c1 = &i2c1;
 		i2c2 = &i2c2;
@@ -577,6 +583,13 @@ wdt4: watchdog at 1e7850c0 {
 				status = "disabled";
 			};
 
+			i3c: bus at 1e7a0000 {
+				compatible = "simple-bus";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0x1e7a0000 0x8000>;
+			};
+
 			peci0: peci-controller at 1e78b000 {
 				compatible = "aspeed,ast2600-peci";
 				reg = <0x1e78b000 0x100>;
@@ -1139,3 +1152,138 @@ i2c15: i2c-bus at 800 {
 		status = "disabled";
 	};
 };
+
+&i3c {
+	i3c_global: i3cg at 0 {
+		reg = <0x0 0x1000>;
+		compatible = "aspeed,ast2600-i3c-global", "syscon";
+	};
+
+	i3c0: i3c0 at 2000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#interrupt-cells = <1>;
+
+		reg = <0x2000 0x1000>;
+		compatible = "aspeed,ast2600-i3c", "syscon";
+		clocks = <&syscon ASPEED_CLK_GATE_I3C0CLK>;
+		resets = <&syscon ASPEED_RESET_I3C0>, <&syscon ASPEED_RESET_I3C>;
+		reset-names = "core_rst", "global_rst";
+		interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i3c1_default>;
+
+		i2c-scl-hz = <1000000>;
+		i3c-scl-hz = <12500000>;
+		aspeed,global-regs = <&i3c_global 0>;
+		sda-pullup-ohms = <2000>;
+
+		status = "disabled";
+	};
+
+	i3c1: i3c1 at 3000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#interrupt-cells = <1>;
+
+		reg = <0x3000 0x1000>;
+		compatible = "aspeed,ast2600-i3c", "syscon";
+		clocks = <&syscon ASPEED_CLK_GATE_I3C1CLK>;
+		resets = <&syscon ASPEED_RESET_I3C1>, <&syscon ASPEED_RESET_I3C>;
+		reset-names = "core_rst", "global_rst";
+		interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i3c2_default>;
+
+		i2c-scl-hz = <1000000>;
+		i3c-scl-hz = <12500000>;
+		aspeed,global-regs = <&i3c_global 1>;
+		sda-pullup-ohms = <2000>;
+
+		status = "disabled";
+	};
+
+	i3c2: i3c2 at 4000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#interrupt-cells = <1>;
+
+		reg = <0x4000 0x1000>;
+		compatible = "aspeed,ast2600-i3c", "syscon";
+		clocks = <&syscon ASPEED_CLK_GATE_I3C2CLK>;
+		resets = <&syscon ASPEED_RESET_I3C2>, <&syscon ASPEED_RESET_I3C>;
+		reset-names = "core_rst", "global_rst";
+		interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
+
+		i2c-scl-hz = <1000000>;
+		i3c-scl-hz = <12500000>;
+		aspeed,global-regs = <&i3c_global 2>;
+		sda-pullup-ohms = <2000>;
+
+		status = "disabled";
+	};
+
+	i3c3: i3c3 at 5000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#interrupt-cells = <1>;
+
+		reg = <0x5000 0x1000>;
+		compatible = "aspeed,ast2600-i3c", "syscon";
+		clocks = <&syscon ASPEED_CLK_GATE_I3C3CLK>;
+		resets = <&syscon ASPEED_RESET_I3C3>, <&syscon ASPEED_RESET_I3C>;
+		reset-names = "core_rst", "global_rst";
+		interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
+
+		i2c-scl-hz = <1000000>;
+		i3c-scl-hz = <12500000>;
+		aspeed,global-regs = <&i3c_global 3>;
+		sda-pullup-ohms = <2000>;
+
+		status = "disabled";
+	};
+
+	i3c4: i3c4 at 6000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#interrupt-cells = <1>;
+
+		reg = <0x6000 0x1000>;
+		compatible = "aspeed,ast2600-i3c", "syscon";
+		clocks = <&syscon ASPEED_CLK_GATE_I3C4CLK>;
+		resets = <&syscon ASPEED_RESET_I3C4>, <&syscon ASPEED_RESET_I3C>;
+		reset-names = "core_rst", "global_rst";
+		interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i3c5_default>;
+
+		i2c-scl-hz = <1000000>;
+		i3c-scl-hz = <12500000>;
+		aspeed,global-regs = <&i3c_global 4>;
+		sda-pullup-ohms = <2000>;
+
+		status = "disabled";
+	};
+
+	i3c5: i3c5 at 7000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#interrupt-cells = <1>;
+
+		reg = <0x7000 0x1000>;
+		compatible = "aspeed,ast2600-i3c", "syscon";
+		clocks = <&syscon ASPEED_CLK_GATE_I3C5CLK>;
+		resets = <&syscon ASPEED_RESET_I3C5>, <&syscon ASPEED_RESET_I3C>;
+		reset-names = "core_rst", "global_rst";
+		interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i3c6_default>;
+
+		i2c-scl-hz = <1000000>;
+		i3c-scl-hz = <12500000>;
+		aspeed,global-regs = <&i3c_global 5>;
+		sda-pullup-ohms = <2000>;
+
+		status = "disabled";
+	};
+};
-- 
2.25.1

