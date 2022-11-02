From: Joel Stanley <joel@jms.id.au>
Date: Thu,  3 Nov 2022 09:05:54 +1030
Subject: [PATCH] ARM: dts: aspeed: rainier: Fix pca9551 nodes
Message-ID: <20221102223554.1738642-1-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Santosh Puranik <santosh.puranik@in.ibm.com>

The pca9551 compatible LED drivers are under the pca9546 mux
on Rainier pass > 1. On pass 1, they are directly connected to
the aspeed i2c.

Signed-off-by: Santosh Puranik <santosh.puranik@in.ibm.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 208 +++++++++----------
 1 file changed, 104 insertions(+), 104 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
index 24c1f698275d..05d856856844 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
@@ -1018,32 +1018,6 @@ tmp275 at 4a {
 		reg = <0x4a>;
 	};
 
-	pca9551 at 60 {
-		compatible = "nxp,pca9551";
-		reg = <0x60>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		gpio-controller;
-		#gpio-cells = <2>;
-
-		led at 0 {
-			label = "cablecard0-cxp-top";
-			reg = <0>;
-			retain-state-shutdown;
-			default-state = "keep";
-			type = <PCA955X_TYPE_LED>;
-		};
-
-		led at 1 {
-			label = "cablecard0-cxp-bot";
-			reg = <1>;
-			retain-state-shutdown;
-			default-state = "keep";
-			type = <PCA955X_TYPE_LED>;
-		};
-	};
-
 	pca9546 at 70 {
 		compatible = "nxp,pca9546";
 		reg = <0x70>;
@@ -1061,6 +1035,32 @@ eeprom at 50 {
 				compatible = "atmel,24c64";
 				reg = <0x50>;
 			};
+
+			pca9551 at 60 {
+				compatible = "nxp,pca9551";
+				reg = <0x60>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				led at 0 {
+					label = "cablecard0-cxp-top";
+					reg = <0>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led at 1 {
+					label = "cablecard0-cxp-bot";
+					reg = <1>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+			};
 		};
 
 		i2c4mux0chn1: i2c at 1 {
@@ -1100,58 +1100,6 @@ tmp275 at 49 {
 		reg = <0x49>;
 	};
 
-	pca9551 at 60 {
-		compatible = "nxp,pca9551";
-		reg = <0x60>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		gpio-controller;
-		#gpio-cells = <2>;
-
-		led at 0 {
-			label = "cablecard3-cxp-top";
-			reg = <0>;
-			retain-state-shutdown;
-			default-state = "keep";
-			type = <PCA955X_TYPE_LED>;
-		};
-
-		led at 1 {
-			label = "cablecard3-cxp-bot";
-			reg = <1>;
-			retain-state-shutdown;
-			default-state = "keep";
-			type = <PCA955X_TYPE_LED>;
-		};
-	};
-
-	pca9551 at 61 {
-		compatible = "nxp,pca9551";
-		reg = <0x61>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		gpio-controller;
-		#gpio-cells = <2>;
-
-		led at 0 {
-			label = "cablecard4-cxp-top";
-			reg = <0>;
-			retain-state-shutdown;
-			default-state = "keep";
-			type = <PCA955X_TYPE_LED>;
-		};
-
-		led at 1 {
-			label = "cablecard4-cxp-bot";
-			reg = <1>;
-			retain-state-shutdown;
-			default-state = "keep";
-			type = <PCA955X_TYPE_LED>;
-		};
-	};
-
 	pca9546 at 70 {
 		compatible = "nxp,pca9546";
 		reg = <0x70>;
@@ -1169,6 +1117,32 @@ eeprom at 50 {
 				compatible = "atmel,24c64";
 				reg = <0x50>;
 			};
+
+			pca9551 at 60 {
+				compatible = "nxp,pca9551";
+				reg = <0x60>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				led at 0 {
+					label = "cablecard3-cxp-top";
+					reg = <0>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led at 1 {
+					label = "cablecard3-cxp-bot";
+					reg = <1>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+			};
 		};
 
 		i2c5mux0chn1: i2c at 1 {
@@ -1180,6 +1154,32 @@ eeprom at 51 {
 				compatible = "atmel,24c64";
 				reg = <0x51>;
 			};
+
+			pca9551 at 61 {
+				compatible = "nxp,pca9551";
+				reg = <0x61>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				led at 0 {
+					label = "cablecard4-cxp-top";
+					reg = <0>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led at 1 {
+					label = "cablecard4-cxp-bot";
+					reg = <1>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+			};
 		};
 	};
 };
@@ -2032,32 +2032,6 @@ tmp275 at 49 {
 		reg = <0x49>;
 	};
 
-	pca9551 at 60 {
-		compatible = "nxp,pca9551";
-		reg = <0x60>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		gpio-controller;
-		#gpio-cells = <2>;
-
-		led at 0 {
-			label = "cablecard10-cxp-top";
-			reg = <0>;
-			retain-state-shutdown;
-			default-state = "keep";
-			type = <PCA955X_TYPE_LED>;
-		};
-
-		led at 1 {
-			label = "cablecard10-cxp-bot";
-			reg = <1>;
-			retain-state-shutdown;
-			default-state = "keep";
-			type = <PCA955X_TYPE_LED>;
-		};
-	};
-
 	pca9546 at 70 {
 		compatible = "nxp,pca9546";
 		reg = <0x70>;
@@ -2075,6 +2049,32 @@ eeprom at 50 {
 				compatible = "atmel,24c64";
 				reg = <0x50>;
 			};
+
+			pca9551 at 60 {
+				compatible = "nxp,pca9551";
+				reg = <0x60>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				led at 0 {
+					label = "cablecard10-cxp-top";
+					reg = <0>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led at 1 {
+					label = "cablecard10-cxp-bot";
+					reg = <1>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+			};
 		};
 
 		i2c11mux0chn1: i2c at 1 {
-- 
2.35.1

