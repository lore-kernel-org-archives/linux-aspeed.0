From: Howard Chiu <howard_chiu@aspeedtech.com>
Date: Thu, 24 Mar 2022 07:28:18 +0000
Subject: [PATCH v1 3/3] ARM: dts: aspeed: ast2600-evb: Support KVM
Message-ID: <SG2PR06MB23154FA2D344640D9BEE586DE6199@SG2PR06MB2315.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Enable video engine driver and reserve memory for it.
Enable USB driver for HID support

Signed-off-by: Howard Chiu <howard_chiu@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed-ast2600-evb.dts | 39 +++++++++++++++++++-----
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-ast2600-evb.dts b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
index b7eb552640cb..d535a711bf5a 100644
--- a/arch/arm/boot/dts/aspeed-ast2600-evb.dts
+++ b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
@@ -23,6 +23,19 @@ memory at 80000000 {
 		reg = <0x80000000 0x80000000>;
 	};
 
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		video_engine_memory: video {
+			size = <0x04000000>;
+			alignment = <0x01000000>;
+			compatible = "shared-dma-pool";
+			reusable;
+		};
+	};
+
 	vcc_sdhci0: regulator-vcc-sdhci0 {
 		compatible = "regulator-fixed";
 		regulator-name = "SDHCI0 Vcc";
@@ -250,14 +263,6 @@ &fsim0 {
 	status = "okay";
 };
 
-&ehci1 {
-	status = "okay";
-};
-
-&uhci {
-	status = "okay";
-};
-
 &sdc {
 	status = "okay";
 };
@@ -300,3 +305,21 @@ &sdhci1 {
 	vqmmc-supply = <&vccq_sdhci1>;
 	clk-phase-sd-hs = <7>, <200>;
 };
+
+&ehci1 {
+	status = "okay";
+};
+
+&uhci {
+	status = "okay";
+};
+
+&vhub {
+	status = "okay";
+	pinctrl-names = "default";
+};
+
+&video {
+	status = "okay";
+	memory-region = <&video_engine_memory>;
+};
-- 
2.25.1

