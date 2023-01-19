From: Jordan Chang <jordan.chang@ufispace.com>
Date: Thu, 19 Jan 2023 18:21:02 +0800
Subject: [PATCH 3/3] ARM: dts: aspeed: Add device tree for Ufispace NCPLite BMC
In-Reply-To: <20230119102102.73414-1-jordan.chang@ufispace.com>
References: <20230119102102.73414-1-jordan.chang@ufispace.com>
Message-ID: <20230119102102.73414-4-jordan.chang@ufispace.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add initial version of device tree for Ufispace NCPlite platform
which is equipped with AST2600-based BMC.

Signed-off-by: Jordan Chang <jordan.chang@ufispace.com>
---
 arch/arm/boot/dts/Makefile                    |   1 +
 .../boot/dts/aspeed-bmc-ufispace-ncplite.dts  | 360 ++++++++++++++++++
 2 files changed, 361 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-ufispace-ncplite.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 2ee9c043218b..d26e0651e805 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1626,6 +1626,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-inventec-transformers.dtb \
 	aspeed-bmc-tyan-s7106.dtb \
 	aspeed-bmc-tyan-s8036.dtb \
+	aspeed-bmc-ufispace-ncplite.dtb \
 	aspeed-bmc-vegman-n110.dtb \
 	aspeed-bmc-vegman-rx20.dtb \
 	aspeed-bmc-vegman-sx20.dtb
