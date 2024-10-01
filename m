From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Date: Tue,  1 Oct 2024 16:20:50 +0800
Subject: [PATCH v2 08/10] ARM: dts: aspeed: yosemite4: Change the address of Fan IC on fan boards
In-Reply-To: <20241001082053.3455836-1-Delphine_CC_Chiu@wiwynn.com>
References: <20241001082053.3455836-1-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <20241001082053.3455836-9-Delphine_CC_Chiu@wiwynn.com>
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
 .../arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 01ee455c41b0..6a1dccd23225 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1188,9 +1188,9 @@ gpio at 22{
 				#gpio-cells = <2>;
 			};
 
-			pwm at 23{
+			pwm at 2f{
 				compatible = "maxim,max31790";
-				reg = <0x23>;
+				reg = <0x2f>;
 			};
 
 			adc at 33 {
@@ -1236,9 +1236,9 @@ gpio at 22{
 				#gpio-cells = <2>;
 			};
 
-			pwm at 23{
+			pwm at 2f{
 				compatible = "maxim,max31790";
-				reg = <0x23>;
+				reg = <0x2f>;
 			};
 
 			adc at 33 {
-- 
2.25.1

