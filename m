From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 29 May 2022 13:14:42 +0200
Subject: [PATCH] ARM: dts: aspeed: vegman: drop unused fttmr010,pwm-outputs property
Message-ID: <20220529111442.182722-1-krzysztof.kozlowski@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The "fttmr010,pwm-outputs" property is neither documented, nor used in
Linux kernel driver, so remove it.  This also fixes warning like:

  aspeed-bmc-vegman-n110.dtb: timer at 1e782000: 'fttmr010,pwm-outputs' does not match any of the regexes:

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/aspeed-bmc-vegman.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-vegman.dtsi b/arch/arm/boot/dts/aspeed-bmc-vegman.dtsi
index 1a5b25b2ea29..43af63910571 100644
--- a/arch/arm/boot/dts/aspeed-bmc-vegman.dtsi
+++ b/arch/arm/boot/dts/aspeed-bmc-vegman.dtsi
@@ -166,7 +166,6 @@ &sdhci1 {
 };
 
 &timer {
-	fttmr010,pwm-outputs = <5>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_timer5_default>;
 	#pwm-cells = <3>;
-- 
2.34.1