diff --git a/arch/arm/boot/dts/aspeed-bmc-ufispace-ncplite.dts b/arch/arm/boot/dts/aspeed-bmc-ufispace-ncplite.dts
new file mode 100644
index 000000000000..7ab29129d1e4
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed-bmc-ufispace-ncplite.dts
@@ -0,0 +1,360 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright (c) 2022 Ufispace Co., Ltd.
+/dts-v1/;
+
+#include "aspeed-g6.dtsi"
+#include <dt-bindings/i2c/i2c.h>
+#include <dt-bindings/gpio/aspeed-gpio.h>
+
+/ {
+	model = "Ufispace NCPLite BMC";
+	compatible = "ufispace,ncplite-bmc", "aspeed,ast2600";
+
+	aliases {
+		serial4 = &uart5;
+	};
+
+	chosen {
+		stdout-path = &uart5;
+		bootargs = "console=ttyS4,115200n8 earlycon";
+	};
+
+	memory at 80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x80000000>;
+	};
+
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
+			      <&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
+			      <&adc1 0>, <&adc1 1>, <&adc1 2>, <&adc1 3>,
+			      <&adc1 4>, <&adc1 5>, <&adc1 6>, <&adc1 7>;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		fan-status-int-l {
+			label = "fan-status-int-l";
+			gpios = <&gpio0 ASPEED_GPIO(M, 2) GPIO_ACTIVE_LOW>;
+			linux,code = <ASPEED_GPIO(M, 2)>;
+		};
+
+		allpwr-good {
+			label = "allpwr-good";
+			gpios = <&gpio0 ASPEED_GPIO(V, 4) GPIO_ACTIVE_HIGH>;
+			linux,code = <ASPEED_GPIO(V, 4)>;
+		};
+
+		psu0-alert-n {
+			label = "psu0-alert-n";
+			gpios = <&gpio0 ASPEED_GPIO(V, 1) GPIO_ACTIVE_LOW>;
+			linux,code = <ASPEED_GPIO(V, 1)>;
+		};
+
+		psu1-alert-n {
+			label = "psu1-alert-n";
+			gpios = <&gpio0 ASPEED_GPIO(V, 2) GPIO_ACTIVE_LOW>;
+			linux,code = <ASPEED_GPIO(V, 2)>;
+		};
+
+		int-thermal-alert {
+			label = "int-thermal-alert";
+			gpios = <&gpio0 ASPEED_GPIO(P, 2) GPIO_ACTIVE_LOW>;
+			linux,code = <ASPEED_GPIO(P, 2)>;
+		};
+
+		cpu-caterr-l {
+			label = "cpu-caterr-l";
+			gpios = <&gpio0 ASPEED_GPIO(N, 3) GPIO_ACTIVE_LOW>;
+			linux,code = <ASPEED_GPIO(N, 3)>;
+		};
+
+		cpu-thermtrip-l {
+			label = "cpu-thermtrip-l";
+			gpios = <&gpio0 ASPEED_GPIO(V, 5) GPIO_ACTIVE_LOW>;
+			linux,code = <ASPEED_GPIO(V, 5)>;
+		};
+
+		psu0-presence-l {
+			label = "psu0-presence-l";
+			gpios = <&gpio0 ASPEED_GPIO(F, 6) GPIO_ACTIVE_LOW>;
+			linux,code = <ASPEED_GPIO(F, 6)>;
+		};
+
+		psu1-presence-l {
+			label = "psu1-presence-l";
+			gpios = <&gpio0 ASPEED_GPIO(F, 7) GPIO_ACTIVE_LOW>;
+			linux,code = <ASPEED_GPIO(F, 7)>;
+		};
+
+		psu0-power-ok {
+			label = "psu0-power-ok";
+			gpios = <&gpio0 ASPEED_GPIO(M, 4) GPIO_ACTIVE_HIGH>;
+			linux,code = <ASPEED_GPIO(M, 4)>;
+		};
+
+		psu1-power-ok {
+			label = "psu1-power-ok";
+			gpios = <&gpio0 ASPEED_GPIO(M, 5) GPIO_ACTIVE_HIGH>;
+			linux,code = <ASPEED_GPIO(M, 5)>;
+		};
+	};
+
+	gpio-keys-polled {
+		compatible = "gpio-keys-polled";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		poll-interval = <1000>;
+
+		fan0-presence {
+			label = "fan0-presence";
+			gpios = <&fan_ioexp 2 GPIO_ACTIVE_LOW>;
+			linux,code = <2>;
+		};
+
+		fan1-presence {
+			label = "fan1-presence";
+			gpios = <&fan_ioexp 6 GPIO_ACTIVE_LOW>;
+			linux,code = <6>;
+		};
+
+		fan2-presence {
+			label = "fan2-presence";
+			gpios = <&fan_ioexp 10 GPIO_ACTIVE_LOW>;
+			linux,code = <10>;
+		};
+
+		fan3-presence {
+			label = "fan3-presence";
+			gpios = <&fan_ioexp 14 GPIO_ACTIVE_LOW>;
+			linux,code = <14>;
+		};
+	};
+};
+
+&mac2 {
+	status = "okay";
+	use-ncsi;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rmii3_default>;
+	clocks = <&syscon ASPEED_CLK_GATE_MAC3CLK>,
+		 <&syscon ASPEED_CLK_MAC3RCLK>;
+	clock-names = "MACCLK", "RCLK";
+};
+
+&fmc {
+	status = "okay";
+	flash at 0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "bmc";
+		spi-max-frequency = <50000000>;
+#include "openbmc-flash-layout-64.dtsi"
+	};
+
+	flash at 1 {
+		status = "okay";
+		m25p,fast-read;
+		label = "alt-bmc";
+		spi-max-frequency = <50000000>;
+#include "openbmc-flash-layout-64-alt.dtsi"
+	};
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&uart4 {
+	status = "okay";
+};
+
+&uart5 {
+	status = "okay";
+};
+
+&kcs3 {
+	status = "okay";
+	aspeed,lpc-io-reg = <0xca2>;
+};
+
+&lpc_reset {
+	status = "okay";
+};
+
+&lpc_ctrl {
+	status = "okay";
+};
+
+&uart_routing {
+	status = "okay";
+};
+
+&wdt1 {
+	status = "okay";
+};
+
+&wdt2 {
+	status = "okay";
+};
+
+&peci0 {
+	status = "okay";
+};
+
+&udc {
+	status = "okay";
+};
+
+&adc0 {
+	vref = <2500>;
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc0_default &pinctrl_adc1_default
+		&pinctrl_adc2_default &pinctrl_adc3_default
+		&pinctrl_adc4_default &pinctrl_adc5_default
+		&pinctrl_adc6_default &pinctrl_adc7_default>;
+};
+
+&adc1 {
+	vref = <2500>;
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc9_default
+		&pinctrl_adc10_default &pinctrl_adc11_default
+		&pinctrl_adc12_default &pinctrl_adc13_default
+		&pinctrl_adc14_default &pinctrl_adc15_default>;
+};
+
+&i2c0 {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+
+	lm75 at 48 {
+		compatible = "national,lm75";
+		reg = <0x48>;
+	};
+
+	lm75 at 49 {
+		compatible = "national,lm75";
+		reg = <0x49>;
+	};
+
+	lm86 at 4c {
+		compatible = "national,lm86";
+		reg = <0x4c>;
+	};
+};
+
+&i2c2 {
+	status = "okay";
+
+	lm75 at 4f {
+		cpmpatible = "national,lm75";
+		reg = <0x4f>;
+	};
+
+	fan_ioexp: pca9535 at 20 {
+		compatible = "nxp,pca9535";
+		reg = <0x20>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names =
+		"","","presence-fan0","",
+		"","","presence-fan1","",
+		"","","presence-fan2","",
+		"","","presence-fan3","";
+	};
+};
+
+&i2c3 {
+	status = "okay";
+
+	eeprom at 50 {
+		compatible = "atmel,24c128";
+		reg = <0x50>;
+		pagesize = <64>;
+	};
+};
+
+&i2c4 {
+	status = "okay";
+
+	psu at 58 {
+		compatible = "pmbus";
+		reg = <0x58>;
+	};
+
+	eeprom at 50 {
+		compatible = "atmel,24c02";
+		reg = <0x50>;
+		pagesize = <1>;
+	};
+};
+
+&i2c5 {
+	status = "okay";
+
+	psu at 58 {
+		compatible = "pmbus";
+		reg = <0x58>;
+	};
+
+	eeprom at 50 {
+		compatible = "atmel,24c02";
+		reg = <0x50>;
+		pagesize = <1>;
+	};
+};
+
+&i2c8 {
+	status = "okay";
+};
+
+&i2c10 {
+	status = "okay";
+
+	lm75 at 4d {
+		compatible = "national,lm75";
+		reg = <0x4d>;
+	};
+};
+
+&gpio0 {
+	status = "okay";
+
+	gpio-line-names =
+	/*A0-A7*/	"","","","","","","","",
+	/*B0-B7*/	"","","","","","","","",
+	/*C0-C7*/	"","","","","","","","",
+	/*D0-D7*/	"","","","","","","","",
+	/*E0-E7*/	"","","","","","","","",
+	/*F0-F7*/	"CPU_PWRGD","","","power-button","host0-ready","","presence-ps0","presence-ps1",
+	/*G0-G7*/	"","","","","","","","",
+	/*H0-H7*/	"","","","","","","","",
+	/*I0-I7*/	"","","","","","reset-button","","",
+	/*J0-J7*/	"","","","","","","","",
+	/*K0-K7*/	"","","","","","","","",
+	/*L0-L7*/	"","","","","","","","",
+	/*M0-M7*/	"","","","","","","","",
+	/*N0-N7*/	"power-chassis-control0","power-chassis-control1","","","","","","",
+	/*O0-O7*/	"","","","","","","","",
+	/*P0-P7*/	"","","","","","","","",
+	/*Q0-Q7*/	"","","","","","","","",
+	/*R0-R7*/	"","","","","","","","",
+	/*S0-S7*/	"","","","","","","","",
+	/*T0-T7*/	"","","","","","","","",
+	/*U0-U7*/	"","","","","","","","",
+	/*V0-V7*/	"","","","","power-chassis-good","","","";
+};
-- 
2.39.0


-- 
******************************
This e-mail is confidential. If you are not 
the intended recipient, you must not disclose, distribute or use the 
information in it as this could be a breach of confidentiality.If you have 
received this message in error, please advise us immediately by return 
e-mail and delete the document. The address from which this message has 
been sent is strictly for business mail only and the company reserves the 
right to monitor the contents of communications and take action where and 
when it is deemed necessary.
Thank you for your co-operation.
