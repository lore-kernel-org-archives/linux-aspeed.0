From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Date: Mon, 11 Dec 2023 13:47:26 +0800
Subject: [PATCH v3 11/14] ARM: dts: aspeed: yosemite4: Revise mx31790 fan tach config
In-Reply-To: <20231211054730.208588-1-Delphine_CC_Chiu@wiwynn.com>
References: <20231211054730.208588-1-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <20231211054730.208588-12-Delphine_CC_Chiu@wiwynn.com>
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
index eb3687bfd632..073f27f1e35f 100644
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

