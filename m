From: Eddie James <eajames@linux.ibm.com>
Date: Thu, 16 May 2024 13:19:07 -0500
Subject: [PATCH v3 40/40] ARM: dts: aspeed: P10: Bump SPI max frequencies
In-Reply-To: <20240516181907.3468796-1-eajames@linux.ibm.com>
References: <20240516181907.3468796-1-eajames@linux.ibm.com>
Message-ID: <20240516181907.3468796-41-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

These parts support 10MHZ.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 .../dts/aspeed/aspeed-bmc-ibm-everest.dts     | 32 +++++++++----------
 .../arm/boot/dts/aspeed/ibm-power10-dual.dtsi | 16 +++++-----
 .../arm/boot/dts/aspeed/ibm-power10-quad.dtsi | 16 +++++-----
 3 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts
index 214b2e6a4c6df..1365dc95f1352 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts
@@ -2797,7 +2797,7 @@ eeprom at 0 {
 
 					compatible = "atmel,at25";
 					reg = <0>;
-					spi-max-frequency = <1000000>;
+					spi-max-frequency = <10000000>;
 				};
 			};
 
@@ -2813,7 +2813,7 @@ eeprom at 0 {
 
 					compatible = "atmel,at25";
 					reg = <0>;
-					spi-max-frequency = <1000000>;
+					spi-max-frequency = <10000000>;
 				};
 			};
 
@@ -2830,7 +2830,7 @@ eeprom at 0 {
 
 					compatible = "atmel,at25";
 					reg = <0>;
-					spi-max-frequency = <1000000>;
+					spi-max-frequency = <10000000>;
 				};
 			};
 
@@ -2847,7 +2847,7 @@ eeprom at 0 {
 
 					compatible = "atmel,at25";
 					reg = <0>;
-					spi-max-frequency = <1000000>;
+					spi-max-frequency = <10000000>;
 				};
 			};
 		};
@@ -3170,7 +3170,7 @@ eeprom at 0 {
 
 					compatible = "atmel,at25";
 					reg = <0>;
-					spi-max-frequency = <1000000>;
+					spi-max-frequency = <10000000>;
 				};
 			};
 
@@ -3186,7 +3186,7 @@ eeprom at 0 {
 
 					compatible = "atmel,at25";
 					reg = <0>;
-					spi-max-frequency = <1000000>;
+					spi-max-frequency = <10000000>;
 				};
 			};
 
@@ -3203,7 +3203,7 @@ eeprom at 0 {
 
 					compatible = "atmel,at25";
 					reg = <0>;
-					spi-max-frequency = <1000000>;
+					spi-max-frequency = <10000000>;
 				};
 			};
 
@@ -3220,7 +3220,7 @@ eeprom at 0 {
 
 					compatible = "atmel,at25";
 					reg = <0>;
-					spi-max-frequency = <1000000>;
+					spi-max-frequency = <10000000>;
 				};
 			};
 		};
@@ -3543,7 +3543,7 @@ eeprom at 0 {
 
 					compatible = "atmel,at25";
 					reg = <0>;
-					spi-max-frequency = <1000000>;
+					spi-max-frequency = <10000000>;
 				};
 			};
 
@@ -3559,7 +3559,7 @@ eeprom at 0 {
 
 					compatible = "atmel,at25";
 					reg = <0>;
-					spi-max-frequency = <1000000>;
+					spi-max-frequency = <10000000>;
 				};
 			};
 
@@ -3576,7 +3576,7 @@ eeprom at 0 {
 
 					compatible = "atmel,at25";
 					reg = <0>;
-					spi-max-frequency = <1000000>;
+					spi-max-frequency = <10000000>;
 				};
 			};
 
@@ -3593,7 +3593,7 @@ eeprom at 0 {
 
 					compatible = "atmel,at25";
 					reg = <0>;
-					spi-max-frequency = <1000000>;
+					spi-max-frequency = <10000000>;
 				};
 			};
 		};
@@ -3916,7 +3916,7 @@ eeprom at 0 {
 
 					compatible = "atmel,at25";
 					reg = <0>;
-					spi-max-frequency = <1000000>;
+					spi-max-frequency = <10000000>;
 				};
 			};
 
@@ -3932,7 +3932,7 @@ eeprom at 0 {
 
 					compatible = "atmel,at25";
 					reg = <0>;
-					spi-max-frequency = <1000000>;
+					spi-max-frequency = <10000000>;
 				};
 			};
 
@@ -3949,7 +3949,7 @@ eeprom at 0 {
 
 					compatible = "atmel,at25";
 					reg = <0>;
-					spi-max-frequency = <1000000>;
+					spi-max-frequency = <10000000>;
 				};
 			};
 
@@ -3966,7 +3966,7 @@ eeprom at 0 {
 
 					compatible = "atmel,at25";
 					reg = <0>;
-					spi-max-frequency = <1000000>;
+					spi-max-frequency = <10000000>;
 				};
 			};
 		};
