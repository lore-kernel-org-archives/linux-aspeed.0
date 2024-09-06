From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Date: Fri,  6 Sep 2024 14:26:54 +0800
Subject: [PATCH v15 28/32] ARM: dts: aspeed: yosemite4: fix GPIO linename typo
In-Reply-To: <20240906062701.37088-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240906062701.37088-1-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <20240906062701.37088-29-Delphine_CC_Chiu@wiwynn.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Fix GPIO linename typo and add missing GPIO pin initial state.

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 554 ++++++++++++++----
 1 file changed, 455 insertions(+), 99 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index abd4a9173de4..4090725160f9 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -285,6 +285,8 @@ &mac2 {
 	pinctrl-0 = <&pinctrl_rmii3_default>;
 	use-ncsi;
 	mellanox,multi-host;
+	ncsi-ctrl,start-redo-probe;
+	ncsi-ctrl,no-channel-monitor;
 };
 
 &mac3 {
@@ -293,6 +295,8 @@ &mac3 {
 	pinctrl-0 = <&pinctrl_rmii4_default>;
 	use-ncsi;
 	mellanox,multi-host;
+	ncsi-ctrl,start-redo-probe;
+	ncsi-ctrl,no-channel-monitor;
 };
 
 &fmc {
@@ -327,6 +331,13 @@ mctp at 10 {
 		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
 	};
 
+	gpio at 24 {
+		compatible = "nxp,pca9506";
+		reg = <0x24>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	gpio at 21 {
 		compatible = "nxp,pca9506";
 		reg = <0x21>;
@@ -348,13 +359,6 @@ gpio at 23 {
 		#gpio-cells = <2>;
 	};
 
-	gpio at 24 {
-		compatible = "nxp,pca9506";
-		reg = <0x24>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-
 	power-sensor at 40 {
 		compatible = "adi,adm1281", "mps,mp5990";
 		reg = <0x40>;
@@ -373,6 +377,13 @@ mctp at 10 {
 		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
 	};
 
+	gpio at 24 {
+		compatible = "nxp,pca9506";
+		reg = <0x24>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	gpio at 21 {
 		compatible = "nxp,pca9506";
 		reg = <0x21>;
@@ -394,13 +405,6 @@ gpio at 23 {
 		#gpio-cells = <2>;
 	};
 
-	gpio at 24 {
-		compatible = "nxp,pca9506";
-		reg = <0x24>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-
 	power-sensor at 40 {
 		compatible = "adi,adm1281", "mps,mp5990";
 		reg = <0x40>;
@@ -419,6 +423,13 @@ mctp at 10 {
 		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
 	};
 
+	gpio at 24 {
+		compatible = "nxp,pca9506";
+		reg = <0x24>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	gpio at 21 {
 		compatible = "nxp,pca9506";
 		reg = <0x21>;
@@ -440,13 +451,6 @@ gpio at 23 {
 		#gpio-cells = <2>;
 	};
 
-	gpio at 24 {
-		compatible = "nxp,pca9506";
-		reg = <0x24>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-
 	power-sensor at 40 {
 		compatible = "adi,adm1281", "mps,mp5990";
 		reg = <0x40>;
@@ -465,6 +469,13 @@ mctp at 10 {
 		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
 	};
 
+	gpio at 24 {
+		compatible = "nxp,pca9506";
+		reg = <0x24>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	gpio at 21 {
 		compatible = "nxp,pca9506";
 		reg = <0x21>;
@@ -486,13 +497,6 @@ gpio at 23 {
 		#gpio-cells = <2>;
 	};
 
-	gpio at 24 {
-		compatible = "nxp,pca9506";
-		reg = <0x24>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-
 	power-sensor at 40 {
 		compatible = "adi,adm1281", "mps,mp5990";
 		reg = <0x40>;
@@ -511,6 +515,13 @@ mctp at 10 {
 		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
 	};
 
+	gpio at 24 {
+		compatible = "nxp,pca9506";
+		reg = <0x24>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	gpio at 21 {
 		compatible = "nxp,pca9506";
 		reg = <0x21>;
@@ -532,13 +543,6 @@ gpio at 23 {
 		#gpio-cells = <2>;
 	};
 
-	gpio at 24 {
-		compatible = "nxp,pca9506";
-		reg = <0x24>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-
 	power-sensor at 40 {
 		compatible = "adi,adm1281", "mps,mp5990";
 		reg = <0x40>;
@@ -557,6 +561,13 @@ mctp at 10 {
 		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
 	};
 
+	gpio at 24 {
+		compatible = "nxp,pca9506";
+		reg = <0x24>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	gpio at 21 {
 		compatible = "nxp,pca9506";
 		reg = <0x21>;
@@ -578,13 +589,6 @@ gpio at 23 {
 		#gpio-cells = <2>;
 	};
 
-	gpio at 24 {
-		compatible = "nxp,pca9506";
-		reg = <0x24>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-
 	power-sensor at 40 {
 		compatible = "adi,adm1281", "mps,mp5990";
 		reg = <0x40>;
@@ -603,6 +607,13 @@ mctp at 10 {
 		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
 	};
 
+	gpio at 24 {
+		compatible = "nxp,pca9506";
+		reg = <0x24>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	gpio at 21 {
 		compatible = "nxp,pca9506";
 		reg = <0x21>;
@@ -624,13 +635,6 @@ gpio at 23 {
 		#gpio-cells = <2>;
 	};
 
-	gpio at 24 {
-		compatible = "nxp,pca9506";
-		reg = <0x24>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-
 	power-sensor at 40 {
 		compatible = "adi,adm1281", "mps,mp5990";
 		reg = <0x40>;
@@ -649,6 +653,13 @@ mctp at 10 {
 		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
 	};
 
+	gpio at 24 {
+		compatible = "nxp,pca9506";
+		reg = <0x24>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	gpio at 21 {
 		compatible = "nxp,pca9506";
 		reg = <0x21>;
@@ -670,13 +681,6 @@ gpio at 23 {
 		#gpio-cells = <2>;
 	};
 
-	gpio at 24 {
-		compatible = "nxp,pca9506";
-		reg = <0x24>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-
 	power-sensor at 40 {
 		compatible = "adi,adm1281", "mps,mp5990";
 		reg = <0x40>;
@@ -687,6 +691,7 @@ power-sensor at 40 {
 &i2c8 {
 	status = "okay";
 	bus-frequency = <400000>;
+	i2c-clk-high-min-percent = <40>;
 	i2c-mux at 70 {
 		compatible = "nxp,pca9544";
 		i2c-mux-idle-disconnect;
@@ -798,6 +803,7 @@ eeprom at 54 {
 &i2c9 {
 	status = "okay";
 	bus-frequency = <400000>;
+	i2c-clk-high-min-percent = <40>;
 	i2c-mux at 71 {
 		compatible = "nxp,pca9544";
 		i2c-mux-idle-disconnect;
@@ -993,7 +999,7 @@ power-sensor at 13 {
 		reg = <0x13>;
 	};
 
-	gpio at 20 {
+	gpio_ext1: pca9555 at 20 {
 		compatible = "nxp,pca9555";
 		pinctrl-names = "default";
 		gpio-controller;
@@ -1012,7 +1018,7 @@ gpio at 20 {
 		"","";
 	};
 
-	gpio at 21 {
+	gpio_ext2: pca9555 at 21 {
 		compatible = "nxp,pca9555";
 		pinctrl-names = "default";
 		gpio-controller;
@@ -1031,7 +1037,7 @@ gpio at 21 {
 		"","";
 	};
 
-	gpio at 22 {
+	gpio_ext3: pca9555 at 22 {
 		compatible = "nxp,pca9555";
 		pinctrl-names = "default";
 		gpio-controller;
@@ -1050,7 +1056,7 @@ gpio at 22 {
 		"PWRGD_P12V_AUX_0","PWRGD_P12V_AUX_1";
 	};
 
-	gpio at 23 {
+	gpio_ext4: pca9555 at 23 {
 		compatible = "nxp,pca9555";
 		pinctrl-names = "default";
 		gpio-controller;
@@ -1070,21 +1076,21 @@ gpio at 23 {
 	};
 
 	power-sensor at 40 {
-		compatible = "mps,mp5023";
-		reg = <0x40>;
+			compatible = "mps,mp5023";
+			reg = <0x40>;
 	};
 
 	power-sensor at 41 {
-			compatible = "ti,ina233";
-			resistor-calibration = /bits/ 16 <0x0a00>;
-			current-lsb= /bits/ 16 <0x0001>;
-			reg = <0x41>;
+		compatible = "ti,ina233";
+		resistor-calibration = /bits/ 16 <0x0a00>;
+		current-lsb= /bits/ 16 <0x0001>;
+		reg = <0x41>;
 	};
 
 	power-sensor at 44 {
-			compatible = "ti,ina238";
-			shunt-resistor = <1000>;
-			reg = <0x44>;
+		compatible = "ti,ina238";
+		shunt-resistor = <1000>;
+		reg = <0x44>;
 	};
 
 	temperature-sensor at 48 {
@@ -1156,33 +1162,32 @@ rtc at 6f {
 				compatible = "nuvoton,nct3018y";
 				reg = <0x6f>;
 			};
-
 			gpio at 20 {
-				compatible = "nxp,pca9506";
-				reg = <0x20>;
-				gpio-controller;
-				#gpio-cells = <2>;
+					compatible = "nxp,pca9506";
+					reg = <0x20>;
+					gpio-controller;
+					#gpio-cells = <2>;
 			};
 
 			gpio at 21 {
-				compatible = "nxp,pca9506";
-				reg = <0x21>;
-				gpio-controller;
-				#gpio-cells = <2>;
+					compatible = "nxp,pca9506";
+					reg = <0x21>;
+					gpio-controller;
+					#gpio-cells = <2>;
 			};
 
 			gpio at 22 {
-				compatible = "nxp,pca9506";
-				reg = <0x22>;
-				gpio-controller;
-				#gpio-cells = <2>;
+					compatible = "nxp,pca9506";
+					reg = <0x22>;
+					gpio-controller;
+					#gpio-cells = <2>;
 			};
 
 			gpio at 23 {
-				compatible = "nxp,pca9506";
-				reg = <0x23>;
-				gpio-controller;
-				#gpio-cells = <2>;
+					compatible = "nxp,pca9506";
+					reg = <0x23>;
+					gpio-controller;
+					#gpio-cells = <2>;
 			};
 		};
 
@@ -1242,35 +1247,35 @@ adc at 37 {
 	power-sensor at 40 {
 		compatible = "ti,ina233", "richtek,rtq6056";
 		reg = <0x40>;
-		resistor-calibration = /bits/ 16 <0x0a00>;
+		resistor-calibration = /bits/ 16 <0x0400>;
 		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor at 41 {
 		compatible = "ti,ina233", "richtek,rtq6056";
 		reg = <0x41>;
-		resistor-calibration = /bits/ 16 <0x0a00>;
+		resistor-calibration = /bits/ 16 <0x0400>;
 		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor at 42 {
 		compatible = "ti,ina233", "richtek,rtq6056";
 		reg = <0x42>;
-		resistor-calibration = /bits/ 16 <0x0a00>;
+		resistor-calibration = /bits/ 16 <0x0400>;
 		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor at 43 {
 		compatible = "ti,ina233", "richtek,rtq6056";
 		reg = <0x43>;
-		resistor-calibration = /bits/ 16 <0x0a00>;
+		resistor-calibration = /bits/ 16 <0x0400>;
 		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor at 44 {
 		compatible = "ti,ina233", "richtek,rtq6056";
 		reg = <0x44>;
-		resistor-calibration = /bits/ 16 <0x0a00>;
+		resistor-calibration = /bits/ 16 <0x0400>;
 		current-lsb= /bits/ 16 <0x0001>;
 	};
 
@@ -1323,6 +1328,42 @@ channel at 5 {
 				};
 			};
 
+			hwmon0: hwmon at 21 {
+				compatible = "nuvoton,nct7363";
+				reg = <0x21>;
+				#pwm-cells = <2>;
+
+				fan-3 {
+					pwms = <&hwmon0 2 20000>;
+					tach-ch = /bits/ 8 <0x00>;
+				};
+
+				fan-4 {
+					pwms = <&hwmon0 5 20000>;
+					tach-ch = /bits/ 8 <0x01>;
+				};
+
+				fan-5 {
+					pwms = <&hwmon0 5 20000>;
+					tach-ch = /bits/ 8 <0x02>;
+				};
+
+				fan-0 {
+					pwms = <&hwmon0 0 20000>;
+					tach-ch = /bits/ 8 <0x09>;
+				};
+
+				fan-1 {
+					pwms = <&hwmon0 0 20000>;
+					tach-ch = /bits/ 8 <0x0c>;
+				};
+
+				fan-2 {
+					pwms = <&hwmon0 2 20000>;
+					tach-ch = /bits/ 8 <0x0e>;
+				};
+			};
+
 			gpio at 22{
 				compatible = "ti,tca6424";
 				reg = <0x22>;
@@ -1330,6 +1371,42 @@ gpio at 22{
 				#gpio-cells = <2>;
 			};
 
+			hwmon1: hwmon at 23 {
+				compatible = "nuvoton,nct7363";
+				reg = <0x23>;
+				#pwm-cells = <2>;
+
+				fan-3 {
+					pwms = <&hwmon0 2 20000>;
+					tach-ch = /bits/ 8 <0x00>;
+				};
+
+				fan-4 {
+					pwms = <&hwmon0 5 20000>;
+					tach-ch = /bits/ 8 <0x01>;
+				};
+
+				fan-5 {
+					pwms = <&hwmon0 5 20000>;
+					tach-ch = /bits/ 8 <0x02>;
+				};
+
+				fan-0 {
+					pwms = <&hwmon0 0 20000>;
+					tach-ch = /bits/ 8 <0x09>;
+				};
+
+				fan-1 {
+					pwms = <&hwmon0 0 20000>;
+					tach-ch = /bits/ 8 <0x0c>;
+				};
+
+				fan-2 {
+					pwms = <&hwmon0 2 20000>;
+					tach-ch = /bits/ 8 <0x0e>;
+				};
+			};
+
 			pwm at 2f{
 				compatible = "maxim,max31790";
 				#address-cells = <1>;
@@ -1393,6 +1470,42 @@ channel at 5 {
 				};
 			};
 
+			hwmon2: hwmon at 21 {
+				compatible = "nuvoton,nct7363";
+				reg = <0x21>;
+				#pwm-cells = <2>;
+
+				fan-3 {
+					pwms = <&hwmon2 2 20000>;
+					tach-ch = /bits/ 8 <0x00>;
+				};
+
+				fan-4 {
+					pwms = <&hwmon2 5 20000>;
+					tach-ch = /bits/ 8 <0x01>;
+				};
+
+				fan-5 {
+					pwms = <&hwmon2 5 20000>;
+					tach-ch = /bits/ 8 <0x02>;
+				};
+
+				fan-0 {
+					pwms = <&hwmon2 0 20000>;
+					tach-ch = /bits/ 8 <0x09>;
+				};
+
+				fan-1 {
+					pwms = <&hwmon2 0 20000>;
+					tach-ch = /bits/ 8 <0x0c>;
+				};
+
+				fan-2 {
+					pwms = <&hwmon2 2 20000>;
+					tach-ch = /bits/ 8 <0x0e>;
+				};
+			};
+
 			gpio at 22{
 				compatible = "ti,tca6424";
 				reg = <0x22>;
@@ -1400,6 +1513,42 @@ gpio at 22{
 				#gpio-cells = <2>;
 			};
 
+			hwmon3: hwmon at 23 {
+				compatible = "nuvoton,nct7363";
+				reg = <0x23>;
+				#pwm-cells = <2>;
+
+				fan-3 {
+					pwms = <&hwmon3 2 20000>;
+					tach-ch = /bits/ 8 <0x00>;
+				};
+
+				fan-4 {
+					pwms = <&hwmon3 5 20000>;
+					tach-ch = /bits/ 8 <0x01>;
+				};
+
+				fan-5 {
+					pwms = <&hwmon3 5 20000>;
+					tach-ch = /bits/ 8 <0x02>;
+				};
+
+				fan-0 {
+					pwms = <&hwmon3 0 20000>;
+					tach-ch = /bits/ 8 <0x09>;
+				};
+
+				fan-1 {
+					pwms = <&hwmon3 0 20000>;
+					tach-ch = /bits/ 8 <0x0c>;
+				};
+
+				fan-2 {
+					pwms = <&hwmon3 2 20000>;
+					tach-ch = /bits/ 8 <0x0e>;
+				};
+			};
+
 			pwm at 2f{
 				compatible = "maxim,max31790";
 				#address-cells = <1>;
@@ -1493,7 +1642,7 @@ temperature-sensor at 1f {
 				reg = <0x1f>;
 			};
 
-			temperature-sensor at 3c {
+			emc1403 at 3c {
 				compatible = "smsc,emc1403";
 				reg = <0x3c>;
 			};
@@ -1514,7 +1663,7 @@ temperature-sensor at 1f {
 				reg = <0x1f>;
 			};
 
-			temperature-sensor at 3c {
+			emc1403 at 3c {
 				compatible = "smsc,emc1403";
 				reg = <0x3c>;
 			};
@@ -1535,7 +1684,7 @@ temperature-sensor at 1f {
 				reg = <0x1f>;
 			};
 
-			temperature-sensor at 3c {
+			emc1403 at 3c {
 				compatible = "smsc,emc1403";
 				reg = <0x3c>;
 			};
@@ -1556,7 +1705,7 @@ temperature-sensor at 1f {
 				reg = <0x1f>;
 			};
 
-			temperature-sensor at 3c {
+			emc1403 at 3c {
 				compatible = "smsc,emc1403";
 				reg = <0x3c>;
 			};
@@ -1569,6 +1718,92 @@ eeprom at 50 {
 	};
 };
 
+&i3c0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i3c1_default>;
+	i3c-pp-scl-hi-period-ns = <40>;
+	i3c-pp-scl-lo-period-ns = <40>;
+	i3c-od-scl-hi-period-ns = <380>;
+	i3c-od-scl-lo-period-ns = <620>;
+	sda-tx-hold-ns = <10>;
+
+	mctp-controller;
+	hub at 0x70 {
+		reg = <0x70 0x3c0 0x00700000>;
+		cp0-ldo-en = "enabled";
+		cp1-ldo-en = "enabled";
+		cp0-ldo-volt = "1.2V";
+		cp1-ldo-volt = "1.2V";
+		tp0145-ldo-en = "enabled";
+		tp2367-ldo-en = "enabled";
+		tp0145-ldo-volt = "1.2V";
+		tp2367-ldo-volt = "1.2V";
+		tp0145-pullup = "2k";
+		tp2367-pullup = "2k";
+
+		target-port at 0 {
+			mode = "i3c";
+			pullup = "enabled";
+		};
+		target-port at 1 {
+			mode = "i3c";
+			pullup = "enabled";
+		};
+		target-port at 2 {
+			mode = "i3c";
+			pullup = "enabled";
+		};
+		target-port at 3 {
+			mode = "i3c";
+			pullup = "enabled";
+		};
+	};
+};
+
+&i3c1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i3c2_default>;
+	i3c-pp-scl-hi-period-ns = <40>;
+	i3c-pp-scl-lo-period-ns = <40>;
+	i3c-od-scl-hi-period-ns = <380>;
+	i3c-od-scl-lo-period-ns = <620>;
+	sda-tx-hold-ns = <10>;
+
+	mctp-controller;
+	hub at 0x70 {
+		reg = <0x70 0x3c0 0x00700000>;
+		cp0-ldo-en = "enabled";
+		cp1-ldo-en = "enabled";
+		cp0-ldo-volt = "1.2V";
+		cp1-ldo-volt = "1.2V";
+		tp0145-ldo-en = "enabled";
+		tp2367-ldo-en = "enabled";
+		tp0145-ldo-volt = "1.2V";
+		tp2367-ldo-volt = "1.2V";
+		tp0145-pullup = "2k";
+		tp2367-pullup = "2k";
+
+		target-port at 0 {
+			mode = "i3c";
+			pullup = "enabled";
+		};
+		target-port at 1 {
+			mode = "i3c";
+			pullup = "enabled";
+		};
+		target-port at 2 {
+			mode = "i3c";
+			pullup = "enabled";
+		};
+		target-port at 3 {
+			mode = "i3c";
+			pullup = "enabled";
+		};
+	};
+};
+
 &adc0 {
 	status = "okay";
 	pinctrl-0 = <&pinctrl_adc0_default &pinctrl_adc1_default
@@ -1579,8 +1814,8 @@ &pinctrl_adc4_default &pinctrl_adc5_default
 
 &adc1 {
 	status = "okay";
-	pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc9_default>
-			&pinctrl_adc15_default>;
+	pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc9_default
+	    &pinctrl_adc15_default>;
 };
 
 &ehci0 {
@@ -1595,6 +1830,10 @@ &uhci {
 	status = "okay";
 };
 
+&jtag1 {
+      status = "okay";
+};
+
 &sgpiom0 {
 	status = "okay";
 	ngpios = <128>;
@@ -1701,16 +1940,29 @@ &pinctrl_gpio3_unbiased &pinctrl_gpio4_unbiased
 			"","PRSNT_NIC0_N","","",
 	/*V0-V7*/       "FM_RESBTN_SLOT5_BMC_N","FM_RESBTN_SLOT6_BMC_N",
 			"FM_RESBTN_SLOT7_BMC_N","FM_RESBTN_SLOT8_BMC_N",
-			"","","","",
+			"ALT_SPIDER_INA233_R_N","ALT_SPIDER_TMP75_R_N",
+			"INT_FANBOARD1_IOEXP_N","INT_FANBOARD0_IOEXP_N",
 	/*W0-W7*/       "PRSNT_TPM_BMC_N","PRSNT_OCP_DEBUG_BMC_N","ALT_TEMP_BMC_N","ALT_RTC_BMC_N",
 			"","","","",
-	/*X0-X7*/       "","LT_HSC_SERVER_SLOT6_N","FLT_HSC_SERVER_SLOT7_N","","","",
+	/*X0-X7*/       "","FLT_HSC_SERVER_SLOT6_N","FLT_HSC_SERVER_SLOT7_N","","","",
 			"PWRGD_SLOT5_STBY","PWRGD_SLOT6_STBY",
 	/*Y0-Y7*/       "","","SPI_LOCK_REQ_BMC_N","PWRGD_SLOT7_STBY",
 			"","","EN_NIC2_POWER_BMC_R","",
 	/*Z0-Z7*/       "EN_P5V_USB_CPLD_R","FLT_HSC_SERVER_SLOT5_N",
 			"PWRGD_SLOT8_STBY","","","","","";
 
+	pin_gpio_b0 {
+		gpios = <ASPEED_GPIO(B, 0) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_b2 {
+		gpios = <ASPEED_GPIO(B, 2) GPIO_ACTIVE_HIGH>;
+		input;
+	};
+	pin_gpio_b3 {
+		gpios = <ASPEED_GPIO(B, 3) GPIO_ACTIVE_HIGH>;
+		input;
+	};
 	pin_gpio_b4 {
 		gpios = <ASPEED_GPIO(B, 4) GPIO_ACTIVE_HIGH>;
 		input;
@@ -1719,6 +1971,14 @@ pin_gpio_b5 {
 		gpios = <ASPEED_GPIO(B, 5) GPIO_ACTIVE_HIGH>;
 		input;
 	};
+	pin_gpio_e0 {
+		gpios = <ASPEED_GPIO(E, 0) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_e1 {
+		gpios = <ASPEED_GPIO(E, 1) GPIO_ACTIVE_LOW>;
+		input;
+	};
 	pin_gpio_f0 {
 		gpios = <ASPEED_GPIO(F, 0) GPIO_ACTIVE_LOW>;
 		input;
@@ -1759,6 +2019,58 @@ pin_gpio_l7 {
 		gpios = <ASPEED_GPIO(L, 7) GPIO_ACTIVE_LOW>;
 		input;
 	};
+	pin_gpio_m3 {
+		gpios = <ASPEED_GPIO(M, 3) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_m4 {
+		gpios = <ASPEED_GPIO(M, 4) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_m5 {
+		gpios = <ASPEED_GPIO(M, 5) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_n0 {
+		gpios = <ASPEED_GPIO(N, 0) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_n1 {
+		gpios = <ASPEED_GPIO(N, 1) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_n2 {
+		gpios = <ASPEED_GPIO(N, 2) GPIO_ACTIVE_LOW>;
+		input;
+		};
+	pin_gpio_n3 {
+		gpios = <ASPEED_GPIO(N, 3) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_p1 {
+		gpios = <ASPEED_GPIO(P, 1) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_q4 {
+		gpios = <ASPEED_GPIO(Q, 4) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_q5 {
+		gpios = <ASPEED_GPIO(Q, 5) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_q6 {
+		gpios = <ASPEED_GPIO(Q, 6) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_q7 {
+		gpios = <ASPEED_GPIO(Q, 7) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_r1 {
+		gpios = <ASPEED_GPIO(R, 1) GPIO_ACTIVE_LOW>;
+		input;
+	};
 	pin_gpio_s0 {
 		gpios = <ASPEED_GPIO(S, 0) GPIO_ACTIVE_LOW>;
 		input;
@@ -1767,6 +2079,14 @@ pin_gpio_s1 {
 		gpios = <ASPEED_GPIO(S, 1) GPIO_ACTIVE_LOW>;
 		input;
 	};
+	pin_gpio_s5 {
+		gpios = <ASPEED_GPIO(S, 5) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_u5 {
+		gpios = <ASPEED_GPIO(U, 5) GPIO_ACTIVE_LOW>;
+		input;
+	};
 	pin_gpio_v0 {
 		gpios = <ASPEED_GPIO(V, 0) GPIO_ACTIVE_LOW>;
 		input;
@@ -1783,6 +2103,14 @@ pin_gpio_v3 {
 		gpios = <ASPEED_GPIO(V, 3) GPIO_ACTIVE_LOW>;
 		input;
 	};
+	pin_gpio_v6 {
+		gpios = <ASPEED_GPIO(V, 6) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_v7 {
+		gpios = <ASPEED_GPIO(V, 7) GPIO_ACTIVE_LOW>;
+		input;
+	};
 	pin_gpio_w0 {
 		gpios = <ASPEED_GPIO(W, 0) GPIO_ACTIVE_LOW>;
 		input;
@@ -1815,6 +2143,34 @@ pin_gpio_w7 {
 		gpios = <ASPEED_GPIO(W, 7) GPIO_ACTIVE_LOW>;
 		input;
 	};
+	pin_gpio_x1 {
+		gpios = <ASPEED_GPIO(X, 1) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_x2 {
+		gpios = <ASPEED_GPIO(X, 2) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_x6 {
+		gpios = <ASPEED_GPIO(X, 6) GPIO_ACTIVE_HIGH>;
+		input;
+	};
+	pin_gpio_x7 {
+		gpios = <ASPEED_GPIO(X, 7) GPIO_ACTIVE_HIGH>;
+		input;
+	};
+	pin_gpio_y3 {
+		gpios = <ASPEED_GPIO(Y, 3) GPIO_ACTIVE_HIGH>;
+		input;
+	};
+	pin_gpio_z1 {
+		gpios = <ASPEED_GPIO(Z, 1) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_z2 {
+		gpios = <ASPEED_GPIO(Z, 2) GPIO_ACTIVE_HIGH>;
+		input;
+	};
 	pin_gpio_z3 {
 		gpios = <ASPEED_GPIO(Z, 3) GPIO_ACTIVE_LOW>;
 		input;
-- 
2.25.1

