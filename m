From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 10 Aug 2022 14:11:26 +0300
Subject: [PATCH] ARM: dts: aspeed: align SPI node name with dtschema
Message-ID: <20220810111126.281214-1-krzysztof.kozlowski@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The node names should be generic and DT schema expects certain pattern.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-cloudripper.dts | 2 +-
 arch/arm/boot/dts/aspeed-bmc-facebook-elbert.dts      | 2 +-
 arch/arm/boot/dts/aspeed-bmc-facebook-fuji.dts        | 2 +-
 arch/arm/boot/dts/aspeed-bmc-facebook-wedge400.dts    | 2 +-
 arch/arm/boot/dts/ast2600-facebook-netbmc-common.dtsi | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-cloudripper.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-cloudripper.dts
index 9c6271a17ae8..5cd060029ea9 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-cloudripper.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-cloudripper.dts
@@ -77,7 +77,7 @@ aliases {
 		i2c55 = &imux55;
 	};
 
-	spi_gpio: spi-gpio {
+	spi_gpio: spi {
 		num-chipselects = <2>;
 		cs-gpios = <&gpio0 ASPEED_GPIO(X, 0) GPIO_ACTIVE_LOW>,
 			   <&gpio0 ASPEED_GPIO(X, 1) GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-elbert.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-elbert.dts
index 27b43fe099f1..4b520d7ce3e1 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-elbert.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-elbert.dts
@@ -44,7 +44,7 @@ chosen {
 		stdout-path = &uart5;
 	};
 
-	spi_gpio: spi-gpio {
+	spi_gpio: spi {
 		num-chipselects = <1>;
 		cs-gpios = <&gpio0 ASPEED_GPIO(X, 0) GPIO_ACTIVE_LOW>;
 	};
diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-fuji.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-fuji.dts
index af58a73bbc49..6b319f34a9b9 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-fuji.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-fuji.dts
@@ -207,7 +207,7 @@ aliases {
 		i2c143 = &imux143;
 	};
 
-	spi_gpio: spi-gpio {
+	spi_gpio: spi {
 		num-chipselects = <3>;
 		cs-gpios = <&gpio0 ASPEED_GPIO(X, 0) GPIO_ACTIVE_LOW>,
 			   <0>,	/* device reg=<1> does not exist */
diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-wedge400.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-wedge400.dts
index a901c8be49b9..ed305948386f 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-wedge400.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-wedge400.dts
@@ -67,7 +67,7 @@ ast-adc-hwmon {
 	 * full-duplex SPI transactions are not supported by ASPEED SPI
 	 * Controllers.
 	 */
-	spi_gpio: spi-gpio {
+	spi_gpio: spi {
 		status = "okay";
 		compatible = "spi-gpio";
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/ast2600-facebook-netbmc-common.dtsi b/arch/arm/boot/dts/ast2600-facebook-netbmc-common.dtsi
index 051de5bec345..31590d3186a2 100644
--- a/arch/arm/boot/dts/ast2600-facebook-netbmc-common.dtsi
+++ b/arch/arm/boot/dts/ast2600-facebook-netbmc-common.dtsi
@@ -25,7 +25,7 @@ memory at 80000000 {
 	 * full-duplex SPI transactions are not supported by ASPEED SPI
 	 * Controllers.
 	 */
-	spi_gpio: spi-gpio {
+	spi_gpio: spi {
 		status = "okay";
 		compatible = "spi-gpio";
 		#address-cells = <1>;
-- 
2.34.1

