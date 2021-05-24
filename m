From: Steven Lee <steven_lee@aspeedtech.com>
Date: Mon, 24 May 2021 15:32:53 +0800
Subject: [PATCH v5 1/4] ARM: dts: aspeed: ast2600evb: Add sdhci node and gpio
 regulator for A2 evb.
In-Reply-To: <20210524073308.9328-1-steven_lee@aspeedtech.com>
References: <20210524073308.9328-1-steven_lee@aspeedtech.com>
Message-ID: <20210524073308.9328-2-steven_lee@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

AST2600 A2(or newer) EVB has gpio regulators for toggling signal voltage
between 3.3v and 1.8v, the patch adds sdhci node and gpio regulator in the
dts file and adds comment for describing the reference design.

Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed-ast2600-evb.dts | 84 ++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-ast2600-evb.dts b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
index 2772796e215e..401034da6dcc 100644
--- a/arch/arm/boot/dts/aspeed-ast2600-evb.dts
+++ b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
@@ -4,6 +4,7 @@
 /dts-v1/;
 
 #include "aspeed-g6.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
 
 / {
 	model = "AST2600 EVB";
@@ -21,6 +22,46 @@
 		device_type = "memory";
 		reg = <0x80000000 0x80000000>;
 	};
+
+	vcc_sdhci0: regulator-vcc-sdhci0 {
+		compatible = "regulator-fixed";
+		regulator-name = "SDHCI0 Vcc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpios = <&gpio0 ASPEED_GPIO(V, 0) GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	vccq_sdhci0: regulator-vccq-sdhci0 {
+		compatible = "regulator-gpio";
+		regulator-name = "SDHCI0 VccQ";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		gpios = <&gpio0 ASPEED_GPIO(V, 1) GPIO_ACTIVE_HIGH>;
+		gpios-states = <1>;
+		states = <3300000 1>,
+			 <1800000 0>;
+	};
+
+	vcc_sdhci1: regulator-vcc-sdhci1 {
+		compatible = "regulator-fixed";
+		regulator-name = "SDHCI1 Vcc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpios = <&gpio0 ASPEED_GPIO(V, 2) GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	vccq_sdhci1: regulator-vccq-sdhci1 {
+		compatible = "regulator-gpio";
+		regulator-name = "SDHCI1 VccQ";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		gpios = <&gpio0 ASPEED_GPIO(V, 3) GPIO_ACTIVE_HIGH>;
+		gpios-states = <1>;
+		states = <3300000 1>,
+			 <1800000 0>;
+	};
 };
 
 &mdio0 {
@@ -245,3 +286,46 @@
 &uhci {
 	status = "okay";
 };
+
+&sdc {
+	status = "okay";
+};
+
+/*
+ * The signal voltage of sdhci0 and sdhci1 on AST2600-A2 EVB is able to be
+ * toggled by GPIO pins.
+ * In the reference design, GPIOV0 of AST2600-A2 EVB is connected to the
+ * power load switch that provides 3.3v to sdhci0 vdd, GPIOV1 is connected to
+ * a 1.8v and a 3.3v power load switch that provides signal voltage to
+ * sdhci0 bus.
+ * If GPIOV0 is active high, sdhci0 is enabled, otherwise, sdhci0 is disabled.
+ * If GPIOV1 is active high, 3.3v power load switch is enabled, sdhci0 signal
+ * voltage is 3.3v, otherwise, 1.8v power load switch will be enabled,
+ * sdhci0 signal voltage becomes 1.8v.
+ * AST2600-A2 EVB also supports toggling signal voltage for sdhci1.
+ * The design is the same as sdhci0, it uses GPIOV2 as power-gpio and GPIOV3
+ * as power-switch-gpio.
+ */
+&sdhci0 {
+	status = "okay";
+	bus-width = <4>;
+	max-frequency = <100000000>;
+	sdhci-drive-type = /bits/ 8 <3>;
+	sdhci-caps-mask = <0x7 0x0>;
+	sdhci,wp-inverted;
+	vmmc-supply = <&vcc_sdhci0>;
+	vqmmc-supply = <&vccq_sdhci0>;
+	clk-phase-sd-hs = <7>, <200>;
+};
+
+&sdhci1 {
+	status = "okay";
+	bus-width = <4>;
+	max-frequency = <100000000>;
+	sdhci-drive-type = /bits/ 8 <3>;
+	sdhci-caps-mask = <0x7 0x0>;
+	sdhci,wp-inverted;
+	vmmc-supply = <&vcc_sdhci1>;
+	vqmmc-supply = <&vccq_sdhci1>;
+	clk-phase-sd-hs = <7>, <200>;
+};
-- 
2.17.1

