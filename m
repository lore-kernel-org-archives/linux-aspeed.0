From: Yang Chen <yangchen.openbmc@gmail.com>
Date: Tue, 12 Dec 2023 15:51:56 +0800
Subject: [PATCH 07/11] ARM: dts: aspeed: minerva: add bus labels and aliases
In-Reply-To: <20231212075200.983536-1-yangchen.openbmc@gmail.com>
References: <20231212075200.983536-1-yangchen.openbmc@gmail.com>
Message-ID: <20231212075200.983536-8-yangchen.openbmc@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add bus labels and aliases for the fan control board.

Signed-off-by: Yang Chen <yangchen.openbmc@gmail.com>
---
 .../aspeed/aspeed-bmc-facebook-minerva.dts    | 22 ++++++++++++++-----
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index f2a48033ac5c..f4cb5ef72310 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -12,6 +12,16 @@ / {
 
 	aliases {
 		serial5 = &uart5;
+		/*
+		 * PCA9548 (2-0077) provides 8 channels connecting to
+		 * 6 pcs of FCB (Fan Controller Board).
+		 */
+		i2c16 = &imux16;
+		i2c17 = &imux17;
+		i2c18 = &imux18;
+		i2c19 = &imux19;
+		i2c20 = &imux20;
+		i2c21 = &imux21;
 	};
 
 	chosen {
@@ -139,7 +149,7 @@ i2c-mux at 77 {
 		#size-cells = <0>;
 		i2c-mux-idle-disconnect;
 
-		i2c at 0 {
+		imux16: i2c at 0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
@@ -150,7 +160,7 @@ eeprom at 50 {
 			};
 		};
 
-		i2c at 1 {
+		imux17: i2c at 1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <1>;
@@ -161,7 +171,7 @@ eeprom at 50 {
 			};
 		};
 
-		i2c at 2 {
+		imux18: i2c at 2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <2>;
@@ -172,7 +182,7 @@ eeprom at 50 {
 			};
 		};
 
-		i2c at 3 {
+		imux19: i2c at 3 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <3>;
@@ -183,7 +193,7 @@ eeprom at 50 {
 			};
 		};
 
-		i2c at 4 {
+		imux20: i2c at 4 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <4>;
@@ -194,7 +204,7 @@ eeprom at 50 {
 			};
 		};
 
-		i2c at 5 {
+		imux21: i2c at 5 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <5>;
-- 
2.34.1

