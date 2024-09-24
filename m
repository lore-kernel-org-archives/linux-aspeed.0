From: Yang Chen <yangchen.openbmc@gmail.com>
Date: Tue, 24 Sep 2024 22:02:14 +0800
Subject: [PATCH v1 2/3] ARM: dts: aspeed: minerva: change the i2c mux number for FCBs
In-Reply-To: <20240924140215.2484170-1-yangchen.openbmc@gmail.com>
References: <20240924140215.2484170-1-yangchen.openbmc@gmail.com>
Message-ID: <20240924140215.2484170-3-yangchen.openbmc@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Change the i2c mux channel to match the correct fan board location.

Signed-off-by: Yang Chen <yangchen.openbmc@gmail.com>
---
 .../aspeed/aspeed-bmc-facebook-minerva.dts    | 31 ++++++++++---------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index 38eb42aaa98b..c915db28a806 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -213,10 +213,11 @@ i2c-mux at 77 {
 		#size-cells = <0>;
 		i2c-mux-idle-disconnect;
 
-		imux16: i2c at 0 {
+		// FCB 1
+		imux16: i2c at 1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			reg = <0>;
+			reg = <1>;
 
 			eeprom at 50 {
 				compatible = "atmel,24c128";
@@ -259,11 +260,11 @@ temperature-sensor at 4b {
 				reg = <0x4b>;
 			};
 		};
-
-		imux17: i2c at 1 {
+		// FCB 2
+		imux17: i2c at 0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			reg = <1>;
+			reg = <0>;
 
 			eeprom at 50 {
 				compatible = "atmel,24c128";
@@ -306,11 +307,11 @@ temperature-sensor at 4b {
 				reg = <0x4b>;
 			};
 		};
-
-		imux18: i2c at 2 {
+		// FCB 3
+		imux18: i2c at 3 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			reg = <2>;
+			reg = <3>;
 
 			eeprom at 50 {
 				compatible = "atmel,24c128";
@@ -353,11 +354,11 @@ temperature-sensor at 4b {
 				reg = <0x4b>;
 			};
 		};
-
-		imux19: i2c at 3 {
+		// FCB 4
+		imux19: i2c at 2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			reg = <3>;
+			reg = <2>;
 
 			eeprom at 50 {
 				compatible = "atmel,24c128";
@@ -400,8 +401,8 @@ temperature-sensor at 4b {
 				reg = <0x4b>;
 			};
 		};
-
-		imux20: i2c at 5 {
+		// FCB 5
+		imux20: i2c at 4 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <4>;
@@ -446,8 +447,8 @@ temperature-sensor at 4b {
 				reg = <0x4b>;
 			};
 		};
-
-		imux21: i2c at 4 {
+		// FCB 6
+		imux21: i2c at 5 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <5>;
-- 
2.34.1

