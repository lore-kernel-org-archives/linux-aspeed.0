From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Date: Thu, 23 May 2024 17:17:59 +0800
Subject: [PATCH v8 12/23] ARM: dts: aspeed: yosemite4: Remove temperature sensor for yosemite4 schematic change
In-Reply-To: <20240523091812.2032933-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240523091812.2032933-1-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <20240523091812.2032933-13-Delphine_CC_Chiu@wiwynn.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Remove temperature sensor for yosemite4 schematic change

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts  | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 9a14f0220cf6..8f3bbdd1bbc5 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -921,16 +921,6 @@ temperature-sensor at 49 {
 		reg = <0x49>;
 	};
 
-	temperature-sensor at 4a {
-		compatible = "ti,tmp75";
-		reg = <0x4a>;
-	};
-
-	temperature-sensor at 4b {
-		compatible = "ti,tmp75";
-		reg = <0x4b>;
-	};
-
 	eeprom at 54 {
 		compatible = "atmel,24c128";
 		reg = <0x54>;
-- 
2.25.1

