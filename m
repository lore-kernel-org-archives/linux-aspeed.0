From: Joel Stanley <joel@jms.id.au>
Date: Mon,  7 Jun 2021 12:42:59 +0930
Subject: [PATCH 6/6] ARM: dts: aspeed: everest: Add pcie cable card indicator
 leds
In-Reply-To: <20210607031259.475020-1-joel@jms.id.au>
References: <20210607031259.475020-1-joel@jms.id.au>
Message-ID: <20210607031259.475020-7-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Vishwanatha Subbanna <vishwa@linux.vnet.ibm.com>

These are leds on the IBM proprietary PCIE cards called cable cards.
Cable cards have 2 ports on them and each port has an indicator led.

Signed-off-by: Vishwanatha Subbanna <vishwa@linux.vnet.ibm.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts | 714 +++++++++++++++++--
 1 file changed, 665 insertions(+), 49 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
index 2bac7d1f8a03..d26a9e16ff7c 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
@@ -508,6 +508,62 @@ eeprom at 52 {
 				compatible = "atmel,24c64";
 				reg = <0x52>;
 			};
+
+			pca_cable_card_c01: pca9551 at 62 {
+				compatible = "nxp,pca9551";
+				reg = <0x62>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				led at 0 {
+					label = "cablecard-c01-cxp-top";
+					reg = <0>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led at 1 {
+					label = "cablecard-c01-cxp-bot";
+					reg = <1>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				gpio at 2 {
+					reg = <2>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 3 {
+					reg = <3>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 4 {
+					reg = <4>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 5 {
+					reg = <5>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 6 {
+					reg = <6>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 7 {
+					reg = <7>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+			};
 		};
 
 		i2c4mux0chn1: i2c at 1 {
@@ -518,6 +574,62 @@ eeprom at 50 {
 				compatible = "atmel,24c64";
 				reg = <0x50>;
 			};
+
+			pca_cable_card_c02: pca9551 at 60 {
+				compatible = "nxp,pca9551";
+				reg = <0x60>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				led at 0 {
+					label = "cablecard-c02-cxp-top";
+					reg = <0>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led at 1 {
+					label = "cablecard-c02-cxp-bot";
+					reg = <1>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				gpio at 2 {
+					reg = <2>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 3 {
+					reg = <3>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 4 {
+					reg = <4>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 5 {
+					reg = <5>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 6 {
+					reg = <6>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 7 {
+					reg = <7>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+			};
 		};
 
 		i2c4mux0chn2: i2c at 2 {
@@ -528,6 +640,62 @@ eeprom at 51 {
 				compatible = "atmel,24c64";
 				reg = <0x51>;
 			};
+
+			pca_cable_card_c03: pca9551 at 61 {
+				compatible = "nxp,pca9551";
+				reg = <0x61>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				led at 0 {
+					label = "cablecard-c03-cxp-top";
+					reg = <0>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led at 1 {
+					label = "cablecard-c03-cxp-bot";
+					reg = <1>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				gpio at 2 {
+					reg = <2>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 3 {
+					reg = <3>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 4 {
+					reg = <4>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 5 {
+					reg = <5>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 6 {
+					reg = <6>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 7 {
+					reg = <7>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+			};
 		};
 	};
 };
@@ -636,68 +804,404 @@ eeprom at 50 {
 				compatible = "atmel,24c64";
 				reg = <0x50>;
 			};
-		};
 
-		i2c5mux0chn1: i2c at 1 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <1>;
-			eeprom at 51 {
-				compatible = "atmel,24c64";
-				reg = <0x51>;
-			};
-		};
+			pca_cable_card_c04: pca9551 at 60 {
+				compatible = "nxp,pca9551";
+				reg = <0x60>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 
-		i2c5mux0chn2: i2c at 2 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <2>;
-			eeprom at 52 {
-				compatible = "atmel,24c64";
-				reg = <0x52>;
-			};
-		};
+				gpio-controller;
+				#gpio-cells = <2>;
 
-		i2c5mux0chn3: i2c at 3 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <3>;
-			eeprom at 53 {
-				compatible = "atmel,24c64";
-				reg = <0x53>;
-			};
-		};
-	};
-};
+				led at 0 {
+					label = "cablecard-c04-cxp-top";
+					reg = <0>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
 
-&i2c6 {
-	status = "okay";
+				led at 1 {
+					label = "cablecard-c04-cxp-bot";
+					reg = <1>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
 
-	i2c-switch at 70 {
-		compatible = "nxp,pca9546";
-		reg = <0x70>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		status = "okay";
-		i2c-mux-idle-disconnect;
+				gpio at 2 {
+					reg = <2>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
 
-		i2c6mux0chn0: i2c at 0 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0>;
-			eeprom at 50 {
-				compatible = "atmel,24c64";
-				reg = <0x50>;
+				gpio at 3 {
+					reg = <3>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 4 {
+					reg = <4>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 5 {
+					reg = <5>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 6 {
+					reg = <6>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 7 {
+					reg = <7>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
 			};
 		};
 
-		i2c6mux0chn1: i2c at 1 {
+		i2c5mux0chn1: i2c at 1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <1>;
-			eeprom at 52 {
+			eeprom at 51 {
 				compatible = "atmel,24c64";
-				reg = <0x52>;
+				reg = <0x51>;
+			};
+
+			pca_cable_card_c05: pca9551 at 61 {
+				compatible = "nxp,pca9551";
+				reg = <0x61>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				led at 0 {
+					label = "cablecard-c05-cxp-top";
+					reg = <0>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led at 1 {
+					label = "cablecard-c05-cxp-bot";
+					reg = <1>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				gpio at 2 {
+					reg = <2>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 3 {
+					reg = <3>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 4 {
+					reg = <4>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 5 {
+					reg = <5>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 6 {
+					reg = <6>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 7 {
+					reg = <7>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+			};
+		};
+
+		i2c5mux0chn2: i2c at 2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+			eeprom at 52 {
+				compatible = "atmel,24c64";
+				reg = <0x52>;
+			};
+
+			pca_cable_card_c06: pca9551 at 62 {
+				compatible = "nxp,pca9551";
+				reg = <0x62>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				led at 0 {
+					label = "cablecard-c06-cxp-top";
+					reg = <0>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led at 1 {
+					label = "cablecard-c06-cxp-bot";
+					reg = <1>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				gpio at 2 {
+					reg = <2>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 3 {
+					reg = <3>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 4 {
+					reg = <4>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 5 {
+					reg = <5>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 6 {
+					reg = <6>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 7 {
+					reg = <7>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+			};
+		};
+
+		i2c5mux0chn3: i2c at 3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+			eeprom at 53 {
+				compatible = "atmel,24c64";
+				reg = <0x53>;
+			};
+
+			pca_cable_card_c07: pca9551 at 63 {
+				compatible = "nxp,pca9551";
+				reg = <0x63>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				led at 0 {
+					label = "cablecard-c07-cxp-top";
+					reg = <0>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led at 1 {
+					label = "cablecard-c07-cxp-bot";
+					reg = <1>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				gpio at 2 {
+					reg = <2>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 3 {
+					reg = <3>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 4 {
+					reg = <4>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 5 {
+					reg = <5>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 6 {
+					reg = <6>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 7 {
+					reg = <7>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+			};
+		};
+	};
+};
+
+&i2c6 {
+	status = "okay";
+
+	i2c-switch at 70 {
+		compatible = "nxp,pca9546";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "okay";
+		i2c-mux-idle-disconnect;
+
+		i2c6mux0chn0: i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+			eeprom at 50 {
+			compatible = "atmel,24c64";
+			reg = <0x50>;
+			};
+
+			pca_cable_card_c08: pca9551 at 60 {
+				compatible = "nxp,pca9551";
+				reg = <0x60>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				led at 0 {
+					label = "cablecard-c08-cxp-top";
+					reg = <0>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led at 1 {
+					label = "cablecard-c08-cxp-bot";
+					reg = <1>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				gpio at 2 {
+					reg = <2>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 3 {
+					reg = <3>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 4 {
+					reg = <4>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 5 {
+					reg = <5>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 6 {
+					reg = <6>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 7 {
+					reg = <7>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+			};
+		};
+
+		i2c6mux0chn1: i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			eeprom at 52 {
+				compatible = "atmel,24c64";
+				reg = <0x52>;
+			};
+
+			pca_cable_card_c09: pca9551 at 62 {
+				compatible = "nxp,pca9551";
+				reg = <0x62>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				led at 0 {
+					label = "cablecard-c09-cxp-top";
+					reg = <0>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led at 1 {
+					label = "cablecard-c09-cxp-bot";
+					reg = <1>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				gpio at 2 {
+					reg = <2>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 3 {
+					reg = <3>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 4 {
+					reg = <4>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 5 {
+					reg = <5>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 6 {
+					reg = <6>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 7 {
+					reg = <7>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
 			};
 		};
 
@@ -709,6 +1213,62 @@ eeprom at 53 {
 				compatible = "atmel,24c64";
 				reg = <0x53>;
 			};
+
+			pca_cable_card_c10: pca9551 at 63 {
+				compatible = "nxp,pca9551";
+				reg = <0x63>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				led at 0 {
+					label = "cablecard-c10-cxp-top";
+					reg = <0>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led at 1 {
+					label = "cablecard-c10-cxp-bot";
+					reg = <1>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				gpio at 2 {
+					reg = <2>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 3 {
+					reg = <3>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 4 {
+					reg = <4>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 5 {
+					reg = <5>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 6 {
+					reg = <6>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 7 {
+					reg = <7>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+			};
 		};
 
 		i2c6mux0chn3: i2c at 3 {
@@ -719,6 +1279,62 @@ eeprom at 51 {
 				compatible = "atmel,24c64";
 				reg = <0x51>;
 			};
+
+			pca_cable_card_c11: pca9551 at 61 {
+				compatible = "nxp,pca9551";
+				reg = <0x61>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				led at 0 {
+					label = "cablecard-c11-cxp-top";
+					reg = <0>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led at 1 {
+					label = "cablecard-c11-cxp-bot";
+					reg = <1>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				gpio at 2 {
+					reg = <2>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 3 {
+					reg = <3>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 4 {
+					reg = <4>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 5 {
+					reg = <5>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 6 {
+					reg = <6>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+
+				gpio at 7 {
+					reg = <7>;
+					type = <PCA955X_TYPE_GPIO>;
+				};
+			};
 		};
 	};
 
-- 
2.30.2

