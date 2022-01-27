From: Andrei Kartashev <a.kartashev@yadro.com>
Date: Thu, 27 Jan 2022 17:16:04 +0300
Subject: [PATCH v2] ARM: dts: aspeed: vegman: remove beeper
Message-ID: <20220127141604.1163-1-a.kartashev@yadro.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Beeper definition is a leftover from internal fork and not actual for
upstream kernel. It could be removed both beeper node and corresponded
timer node.
Fixes: 67ac01d03862 ("ARM: dts: aspeed: add device tree for YADRO VEGMAN BMC")

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
Signed-off-by: Andrei Kartashev <a.kartashev@yadro.com>
---
 arch/arm/boot/dts/aspeed-bmc-vegman.dtsi | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-vegman.dtsi b/arch/arm/boot/dts/aspeed-bmc-vegman.dtsi
index 1a5b25b2ea29..8ee4e6aab40e 100644
--- a/arch/arm/boot/dts/aspeed-bmc-vegman.dtsi
+++ b/arch/arm/boot/dts/aspeed-bmc-vegman.dtsi
@@ -79,11 +79,6 @@ power_ok {
 			gpios = <&gpio ASPEED_GPIO(AA, 5) GPIO_ACTIVE_LOW>;
 		};
 	};
-
-	beeper {
-		compatible = "pwm-beeper";
-		pwms = <&timer 5 1000000 0>;
-	};
 };
 
 &fmc {
@@ -165,14 +160,6 @@ &sdhci1 {
 	disable-wp;
 };
 
-&timer {
-	fttmr010,pwm-outputs = <5>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_timer5_default>;
-	#pwm-cells = <3>;
-	status = "okay";
-};
-
 &uart1 {
 	status = "okay";
 	pinctrl-names = "default";
-- 
2.34.1

