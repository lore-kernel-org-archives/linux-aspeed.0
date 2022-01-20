From: Joel Stanley <joel@jms.id.au>
Date: Thu, 20 Jan 2022 17:03:06 +1030
Subject: [PATCH] ARM: dts: aspeed: rainier: Remove SPI NOR controllers
Message-ID: <20220120063307.63898-1-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Early Rainier builds had SPI NOR as a fallback boot device when eMMC
was not programmed. Most systems don't have the NOR populated, so remove
it from the device tree as it is not used.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 24 --------------------
 1 file changed, 24 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
index 652c866c14dc..43bacb16d336 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
@@ -2360,30 +2360,6 @@ &mac3 {
 	use-ncsi;
 };
 
-&fmc {
-	status = "okay";
-	flash at 0 {
-		status = "okay";
-		m25p,fast-read;
-		label = "bmc";
-		spi-max-frequency = <50000000>;
-#include "openbmc-flash-layout-128.dtsi"
-	};
-};
-
-&spi1 {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_spi1_default>;
-
-	flash at 0 {
-		status = "okay";
-		m25p,fast-read;
-		label = "pnor";
-		spi-max-frequency = <100000000>;
-	};
-};
-
 &wdt1 {
 	aspeed,reset-type = "none";
 	aspeed,external-signal;
-- 
2.34.1

