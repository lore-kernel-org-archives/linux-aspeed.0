From: Vijay Khemka <vijaykhemka@fb.com>
Date: Tue, 23 Jul 2019 10:58:20 -0700
Subject: [PATCH v2] ARM: dts: aspeed: tiogapass: Add Riser card
Message-ID: <20190723175820.1565972-1-vijaykhemka@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Added i2c mux for riser card and multiple ava card and its sensor
components for Facebook tiogapass platform

Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
---
In V2: Modified ina219 to ina230 which is correct device.

 .../dts/aspeed-bmc-facebook-tiogapass.dts     | 230 ++++++++++++++++++
 1 file changed, 230 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
index e722e9aef907..d0c823e8fce5 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
@@ -12,6 +12,27 @@
 	aliases {
 		serial0 = &uart1;
 		serial4 = &uart5;
+
+		/*
+		 * Hardcode the bus number of i2c switches' channels to
+		 * avoid breaking the legacy applications.
+		 */
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
 	};
 	chosen {
 		stdout-path = &uart5;
@@ -124,6 +145,215 @@
 &i2c1 {
 	status = "okay";
 	//X24 Riser
+	i2c-switch at 71 {
+		compatible = "nxp,pca9544";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x71>;
+
+		imux16: i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			ina230 at 45 {
+				compatible = "ti,ina230";
+				reg = <0x45>;
+			};
+
+			tmp75 at 48 {
+				compatible = "ti,tmp75";
+				reg = <0x48>;
+			};
+
+			tmp421 at 49 {
+				compatible = "ti,tmp75";
+				reg = <0x49>;
+			};
+
+			eeprom at 50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+				pagesize = <32>;
+			};
+
+			i2c-switch at 73 {
+				compatible = "nxp,pca9546";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x73>;
+
+				imux20: i2c at 0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+				};
+
+				imux21: i2c at 1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+				};
+
+				imux22: i2c at 2 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <2>;
+				};
+
+				imux23: i2c at 3 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <3>;
+				};
+
+			};
+
+		};
+
+		imux17: i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+
+			ina230 at 45 {
+				compatible = "ti,ina230";
+				reg = <0x45>;
+			};
+
+			tmp421 at 48 {
+				compatible = "ti,tmp75";
+				reg = <0x48>;
+			};
+
+			tmp421 at 49 {
+				compatible = "ti,tmp75";
+				reg = <0x49>;
+			};
+
+			eeprom at 50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+				pagesize = <32>;
+			};
+
+			i2c-switch at 73 {
+				compatible = "nxp,pca9546";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x73>;
+
+				imux24: i2c at 0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+				};
+
+				imux25: i2c at 1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+				};
+
+				imux26: i2c at 2 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <2>;
+				};
+
+				imux27: i2c at 3 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <3>;
+				};
+
+			};
+
+		};
+
+		imux18: i2c at 2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+
+			ina230 at 45 {
+				compatible = "ti,ina230";
+				reg = <0x45>;
+			};
+
+			tmp421 at 48 {
+				compatible = "ti,tmp75";
+				reg = <0x48>;
+			};
+
+			tmp421 at 49 {
+				compatible = "ti,tmp75";
+				reg = <0x49>;
+			};
+
+			eeprom at 50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+				pagesize = <32>;
+			};
+
+			i2c-switch at 73 {
+				compatible = "nxp,pca9546";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x73>;
+
+				imux28: i2c at 0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+				};
+
+				imux29: i2c at 1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+				};
+
+				imux30: i2c at 2 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <2>;
+				};
+
+				imux31: i2c at 3 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <3>;
+				};
+
+			};
+
+		};
+
+		imux19: i2c at 3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+
+			i2c-switch at 40 {
+				compatible = "ti,ina230";
+				reg = <0x40>;
+			};
+
+			i2c-switch at 41 {
+				compatible = "ti,ina230";
+				reg = <0x41>;
+			};
+
+			i2c-switch at 45 {
+				compatible = "ti,ina230";
+				reg = <0x45>;
+			};
+
+		};
+
+	};
 };
 
 &i2c2 {
-- 
2.17.1

