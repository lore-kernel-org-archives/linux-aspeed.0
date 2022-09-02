From: Neal Liu <neal_liu@aspeedtech.com>
Date: Fri, 2 Sep 2022 14:00:10 +0800
Subject: [PATCH v1 2/4] ARM: dts: aspeed: Add ACRY/AHBC device controller node
In-Reply-To: <20220902060012.3758637-1-neal_liu@aspeedtech.com>
References: <20220902060012.3758637-1-neal_liu@aspeedtech.com>
Message-ID: <20220902060012.3758637-3-neal_liu@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add acry & ahbc node to device tree for AST2600.

Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed-g6.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index 095cf8d03616..ad177799db0b 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -94,6 +94,11 @@ gic: interrupt-controller at 40461000 {
 			    <0x40466000 0x2000>;
 			};
 
+		ahbc: bus at 1e600000 {
+			compatible = "aspeed,ast2600-ahbc", "syscon";
+			reg = <0x1e600000 0x100>;
+		};
+
 		fmc: spi at 1e620000 {
 			reg = <0x1e620000 0xc4>, <0x20000000 0x10000000>;
 			#address-cells = <1>;
@@ -427,6 +432,14 @@ sbc: secure-boot-controller at 1e6f2000 {
 				reg = <0x1e6f2000 0x1000>;
 			};
 
+			acry: crypto at 1e6fa000 {
+				compatible = "aspeed,ast2600-acry";
+				reg = <0x1e6fa000 0x400>, <0x1e710000 0x1800>;
+				interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&syscon ASPEED_CLK_GATE_RSACLK>;
+				aspeed,ahbc = <&ahbc>;
+			};
+
 			video: video at 1e700000 {
 				compatible = "aspeed,ast2600-video-engine";
 				reg = <0x1e700000 0x1000>;
-- 
2.25.1

