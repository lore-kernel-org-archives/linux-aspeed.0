From: Howard Chiu <howard_chiu@aspeedtech.com>
Date: Tue, 29 Mar 2022 03:24:03 +0000
Subject: [PATCH v4 2/3] ARM: dts: aspeed: ast2600-evb: Enable video engine
Message-ID: <SG2PR06MB23159B914BF7EF937FEDD2B5E61E9@SG2PR06MB2315.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Enable video engine and reserve memory for it.

Signed-off-by: Howard Chiu <howard_chiu@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed-ast2600-evb.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-ast2600-evb.dts b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
index b7eb552640cb..158b88f38d2c 100644
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
@@ -300,3 +313,8 @@ &sdhci1 {
 	vqmmc-supply = <&vccq_sdhci1>;
 	clk-phase-sd-hs = <7>, <200>;
 };
+
+&video {
+	status = "okay";
+	memory-region = <&video_engine_memory>;
+};
-- 
2.25.1

