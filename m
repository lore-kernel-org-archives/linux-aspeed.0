From: Ninad Palsule <ninad@linux.ibm.com>
Date: Tue, 12 Dec 2023 10:40:01 -0600
Subject: [PATCH v1 5/8] ARM: dts: aspeed: System1: Voltage regulators
In-Reply-To: <20231212164004.1683589-1-ninad@linux.ibm.com>
References: <20231212164004.1683589-1-ninad@linux.ibm.com>
Message-ID: <20231212164004.1683589-6-ninad@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This commit adds different voltage regulators.

Tested:
    This board is tested using the simics simulator.

Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
 .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 266 ++++++++++++++++++
 1 file changed, 266 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
index 0557bff9f36a..b8e7e52d4600 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
@@ -114,10 +114,127 @@ vga_memory: region at bf000000 {
 		};
 	};
 
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&p12v_vd 0>, <&p5v_aux_vd 0>,
+			<&p5v_bmc_aux_vd 0>, <&p3v3_aux_vd 0>,
+			<&p3v3_bmc_aux_vd 0>, <&p1v8_bmc_aux_vd 0>,
+			<&adc1 4>, <&adc0 2>, <&adc1 0>,
+			<&p2V5_aux_vd 0>, <&adc1 7>;
+	};
+
+	p12v_vd: voltage_divider1 {
+		compatible = "voltage-divider";
+		io-channels = <&adc1 3>;
+		#io-channel-cells = <1>;
+
+		/* Scale the system voltage by 1127/127 to fit the ADC range.
+		 * Use small nominator to prevent integer overflow.
+		 */
+		output-ohms = <15>;
+		full-ohms = <133>;
+	};
+
+	p5v_aux_vd: voltage_divider2 {
+		compatible = "voltage-divider";
+		io-channels = <&adc1 5>;
+		#io-channel-cells = <1>;
+
+		/* Scale the system voltage by 1365/365 to fit the ADC range.
+		 * Use small nominator to prevent integer overflow.
+		 */
+		output-ohms = <50>;
+		full-ohms = <187>;
+	};
+
+	p5v_bmc_aux_vd: voltage_divider3 {
+		compatible = "voltage-divider";
+		io-channels = <&adc0 3>;
+		#io-channel-cells = <1>;
+
+		/* Scale the system voltage by 1365/365 to fit the ADC range.
+		 * Use small nominator to prevent integer overflow.
+		 */
+		output-ohms = <50>;
+		full-ohms = <187>;
+	};
+
+	p3v3_aux_vd: voltage_divider4 {
+		compatible = "voltage-divider";
+		io-channels = <&adc1 2>;
+		#io-channel-cells = <1>;
+
+		/* Scale the system voltage by 1698/698 to fit the ADC range.
+		 * Use small nominator to prevent integer overflow.
+		 */
+		output-ohms = <14>;
+		full-ohms = <34>;
+	};
+
+	p3v3_bmc_aux_vd: voltage_divider5 {
+		compatible = "voltage-divider";
+		io-channels = <&adc0 7>;
+		#io-channel-cells = <1>;
+
+		/* Scale the system voltage by 1698/698 to fit the ADC range.
+		 * Use small nominator to prevent integer overflow.
+		 */
+		output-ohms = <14>;
+		full-ohms = <34>;
+	};
+
+	p1v8_bmc_aux_vd: voltage_divider6 {
+		compatible = "voltage-divider";
+		io-channels = <&adc0 6>;
+		#io-channel-cells = <1>;
+
+		/* Scale the system voltage by 4000/3000 to fit the ADC range.
+		 * Use small nominator to prevent integer overflow.
+		 */
+		output-ohms = <3>;
+		full-ohms = <4>;
+	};
+
+	p2V5_aux_vd: voltage_divider7 {
+		compatible = "voltage-divider";
+		io-channels = <&adc1 1>;
+		#io-channel-cells = <1>;
+
+		/* Scale the system voltage by 2100/1100 to fit the ADC range.
+		 * Use small nominator to prevent integer overflow.
+		 */
+		output-ohms = <11>;
+		full-ohms = <21>;
+	};
+
+	p1v8_bmc_aux: fixedregulator-p1v8_bmc_aux {
+		compatible = "regulator-fixed";
+		regulator-name = "p1v8_bmc_aux";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+	};
+};
+
+&adc0 {
+	status = "okay";
+	vref-supply = <&p1v8_bmc_aux>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc0_default
+		&pinctrl_adc1_default
+		&pinctrl_adc2_default
+		&pinctrl_adc3_default
+		&pinctrl_adc4_default
+		&pinctrl_adc5_default
+		&pinctrl_adc6_default
+		&pinctrl_adc7_default>;
 };
 
 &adc1 {
 	status = "okay";
+	vref-supply = <&p1v8_bmc_aux>;
+	aspeed,battery-sensing;
 
 	aspeed,int-vref-microvolt = <2500000>;
 	pinctrl-names = "default";
@@ -250,10 +367,32 @@ &kcs3 {
 
 &i2c0 {
 	status = "okay";
+
+	regulator at 60 {
+		compatible = "maxim,max8952";
+		reg = <0x60>;
+
+		max8952,default-mode = <0>;
+		max8952,dvs-mode-microvolt = <1250000>, <1200000>,
+						<1050000>, <950000>;
+		max8952,sync-freq = <0>;
+		max8952,ramp-speed = <0>;
+
+		regulator-name = "VR_1.0V";
+		regulator-min-microvolt = <770000>;
+		regulator-max-microvolt = <1400000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
 };
 
 &i2c1 {
 	status = "okay";
+
+	regulator at 42 {
+		compatible = "infineon,ir38263";
+		reg = <0x42>;
+	};
 };
 
 &i2c2 {
@@ -327,6 +466,21 @@ &i2c4 {
 
 &i2c5 {
 	status = "okay";
+
+	regulator at 3a {
+		compatible = "maxim,max5970";
+		reg = <0x3a>;
+	};
+
+	regulator at 42 {
+		compatible = "infineon,ir38263";
+		reg = <0x42>;
+	};
+
+	regulator at 43 {
+		compatible = "infineon,ir38060";
+		reg = <0x43>;
+	};
 };
 
 &i2c6 {
@@ -423,6 +577,11 @@ i2c7mux0chn3: i2c at 3 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <3>;
+
+			regulator at 58 {
+				compatible = "mps,mp2973";
+				reg = <0x58>;
+			};
 		};
 
 		i2c7mux0chn4: i2c at 4 {
@@ -435,6 +594,11 @@ i2c7mux0chn5: i2c at 5 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <5>;
+
+			regulator at 40 {
+				compatible = "infineon,tda38640";
+				reg = <0x40>;
+			};
 		};
 
 		i2c7mux0chn6: i2c at 6 {
@@ -466,12 +630,37 @@ i2c8mux0chn0: i2c at 0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
+
+			regulator at 58 {
+				compatible = "mps,mp2971";
+				reg = <0x58>;
+			};
 		};
 
 		i2c8mux0chn1: i2c at 1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <1>;
+
+			regulator at 40 {
+				compatible = "infineon,tda38640";
+				reg = <0x40>;
+			};
+
+			regulator at 41 {
+				compatible = "infineon,tda38640";
+				reg = <0x41>;
+			};
+
+			regulator at 58 {
+				compatible = "mps,mp2971";
+				reg = <0x58>;
+			};
+
+			regulator at 5b {
+				compatible = "mps,mp2971";
+				reg = <0x5b>;
+			};
 		};
 
 		i2c8mux0chn2: i2c at 2 {
@@ -565,12 +754,44 @@ i2c8mux0chn7: i2c at 7 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <7>;
+
+			regulator at 40 {
+				compatible = "infineon,ir38060";
+				reg = <0x40>;
+			};
 		};
 	};
 };
 
 &i2c9 {
 	status = "okay";
+
+	regulator at 40 {
+		compatible = "infineon,ir38263";
+		reg = <0x40>;
+	};
+
+	regulator at 41 {
+		compatible = "infineon,ir38263";
+		reg = <0x41>;
+	};
+
+	regulator at 60 {
+		compatible = "maxim,max8952";
+		reg = <0x60>;
+
+		max8952,default-mode = <0>;
+		max8952,dvs-mode-microvolt = <1250000>, <1200000>,
+						<1050000>, <950000>;
+		max8952,sync-freq = <0>;
+		max8952,ramp-speed = <0>;
+
+		regulator-name = "VR_1.2V";
+		regulator-min-microvolt = <770000>;
+		regulator-max-microvolt = <1400000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
 };
 
 &i2c11 {
@@ -583,6 +804,11 @@ &i2c12 {
 
 &i2c13 {
 	status = "okay";
+
+	regulator at 41 {
+		compatible = "infineon,ir38263";
+		reg = <0x41>;
+	};
 };
 
 &i2c14 {
@@ -618,6 +844,11 @@ i2c14mux0chn3: i2c at 3 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <3>;
+
+			regulator at 58 {
+				compatible = "mps,mp2973";
+				reg = <0x58>;
+			};
 		};
 
 		i2c14mux0chn4: i2c at 4 {
@@ -630,6 +861,11 @@ i2c14mux0chn5: i2c at 5 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <5>;
+
+			regulator at 40 {
+				compatible = "infineon,tda38640";
+				reg = <0x40>;
+			};
 		};
 
 		i2c14mux0chn6: i2c at 6 {
@@ -661,12 +897,37 @@ i2c15mux0chn0: i2c at 0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
+
+			regulator at 58 {
+				compatible = "mps,mp2971";
+				reg = <0x58>;
+			};
 		};
 
 		i2c15mux0chn1: i2c at 1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <1>;
+
+			regulator at 40 {
+				compatible = "infineon,tda38640";
+				reg = <0x40>;
+			};
+
+			regulator at 41 {
+				compatible = "infineon,tda38640";
+				reg = <0x41>;
+			};
+
+			regulator at 58 {
+				compatible = "mps,mp2971";
+				reg = <0x58>;
+			};
+
+			regulator at 5b {
+				compatible = "mps,mp2971";
+				reg = <0x5b>;
+			};
 		};
 
 		i2c15mux0chn2: i2c at 2 {
@@ -760,6 +1021,11 @@ i2c15mux0chn7: i2c at 7 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <7>;
+
+			regulator at 40 {
+				compatible = "infineon,ir38060";
+				reg = <0x40>;
+			};
 		};
 	};
 };
-- 
2.39.2

