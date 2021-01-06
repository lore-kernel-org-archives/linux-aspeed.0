From: Chia-Wei, Wang <chiawei_wang@aspeedtech.com>
Date: Wed, 6 Jan 2021 13:59:39 +0800
Subject: [PATCH 6/6] ARM: dts: aspeed: Add AST2600 eSPI nodes
In-Reply-To: <20210106055939.19386-1-chiawei_wang@aspeedtech.com>
References: <20210106055939.19386-1-chiawei_wang@aspeedtech.com>
Message-ID: <20210106055939.19386-7-chiawei_wang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add eSPI nodes for the device tree of Aspeed 6th generation SoCs.

Signed-off-by: Chia-Wei, Wang <chiawei_wang@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed-g6.dtsi | 57 ++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index 810b0676ab03..d457baf11e37 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -3,7 +3,9 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/aspeed-scu-ic.h>
+#include <dt-bindings/interrupt-controller/aspeed-espi-ic.h>
 #include <dt-bindings/clock/ast2600-clock.h>
+#include <dt-bindings/gpio/aspeed-gpio.h>
 
 / {
 	model = "Aspeed BMC";
@@ -75,6 +77,61 @@
 		interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	espi: espi at 1e6ee000 {
+		compatible = "aspeed,ast2600-espi", "simple-mfd", "syscon";
+		reg = <0x1e6ee000 0x1000>;
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x1e6ee000 0x1000>;
+
+		espi_ic: espi-ic {
+			#interrupt-cells = <1>;
+			compatible = "aspeed,ast2600-espi-ic";
+			interrupts-extended = <&gic GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
+					      <&gpio0 ASPEED_GPIO(W, 7) IRQ_TYPE_EDGE_FALLING>;
+			interrupt-controller;
+			status = "disabled";
+		};
+
+		espi_ctrl: espi-ctrl {
+			compatible = "aspeed,ast2600-espi-ctrl";
+			interrupts-extended = <&espi_ic ASPEED_ESPI_IC_CTRL_EVENT>,
+					      <&espi_ic ASPEED_ESPI_IC_CTRL_RESET>;
+			clocks = <&syscon ASPEED_CLK_GATE_ESPICLK>;
+			resets = <&syscon ASPEED_RESET_ESPI>;
+			status = "disabled";
+		};
+
+		espi_peripheral: espi-peripheral-channel {
+			compatible = "aspeed,ast2600-espi-peripheral";
+			interrupts-extended = <&espi_ic ASPEED_ESPI_IC_PERIF_EVENT>,
+					      <&espi_ic ASPEED_ESPI_IC_CHAN_RESET>;
+			status = "disabled";
+		};
+
+		espi_vw: espi-vw-channel {
+			compatible = "aspeed,ast2600-espi-vw";
+			interrupts-extended = <&espi_ic ASPEED_ESPI_IC_VW_EVENT>,
+					      <&espi_ic ASPEED_ESPI_IC_CHAN_RESET>;
+			status = "disabled";
+		};
+
+		espi_oob: espi-oob-channel {
+			compatible = "aspeed,ast2600-espi-oob";
+			interrupts-extended = <&espi_ic ASPEED_ESPI_IC_OOB_EVENT>,
+					      <&espi_ic ASPEED_ESPI_IC_CHAN_RESET>;
+			status = "disabled";
+		};
+
+		espi_flash: espi-flash-channel {
+			compatible = "aspeed,ast2600-espi-flash";
+			interrupts-extended = <&espi_ic ASPEED_ESPI_IC_FLASH_EVENT>,
+					      <&espi_ic ASPEED_ESPI_IC_CHAN_RESET>;
+			status = "disabled";
+		};
+	};
+
 	ahb {
 		compatible = "simple-bus";
 		#address-cells = <1>;
-- 
2.17.1

