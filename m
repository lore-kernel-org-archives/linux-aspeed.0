From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 26 Sep 2024 15:10:44 +0800
Subject: [PATCH v2 1/3] ARM: dts: aspeed: catalina: move hdd board i2c mux
 bus to i2c5
In-Reply-To: <20240926-catalina-evt-dvt-system-modify-v2-0-a861daeba059@gmail.com>
References: <20240926-catalina-evt-dvt-system-modify-v2-0-a861daeba059@gmail.com>
Message-ID: <20240926-catalina-evt-dvt-system-modify-v2-1-a861daeba059@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Potin Lai <potin.lai@quantatw.com>

Due to EVT hardware changes, move HDD board i2c mux bus from i2c30 to i2c5.

Signed-off-by: Potin Lai <potin.lai@quantatw.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-catalina.dts    | 165 +++++++++++----------
 1 file changed, 83 insertions(+), 82 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index fa0921a4afe2..eac6e33e98f4 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -50,14 +50,14 @@ aliases {
 		i2c45 = &i2c0mux5ch1;
 		i2c46 = &i2c0mux5ch2;
 		i2c47 = &i2c0mux5ch3;
-		i2c48 = &i2c30mux0ch0;
-		i2c49 = &i2c30mux0ch1;
-		i2c50 = &i2c30mux0ch2;
-		i2c51 = &i2c30mux0ch3;
-		i2c52 = &i2c30mux0ch4;
-		i2c53 = &i2c30mux0ch5;
-		i2c54 = &i2c30mux0ch6;
-		i2c55 = &i2c30mux0ch7;
+		i2c48 = &i2c5mux0ch0;
+		i2c49 = &i2c5mux0ch1;
+		i2c50 = &i2c5mux0ch2;
+		i2c51 = &i2c5mux0ch3;
+		i2c52 = &i2c5mux0ch4;
+		i2c53 = &i2c5mux0ch5;
+		i2c54 = &i2c5mux0ch6;
+		i2c55 = &i2c5mux0ch7;
 	};
 
 	chosen {
@@ -244,80 +244,6 @@ i2c0mux1ch2: i2c at 2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <2>;
-			i2c-mux at 70 {
-				compatible = "nxp,pca9548";
-				reg = <0x70>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				i2c-mux-idle-disconnect;
-
-				i2c30mux0ch0: i2c at 0 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <0>;
-				};
-				i2c30mux0ch1: i2c at 1 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <1>;
-				};
-				i2c30mux0ch2: i2c at 2 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <2>;
-				};
-				i2c30mux0ch3: i2c at 3 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <3>;
-				};
-				i2c30mux0ch4: i2c at 4 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <4>;
-				};
-				i2c30mux0ch5: i2c at 5 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <5>;
-				};
-				i2c30mux0ch6: i2c at 6 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <6>;
-					// HDD FRU EEPROM
-					eeprom at 52 {
-						compatible = "atmel,24c64";
-						reg = <0x52>;
-					};
-				};
-				i2c30mux0ch7: i2c at 7 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <7>;
-
-					power-sensor at 40 {
-						compatible = "ti,ina230";
-						reg = <0x40>;
-						shunt-resistor = <2000>;
-					};
-					power-sensor at 41 {
-						compatible = "ti,ina230";
-						reg = <0x41>;
-						shunt-resistor = <2000>;
-					};
-					power-sensor at 44 {
-						compatible = "ti,ina230";
-						reg = <0x44>;
-						shunt-resistor = <2000>;
-					};
-					power-sensor at 45 {
-						compatible = "ti,ina230";
-						reg = <0x45>;
-						shunt-resistor = <2000>;
-					};
-				};
-			};
 		};
 		i2c0mux1ch3: i2c at 3 {
 			#address-cells = <1>;
@@ -647,6 +573,81 @@ &i2c4 {
 
 &i2c5 {
 	status = "okay";
+
+	i2c-mux at 70 {
+		compatible = "nxp,pca9548";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		i2c5mux0ch0: i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+		i2c5mux0ch1: i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+		i2c5mux0ch2: i2c at 2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+		i2c5mux0ch3: i2c at 3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+		i2c5mux0ch4: i2c at 4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+		};
+		i2c5mux0ch5: i2c at 5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+		};
+		i2c5mux0ch6: i2c at 6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+			// HDD FRU EEPROM
+			eeprom at 52 {
+				compatible = "atmel,24c64";
+				reg = <0x52>;
+			};
+		};
+		i2c5mux0ch7: i2c at 7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+
+			power-sensor at 40 {
+				compatible = "ti,ina230";
+				reg = <0x40>;
+				shunt-resistor = <2000>;
+			};
+			power-sensor at 41 {
+				compatible = "ti,ina230";
+				reg = <0x41>;
+				shunt-resistor = <2000>;
+			};
+			power-sensor at 44 {
+				compatible = "ti,ina230";
+				reg = <0x44>;
+				shunt-resistor = <2000>;
+			};
+			power-sensor at 45 {
+				compatible = "ti,ina230";
+				reg = <0x45>;
+				shunt-resistor = <2000>;
+			};
+		};
+	};
 };
 
 &i2c6 {

-- 
2.31.1

