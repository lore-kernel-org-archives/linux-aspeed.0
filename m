From: Howard Chiu <howard_chiu@aspeedtech.com>
Date: Tue, 29 Mar 2022 01:38:43 +0000
Subject: [PATCH v3 1/2] ARM: dts: aspeed: Add video engine
Message-ID: <SG2PR06MB2315BF301B03A52EE0D8BB56E61E9@SG2PR06MB2315.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The ast2600 SoC has an embedded video engine
This node was removed by commit 645afe7

Signed-off-by: Howard Chiu <howard_chiu@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed-g6.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index c32e87fad4dc..aac55b3aeded 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -389,6 +389,16 @@ sbc: secure-boot-controller at 1e6f2000 {
 				reg = <0x1e6f2000 0x1000>;
 			};
 
+			video: video at 1e700000 {
+				compatible = "aspeed,ast2600-video-engine";
+				reg = <0x1e700000 0x1000>;
+				clocks = <&syscon ASPEED_CLK_GATE_VCLK>,
+					 <&syscon ASPEED_CLK_GATE_ECLK>;
+				clock-names = "vclk", "eclk";
+				interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
+
 			gpio0: gpio at 1e780000 {
 				#gpio-cells = <2>;
 				gpio-controller;
-- 
2.25.1

