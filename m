From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Date: Thu, 26 Sep 2024 11:28:17 +0800
Subject: [PATCH v1 1/5] ARM: dts: aspeed: yosemite4: Add i2c-mux for two fan boards
In-Reply-To: <20240926032821.4171466-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240926032821.4171466-1-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <20240926032821.4171466-2-Delphine_CC_Chiu@wiwynn.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

Change the address of the I2C mux for two fan boards to 0x74
according to schematic.

Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 81 ++++++++++---------
 1 file changed, 44 insertions(+), 37 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 98477792aa00..04f6378c2b5f 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -17,6 +17,9 @@ aliases {
 		serial6 = &uart7;
 		serial7 = &uart8;
 		serial8 = &uart9;
+
+		i2c30 = &imux30;
+		i2c31 = &imux31;
 	};
 
 	chosen {
@@ -380,6 +383,8 @@ ipmb at 10 {
 };
 
 &i2c14 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	bus-frequency = <400000>;
 	adc at 1d {
@@ -440,20 +445,50 @@ eeprom at 51 {
 		reg = <0x51>;
 	};
 
-	i2c-mux at 71 {
-		compatible = "nxp,pca9846";
+	i2c-mux at 73 {
+		compatible = "nxp,pca9544";
 		#address-cells = <1>;
 		#size-cells = <0>;
 
 		idle-state = <0>;
 		i2c-mux-idle-disconnect;
-		reg = <0x71>;
+		reg = <0x73>;
 
 		i2c at 0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
 
+			adc at 35 {
+				compatible = "maxim,max11617";
+				reg = <0x35>;
+			};
+		};
+
+		i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			adc at 35 {
+				compatible = "maxim,max11617";
+				reg = <0x35>;
+			};
+		};
+	};
+
+	i2c-mux at 74 {
+		compatible = "nxp,pca9546";
+		reg = <0x74>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		imux30: i2c at 0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
 			adc at 1f {
 				compatible = "ti,adc128d818";
 				reg = <0x1f>;
@@ -470,6 +505,8 @@ pwm at 20{
 			gpio at 22{
 				compatible = "ti,tca6424";
 				reg = <0x22>;
+				gpio-controller;
+				#gpio-cells = <2>;
 			};
 
 			pwm at 23{
@@ -499,10 +536,10 @@ gpio at 61 {
 			};
 		};
 
-		i2c at 1 {
+		imux31: i2c at 1 {
+			reg = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			reg = <0>;
 
 			adc at 1f {
 				compatible = "ti,adc128d818";
@@ -520,6 +557,8 @@ pwm at 20{
 			gpio at 22{
 				compatible = "ti,tca6424";
 				reg = <0x22>;
+				gpio-controller;
+				#gpio-cells = <2>;
 			};
 
 			pwm at 23{
@@ -549,38 +588,6 @@ gpio at 61 {
 			};
 		};
 	};
-
-	i2c-mux at 73 {
-		compatible = "nxp,pca9544";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		idle-state = <0>;
-		i2c-mux-idle-disconnect;
-		reg = <0x73>;
-
-		i2c at 0 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0>;
-
-			adc at 35 {
-				compatible = "maxim,max11617";
-				reg = <0x35>;
-			};
-		};
-
-		i2c at 1 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0>;
-
-			adc at 35 {
-				compatible = "maxim,max11617";
-				reg = <0x35>;
-			};
-		};
-	};
 };
 
 &i2c15 {
-- 
2.25.1

