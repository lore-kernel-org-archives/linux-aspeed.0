From: Yang Chen <yangchen.openbmc@gmail.com>
Date: Tue, 12 Dec 2023 15:51:57 +0800
Subject: [PATCH 08/11] ARM: dts: aspeed: minerva: add fan rpm controller
In-Reply-To: <20231212075200.983536-1-yangchen.openbmc@gmail.com>
References: <20231212075200.983536-1-yangchen.openbmc@gmail.com>
Message-ID: <20231212075200.983536-9-yangchen.openbmc@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add fan rpm controller max31790 on all bus of FCB.

Signed-off-by: Yang Chen <yangchen.openbmc@gmail.com>
---
 .../aspeed/aspeed-bmc-facebook-minerva.dts    | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index f4cb5ef72310..c7445c819baf 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -158,6 +158,13 @@ eeprom at 50 {
 				compatible = "atmel,24c128";
 				reg = <0x50>;
 			};
+
+			pwm at 5e{
+				compatible = "max31790";
+				reg = <0x5e>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
 		};
 
 		imux17: i2c at 1 {
@@ -169,6 +176,13 @@ eeprom at 50 {
 				compatible = "atmel,24c128";
 				reg = <0x50>;
 			};
+
+			pwm at 5e{
+				compatible = "max31790";
+				reg = <0x5e>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
 		};
 
 		imux18: i2c at 2 {
@@ -180,6 +194,13 @@ eeprom at 50 {
 				compatible = "atmel,24c128";
 				reg = <0x50>;
 			};
+
+			pwm at 5e{
+				compatible = "max31790";
+				reg = <0x5e>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
 		};
 
 		imux19: i2c at 3 {
@@ -191,6 +212,13 @@ eeprom at 50 {
 				compatible = "atmel,24c128";
 				reg = <0x50>;
 			};
+
+			pwm at 5e{
+				compatible = "max31790";
+				reg = <0x5e>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
 		};
 
 		imux20: i2c at 4 {
@@ -202,6 +230,13 @@ eeprom at 50 {
 				compatible = "atmel,24c128";
 				reg = <0x50>;
 			};
+
+			pwm at 5e{
+				compatible = "max31790";
+				reg = <0x5e>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
 		};
 
 		imux21: i2c at 5 {
@@ -213,6 +248,13 @@ eeprom at 50 {
 				compatible = "atmel,24c128";
 				reg = <0x50>;
 			};
+
+			pwm at 5e{
+				compatible = "max31790";
+				reg = <0x5e>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
 		};
 	};
 };
-- 
2.34.1

