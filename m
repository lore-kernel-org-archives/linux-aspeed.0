From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Date: Thu, 21 Mar 2024 10:12:29 +0800
Subject: [PATCH v7 17/22] ARM: dts: aspeed: yosemite4: Revise mx31790 fan tach config
In-Reply-To: <20240321021236.1823693-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240321021236.1823693-1-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <20240321021236.1823693-18-Delphine_CC_Chiu@wiwynn.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Revise fan tach config for max31790 driver change

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 48 +++++++++++++++++--
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index d59542a9ef75..e0ca0f7b65ea 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1095,8 +1095,18 @@ adc at 1f {
 
 			pwm at 20{
 				compatible = "maxim,max31790";
-				pwm-as-tach = <4 5>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <0x20>;
+				channel at 4 {
+					reg = <4>;
+					sensor-type = "TACH";
+				};
+
+				channel at 5 {
+					reg = <5>;
+					sensor-type = "TACH";
+				};
 			};
 
 			gpio at 22{
@@ -1108,8 +1118,18 @@ gpio at 22{
 
 			pwm at 2f{
 				compatible = "maxim,max31790";
-				pwm-as-tach = <4 5>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <0x2f>;
+				channel at 4 {
+					reg = <4>;
+					sensor-type = "TACH";
+				};
+
+				channel at 5 {
+					reg = <5>;
+					sensor-type = "TACH";
+				};
 			};
 
 			adc at 33 {
@@ -1145,8 +1165,18 @@ adc at 1f {
 
 			pwm at 20{
 				compatible = "maxim,max31790";
-				pwm-as-tach = <4 5>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <0x20>;
+				channel at 4 {
+					reg = <4>;
+					sensor-type = "TACH";
+				};
+
+				channel at 5 {
+					reg = <5>;
+					sensor-type = "TACH";
+				};
 			};
 
 			gpio at 22{
@@ -1158,8 +1188,18 @@ gpio at 22{
 
 			pwm at 2f{
 				compatible = "maxim,max31790";
-				pwm-as-tach = <4 5>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <0x2f>;
+				channel at 4 {
+					reg = <4>;
+					sensor-type = "TACH";
+				};
+
+				channel at 5 {
+					reg = <5>;
+					sensor-type = "TACH";
+				};
 			};
 
 			adc at 33 {
-- 
2.25.1