diff --git a/arch/arm/boot/dts/aspeed/ibm-power10-dual.dtsi b/arch/arm/boot/dts/aspeed/ibm-power10-dual.dtsi
index 44e48e39e6e96..e11354bb384c2 100644
--- a/arch/arm/boot/dts/aspeed/ibm-power10-dual.dtsi
+++ b/arch/arm/boot/dts/aspeed/ibm-power10-dual.dtsi
@@ -94,7 +94,7 @@ eeprom at 0 {
 
 					compatible = "atmel,at25";
 					reg = <0>;
-					spi-max-frequency = <1000000>;
+					spi-max-frequency = <10000000>;
 				};
 			};
 
@@ -110,7 +110,7 @@ eeprom at 0 {
 
 					compatible = "atmel,at25";
 					reg = <0>;
-					spi-max-frequency = <1000000>;
+					spi-max-frequency = <10000000>;
 				};
 			};
 
@@ -127,7 +127,7 @@ eeprom at 0 {
 
 					compatible = "atmel,at25";
 					reg = <0>;
-					spi-max-frequency = <1000000>;
+					spi-max-frequency = <10000000>;
 				};
 			};
 
@@ -144,7 +144,7 @@ eeprom at 0 {
 
 					compatible = "atmel,at25";
 					reg = <0>;
-					spi-max-frequency = <1000000>;
+					spi-max-frequency = <10000000>;
 				};
 			};
 		};
@@ -261,7 +261,7 @@ eeprom at 0 {
 
 					compatible = "atmel,at25";
 					reg = <0>;
-					spi-max-frequency = <1000000>;
+					spi-max-frequency = <10000000>;
 				};
 			};
 
@@ -277,7 +277,7 @@ eeprom at 0 {
 
 					compatible = "atmel,at25";
 					reg = <0>;
-					spi-max-frequency = <1000000>;
+					spi-max-frequency = <10000000>;
 				};
 			};
 
@@ -294,7 +294,7 @@ eeprom at 0 {
 
 					compatible = "atmel,at25";
 					reg = <0>;
-					spi-max-frequency = <1000000>;
+					spi-max-frequency = <10000000>;
 				};
 			};
 
@@ -311,7 +311,7 @@ eeprom at 0 {
 
 					compatible = "atmel,at25";
 					reg = <0>;
-					spi-max-frequency = <1000000>;
+					spi-max-frequency = <10000000>;
 				};
 			};
 		};
diff --git a/arch/arm/boot/dts/aspeed/ibm-power10-quad.dtsi b/arch/arm/boot/dts/aspeed/ibm-power10-quad.dtsi
index 57494c744b5d0..0ffb4ae6423fc 100644
--- a/arch/arm/boot/dts/aspeed/ibm-power10-quad.dtsi
+++ b/arch/arm/boot/dts/aspeed/ibm-power10-quad.dtsi
@@ -744,7 +744,7 @@ eeprom at 0 {
 
 					compatible = "atmel,at25";
 					reg = <0>;
-					spi-max-frequency = <1000000>;
+					spi-max-frequency = <10000000>;
 				};
 			};
 
@@ -760,7 +760,7 @@ eeprom at 0 {
 
 					compatible = "atmel,at25";
 					reg = <0>;
-					spi-max-frequency = <1000000>;
+					spi-max-frequency = <10000000>;
 				};
 			};
 
@@ -777,7 +777,7 @@ eeprom at 0 {
 
 					compatible = "atmel,at25";
 					reg = <0>;
-					spi-max-frequency = <1000000>;
+					spi-max-frequency = <10000000>;
 				};
 			};
 
@@ -794,7 +794,7 @@ eeprom at 0 {
 
 					compatible = "atmel,at25";
 					reg = <0>;
-					spi-max-frequency = <1000000>;
+					spi-max-frequency = <10000000>;
 				};
 			};
 		};
@@ -1117,7 +1117,7 @@ eeprom at 0 {
 
 					compatible = "atmel,at25";
 					reg = <0>;
-					spi-max-frequency = <1000000>;
+					spi-max-frequency = <10000000>;
 				};
 			};
 
@@ -1133,7 +1133,7 @@ eeprom at 0 {
 
 					compatible = "atmel,at25";
 					reg = <0>;
-					spi-max-frequency = <1000000>;
+					spi-max-frequency = <10000000>;
 				};
 			};
 
@@ -1150,7 +1150,7 @@ eeprom at 0 {
 
 					compatible = "atmel,at25";
 					reg = <0>;
-					spi-max-frequency = <1000000>;
+					spi-max-frequency = <10000000>;
 				};
 			};
 
@@ -1167,7 +1167,7 @@ eeprom at 0 {
 
 					compatible = "atmel,at25";
 					reg = <0>;
-					spi-max-frequency = <1000000>;
+					spi-max-frequency = <10000000>;
 				};
 			};
 		};
-- 
2.39.3

