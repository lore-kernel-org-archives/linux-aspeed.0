From: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Date: Thu, 19 Aug 2021 16:00:40 +0800
Subject: [PATCH v2 5/5] ARM: dts: aspeed: Add eSPI node
In-Reply-To: <20210819080040.31242-1-chiawei_wang@aspeedtech.com>
References: <20210819080040.31242-1-chiawei_wang@aspeedtech.com>
Message-ID: <20210819080040.31242-6-chiawei_wang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add eSPI to the device tree for Aspeed 5/6th generation SoCs.

Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed-g6.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index f96607b7b4e2..47dc0b3993d1 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -364,6 +364,23 @@
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
 			gpio0: gpio at 1e780000 {
 				#gpio-cells = <2>;
 				gpio-controller;
-- 
2.17.1

