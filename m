From: wangmin_phy@126.com <wangmin_phy@126.com>
Date: Mon, 11 Jul 2022 20:23:33 +0800
Subject: [PATCH 1/1] ARM: dts: aspeed: Add device tree for Phytium's BMC
In-Reply-To: <20220711122333.385730-1-wangmin_phy@126.com>
References: <20220711122333.385730-1-wangmin_phy@126.com>
Message-ID: <20220711122333.385730-2-wangmin_phy@126.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Min Wang <wangmin@phytium.com.cn>

The Phytium's BMC card is an ASPEED AST2500-based BMC for the
hardware reference platform with Phytium's Processors Family.

Signed-off-by: Min Wang <wangmin@phytium.com.cn>
---
 arch/arm/boot/dts/Makefile                    |   3 +-
 .../boot/dts/aspeed-bmc-phytium-pomelo.dts    | 302 ++++++++++++++++++
 2 files changed, 304 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-phytium-pomelo.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 7e0934180724..e02cd800d45a 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1497,4 +1497,5 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-opp-zaius.dtb \
 	aspeed-bmc-portwell-neptune.dtb \
 	aspeed-bmc-quanta-q71l.dtb \
-	aspeed-bmc-supermicro-x11spi.dtb
+	aspeed-bmc-supermicro-x11spi.dtb \
+	aspeed-bmc-phytium-pomelo.dtb
diff --git a/arch/arm/boot/dts/aspeed-bmc-phytium-pomelo.dts b/arch/arm/boot/dts/aspeed-bmc-phytium-pomelo.dts
new file mode 100644
index 000000000000..a75017f22140
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed-bmc-phytium-pomelo.dts
@@ -0,0 +1,302 @@
+// SPDX-License-Identifier: GPL-2.0+
+/dts-v1/;
+
+#include "aspeed-g5.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+
+/ {
+	model = "Phytium AST2500 BMC";
+	compatible = "aspeed,ast2500";
+
+	aliases {
+		serial4 = &uart5;
+	};
+
+	chosen {
+		stdout-path = &uart5;
+		bootargs = "console=tty0 console=ttyS4,115200 earlyprintk";
+	};
+
+	memory at 80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x20000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		vga_memory: framebuffer at 9c000000 {
+			no-map;
+			reg = <0x9c000000 0x04000000>; /* 64M */
+		};
+
+		video_engine_memory: jpegbuffer {
+			size = <0x02000000>;	/* 32M */
+			alignment = <0x01000000>;
+			compatible = "shared-dma-pool";
+			reusable;
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		id-button {
+			label = "id-button";
+			gpios = <&gpio  ASPEED_GPIO(S, 2)  GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		identify {
+			gpios = <&gpio ASPEED_GPIO(C, 6) GPIO_ACTIVE_LOW>;
+		};
+		fault {
+			gpios = <&gpio ASPEED_GPIO(C, 7) GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&adc 0>, <&adc 1>, <&adc 2>, <&adc 3>,
+		      <&adc 4>, <&adc 5>, <&adc 6>, <&adc 7>,
+		      <&adc 8>, <&adc 9>, <&adc 10>, <&adc 11>,
+		      <&adc 12>, <&adc 13>, <&adc 14>, <&adc 15>;
+	};
+};
+
+&adc {
+	status = "okay";
+};
+
+&fmc {
+	status = "okay";
+	flash at 0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "bmc";
+		spi-max-frequency = <50000000>;
+#include "openbmc-flash-layout.dtsi"
+	};
+};
+
+&spi1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi1_default>;
+	flash at 0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "pnor";
+		spi-max-frequency = <100000000>;
+	};
+};
+
+&spi2 {
+	status = "okay";
+};
+
+&uart5 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_txd1_default
+			&pinctrl_rxd1_default
+			&pinctrl_nrts1_default
+			&pinctrl_ndtr1_default
+			&pinctrl_ndsr1_default
+			&pinctrl_ncts1_default
+			&pinctrl_ndcd1_default
+			&pinctrl_nri1_default>;
+
+};
+
+&lpc_snoop {
+	status = "okay";
+	snoop-ports = <0x80>;
+};
+
+&kcs3 {
+	status = "okay";
+	aspeed,lpc-io-reg = <0xCA2>;
+};
+
+&kcs2 {
+	status = "okay";
+	aspeed,lpc-io-reg = <0xCA8>;
+};
+
+&mac0 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rmii1_default>;
+	clocks = <&syscon ASPEED_CLK_GATE_MAC1CLK>,
+		 <&syscon ASPEED_CLK_MAC1RCLK>;
+	clock-names = "MACCLK", "RCLK";
+	use-ncsi;
+};
+
+&mac1 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rgmii2_default &pinctrl_mdio2_default>;
+};
+
+&i2c1 {
+	status = "okay";
+	psu1 at 58 {
+		compatible = "pmbus";
+		reg = <0x58>;
+	};
+	psu2 at 59 {
+		compatible = "pmbus";
+		reg = <0x59>;
+	};
+};
+
+&i2c2 {
+	status = "okay";
+};
+
+&i2c3 {
+	status = "okay";
+
+};
+
+&i2c4 {
+	status = "okay";
+	rtc at 68 {
+		compatible = "dallas,ds1339";
+		reg = <0x68>;
+	};
+};
+
+&i2c5 {
+	status = "okay";
+};
+
+
+&i2c6 {
+	status = "okay";
+};
+
+&i2c7 {
+	status = "okay";
+};
+
+&i2c8 {
+	status = "okay";
+	lm75 at 48 {
+		compatible = "ti,tmp100";
+		reg = <0x48>;
+	};
+	lm75 at 49 {
+		compatible = "ti,tmp100";
+		reg = <0x49>;
+	};
+	lm75 at 4a {
+		compatible = "ti,tmp100";
+		reg = <0x4a>;
+	};
+	lm75 at 4c {
+		compatible = "ti,tmp100";
+		reg = <0x4c>;
+	};
+	lm75 at 4d {
+		compatible = "ti,tmp100";
+		reg = <0x4d>;
+	};
+	lm75 at 4e {
+		compatible = "ti,tmp100";
+		reg = <0x4e>;
+	};
+
+};
+
+&i2c0 {
+	status = "okay";
+};
+
+
+/*
+ * Enable port A as device (via the virtual hub) and port B as
+ * host by default on the eval board. This can be easily changed
+ * by replacing the override below with &ehci0 { ... } to enable
+ * host on both ports.
+ */
+&vhub {
+	status = "okay";
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&uhci {
+	status = "okay";
+};
+
+&pwm_tacho {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm0_default
+		     &pinctrl_pwm1_default
+		     &pinctrl_pwm2_default
+		     &pinctrl_pwm3_default
+		     &pinctrl_pwm4_default
+		     &pinctrl_pwm5_default
+		     &pinctrl_pwm6_default
+		     &pinctrl_pwm7_default>;
+
+	fan at 0 {
+		reg = <0x00>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x0>;
+	};
+
+	fan at 1 {
+		reg = <0x01>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x1>;
+	};
+
+	fan at 2 {
+		reg = <0x02>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x2>;
+	};
+
+	fan at 3 {
+		reg = <0x03>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x3>;
+	};
+
+	fan at 4 {
+		reg = <0x04>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x4>;
+	};
+
+	fan at 5 {
+		reg = <0x05>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x5>;
+	};
+
+	fan at 6 {
+		reg = <0x06>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x6>;
+	};
+
+	fan at 7 {
+		reg = <0x07>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x7>;
+	};
+};
+
+&video {
+	status = "okay";
+	memory-region = <&video_engine_memory>;
+};
-- 
2.27.0

