From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Date: Thu, 26 Sep 2024 10:31:19 +0800
Subject: [PATCH v1] ARM: dts: aspeed: yosemite4: Add i2c-mux for four NICs
Message-ID: <20240926023120.3785292-1-Delphine_CC_Chiu@wiwynn.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

Add i2c-mux on Spider board for four NICs and add the temperature sensor
and EEPROM for the NICs.

Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 76 ++++++++++++++++++-
 1 file changed, 73 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 98477792aa00..d6b1742605c1 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -17,6 +17,11 @@ aliases {
 		serial6 = &uart7;
 		serial7 = &uart8;
 		serial8 = &uart9;
+
+		i2c24 = &imux24;
+		i2c25 = &imux25;
+		i2c26 = &imux26;
+		i2c27 = &imux27;
 	};
 
 	chosen {
@@ -584,8 +589,9 @@ adc at 35 {
 };
 
 &i2c15 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
-	mctp-controller;
 	multi-master;
 	bus-frequency = <400000>;
 
@@ -596,9 +602,73 @@ mctp at 10 {
 
 	i2c-mux at 72 {
 		compatible = "nxp,pca9544";
-		idle-state = <0>;
-		i2c-mux-idle-disconnect;
 		reg = <0x72>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		imux24: i2c at 0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			mctp-controller;
+			temperature-sensor at 1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
+
+			eeprom at 50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
+		};
+
+		imux25: i2c at 1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			mctp-controller;
+			temperature-sensor at 1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
+
+			eeprom at 50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
+		};
+
+		imux26: i2c at 2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			mctp-controller;
+			temperature-sensor at 1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
+
+			eeprom at 50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
+		};
+
+		imux27: i2c at 3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			mctp-controller;
+			temperature-sensor at 1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
+
+			eeprom at 50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
+		};
 	};
 };
 
-- 
2.25.1

