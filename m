From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Date: Fri, 22 Sep 2023 14:41:26 +0800
Subject: [PATCH v1 1/1] ARM: dts: aspeed: yosemite4: Add i2c-mux/eeprom devices
In-Reply-To: <20230922064127.283625-1-Delphine_CC_Chiu@wiwynn.com>
References: <20230922064127.283625-1-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <20230922064127.283625-2-Delphine_CC_Chiu@wiwynn.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Revise Yosemite 4 devicetree for i2c-mux and eeprom,
also the following changes:
- Enable adc 15, tpm, wdt2
- Change spi-tx/rx-bus-width to duo mode
- Add device mp5023, pmbus for Flex power module
- Change ina230 to ina233, pca9846 to pca9546
- Set adc128d818 and max31790 config
- Add jtag1 and gpio0 config

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
Changelog:
 v1 - Add gpio and eeprom devices
    - Enable adc 15, tpm, wdt2
    - Change spi-tx/rx-bus-width to duo mode
    - Add device mp5023, pmbus for Flex power module
    - Change ina230 to ina233, pca9846 to pca9546
    - Set adc128d818 and max31790 config
    - Add jtag1 and gpio0 config
    - Separate binding dosument to corresponding driver patches
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 897 ++++++++++++++++--
 1 file changed, 843 insertions(+), 54 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 64075cc41d92..894ee25c2654 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -17,6 +17,25 @@ aliases {
 		serial6 = &uart7;
 		serial7 = &uart8;
 		serial8 = &uart9;
+
+		i2c16 = &imux16;
+		i2c17 = &imux17;
+		i2c18 = &imux18;
+		i2c19 = &imux19;
+		i2c20 = &imux20;
+		i2c21 = &imux21;
+		i2c22 = &imux22;
+		i2c23 = &imux23;
+		i2c24 = &imux24;
+		i2c25 = &imux25;
+		i2c26 = &imux26;
+		i2c27 = &imux27;
+		i2c28 = &imux28;
+		i2c29 = &imux29;
+		i2c30 = &imux30;
+		i2c31 = &imux31;
+		i2c32 = &imux32;
+		i2c33 = &imux33;
 	};
 
 	chosen {
@@ -32,7 +51,26 @@ iio-hwmon {
 		compatible = "iio-hwmon";
 		io-channels = <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
 				<&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
-				<&adc1 0>, <&adc1 1>;
+				<&adc1 0>, <&adc1 1>, <&adc1 7>;
+	};
+
+	spi_gpio: spi-gpio {
+		status = "okay";
+		compatible = "spi-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpio-sck = <&gpio0 ASPEED_GPIO(X, 3) GPIO_ACTIVE_HIGH>;
+		gpio-mosi = <&gpio0 ASPEED_GPIO(X, 4) GPIO_ACTIVE_HIGH>;
+		gpio-miso = <&gpio0 ASPEED_GPIO(X, 5) GPIO_ACTIVE_HIGH>;
+		num-chipselects = <1>;
+		cs-gpios = <&gpio0 ASPEED_GPIO(X, 0) GPIO_ACTIVE_LOW>;
+
+		tpmdev at 0 {
+			compatible = "tcg,tpm_tis-spi";
+			spi-max-frequency = <33000000>;
+			reg = <0>;
+		};
 	};
 };
 
@@ -83,6 +121,13 @@ &wdt1 {
 	aspeed,ext-pulse-duration = <256>;
 };
 
+&wdt2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdtrst2_default>;
+	aspeed,reset-type = "system";
+};
+
 &mac2 {
 	status = "okay";
 	pinctrl-names = "default";
@@ -105,15 +150,17 @@ flash at 0 {
 		status = "okay";
 		m25p,fast-read;
 		label = "bmc";
-		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <2>;
+		spi-rx-bus-width = <2>;
 		spi-max-frequency = <50000000>;
-#include "openbmc-flash-layout-64.dtsi"
+#include "openbmc-flash-layout-128.dtsi"
 	};
 	flash at 1 {
 		status = "okay";
 		m25p,fast-read;
 		label = "bmc2";
-		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <2>;
+		spi-rx-bus-width = <2>;
 		spi-max-frequency = <50000000>;
 	};
 };
