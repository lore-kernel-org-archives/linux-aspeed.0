From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Date: Tue, 26 Mar 2024 15:17:13 +0800
Subject: [PATCH v1] ARM: dts: aspeed: yosemite4: set bus13 frequency to 100k
Message-ID: <20240326071713.2786206-1-Delphine_CC_Chiu@wiwynn.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Since the ocp debug card only supports 100k, the bus is also set to 100k.

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 64075cc41d92..98e58e3fea77 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -369,7 +369,7 @@ rtc at 6f {
 
 &i2c13 {
 	status = "okay";
-	bus-frequency = <400000>;
+	bus-frequency = <100000>;
 };
 
 &i2c14 {
-- 
2.25.1

