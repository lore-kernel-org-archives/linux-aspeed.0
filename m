From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Date: Thu, 23 May 2024 16:03:18 +0800
Subject: [PATCH v8 13/23] ARM: dts: aspeed: yosemite4: Revise adc128d818 adc mode for yosemite4 schematic change
In-Reply-To: <20240523080330.1860074-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240523080330.1860074-1-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <20240523080330.1860074-14-Delphine_CC_Chiu@wiwynn.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Revise adc128d818 adc mode for yosemite4 schematic change

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts  | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 8f3bbdd1bbc5..0c7d85ff4360 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1018,19 +1018,19 @@ &i2c14 {
 	adc at 1d {
 		compatible = "ti,adc128d818";
 		reg = <0x1d>;
-		ti,mode = /bits/ 8 <2>;
+		ti,mode = /bits/ 8 <1>;
 	};
 
-	adc at 35 {
+	adc at 36 {
 		compatible = "ti,adc128d818";
-		reg = <0x35>;
-		ti,mode = /bits/ 8 <2>;
+		reg = <0x36>;
+		ti,mode = /bits/ 8 <1>;
 	};
 
 	adc at 37 {
 		compatible = "ti,adc128d818";
 		reg = <0x37>;
-		ti,mode = /bits/ 8 <2>;
+		ti,mode = /bits/ 8 <1>;
 	};
 
 	power-sensor at 40 {
-- 
2.25.1

