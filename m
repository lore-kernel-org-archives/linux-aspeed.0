From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Date: Thu,  3 Oct 2024 15:42:42 +0800
Subject: [PATCH v3 1/9] ARM: dts: aspeed: yosemite4: add i2c-mux for all Server Board slots
In-Reply-To: <20241003074251.3818101-1-Delphine_CC_Chiu@wiwynn.com>
References: <20241003074251.3818101-1-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <20241003074251.3818101-2-Delphine_CC_Chiu@wiwynn.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

Add i2c mux to 8 slots of server board and add the io expanders and
eeprom for the slots.

Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 238 +++++++++++++++++-
 1 file changed, 234 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index ae2a2ed603ff..5d623d0355df 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -18,6 +18,14 @@ aliases {
 		serial7 = &uart8;
 		serial8 = &uart9;
 
+		i2c16 = &imux16;
+		i2c17 = &imux17;
+		i2c18 = &imux18;
+		i2c19 = &imux19;
+		i2c20 = &imux20;
+		i2c21 = &imux21;
+		i2c22 = &imux22;
+		i2c23 = &imux23;
 		i2c34 = &imux34;
 		i2c35 = &imux35;
 	};
@@ -517,24 +525,246 @@ power-sensor at 40 {
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
 		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		imux16: i2c at 0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
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
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
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
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
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
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
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
 		reg = <0x71>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		imux20: i2c at 0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
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
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
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
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
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
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
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
 
-- 
2.25.1

