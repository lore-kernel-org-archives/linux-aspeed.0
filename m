From: Tao Ren <taoren@fb.com>
Date: Mon, 21 Oct 2019 12:48:20 -0700
Subject: [PATCH 4/4] ARM: dts: aspeed: yamp: include dtsi for common network
 BMC devices
In-Reply-To: <20191021194820.293556-1-taoren@fb.com>
References: <20191021194820.293556-1-taoren@fb.com>
Message-ID: <20191021194820.293556-5-taoren@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The patch simplifies Yamp device tree by including dtsi to define
devices which are common to Facebook AST2500 Network BMC platforms.

Below is the summary of changes comparing with previous dts version:
  - enabling the second firmware flash.
  - enabling the emmc device in slot #1.

Signed-off-by: Tao Ren <taoren@fb.com>
---
 .../arm/boot/dts/aspeed-bmc-facebook-yamp.dts | 62 ++-----------------
 1 file changed, 5 insertions(+), 57 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-yamp.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-yamp.dts
index 4e09a9cf32b7..b184fa1abb60 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-yamp.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-yamp.dts
@@ -2,7 +2,7 @@
 // Copyright (c) 2018 Facebook Inc.
 /dts-v1/;
 
-#include "aspeed-g5.dtsi"
+#include "facebook-netbmc-ast2500-common.dtsi"
 
 / {
 	model = "Facebook YAMP 100 BMC";
@@ -23,47 +23,6 @@
 		stdout-path = &uart5;
 		bootargs = "console=ttyS0,9600n8 root=/dev/ram rw";
 	};
-
-	memory at 80000000 {
-		reg = <0x80000000 0x20000000>;
-	};
-};
-
-&pinctrl {
-	aspeed,external-nodes = <&gfx &lhc>;
-};
-
-/*
- * Update reset type to "system" (full chip) to fix warm reboot hang issue
- * when reset type is set to default ("soc", gated by reset mask registers).
- */
-&wdt1 {
-	status = "okay";
-	aspeed,reset-type = "system";
-};
-
-/*
- * wdt2 is not used by Yamp.
- */
-&wdt2 {
-	status = "disabled";
-};
-
-&fmc {
-	status = "okay";
-	flash at 0 {
-		status = "okay";
-		m25p,fast-read;
-		label = "bmc";
-#include "facebook-bmc-flash-layout.dtsi"
-	};
-};
-
-&uart1 {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_txd1_default
-		     &pinctrl_rxd1_default>;
 };
 
 &uart2 {
@@ -73,17 +32,6 @@
 		     &pinctrl_rxd2_default>;
 };
 
-&uart3 {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_txd3_default
-		     &pinctrl_rxd3_default>;
-};
-
-&uart5 {
-	status = "okay";
-};
-
 &mac0 {
 	status = "okay";
 	use-ncsi;
@@ -92,6 +40,10 @@
 	pinctrl-0 = <&pinctrl_rmii1_default>;
 };
 
+&mac1 {
+	status = "disabled";
+};
+
 &i2c0 {
 	status = "okay";
 };
@@ -154,7 +106,3 @@
 &i2c13 {
 	status = "okay";
 };
-
-&vhub {
-	status = "okay";
-};
-- 
2.17.1

