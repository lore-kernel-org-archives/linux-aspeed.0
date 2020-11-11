From: rentao.bupt@gmail.com <rentao.bupt@gmail.com>
Date: Wed, 11 Nov 2020 15:23:29 -0800
Subject: [PATCH 3/4] ARM: dts: aspeed: wedge100: Use common dtsi
In-Reply-To: <20201111232330.30843-1-rentao.bupt@gmail.com>
References: <20201111232330.30843-1-rentao.bupt@gmail.com>
Message-ID: <20201111232330.30843-4-rentao.bupt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Tao Ren <rentao.bupt@gmail.com>

Simplify the Wedge100 device tree by using the common dtsi.

In addition this enables the second firmware flash, and turns on the
"i2c-mux-idle-disconnect" flag for I2C switch 7-0070.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 .../boot/dts/aspeed-bmc-facebook-wedge100.dts | 120 +++---------------
 1 file changed, 15 insertions(+), 105 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-wedge100.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-wedge100.dts
index 322587b7b67d..39c6be91d53f 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-wedge100.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-wedge100.dts
@@ -2,36 +2,16 @@
 // Copyright (c) 2018 Facebook Inc.
 /dts-v1/;
 
-#include "aspeed-g4.dtsi"
+#include "ast2400-facebook-netbmc-common.dtsi"
 
 / {
 	model = "Facebook Wedge 100 BMC";
 	compatible = "facebook,wedge100-bmc", "aspeed,ast2400";
 
-	aliases {
-		/*
-		 * Override the default uart aliases to avoid breaking
-		 * the legacy applications.
-		 */
-		serial0 = &uart5;
-		serial1 = &uart1;
-		serial2 = &uart3;
-		serial3 = &uart4;
-	};
-
 	chosen {
 		stdout-path = &uart3;
 		bootargs = "console=ttyS2,9600n8 root=/dev/ram rw";
 	};
-
-	memory at 40000000 {
-		reg = <0x40000000 0x20000000>;
-	};
-};
-
-&wdt1 {
-	status = "okay";
-	aspeed,reset-type = "system";
 };
 
 &wdt2 {
@@ -40,108 +20,38 @@
 };
 
 &fmc {
-	status = "okay";
-	flash at 0 {
+	flash at 1 {
 		status = "okay";
 		m25p,fast-read;
-		label = "fmc0";
-#include "facebook-bmc-flash-layout.dtsi"
+		label = "spi0.1";
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			flash1 at 0 {
+				reg = <0x0 0x2000000>;
+				label = "flash1";
+			};
+		};
 	};
 };
 
-&uart1 {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_txd1_default
-		     &pinctrl_rxd1_default>;
-};
-
-&uart3 {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_txd3_default
-		     &pinctrl_rxd3_default>;
-};
-
-&uart4 {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_txd4_default
-		     &pinctrl_rxd4_default>;
-};
-
-&uart5 {
-	status = "okay";
-};
-
-&mac1 {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_rgmii2_default &pinctrl_mdio2_default>;
-};
-
-&i2c0 {
-	status = "okay";
-};
-
-&i2c1 {
-	status = "okay";
-};
-
-&i2c2 {
-	status = "okay";
-};
-
-&i2c3 {
-	status = "okay";
-};
-
-&i2c4 {
-	status = "okay";
-};
-
-&i2c5 {
-	status = "okay";
-};
-
-&i2c6 {
-	status = "okay";
-};
-
 &i2c7 {
-	status = "okay";
-
 	i2c-switch at 70 {
 		compatible = "nxp,pca9548";
 		#address-cells = <1>;
 		#size-cells = <0>;
 		reg = <0x70>;
+		i2c-mux-idle-disconnect;
 	};
 };
 
-&i2c8 {
-	status = "okay";
-};
-
 &i2c9 {
 	status = "okay";
 };
 
-&i2c10 {
-	status = "okay";
-};
-
-&i2c11 {
-	status = "okay";
-};
-
-&i2c12 {
-	status = "okay";
-};
-
-&i2c13 {
-	status = "okay";
-};
 
 &vhub {
 	status = "okay";
-- 
2.17.1

