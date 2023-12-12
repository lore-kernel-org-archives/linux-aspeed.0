From: Ninad Palsule <ninad@linux.ibm.com>
Date: Tue, 12 Dec 2023 10:40:04 -0600
Subject: [PATCH v1 8/8] ARM: dts: aspeed: System1: PS, sensor and more
In-Reply-To: <20231212164004.1683589-1-ninad@linux.ibm.com>
References: <20231212164004.1683589-1-ninad@linux.ibm.com>
Message-ID: <20231212164004.1683589-9-ninad@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This drop adds following devices in the device tree.
- EEPROM/VPD
- Power supplies
- Humidity, pressure and temperature sensors.
- Trusted platform module(TPM) chip

Tested:
    This board is tested using the simics simulator.

Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
 .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
index 75562aa63701..d960b938fe8d 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
@@ -461,6 +461,11 @@ &kcs3 {
 &i2c0 {
 	status = "okay";
 
+	eeprom at 50 {
+		compatible = "atmel,24c64";
+		reg = <0x50>;
+	};
+
 	regulator at 60 {
 		compatible = "maxim,max8952";
 		reg = <0x60>;
@@ -655,6 +660,25 @@ pca0: pca9539 at 74 {
 
 &i2c2 {
 	status = "okay";
+
+	power-supply at 58 {
+		compatible = "ibm,cffps";
+		reg = <0x58>;
+	};
+
+	power-supply at 59 {
+		compatible = "ibm,cffps";
+		reg = <0x59>;
+	};
+
+	power-supply at 5a {
+		compatible = "ibm,cffps";
+		reg = <0x5a>;
+	};
+	power-supply at 5b {
+		compatible = "ibm,cffps";
+		reg = <0x5b>;
+	};
 };
 
 &i2c3 {
@@ -758,6 +782,11 @@ fan-controller at 54 {
 		#size-cells = <0>;
 	};
 
+	eeprom at 55 {
+		compatible = "atmel,24c64";
+		reg = <0x55>;
+	};
+
 	i2c-mux at 70 {
 		compatible = "nxp,pca9548";
 		reg = <0x70>;
@@ -795,6 +824,21 @@ i2c6mux0chn4: i2c at 4 {
 			#size-cells = <0>;
 			reg = <4>;
 
+			humidity-sensor at 40 {
+				compatible = "ti,hdc1080";
+				reg = <0x40>;
+			};
+
+			temperature-sensor at 48 {
+				compatible = "ti,tmp275";
+				reg = <0x48>;
+			};
+
+			eeprom at 50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
+
 			led-controller at 60 {
 				compatible = "nxp,pca9551";
 				reg = <0x60>;
@@ -836,6 +880,12 @@ led at 3 {
 					type = <PCA955X_TYPE_LED>;
 				};
 			};
+
+			temperature-sensor at 76 {
+				compatible = "infineon,dps310";
+				reg = <0x76>;
+				#io-channel-cells = <0>;
+			};
 		};
 
 		i2c6mux0chn5: i2c at 5 {
@@ -1100,6 +1150,11 @@ i2c8mux0chn6: i2c at 6 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <6>;
+
+			temperature-sensor at 4c {
+				compatible = "ti,tmp423";
+				reg = <0x4c>;
+			};
 		};
 
 		i2c8mux0chn7: i2c at 7 {
@@ -1128,6 +1183,11 @@ regulator at 41 {
 		reg = <0x41>;
 	};
 
+	eeprom at 50 {
+		compatible = "atmel,24c64";
+		reg = <0x50>;
+	};
+
 	regulator at 60 {
 		compatible = "maxim,max8952";
 		reg = <0x60>;
@@ -1148,6 +1208,12 @@ regulator at 60 {
 
 &i2c11 {
 	status = "okay";
+
+	tpm at 2e {
+		compatible = "nuvoton,npct75x", "tcg,tpm-tis-i2c";
+		reg = <0x2e>;
+		memory-region = <&event_log>;
+	};
 };
 
 &i2c12 {
@@ -1552,6 +1618,11 @@ i2c15mux0chn6: i2c at 6 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <6>;
+
+			temperature-sensor at 4c {
+				compatible = "ti,tmp423";
+				reg = <0x4c>;
+			};
 		};
 
 		i2c15mux0chn7: i2c at 7 {
@@ -1563,6 +1634,11 @@ regulator at 40 {
 				compatible = "infineon,ir38060";
 				reg = <0x40>;
 			};
+
+			temperature-sensor at 4c {
+				compatible = "ti,tmp423";
+				reg = <0x4c>;
+			};
 		};
 	};
 };
-- 
2.39.2

