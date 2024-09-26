From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Date: Thu, 26 Sep 2024 11:28:19 +0800
Subject: [PATCH v1 3/5] ARM: dts: aspeed: yosemite4: Change the address of Fan IC on fan boards
In-Reply-To: <20240926032821.4171466-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240926032821.4171466-1-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <20240926032821.4171466-4-Delphine_CC_Chiu@wiwynn.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

Change the address of Fan IC: Max31790 on fan boards according to
schematic.

Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 24 +++++++------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 430c28bdd314..a7e51725c595 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -496,10 +496,8 @@ adc at 1f {
 			};
 
 			pwm at 20{
-				compatible = "max31790";
+				compatible = "maxim,max31790";
 				reg = <0x20>;
-				#address-cells = <1>;
-				#size-cells = <0>;
 			};
 
 			gpio at 22{
@@ -509,11 +507,9 @@ gpio at 22{
 				#gpio-cells = <2>;
 			};
 
-			pwm at 23{
-				compatible = "max31790";
-				reg = <0x23>;
-				#address-cells = <1>;
-				#size-cells = <0>;
+			pwm at 2f{
+				compatible = "maxim,max31790";
+				reg = <0x2f>;
 			};
 
 			adc at 33 {
@@ -539,10 +535,8 @@ adc at 1f {
 			};
 
 			pwm at 20{
-				compatible = "max31790";
+				compatible = "maxim,max31790";
 				reg = <0x20>;
-				#address-cells = <1>;
-				#size-cells = <0>;
 			};
 
 			gpio at 22{
@@ -552,11 +546,9 @@ gpio at 22{
 				#gpio-cells = <2>;
 			};
 
-			pwm at 23{
-				compatible = "max31790";
-				reg = <0x23>;
-				#address-cells = <1>;
-				#size-cells = <0>;
+			pwm at 2f{
+				compatible = "maxim,max31790";
+				reg = <0x2f>;
 			};
 
 			adc at 33 {
-- 
2.25.1

