From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Date: Thu,  3 Oct 2024 15:42:43 +0800
Subject: [PATCH v3 2/9] ARM: dts: aspeed: yosemite4: Add i2c-mux for four NICs
In-Reply-To: <20241003074251.3818101-1-Delphine_CC_Chiu@wiwynn.com>
References: <20241003074251.3818101-1-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <20241003074251.3818101-3-Delphine_CC_Chiu@wiwynn.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

Add i2c-mux on Spider board for four NICs and add the temperature sensor
and EEPROM for the NICs.

Also remove the mctp-controller property on I2C bus 15 because we need
to add the property on the I2C mux to each NIC so that the MCTP driver
will ensure that each port is configured properly before communicating
with the NICs.

Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 75 ++++++++++++++++++-
 1 file changed, 72 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 5d623d0355df..fc8af704fe20 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -26,6 +26,10 @@ aliases {
 		i2c21 = &imux21;
 		i2c22 = &imux22;
 		i2c23 = &imux23;
+		i2c24 = &imux24;
+		i2c25 = &imux25;
+		i2c26 = &imux26;
+		i2c27 = &imux27;
 		i2c34 = &imux34;
 		i2c35 = &imux35;
 	};
@@ -1168,8 +1172,9 @@ adc at 35 {
 };
 
 &i2c15 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
-	mctp-controller;
 	multi-master;
 	bus-frequency = <400000>;
 
@@ -1180,9 +1185,73 @@ mctp at 10 {
 
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

