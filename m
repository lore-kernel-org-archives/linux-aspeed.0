From: Kevin Chen <kevin_chen@aspeedtech.com>
Date: Fri, 02 Aug 2024 09:06:30 -0000
Subject: [PATCH v2 8/9] arm64: dts: aspeed: Add initial AST27XX device tree
In-Reply-To: <20240802090544.2741206-1-kevin_chen@aspeedtech.com>
References: <20240802090544.2741206-1-kevin_chen@aspeedtech.com>
Message-ID: <20240802090544.2741206-10-kevin_chen@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add aspeed-g7.dtsi to be AST27XX device tree.

Signed-off-by: Kevin Chen <kevin_chen@aspeedtech.com>
---
 arch/arm64/boot/dts/Makefile              |   1 +
 arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi | 185 ++++++++++++++++++++++
 2 files changed, 186 insertions(+)
 create mode 100644 arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi

diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index 21cd3a87f385..c909c19dc5dd 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -34,3 +34,4 @@ subdir-y += tesla
 subdir-y += ti
 subdir-y += toshiba
 subdir-y += xilinx
+subdir-y += aspeed
diff --git a/arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi b/arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi
new file mode 100644
index 000000000000..85f7977a753a
--- /dev/null
+++ b/arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <dt-bindings/clock/aspeed,ast2700-clk.h>
+#include <dt-bindings/reset/aspeed,ast2700-reset.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/interrupt-controller/aspeed-scu-ic.h>
+
+/ {
+	compatible = "aspeed,ast2700";
+	#address-cells = <2>;
+	#size-cells = <2>;
+	interrupt-parent = <&gic>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			compatible = "arm,cortex-a35";
+			device_type = "cpu";
+			enable-method = "psci";
+			reg = <0>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			next-level-cache = <&l2>;
+		};
+
+		cpu at 1 {
+			compatible = "arm,cortex-a35";
+			device_type = "cpu";
+			enable-method = "psci";
+			reg = <1>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			next-level-cache = <&l2>;
+		};
+
+		cpu at 2 {
+			compatible = "arm,cortex-a35";
+			device_type = "cpu";
+			enable-method = "psci";
+			reg = <2>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			next-level-cache = <&l2>;
+		};
+
+		cpu at 3 {
+			compatible = "arm,cortex-a35";
+			device_type = "cpu";
+			enable-method = "psci";
+			reg = <3>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			next-level-cache = <&l2>;
+		};
+
+		l2: l2-cache0 {
+			compatible = "cache";
+			cache-size = <0x80000>;
+			cache-unified;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
+			cache-level = <2>;
+		};
+	};
+
+	pmu {
+		compatible = "arm,cortex-a35-pmu";
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+		arm,cpu-registers-not-fw-configured;
+		always-on;
+	};
+
+	soc0: soc at 10000000 {
+		compatible = "simple-bus";
+		reg = <0x0 0x10000000 0x0 0x10000000>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		gic: interrupt-controller at 12200000 {
+			compatible = "arm,gic-v3";
+			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			interrupt-parent = <&gic>;
+			reg = <0 0x12200000 0 0x10000>, /* GICD */
+				  <0 0x12280000 0 0x80000>, /* GICR */
+				  <0 0x40440000 0 0x1000>;  /* GICC */
+			#address-cells = <2>;
+			#size-cells = <2>;
+		};
+
+		syscon0: syscon at 12c02000 {
+			compatible = "aspeed,ast2700-scu0", "syscon", "simple-mfd";
+			reg = <0x0 0x12c02000 0x0 0x1000>;
+			ranges = <0x0 0x0 0 0x12c02000 0 0x1000>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+
+			silicon-id at 0 {
+				compatible = "aspeed,ast2700-silicon-id", "aspeed,silicon-id";
+				reg = <0 0x0 0 0x4>;
+			};
+
+			soc0_rst: reset-controller at 200 {
+				reg = <0 0x200 0 0x40>;
+			};
+
+			soc0_clk: clock-controller at 240 {
+				reg = <0 0x240 0 0x1c0>;
+			};
+		};
+
+		uart4: serial at 12c1a000 {
+			compatible = "ns16550a";
+			reg = <0x0 0x12c1a000 0x0 0x1000>;
+			clocks = <&syscon0 SCU0_CLK_GATE_UART4CLK>;
+			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			no-loopback-test;
+		};
+	};
+
+	soc1: soc at 14000000 {
+		compatible = "simple-bus";
+		reg = <0x0 0x14000000 0x0 0x10000000>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		syscon1: syscon at 14c02000 {
+			compatible = "aspeed,ast2700-scu1", "syscon", "simple-mfd";
+			reg = <0x0 0x14c02000 0x0 0x1000>;
+			ranges = <0x0 0x0 0x0 0x14c02000 0x0 0x1000>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+
+			soc1_rst: reset-controller at 200 {
+				reg = <0 0x200 0 0x40>;
+				#reset-cells = <1>;
+			};
+
+			soc1_clk: clock-controller at 240 {
+				reg = <0 0x240 0 0x1c0>;
+			};
+		};
+	};
+};
-- 
2.34.1

