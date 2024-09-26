From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Date: Thu, 26 Sep 2024 11:28:21 +0800
Subject: [PATCH v1 5/5] ARM: dts: aspeed: yosemite4: Add i2c-mux for ADC monitor on Spider Board
In-Reply-To: <20240926032821.4171466-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240926032821.4171466-1-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <20240926032821.4171466-6-Delphine_CC_Chiu@wiwynn.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

Add I2C mux for ADC monitor on Spider Board.

Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 29dd109ebd08..40f6090fcb36 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -20,6 +20,8 @@ aliases {
 
 		i2c30 = &imux30;
 		i2c31 = &imux31;
+		i2c32 = &imux32;
+		i2c33 = &imux33;
 	};
 
 	chosen {
@@ -447,29 +449,25 @@ eeprom at 51 {
 
 	i2c-mux at 73 {
 		compatible = "nxp,pca9544";
+		reg = <0x73>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-
-		idle-state = <0>;
 		i2c-mux-idle-disconnect;
-		reg = <0x73>;
 
-		i2c at 0 {
+		imux32: i2c at 0 {
+			reg = <0>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			reg = <0>;
-
 			adc at 35 {
 				compatible = "maxim,max11617";
 				reg = <0x35>;
 			};
 		};
 
-		i2c at 1 {
+		imux33: i2c at 1 {
+			reg = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			reg = <0>;
-
 			adc at 35 {
 				compatible = "maxim,max11617";
 				reg = <0x35>;
-- 
2.25.1

