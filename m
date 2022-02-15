From: Potin Lai <potin.lai@quantatw.com>
Date: Wed, 16 Feb 2022 00:31:46 +0800
Subject: [PATCH v3 05/10] ARM: dts: aspeed: bletchley: switch to spi-gpio for
 spi2
In-Reply-To: <20220215163151.32252-1-potin.lai@quantatw.com>
References: <20220215163151.32252-1-potin.lai@quantatw.com>
Message-ID: <20220215163151.32252-6-potin.lai@quantatw.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Switch spi2 to spi-gpio driver to avoid unstable signal issue with EVT HW
Remove spi2 node and create a new spi2_gpio node

Signed-off-by: Potin Lai <potin.lai@quantatw.com>
---
 .../dts/aspeed-bmc-facebook-bletchley.dts     | 35 +++++++++++--------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
index b01f1e7adb81..08fa4c7b5ed4 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
@@ -32,7 +32,7 @@
 			<&adc1 4>, <&adc1 5>, <&adc1 6>, <&adc1 7>;
 	};
 
-	spi_gpio: spi-gpio {
+	spi1_gpio: spi1-gpio {
 		compatible = "spi-gpio";
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -50,6 +50,26 @@
 		};
 	};
 
+	spi2_gpio: spi2-gpio {
+		compatible = "spi-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpio-sck = <&gpio0 ASPEED_GPIO(X, 3) GPIO_ACTIVE_HIGH>;
+		gpio-mosi = <&gpio0 ASPEED_GPIO(X, 4) GPIO_ACTIVE_HIGH>;
+		gpio-miso = <&gpio0 ASPEED_GPIO(X, 5) GPIO_ACTIVE_HIGH>;
+		num-chipselects = <1>;
+		cs-gpios = <&gpio0 ASPEED_GPIO(X, 0) GPIO_ACTIVE_LOW>;
+
+		flash at 0 {
+			reg = <0>;
+			compatible = "jedec,spi-nor";
+			m25p,fast-read;
+			label = "pnor";
+			spi-max-frequency = <100000000>;
+		};
+	};
+
 	switchphy: ethernet-phy at 0 {
 		// Fixed link
 	};
@@ -225,19 +245,6 @@
 	};
 };
 
-&spi2 {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_spi2_default>;
-
-	flash at 0 {
-		status = "okay";
-		m25p,fast-read;
-		label = "pnor";
-		spi-max-frequency = <100000000>;
-	};
-};
-
 &i2c0 {
 	status = "okay";
 	/* TODO: Add ADC INA230 */
-- 
2.17.1

