From: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Date: Mon, 16 May 2022 08:54:12 +0800
Subject: [PATCH v5 4/4] ARM: dts: aspeed: Add eSPI node
In-Reply-To: <20220516005412.4844-1-chiawei_wang@aspeedtech.com>
References: <20220516005412.4844-1-chiawei_wang@aspeedtech.com>
Message-ID: <20220516005412.4844-5-chiawei_wang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add eSPI to the device tree for Aspeed 5/6th generation SoCs.

Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed-g5.dtsi | 17 +++++++++++++++++
 arch/arm/boot/dts/aspeed-g6.dtsi | 17 +++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 4147b397c883..4b5bb91a0219 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -289,6 +289,23 @@ adc: adc at 1e6e9000 {
 				status = "disabled";
 			};
 
+			espi: espi at 1e6ee000 {
+				compatible = "aspeed,ast2500-espi", "simple-mfd", "syscon";
+				reg = <0x1e6ee000 0x1000>;
+
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0x0 0x1e6ee000 0x1000>;
+
+				espi_ctrl: espi-ctrl at 0 {
+					compatible = "aspeed,ast2500-espi-ctrl";
+					reg = <0x0 0x800>;
+					interrupts = <23>;
+					clocks = <&syscon ASPEED_CLK_GATE_ESPICLK>;
+					status = "disabled";
+				};
+			};
+
 			video: video at 1e700000 {
 				compatible = "aspeed,ast2500-video-engine";
 				reg = <0x1e700000 0x1000>;
diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index 3d5ce9da42c3..1f14ecad51af 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -384,6 +384,23 @@ adc1: adc at 1e6e9100 {
 				status = "disabled";
 			};
 
+			espi: espi at 1e6ee000 {
+				compatible = "aspeed,ast2600-espi", "simple-mfd", "syscon";
+				reg = <0x1e6ee000 0x1000>;
+
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0x0 0x1e6ee000 0x1000>;
+
+				espi_ctrl: espi-ctrl at 0 {
+					compatible = "aspeed,ast2600-espi-ctrl";
+					reg = <0x0 0x800>;
+					interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&syscon ASPEED_CLK_GATE_ESPICLK>;
+					status = "disabled";
+				};
+			};
+
 			sbc: secure-boot-controller at 1e6f2000 {
 				compatible = "aspeed,ast2600-sbc";
 				reg = <0x1e6f2000 0x1000>;
-- 
2.25.1

