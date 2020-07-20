From: Supreeth Venkatesh <supreeth.venkatesh@amd.com>
Date: Mon, 20 Jul 2020 11:01:47 -0500
Subject: [PATCH 1/1] ARM:dts:aspeed: Initial device tree for AMD EthanolX
Message-ID: <20200720160147.22339-1-supreeth.venkatesh@amd.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Initial introduction of AMD EthanolX platform equipped with an
Aspeed ast2500 BMC manufactured by AMD.

AMD EthanolX platform is an AMD customer reference board with an
Aspeed ast2500 BMC manufactured by AMD.
This adds AMD EthanolX device tree file including the flash layout
used by EthanolX BMC machines.

This also adds an entry of AMD EthanolX device tree file in Makefile.

Signed-off-by: Supreeth Venkatesh <supreeth.venkatesh@amd.com>
---
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts | 209 ++++++++++++++++++
 2 files changed, 210 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index d6dfdf73e66b..55ed881d2ebc 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1281,6 +1281,7 @@ dtb-$(CONFIG_ARCH_ZX) += zx296702-ad1.dtb
 dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-ast2500-evb.dtb \
 	aspeed-ast2600-evb.dtb \
+	aspeed-bmc-amd-ethanolx.dtb \
 	aspeed-bmc-arm-centriq2400-rep.dtb \
 	aspeed-bmc-arm-stardragon4800-rep2.dtb \
 	aspeed-bmc-facebook-cmm.dtb \
diff --git a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
new file mode 100644
index 000000000000..dcabdfc08172
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: Apache-2.0
+// Copyright (c) 2020 AMD Inc.
+// Author: Supreeth Venkatesh <supreeth.venkatesh@amd.com>
+/dts-v1/;
+
+#include "aspeed-g5.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+
+/ {
+	model = "AMD EthanolX BMC";
+	compatible = "amd,ethanolx-bmc", "aspeed,ast2500";
+
+	memory at 80000000 {
+		reg = <0x80000000 0x20000000>;
+	};
+	aliases {
+		serial0 = &uart1;
+		serial4 = &uart5;
+	};
+	chosen {
+		stdout-path = &uart5;
+		bootargs = "console=ttyS4,115200 earlyprintk";
+	};
+	leds {
+		compatible = "gpio-leds";
+
+		fault {
+			gpios = <&gpio ASPEED_GPIO(A, 2) GPIO_ACTIVE_LOW>;
+		};
+
+		identify {
+			gpios = <&gpio ASPEED_GPIO(A, 3) GPIO_ACTIVE_LOW>;
+		};
+	};
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&adc 0>, <&adc 1>, <&adc 2>, <&adc 3>, <&adc 4>;
+	};
+};
+
+&fmc {
+	status = "okay";
+	flash at 0 {
+		status = "okay";
+		m25p,fast-read;
+		#include "openbmc-flash-layout.dtsi"
+	};
+};
+
+
+&mac0 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rmii1_default>;
+	clocks = <&syscon ASPEED_CLK_GATE_MAC1CLK>,
+		 <&syscon ASPEED_CLK_MAC1RCLK>;
+	clock-names = "MACCLK", "RCLK";
+};
+
+&uart1 {
+	//Host Console
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_txd1_default
+		     &pinctrl_rxd1_default>;
+};
+
+&uart5 {
+	//BMC Console
+	status = "okay";
+};
+
+&adc {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc0_default
+		     &pinctrl_adc1_default
+		     &pinctrl_adc2_default
+		     &pinctrl_adc3_default
+		     &pinctrl_adc4_default>;
+};
+
+// Thermal Sensors
+&i2c7 {
+	status = "okay";
+
+	lm75a at 48 {
+		compatible = "national,lm75a";
+		reg = <0x48>;
+	};
+
+	lm75a at 49 {
+		compatible = "national,lm75a";
+		reg = <0x49>;
+	};
+
+	lm75a at 4a {
+		compatible = "national,lm75a";
+		reg = <0x4a>;
+	};
+
+	lm75a at 4b {
+		compatible = "national,lm75a";
+		reg = <0x4b>;
+	};
+
+	lm75a at 4c {
+		compatible = "national,lm75a";
+		reg = <0x4c>;
+	};
+
+	lm75a at 4d {
+		compatible = "national,lm75a";
+		reg = <0x4d>;
+	};
+
+	lm75a at 4e {
+		compatible = "national,lm75a";
+		reg = <0x4e>;
+	};
+
+	lm75a at 4f {
+		compatible = "national,lm75a";
+		reg = <0x4f>;
+	};
+};
+
+&kcs1 {
+	status = "okay";
+	kcs_addr = <0x60>;
+};
+
+&kcs2 {
+	status = "okay";
+	kcs_addr = <0x62>;
+};
+
+&kcs4 {
+	status = "okay";
+	kcs_addr = <0x97DE>;
+};
+
+&lpc_snoop {
+	status = "okay";
+	snoop-ports = <0x80>;
+};
+
+&lpc_ctrl {
+	//Enable lpc clock
+	status = "okay";
+};
+
+&pwm_tacho {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm0_default
+	&pinctrl_pwm1_default
+	&pinctrl_pwm2_default
+	&pinctrl_pwm3_default
+	&pinctrl_pwm4_default
+	&pinctrl_pwm5_default
+	&pinctrl_pwm6_default
+	&pinctrl_pwm7_default>;
+
+	fan at 0 {
+		reg = <0x00>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x00>;
+	};
+
+	fan at 1 {
+		reg = <0x01>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x01>;
+	};
+
+	fan at 2 {
+		reg = <0x02>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x02>;
+	};
+
+	fan at 3 {
+		reg = <0x03>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x03>;
+	};
+
+	fan at 4 {
+		reg = <0x04>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x04>;
+	};
+
+	fan at 5 {
+		reg = <0x05>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x05>;
+	};
+
+	fan at 6 {
+		reg = <0x06>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x06>;
+	};
+
+	fan at 7 {
+		reg = <0x07>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x07>;
+	};
+};
+
+
+
-- 
2.17.1

