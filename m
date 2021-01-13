From: Troy Lee <troy_lee@aspeedtech.com>
Date: Wed, 13 Jan 2021 07:08:47 +0000
Subject: [PATCH v2 3/4] ARM: dts: aspeed: Add Aspeed AST2600 PWM/Fan node in
 devicetree
In-Reply-To: <20210113070850.1184506-1-troy_lee@aspeedtech.com>
References: <20210113070850.1184506-1-troy_lee@aspeedtech.com>
Message-ID: <20210113070850.1184506-4-troy_lee@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Create a common node in aspeed-g6.dtsi and add fan nodes for 
aspeed-ast2600-evb.dts file.

Changes since v1:
- rename properties name in child node

Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed-ast2600-evb.dts | 152 +++++++++++++++++++++++
 arch/arm/boot/dts/aspeed-g6.dtsi         |  10 ++
 2 files changed, 162 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-ast2600-evb.dts b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
index 89be13197780..d94e70b957fb 100644
--- a/arch/arm/boot/dts/aspeed-ast2600-evb.dts
+++ b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
@@ -23,6 +23,158 @@ memory at 80000000 {
 	};
 };
 
+&pwm_tacho {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm0_default &pinctrl_tach0_default
+			&pinctrl_pwm1_default &pinctrl_tach1_default
+			&pinctrl_pwm2_default &pinctrl_tach2_default
+			&pinctrl_pwm3_default &pinctrl_tach3_default
+			&pinctrl_pwm4_default &pinctrl_tach4_default
+			&pinctrl_pwm5_default &pinctrl_tach5_default
+			&pinctrl_pwm6_default &pinctrl_tach6_default
+			&pinctrl_pwm7_default &pinctrl_tach7_default
+			&pinctrl_pwm8g1_default &pinctrl_tach8_default
+			&pinctrl_pwm9g1_default &pinctrl_tach9_default
+			&pinctrl_pwm10g1_default &pinctrl_tach10_default
+			&pinctrl_pwm11g1_default &pinctrl_tach11_default
+			&pinctrl_pwm12g1_default &pinctrl_tach12_default
+			&pinctrl_pwm13g1_default &pinctrl_tach13_default
+			&pinctrl_pwm14g1_default &pinctrl_tach14_default
+			&pinctrl_pwm15g1_default &pinctrl_tach15_default>;
+
+	fan at 1 {
+		reg = <0x00>;
+		aspeed,pwm-freq = <25000>;
+		aspeed,falling-point = /bits/ 8 <100>;
+		cooling-levels = /bits/ 8 <125 151 177 203 229 255>;
+		fan-tach-ch = /bits/ 8 <0x00>;
+		aspeed,tacho-div = <3>;
+		pulses-per-revolution = <1>;
+	};
+
+	fan at 2 {
+		reg = <0x01>;
+		aspeed,pwm-freq = <25000>;
+		aspeed,falling-point = /bits/ 8 <100>;
+		cooling-levels = /bits/ 8 <125 151 177 203 229 255>;
+		fan-tach-ch = /bits/ 8 <0x01>;
+		pulses-per-revolution = <1>;
+	};
+
+	fan at 3 {
+		reg = <0x02>;
+		aspeed,pwm-freq = <25000>;
+		cooling-levels = /bits/ 8 <125 151 177 203 229 255>;
+		fan-tach-ch = /bits/ 8 <0x02>;
+		pulses-per-revolution = <2>;
+	};
+
+	fan at 4 {
+		reg = <0x03>;
+		aspeed,pwm-freq = <25000>;
+		cooling-levels = /bits/ 8 <125 151 177 203 229 255>;
+		fan-tach-ch = /bits/ 8 <0x03>;
+		pulses-per-revolution = <2>;
+	};
+
+	fan at 5 {
+		reg = <0x04>;
+		aspeed,pwm-freq = <25000>;
+		cooling-levels = /bits/ 8 <125 151 177 203 229 255>;
+		fan-tach-ch = /bits/ 8 <0x04>;
+		pulses-per-revolution = <2>;
+	};
+
+	fan at 6 {
+		reg = <0x05>;
+		aspeed,pwm-freq = <25000>;
+		cooling-levels = /bits/ 8 <125 151 177 203 229 255>;
+		fan-tach-ch = /bits/ 8 <0x05>;
+		pulses-per-revolution = <2>;
+	};
+
+	fan at 7 {
+		reg = <0x06>;
+		aspeed,pwm-freq = <25000>;
+		cooling-levels = /bits/ 8 <125 151 177 203 229 255>;
+		fan-tach-ch = /bits/ 8 <0x06>;
+		pulses-per-revolution = <2>;
+	};
+
+	fan at 8 {
+		reg = <0x07>;
+		aspeed,pwm-freq = <25000>;
+		cooling-levels = /bits/ 8 <125 151 177 203 229 255>;
+		fan-tach-ch = /bits/ 8 <0x07>;
+		pulses-per-revolution = <2>;
+	};
+
+	fan at 9 {
+		reg = <0x08>;
+		aspeed,pwm-freq = <25000>;
+		cooling-levels = /bits/ 8 <125 151 177 203 229 255>;
+		fan-tach-ch = /bits/ 8 <0x08>;
+		pulses-per-revolution = <2>;
+	};
+
+	fan at 10 {
+		reg = <0x09>;
+		aspeed,pwm-freq = <25000>;
+		cooling-levels = /bits/ 8 <125 151 177 203 229 255>;
+		fan-tach-ch = /bits/ 8 <0x09>;
+		pulses-per-revolution = <2>;
+	};
+
+	fan at 11 {
+		reg = <0x0a>;
+		aspeed,pwm-freq = <25000>;
+		cooling-levels = /bits/ 8 <125 151 177 203 229 255>;
+		fan-tach-ch = /bits/ 8 <0x0a>;
+		pulses-per-revolution = <2>;
+	};
+
+	fan at 12 {
+		reg = <0x0b>;
+		aspeed,pwm-freq = <25000>;
+		cooling-levels = /bits/ 8 <125 151 177 203 229 255>;
+		fan-tach-ch = /bits/ 8 <0x0b>;
+		pulses-per-revolution = <2>;
+	};
+
+	fan at 13 {
+		reg = <0x0c>;
+		aspeed,pwm-freq = <25000>;
+		cooling-levels = /bits/ 8 <125 151 177 203 229 255>;
+		fan-tach-ch = /bits/ 8 <0x0c>;
+		pulses-per-revolution = <2>;
+	};
+
+	fan at 14 {
+		reg = <0x0d>;
+		aspeed,pwm-freq = <25000>;
+		cooling-levels = /bits/ 8 <125 151 177 203 229 255>;
+		fan-tach-ch = /bits/ 8 <0x0d>;
+		pulses-per-revolution = <2>;
+	};
+
+	fan at 15 {
+		reg = <0x0e>;
+		aspeed,pwm-freq = <25000>;
+		cooling-levels = /bits/ 8 <125 151 177 203 229 255>;
+		fan-tach-ch = /bits/ 8 <0x0e>;
+		pulses-per-revolution = <2>;
+	};
+
+	fan at 16 {
+		reg = <0x0f>;
+		aspeed,pwm-freq = <25000>;
+		cooling-levels = /bits/ 8 <125 151 177 203 229 255>;
+		fan-tach-ch = /bits/ 8 <0x0f>;
+		pulses-per-revolution = <2>;
+	};
+};
+
 &mdio0 {
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index 810b0676ab03..0369f8db123a 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -304,6 +304,16 @@ apb {
 			#size-cells = <1>;
 			ranges;
 
+			pwm_tacho: pwm-tacho-controller at 1e610000 {
+				compatible = "aspeed,ast2600-pwm-tachometer";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x1e610000 0x100>;
+				clocks = <&syscon ASPEED_CLK_AHB>;
+				resets = <&syscon ASPEED_RESET_PWM>;
+				status = "disabled";
+			};
+
 			syscon: syscon at 1e6e2000 {
 				compatible = "aspeed,ast2600-scu", "syscon", "simple-mfd";
 				reg = <0x1e6e2000 0x1000>;
-- 
2.25.1

