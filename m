From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Date: Mon, 26 Aug 2024 14:24:04 +0800
Subject: [PATCH v14 30/31] ARM: dts: aspeed: yosemite4: add SQ52205 support
In-Reply-To: <20240826062408.2885174-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240826062408.2885174-1-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <20240826062408.2885174-31-Delphine_CC_Chiu@wiwynn.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add SQ52205 in yosemite4 DTS.

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts  | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index d056f6d5ff6e..04aa428f94b7 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1245,35 +1245,35 @@ adc at 37 {
 	};
 
 	power-sensor at 40 {
-		compatible = "ti,ina233", "richtek,rtq6056";
+		compatible = "ti,ina233", "richtek,rtq6056", "silergy,sq52205";
 		reg = <0x40>;
 		resistor-calibration = /bits/ 16 <0x0400>;
 		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor at 41 {
-		compatible = "ti,ina233", "richtek,rtq6056";
+		compatible = "ti,ina233", "richtek,rtq6056", "silergy,sq52205";
 		reg = <0x41>;
 		resistor-calibration = /bits/ 16 <0x0400>;
 		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor at 42 {
-		compatible = "ti,ina233", "richtek,rtq6056";
+		compatible = "ti,ina233", "richtek,rtq6056", "silergy,sq52205";
 		reg = <0x42>;
 		resistor-calibration = /bits/ 16 <0x0400>;
 		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor at 43 {
-		compatible = "ti,ina233", "richtek,rtq6056";
+		compatible = "ti,ina233", "richtek,rtq6056", "silergy,sq52205";
 		reg = <0x43>;
 		resistor-calibration = /bits/ 16 <0x0400>;
 		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor at 44 {
-		compatible = "ti,ina233", "richtek,rtq6056";
+		compatible = "ti,ina233", "richtek,rtq6056", "silergy,sq52205";
 		reg = <0x44>;
 		resistor-calibration = /bits/ 16 <0x0400>;
 		current-lsb= /bits/ 16 <0x0001>;
-- 
2.25.1

