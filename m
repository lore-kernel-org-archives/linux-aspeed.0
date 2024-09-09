From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Date: Mon,  9 Sep 2024 18:54:16 +0800
Subject: [PATCH v18 1/3] ARM: dts: aspeed: yosemite4: Revise i2c-mux devices
In-Reply-To: <20240909105420.441607-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240909105420.441607-1-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <20240909105420.441607-2-Delphine_CC_Chiu@wiwynn.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

Revise Yosemite 4 devicetree for devices behind i2c-mux
- Add gpio and eeprom behind i2c-mux
- Remove redundant idle-state setting for i2c-mux
- Revise address of max31790 devices after i2c-mux.
- Fix warnings reporting by dts checking tool.

Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 480 ++++++++++++++++--
 1 file changed, 437 insertions(+), 43 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 98477792aa00..bed6bf695496 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -17,6 +17,29 @@ aliases {
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
+		i2c34 = &imux34;
+		i2c35 = &imux35;
+		i2c36 = &imux36;
+		i2c37 = &imux37;
 	};
 
 	chosen {
@@ -255,41 +278,328 @@ power-sensor at 40 {
 };
 
 &i2c8 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	bus-frequency = <400000>;
 	i2c-mux at 70 {
 		compatible = "nxp,pca9544";
-		idle-state = <0>;
-		i2c-mux-idle-disconnect;
+		#address-cells = <1>;
+		#size-cells = <0>;
 		reg = <0x70>;
+		i2c-mux-idle-disconnect;
+
+		imux16: i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			gpio at 49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
+				gpio-controller;
+				#gpio-cells = <2>;
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
+			gpio at 49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
+				gpio-controller;
+				#gpio-cells = <2>;
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
+			gpio at 49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
+				gpio-controller;
+				#gpio-cells = <2>;
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
+			gpio at 49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
+				gpio-controller;
+				#gpio-cells = <2>;
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
 
 &i2c9 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	bus-frequency = <400000>;
 	i2c-mux at 71 {
 		compatible = "nxp,pca9544";
-		idle-state = <0>;
-		i2c-mux-idle-disconnect;
+		#address-cells = <1>;
+		#size-cells = <0>;
 		reg = <0x71>;
+		i2c-mux-idle-disconnect;
+
+		imux20: i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+			gpio at 49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
+				gpio-controller;
+				#gpio-cells = <2>;
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
+			gpio at 49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
+				gpio-controller;
+				#gpio-cells = <2>;
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
+			gpio at 49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
+				gpio-controller;
+				#gpio-cells = <2>;
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
+
+			gpio at 49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
+				gpio-controller;
+				#gpio-cells = <2>;
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
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	bus-frequency = <400000>;
+	i2c-mux at 74 {
+		compatible = "nxp,pca9544";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x74>;
+		i2c-mux-idle-disconnect;
+
+		imux28: i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
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
+				gpio-line-names =
+				"","","","",
+				"NIC0_MAIN_PWR_EN","NIC1_MAIN_PWR_EN",
+				"NIC2_MAIN_PWR_EN","NIC3_MAIN_PWR_EN",
+				"","","","","","","","",
+				"","","","","","","","",
+				"","","","","","","","";
+			};
+		};
+
+		imux29: i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
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
 
@@ -348,22 +658,61 @@ eeprom at 54 {
 };
 
 &i2c12 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	bus-frequency = <400000>;
 
-	temperature-sensor at 48 {
-		compatible = "ti,tmp75";
-		reg = <0x48>;
-	};
+	i2c-mux at 70 {
+		compatible = "nxp,pca9544";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x70>;
+		i2c-mux-idle-disconnect;
 
-	eeprom at 50 {
-		compatible = "atmel,24c128";
-		reg = <0x50>;
-	};
+		imux34: i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
 
-	rtc at 6f {
-		compatible = "nuvoton,nct3018y";
-		reg = <0x6f>;
+			temperature-sensor at 48 {
+				compatible = "ti,tmp75";
+				reg = <0x48>;
+			};
+
+			eeprom at 50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
+
+			eeprom at 54 {
+				compatible = "atmel,24c64";
+				reg = <0x54>;
+			};
+
+			rtc at 6f {
+				compatible = "nuvoton,nct3018y";
+				reg = <0x6f>;
+			};
+		};
+
+		imux35: i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		imux36: i2c at 2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		imux37: i2c at 3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
 	};
 };
 
@@ -380,6 +729,8 @@ ipmb at 10 {
 };
 
 &i2c14 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	bus-frequency = <400000>;
 	adc at 1d {
@@ -440,16 +791,14 @@ eeprom at 51 {
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
@@ -457,11 +806,11 @@ i2c at 0 {
 			adc at 1f {
 				compatible = "ti,adc128d818";
 				reg = <0x1f>;
-				ti,mode = /bits/ 8 <2>;
+				ti,mode = /bits/ 8 <1>;
 			};
 
 			pwm at 20{
-				compatible = "max31790";
+				compatible = "maxim,max31790";
 				reg = <0x20>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -470,11 +819,13 @@ pwm at 20{
 			gpio at 22{
 				compatible = "ti,tca6424";
 				reg = <0x22>;
+				gpio-controller;
+				#gpio-cells = <2>;
 			};
 
-			pwm at 23{
-				compatible = "max31790";
-				reg = <0x23>;
+			pwm at 2f{
+				compatible = "maxim,max31790";
+				reg = <0x2f>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 			};
@@ -499,19 +850,19 @@ gpio at 61 {
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
 				reg = <0x20>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -520,11 +871,13 @@ pwm at 20{
 			gpio at 22{
 				compatible = "ti,tca6424";
 				reg = <0x22>;
+				gpio-controller;
+				#gpio-cells = <2>;
 			};
 
-			pwm at 23{
-				compatible = "max31790";
-				reg = <0x23>;
+			pwm at 2f{
+				compatible = "maxim,max31790";
+				reg = <0x2f>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 			};
@@ -554,12 +907,10 @@ i2c-mux at 73 {
 		compatible = "nxp,pca9544";
 		#address-cells = <1>;
 		#size-cells = <0>;
-
-		idle-state = <0>;
-		i2c-mux-idle-disconnect;
 		reg = <0x73>;
+		i2c-mux-idle-disconnect;
 
-		i2c at 0 {
+		imux32: i2c at 0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
@@ -570,10 +921,10 @@ adc at 35 {
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
@@ -584,6 +935,8 @@ adc at 35 {
 };
 
 &i2c15 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	mctp-controller;
 	multi-master;
@@ -596,9 +949,50 @@ mctp at 10 {
 
 	i2c-mux at 72 {
 		compatible = "nxp,pca9544";
-		idle-state = <0>;
-		i2c-mux-idle-disconnect;
+		#address-cells = <1>;
+		#size-cells = <0>;
 		reg = <0x72>;
+		i2c-mux-idle-disconnect;
+
+		imux24: i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+			temperature-sensor at 1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
+		};
+
+		imux25: i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			temperature-sensor at 1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
+		};
+
+		imux26: i2c at 2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+			temperature-sensor at 1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
+		};
+
+		imux27: i2c at 3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+			temperature-sensor at 1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
+		};
 	};
 };
 
-- 
2.25.1

