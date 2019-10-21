From: Tao Ren <taoren@fb.com>
Date: Mon, 21 Oct 2019 12:48:19 -0700
Subject: [PATCH 3/4] ARM: dts: aspeed: minipack: include dtsi for common
 network BMC devices
In-Reply-To: <20191021194820.293556-1-taoren@fb.com>
References: <20191021194820.293556-1-taoren@fb.com>
Message-ID: <20191021194820.293556-4-taoren@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The patch simplifies Minipack device tree by including dtsi to define
devices which are common to Facebook AST2500 Network BMC platforms.

Below is the summary of changes comparing with previous dts version:
  - enabling the second firmware flash.
  - updating firmware flashes' size from 32MB to 64MB.
  - enabling the emmc device in slot #1.

Signed-off-by: Tao Ren <taoren@fb.com>
---
 .../boot/dts/aspeed-bmc-facebook-minipack.dts | 59 ++++++-------------
 1 file changed, 19 insertions(+), 40 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-minipack.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-minipack.dts
index c05478296446..ed1a77c76ce9 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-minipack.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-minipack.dts
@@ -2,7 +2,7 @@
 // Copyright (c) 2018 Facebook Inc.
 /dts-v1/;
 
-#include "aspeed-g5.dtsi"
+#include "facebook-netbmc-ast2500-common.dtsi"
 
 / {
 	model = "Facebook Minipack 100 BMC";
@@ -76,35 +76,36 @@
 		stdout-path = &uart1;
 		bootargs = "debug console=ttyS1,9600n8 root=/dev/ram rw";
 	};
-
-	memory at 80000000 {
-		reg = <0x80000000 0x20000000>;
-	};
 };
 
-&wdt1 {
+&wdt2 {
 	status = "okay";
 	aspeed,reset-type = "system";
 };
 
-&wdt2 {
-	status = "okay";
-	aspeed,reset-type = "system";
+/*
+ * Both firmware flashes are 64MB on Minipack BMC.
+ */
+&fmc_flash0 {
+	partitions {
+		data0 at 1c00000 {
+			reg = <0x1c00000 0x2400000>;
+		};
+		flash0 at 0 {
+			reg = <0x0 0x4000000>;
+		};
+	};
 };
 
-&fmc {
-	status = "okay";
-	flash at 0 {
-		status = "okay";
-		m25p,fast-read;
-		label = "bmc";
-#include "facebook-bmc-flash-layout.dtsi"
+&fmc_flash1 {
+	partitions {
+		flash1 at 0 {
+			reg = <0x0 0x4000000>;
+		};
 	};
 };
 
 &uart1 {
-	status = "okay";
-	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_txd1_default
 		     &pinctrl_rxd1_default
 		     &pinctrl_ncts1_default
@@ -120,13 +121,6 @@
 		     &pinctrl_rxd2_default>;
 };
 
-&uart3 {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_txd3_default
-		     &pinctrl_rxd3_default>;
-};
-
 &uart4 {
 	status = "okay";
 	pinctrl-names = "default";
@@ -134,17 +128,6 @@
 		     &pinctrl_rxd4_default>;
 };
 
-&uart5 {
-	status = "okay";
-};
-
-&mac1 {
-	status = "okay";
-	no-hw-checksum;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_rgmii2_default &pinctrl_mdio2_default>;
-};
-
 &i2c0 {
 	status = "okay";
 	bus-frequency = <400000>;
@@ -423,7 +406,3 @@
 &i2c13 {
 	status = "okay";
 };
-
-&vhub {
-	status = "okay";
-};
-- 
2.17.1

