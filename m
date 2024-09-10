From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Date: Tue, 10 Sep 2024 16:57:00 +0800
Subject: [PATCH v1] ARM: dts: aspeed: yosemite4: Remove temperature sensors on Medusa Board
Message-ID: <20240910085701.3595248-1-Delphine_CC_Chiu@wiwynn.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

Remove two temperature sensors on Medusa Board according to hardware
change.

Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts  | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 98477792aa00..986aa707de64 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -331,16 +331,6 @@ temperature-sensor at 49 {
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
 		compatible = "atmel,24c256";
 		reg = <0x54>;
-- 
2.25.1