@@ -262,6 +309,218 @@ i2c-mux at 70 {
 		idle-state = <0>;
 		i2c-mux-idle-disconnect;
 		reg = <0x70>;
+
+		imux16: i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+			gpio at 20 {
+				compatible = "nxp,pca9506";
+				reg = <0x20>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			gpio at 21 {
+				compatible = "nxp,pca9506";
+				reg = <0x21>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			gpio at 22 {
+				compatible = "nxp,pca9506";
+				reg = <0x22>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			gpio at 23 {
+				compatible = "nxp,pca9506";
+				reg = <0x23>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			gpio at 49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
+			};
+
+			eeprom at 50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
+
+			eeprom at 51 {
+				compatible = "atmel,24c128";
+				reg = <0x51>;
+			};
+
+			eeprom at 54 {
+				compatible = "atmel,24c128";
+				reg = <0x54>;
+			};
+		};
+
+		imux17: i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			gpio at 20 {
+				compatible = "nxp,pca9506";
+				reg = <0x20>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			gpio at 21 {
+				compatible = "nxp,pca9506";
+				reg = <0x21>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			gpio at 22 {
+				compatible = "nxp,pca9506";
+				reg = <0x22>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			gpio at 23 {
+				compatible = "nxp,pca9506";
+				reg = <0x23>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			gpio at 49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
+			};
+
+			eeprom at 50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
+
+			eeprom at 51 {
+				compatible = "atmel,24c128";
+				reg = <0x51>;
+			};
+
+			eeprom at 54 {
+				compatible = "atmel,24c128";
+				reg = <0x54>;
+			};
+		};
+
+		imux18: i2c at 2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+			gpio at 20 {
+				compatible = "nxp,pca9506";
+				reg = <0x20>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			gpio at 21 {
+				compatible = "nxp,pca9506";
+				reg = <0x21>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			gpio at 22 {
+				compatible = "nxp,pca9506";
+				reg = <0x22>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			gpio at 23 {
+				compatible = "nxp,pca9506";
+				reg = <0x23>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			gpio at 49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
+			};
+
+			eeprom at 50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
+
+			eeprom at 51 {
+				compatible = "atmel,24c128";
+				reg = <0x51>;
+			};
+
+			eeprom at 54 {
+				compatible = "atmel,24c128";
+				reg = <0x54>;
+			};
+		};
+
+		imux19: i2c at 3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+			gpio at 20 {
+				compatible = "nxp,pca9506";
+				reg = <0x20>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			gpio at 21 {
+				compatible = "nxp,pca9506";
+				reg = <0x21>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			gpio at 22 {
+				compatible = "nxp,pca9506";
+				reg = <0x22>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			gpio at 23 {
+				compatible = "nxp,pca9506";
+				reg = <0x23>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			gpio at 49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
+			};
+
+			eeprom at 50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
+
+			eeprom at 51 {
+				compatible = "atmel,24c128";
+				reg = <0x51>;
+			};
+
+			eeprom at 54 {
+				compatible = "atmel,24c128";
+				reg = <0x54>;
+			};
+		};
 	};
 };
 
@@ -273,23 +532,287 @@ i2c-mux at 71 {
 		idle-state = <0>;
 		i2c-mux-idle-disconnect;
 		reg = <0x71>;
+
+		imux20: i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+			gpio at 20 {
+				compatible = "nxp,pca9506";
+				reg = <0x20>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			gpio at 21 {
+				compatible = "nxp,pca9506";
+				reg = <0x21>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			gpio at 22 {
+				compatible = "nxp,pca9506";
+				reg = <0x22>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			gpio at 23 {
+				compatible = "nxp,pca9506";
+				reg = <0x23>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			gpio at 49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
+			};
+
+			eeprom at 50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
+
+			eeprom at 51 {
+				compatible = "atmel,24c128";
+				reg = <0x51>;
+			};
+
+			eeprom at 54 {
+				compatible = "atmel,24c128";
+				reg = <0x54>;
+			};
+		};
+
+		imux21: i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			gpio at 20 {
+				compatible = "nxp,pca9506";
+				reg = <0x20>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			gpio at 21 {
+				compatible = "nxp,pca9506";
+				reg = <0x21>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			gpio at 22 {
+				compatible = "nxp,pca9506";
+				reg = <0x22>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			gpio at 23 {
+				compatible = "nxp,pca9506";
+				reg = <0x23>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			gpio at 49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
+			};
+
+			eeprom at 50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
+
+			eeprom at 51 {
+				compatible = "atmel,24c128";
+				reg = <0x51>;
+			};
+
+			eeprom at 54 {
+				compatible = "atmel,24c128";
+				reg = <0x54>;
+			};
+		};
+
+		imux22: i2c at 2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+			gpio at 20 {
+				compatible = "nxp,pca9506";
+				reg = <0x20>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			gpio at 21 {
+				compatible = "nxp,pca9506";
+				reg = <0x21>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			gpio at 22 {
+				compatible = "nxp,pca9506";
+				reg = <0x22>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			gpio at 23 {
+				compatible = "nxp,pca9506";
+				reg = <0x23>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			gpio at 49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
+			};
+
+			eeprom at 50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
+
+			eeprom at 51 {
+				compatible = "atmel,24c128";
+				reg = <0x51>;
+			};
+
+			eeprom at 54 {
+				compatible = "atmel,24c128";
+				reg = <0x54>;
+			};
+		};
+
+		imux23: i2c at 3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+			gpio at 20 {
+				compatible = "nxp,pca9506";
+				reg = <0x20>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			gpio at 21 {
+				compatible = "nxp,pca9506";
+				reg = <0x21>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			gpio at 22 {
+				compatible = "nxp,pca9506";
+				reg = <0x22>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			gpio at 23 {
+				compatible = "nxp,pca9506";
+				reg = <0x23>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			gpio at 49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
+			};
+
+			eeprom at 50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
+
+			eeprom at 51 {
+				compatible = "atmel,24c128";
+				reg = <0x51>;
+			};
+
+			eeprom at 54 {
+				compatible = "atmel,24c128";
+				reg = <0x54>;
+			};
+		};
 	};
 };
 
 &i2c10 {
 	status = "okay";
 	bus-frequency = <400000>;
+	i2c-mux at 74 {
+		compatible = "nxp,pca9544";
+		idle-state = <0>;
+		i2c-mux-idle-disconnect;
+		reg = <0x74>;
+
+		imux28: i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		imux29: i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			gpio at 20 {
+				compatible = "nxp,pca9506";
+				reg = <0x20>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			gpio at 21 {
+				compatible = "nxp,pca9506";
+				reg = <0x21>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			gpio at 22 {
+				compatible = "nxp,pca9506";
+				reg = <0x22>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			gpio at 23 {
+				compatible = "nxp,pca9506";
+				reg = <0x23>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			gpio at 24 {
+				compatible = "nxp,pca9506";
+				reg = <0x24>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+		};
+	};
 };
 
 &i2c11 {
 	status = "okay";
 	power-sensor at 10 {
-		compatible = "adi, adm1272";
+		compatible = "adi,adm1272";
 		reg = <0x10>;
 	};
 
 	power-sensor at 12 {
-		compatible = "adi, adm1272";
+		compatible = "adi,adm1272";
 		reg = <0x12>;
 	};
 
@@ -321,6 +844,11 @@ gpio at 23 {
 		#gpio-cells = <2>;
 	};
 
+	power-sensor at 40 {
+		compatible = "mps,mp5023";
+		reg = <0x40>;
+	};
+
 	temperature-sensor at 48 {
 		compatible = "ti,tmp75";
 		reg = <0x48>;
@@ -331,20 +859,30 @@ temperature-sensor at 49 {
 		reg = <0x49>;
 	};
 
-	temperature-sensor at 4a {
-		compatible = "ti,tmp75";
-		reg = <0x4a>;
-	};
-
-	temperature-sensor at 4b {
-		compatible = "ti,tmp75";
-		reg = <0x4b>;
-	};
-
 	eeprom at 54 {
 		compatible = "atmel,24c256";
 		reg = <0x54>;
 	};
+
+	power-sensor at 62 {
+		compatible = "pmbus";
+		reg = <0x62>;
+	};
+
+	power-sensor at 63 {
+		compatible = "pmbus";
+		reg = <0x63>;
+	};
+
+	power-sensor at 66 {
+		compatible = "pmbus";
+		reg = <0x66>;
+	};
+
+	power-sensor at 68 {
+		compatible = "pmbus";
+		reg = <0x68>;
+	};
 };
 
 &i2c12 {
@@ -361,6 +899,11 @@ eeprom at 50 {
 		reg = <0x50>;
 	};
 
+	eeprom at 54 {
+		compatible = "atmel,24c64";
+		reg = <0x54>;
+	};
+
 	rtc at 6f {
 		compatible = "nuvoton,nct3018y";
 		reg = <0x6f>;
@@ -370,6 +913,33 @@ rtc at 6f {
 &i2c13 {
 	status = "okay";
 	bus-frequency = <400000>;
+	gpio at 20 {
+		compatible = "nxp,pca9506";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio at 21 {
+		compatible = "nxp,pca9506";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio at 22 {
+		compatible = "nxp,pca9506";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio at 23 {
+		compatible = "nxp,pca9506";
+		reg = <0x23>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
 };
 
 &i2c14 {
@@ -378,44 +948,54 @@ &i2c14 {
 	adc at 1d {
 		compatible = "ti,adc128d818";
 		reg = <0x1d>;
-		ti,mode = /bits/ 8 <2>;
+		ti,mode = /bits/ 8 <1>;
 	};
 
 	adc at 35 {
 		compatible = "ti,adc128d818";
 		reg = <0x35>;
-		ti,mode = /bits/ 8 <2>;
+		ti,mode = /bits/ 8 <1>;
 	};
 
 	adc at 37 {
 		compatible = "ti,adc128d818";
 		reg = <0x37>;
-		ti,mode = /bits/ 8 <2>;
+		ti,mode = /bits/ 8 <1>;
 	};
 
 	power-sensor at 40 {
-		compatible = "ti,ina230";
+		compatible = "ti,ina233";
 		reg = <0x40>;
+		resistor-calibration = /bits/ 16 <0x0a00>;
+		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor at 41 {
-		compatible = "ti,ina230";
+		compatible = "ti,ina233";
 		reg = <0x41>;
+		resistor-calibration = /bits/ 16 <0x0a00>;
+		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor at 42 {
-		compatible = "ti,ina230";
+		compatible = "ti,ina233";
 		reg = <0x42>;
+		resistor-calibration = /bits/ 16 <0x0a00>;
+		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor at 43 {
-		compatible = "ti,ina230";
+		compatible = "ti,ina233";
 		reg = <0x43>;
+		resistor-calibration = /bits/ 16 <0x0a00>;
+		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor at 44 {
-		compatible = "ti,ina230";
+		compatible = "ti,ina233";
 		reg = <0x44>;
+		resistor-calibration = /bits/ 16 <0x0a00>;
+		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	temperature-sensor at 4e {
@@ -433,16 +1013,14 @@ eeprom at 51 {
 		reg = <0x51>;
 	};
 
-	i2c-mux at 71 {
-		compatible = "nxp,pca9846";
+	i2c-mux at 74 {
+		compatible = "nxp,pca9546";
 		#address-cells = <1>;
 		#size-cells = <0>;
-
-		idle-state = <0>;
 		i2c-mux-idle-disconnect;
-		reg = <0x71>;
+		reg = <0x74>;
 
-		i2c at 0 {
+		imux30: i2c at 0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
@@ -450,26 +1028,26 @@ i2c at 0 {
 			adc at 1f {
 				compatible = "ti,adc128d818";
 				reg = <0x1f>;
-				ti,mode = /bits/ 8 <2>;
+				ti,mode = /bits/ 8 <1>;
 			};
 
 			pwm at 20{
-				compatible = "max31790";
+				compatible = "maxim,max31790";
+				pwm-as-tach = <4 5>;
 				reg = <0x20>;
-				#address-cells = <1>;
-				#size-cells = <0>;
 			};
 
 			gpio at 22{
 				compatible = "ti,tca6424";
 				reg = <0x22>;
+				gpio-controller;
+				#gpio-cells = <2>;
 			};
 
-			pwm at 23{
-				compatible = "max31790";
-				reg = <0x23>;
-				#address-cells = <1>;
-				#size-cells = <0>;
+			pwm at 2f{
+				compatible = "maxim,max31790";
+				pwm-as-tach = <4 5>;
+				reg = <0x2f>;
 			};
 
 			adc at 33 {
@@ -492,34 +1070,34 @@ gpio at 61 {
 			};
 		};
 
-		i2c at 1 {
+		imux31: i2c at 1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			reg = <0>;
+			reg = <1>;
 
 			adc at 1f {
 				compatible = "ti,adc128d818";
 				reg = <0x1f>;
-				ti,mode = /bits/ 8 <2>;
+				ti,mode = /bits/ 8 <1>;
 			};
 
 			pwm at 20{
-				compatible = "max31790";
+				compatible = "maxim,max31790";
+				pwm-as-tach = <4 5>;
 				reg = <0x20>;
-				#address-cells = <1>;
-				#size-cells = <0>;
 			};
 
 			gpio at 22{
 				compatible = "ti,tca6424";
 				reg = <0x22>;
+				gpio-controller;
+				#gpio-cells = <2>;
 			};
 
-			pwm at 23{
-				compatible = "max31790";
-				reg = <0x23>;
-				#address-cells = <1>;
-				#size-cells = <0>;
+			pwm at 2f{
+				compatible = "maxim,max31790";
+				pwm-as-tach = <4 5>;
+				reg = <0x2f>;
 			};
 
 			adc at 33 {
@@ -552,7 +1130,7 @@ i2c-mux at 73 {
 		i2c-mux-idle-disconnect;
 		reg = <0x73>;
 
-		i2c at 0 {
+		imux32: i2c at 0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
@@ -563,10 +1141,10 @@ adc at 35 {
 			};
 		};
 
-		i2c at 1 {
+		imux33: i2c at 1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			reg = <0>;
+			reg = <1>;
 
 			adc at 35 {
 				compatible = "maxim,max11617";
@@ -592,6 +1170,30 @@ i2c-mux at 72 {
 		idle-state = <0>;
 		i2c-mux-idle-disconnect;
 		reg = <0x72>;
+
+		imux24: i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		imux25: i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		imux26: i2c at 2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		imux27: i2c at 3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
 	};
 };
 
@@ -607,7 +1209,8 @@ &pinctrl_adc4_default &pinctrl_adc5_default
 &adc1 {
 	ref_voltage = <2500>;
 	status = "okay";
-	pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc9_default>;
+	pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc9_default
+	    &pinctrl_adc15_default>;
 };
 
 
@@ -622,3 +1225,189 @@ &ehci1 {
 &uhci {
 	status = "okay";
 };
+
+&jtag1 {
+	status = "okay";
+};
+
+&sgpiom0 {
+	status = "okay";
+	ngpios = <128>;
+	bus-frequency = <48000>;
+};
+
+&gpio0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpiu2_default &pinctrl_gpiu3_default
+		     &pinctrl_gpiu4_default &pinctrl_gpiu5_default
+		     &pinctrl_gpiu6_default>;
+	gpio-line-names =
+	/*A0-A7*/       "","","","","","","","",
+	/*B0-B7*/       "FLT_HSC_SERVER_SLOT8_N","AC_ON_OFF_BTN_CPLD_SLOT5_N",
+			"PWRGD_SLOT1_STBY","PWRGD_SLOT2_STBY",
+			"PWRGD_SLOT3_STBY","PWRGD_SLOT4_STBY","","",
+	/*C0-C7*/       "PRSNT_NIC3_N","","","","FM_NIC0_WAKE_N",
+			"FM_NIC1_WAKE_N","","RST_PCIE_SLOT2_N",
+	/*D0-D7*/       "","","","","","","","",
+	/*E0-E7*/       "PRSNT_NIC1_N","PRSNT_NIC2_N","","RST_PCIE_SLOT1_N",
+			"","","","",
+	/*F0-F7*/       "FM_RESBTN_SLOT1_BMC_N","FM_RESBTN_SLOT2_BMC_N",
+			"FM_RESBTN_SLOT3_BMC_N","FM_RESBTN_SLOT4_BMC_N",
+			"PRSNT_SB_SLOT1_N","PRSNT_SB_SLOT2_N",
+			"PRSNT_SB_SLOT3_N","PRSNT_SB_SLOT4_N",
+	/*G0-G7*/       "","","","","","","","",
+	/*H0-H7*/       "","","","","","","","",
+	/*I0-I7*/       "","","","","","ALT_MEDUSA_ADC_N",
+			"ALT_SMB_BMC_CPLD2_N",
+			"INT_SPIDER_ADC_R_N",
+	/*J0-J7*/       "","","","","","","","",
+	/*K0-K7*/       "","","","","","","","",
+	/*L0-L7*/       "","","","","","","ALT_MEDUSA_P12V_EFUSE_N","",
+	/*M0-M7*/       "EN_NIC0_POWER_BMC_R","EN_NIC1_POWER_BMC_R",
+			"INT_MEDUSA_IOEXP_TEMP_N","FLT_P12V_NIC0_N",
+			"INT_SMB_BMC_SLOT1_4_BMC_N",
+			"AC_ON_OFF_BTN_CPLD_SLOT6_N","","",
+	/*N0-N7*/       "FLT_HSC_SERVER_SLOT1_N","FLT_HSC_SERVER_SLOT2_N",
+			"FLT_HSC_SERVER_SLOT3_N","FLT_HSC_SERVER_SLOT4_N",
+			"FM_BMC_READY_R2","FLT_P12V_STBY_BMC_N","","",
+	/*O0-O7*/       "AC_ON_OFF_BTN_CPLD_SLOT8_N","RST_SMB_NIC1_R_N",
+			"RST_SMB_NIC2_R_N","RST_SMB_NIC3_R_N",
+			"FLT_P3V3_NIC2_N","FLT_P3V3_NIC3_N",
+			"","",
+	/*P0-P7*/       "ALT_SMB_BMC_CPLD1_N","'BTN_BMC_R2_N",
+			"EN_P3V_BAT_SCALED_R","PWRGD_P5V_USB_BMC",
+			"FM_BMC_RTCRST_R","RST_USB_HUB_R_N",
+			"FLAG_P5V_USB_BMC_N","",
+	/*Q0-Q7*/       "AC_ON_OFF_BTN_CPLD_SLOT1_N","AC_ON_OFF_BTN_CPLD_SLOT2_N",
+			"AC_ON_OFF_BTN_CPLD_SLOT3_N","AC_ON_OFF_BTN_CPLD_SLOT4_N",
+			"PRSNT_SB_SLOT5_N","PRSNT_SB_SLOT6_N",
+			"PRSNT_SB_SLOT7_N","PRSNT_SB_SLOT8_N",
+	/*R0-R7*/       "AC_ON_OFF_BTN_CPLD_SLOT7_N","INT_SMB_BMC_SLOT5_8_BMC_N",
+			"FM_PWRBRK_NIC_BMC_R2","RST_PCIE_SLOT4_N",
+			"RST_PCIE_SLOT5_N","RST_PCIE_SLOT6_N",
+			"RST_PCIE_SLOT7_N","RST_PCIE_SLOT8_N",
+	/*S0-S7*/       "FM_NIC2_WAKE_N","FM_NIC3_WAKE_N",
+			"EN_NIC3_POWER_BMC_R","SEL_BMC_JTAG_MUX_R",
+			"","ALT_P12V_AUX_N","FAST_PROCHOT_N",
+			"SPI_WP_DISABLE_STATUS_R_N",
+	/*T0-T7*/       "","","","","","","","",
+	/*U0-U7*/       "","","FLT_P3V3_NIC1_N","FLT_P12V_NIC1_N",
+			"FLT_P12V_NIC2_N","FLT_P12V_NIC3_N",
+			"FLT_P3V3_NIC0_N","",
+	/*V0-V7*/       "FM_RESBTN_SLOT5_BMC_N","FM_RESBTN_SLOT6_BMC_N",
+			"FM_RESBTN_SLOT7_BMC_N","FM_RESBTN_SLOT8_BMC_N",
+			"","","","",
+	/*W0-W7*/       "PRSNT_TPM_BMC_N","PRSNT_OCP_DEBUG_BMC_N","ALT_TEMP_BMC_N","ALT_RTC_BMC_N",
+			"","","","",
+	/*X0-X7*/       "","LT_HSC_SERVER_SLOT6_N","FLT_HSC_SERVER_SLOT7_N","","","",
+			"PWRGD_SLOT5_STBY","PWRGD_SLOT6_STBY",
+	/*Y0-Y7*/       "","","SPI_LOCK_REQ_BMC_N","PWRGD_SLOT7_STBY","","","EN_NIC2_POWER_BMC_R","",
+	/*Z0-Z7*/       "EN_P5V_USB_CPLD_R","'FLT_HSC_SERVER_SLOT5_N",
+			"PWRGD_SLOT8_STBY","","","","","";
+
+	pin_gpio_b4 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(B, 4) GPIO_ACTIVE_HIGH>;
+		input;
+	};
+	pin_gpio_b5 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(B, 5) GPIO_ACTIVE_HIGH>;
+		input;
+	};
+	pin_gpio_f0 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(F, 0) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_f1 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(F, 1) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_f2 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(F, 2) GPIO_ACTIVE_LOW>;
+		input;
+		};
+	pin_gpio_f3 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(F, 3) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_f4 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(F, 4) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_f5 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(F, 5) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_f6 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(F, 6) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_f7 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(F, 7) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_l6 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(L, 6) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_l7 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(L, 7) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_s0 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(S, 0) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_s1 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(S, 1) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_w0 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(W, 0) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_w1 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(W, 1) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_w2 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(W, 2) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_w3 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(W, 3) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_z3 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(Z, 3) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_z4 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(Z, 4) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_z5 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(Z, 5) GPIO_ACTIVE_LOW>;
+		input;
+	};
+};
-- 
2.25.1

