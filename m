From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Date: Fri, 20 Sep 2024 15:04:49 +0800
Subject: [PATCH v19 2/2] ARM: dts: aspeed: yosemite4: add mctp config and sensors for NIC
In-Reply-To: <20240920070449.3871705-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240920070449.3871705-1-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <20240920070449.3871705-3-Delphine_CC_Chiu@wiwynn.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

- Add MCTP config for NIC and remove the unnecessary MCTP config on bus
15.
- Add eeprom for NIC.

Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 30 +++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 6b4efb5fbd83..621e4e970790 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -937,7 +937,6 @@ &i2c15 {
 	#address-cells = <1>;
 	#size-cells = <0>;
 	status = "okay";
-	mctp-controller;
 	multi-master;
 	bus-frequency = <400000>;
 
@@ -951,46 +950,73 @@ i2c-mux at 72 {
 		reg = <0x72>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		i2c-mux-idle-disconnect;
 
 		imux24: i2c at 0 {
 			reg = <0>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			mctp-controller;
+
 			temperature-sensor at 1f {
 				compatible = "ti,tmp421";
 				reg = <0x1f>;
 			};
+
+			eeprom at 50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
 		};
 
 		imux25: i2c at 1 {
 			reg = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			mctp-controller;
+
 			temperature-sensor at 1f {
 				compatible = "ti,tmp421";
 				reg = <0x1f>;
 			};
+
+			eeprom at 50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
 		};
 
 		imux26: i2c at 2 {
 			reg = <2>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			mctp-controller;
+
 			temperature-sensor at 1f {
 				compatible = "ti,tmp421";
 				reg = <0x1f>;
 			};
+
+			eeprom at 50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
 		};
 
 		imux27: i2c at 3 {
 			reg = <3>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			mctp-controller;
+
 			temperature-sensor at 1f {
 				compatible = "ti,tmp421";
 				reg = <0x1f>;
 			};
+
+			eeprom at 50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
 		};
 	};
 };
-- 
2.25.1

