From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Date: Wed, 12 Jul 2023 15:37:50 +0800
Subject: [PATCH v1 2/2] ARM: dts: aspeed: yosemitev4: add Facebook Yosemite V4 BMC
In-Reply-To: <20230712073752.54624-1-Delphine_CC_Chiu@wiwynn.com>
References: <20230712073752.54624-1-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <20230712073752.54624-3-Delphine_CC_Chiu@wiwynn.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add linux device tree entry related to
Yosemite V4 specific devices connected to BMC SoC.

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/Makefile                    |   1 +
 .../dts/aspeed-bmc-facebook-yosemitev4.dts    | 570 ++++++++++++++++++
 2 files changed, 571 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev4.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 59829fc90315..871e6d271262 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1631,6 +1631,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-facebook-galaxy100.dtb \
 	aspeed-bmc-facebook-greatlakes.dtb \
 	aspeed-bmc-facebook-minipack.dtb \
+	aspeed-bmc-facebook-yosemitev4.dtb \
 	aspeed-bmc-facebook-tiogapass.dtb \
 	aspeed-bmc-facebook-wedge40.dtb \
 	aspeed-bmc-facebook-wedge100.dtb \
diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev4.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev4.dts
new file mode 100644
index 000000000000..1df151fb6ff3
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev4.dts
@@ -0,0 +1,570 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright 2022 Facebook Inc.
+
+/dts-v1/;
+#include "aspeed-g6.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+#include <dt-bindings/leds/leds-pca955x.h>
+#include <dt-bindings/i2c/i2c.h>
+
+/ {
+	model = "Facebook Yosemite V4 BMC";
+	compatible = "facebook,yosemitev4-bmc", "aspeed,ast2600";
+
+	aliases {
+		serial4 = &uart5;
+		serial5 = &uart6;
+		serial6 = &uart7;
+		serial7 = &uart8;
+		serial8 = &uart9;
+	};
+
+	chosen {
+		bootargs = "console=ttyS4,57600n8";
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
+				<&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
+				<&adc1 0>, <&adc1 1>;
+	};
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&uart3 {
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
+&uart6 {
+	status = "okay";
+};
+
+&uart7 {
+	status = "okay";
+};
+
+&uart8 {
+	status = "okay";
+};
+
+&uart9 {
+	status = "okay";
+};
+
+&wdt1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdtrst1_default>;
+	aspeed,reset-type = "soc";
+	aspeed,external-signal;
+	aspeed,ext-push-pull;
+	aspeed,ext-active-high;
+	aspeed,ext-pulse-duration = <256>;
+};
+
+&mac2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rmii3_default>;
+	no-hw-checksum;
+	use-ncsi;
+	mlx,multi-host;
+	ncsi-ctrl,start-redo-probe;
+	ncsi-ctrl,no-channel-monitor;
+	ncsi-package = <1>;
+	ncsi-channel = <1>;
+	ncsi-rexmit = <1>;
+	ncsi-timeout = <2>;
+};
+
+&mac3 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rmii4_default>;
+	no-hw-checksum;
+	use-ncsi;
+	mlx,multi-host;
+	ncsi-ctrl,start-redo-probe;
+	ncsi-ctrl,no-channel-monitor;
+	ncsi-package = <1>;
+	ncsi-channel = <1>;
+	ncsi-rexmit = <1>;
+	ncsi-timeout = <2>;
+};
+
+&rtc {
+	status = "okay";
+};
+
+&fmc {
+	status = "okay";
+	flash at 0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "bmc";
+		spi-rx-bus-width = <4>;
+		spi-max-frequency = <50000000>;
+#include "openbmc-flash-layout-64.dtsi"
+	};
+	flash at 1 {
+		status = "okay";
+		m25p,fast-read;
+		label = "bmc2";
+		spi-rx-bus-width = <4>;
+		spi-max-frequency = <50000000>;
+	};
+};
+
+&i2c0 {
+	status = "okay";
+	bus-frequency = <400000>;
+	multi-master;
+	adm1278 at 40 {
+		compatible = "adi,adm1278";
+		reg = <0x40>;
+	};
+};
+
+&i2c1 {
+	status = "okay";
+	bus-frequency = <400000>;
+	multi-master;
+	adm1278 at 40 {
+		compatible = "adi,adm1278";
+		reg = <0x40>;
+	};
+};
+
+&i2c2 {
+	status = "okay";
+	bus-frequency = <400000>;
+	multi-master;
+	adm1278 at 40 {
+		compatible = "adi,adm1278";
+		reg = <0x40>;
+	};
+};
+
+&i2c3 {
+	status = "okay";
+	bus-frequency = <400000>;
+	multi-master;
+	adm1278 at 40 {
+		compatible = "adi,adm1278";
+		reg = <0x40>;
+	};
+};
+
+&i2c4 {
+	status = "okay";
+	bus-frequency = <400000>;
+	multi-master;
+	adm1278 at 40 {
+		compatible = "adi,adm1278";
+		reg = <0x40>;
+	};
+};
+
+&i2c5 {
+	status = "okay";
+	bus-frequency = <400000>;
+	multi-master;
+	adm1278 at 40 {
+		compatible = "adi,adm1278";
+		reg = <0x40>;
+	};
+};
+
+&i2c6 {
+	status = "okay";
+	bus-frequency = <400000>;
+	multi-master;
+	adm1278 at 40 {
+		compatible = "adi,adm1278";
+		reg = <0x40>;
+	};
+};
+
+&i2c7 {
+	status = "okay";
+	bus-frequency = <400000>;
+	multi-master;
+	adm1278 at 40 {
+		compatible = "adi,adm1278";
+		reg = <0x40>;
+	};
+};
+
+&i2c8 {
+	status = "okay";
+	bus-frequency = <400000>;
+	i2cswitch at 70 {
+	compatible = "nxp,pca9544";
+	idle-state = <0>;
+	i2c-mux-idle-disconnect;
+	reg = <0x70>;
+	};
+};
+
+&i2c9 {
+	status = "okay";
+	bus-frequency = <400000>;
+	i2cswitch at 71 {
+	compatible = "nxp,pca9544";
+	idle-state = <0>;
+	i2c-mux-idle-disconnect;
+	reg = <0x71>;
+	};
+};
+
+&i2c10 {
+	status = "okay";
+	bus-frequency = <400000>;
+};
+
+&i2c11 {
+	status = "okay";
+	bus-frequency = <400000>;
+	adm1272 at 10 {
+		compatible = "adi, adm1272";
+		reg = <0x10>;
+	};
+
+	adm1272 at 12 {
+		compatible = "adi, adm1272";
+		reg = <0x12>;
+	};
+
+	pca9555 at 20 {
+		compatible = "nxp,pca9555";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	pca9555 at 21 {
+		compatible = "nxp,pca9555";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	pca9555 at 22 {
+		compatible = "nxp,pca9555";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	pca9555 at 23 {
+		compatible = "nxp,pca9555";
+		reg = <0x23>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	tmp75 at 48 {
+		compatible = "ti,tmp75";
+		reg = <0x48>;
+	};
+
+	tmp75 at 49 {
+		compatible = "ti,tmp75";
+		reg = <0x49>;
+	};
+
+	tmp75 at 4a {
+		compatible = "ti,tmp75";
+		reg = <0x4a>;
+	};
+
+	tmp75 at 4b {
+		compatible = "ti,tmp75";
+		reg = <0x4b>;
+	};
+
+	eeprom at 54 {
+		compatible = "atmel,24c256";
+		reg = <0x54>;
+	};
+};
+
+&i2c12 {
+	status = "okay";
+	bus-frequency = <400000>;
+};
+
+&i2c13 {
+	status = "okay";
+	bus-frequency = <400000>;
+};
+
+&i2c14 {
+	status = "okay";
+	bus-frequency = <400000>;
+	adc128d818 at 1d {
+		compatible = "ti,adc128d818";
+		reg = <0x1d>;
+		ti,mode = /bits/ 8 <2>;
+	};
+
+	adc128d818 at 35 {
+		compatible = "ti,adc128d818";
+		reg = <0x35>;
+		ti,mode = /bits/ 8 <2>;
+	};
+
+	adc128d818 at 37 {
+		compatible = "ti,adc128d818";
+		reg = <0x37>;
+		ti,mode = /bits/ 8 <2>;
+	};
+
+	ina230 at 40 {
+		compatible = "ti,ina230";
+		reg = <0x40>;
+	};
+
+	ina230 at 41 {
+		compatible = "ti,ina230";
+		reg = <0x41>;
+	};
+
+	ina230 at 42 {
+		compatible = "ti,ina230";
+		reg = <0x42>;
+	};
+
+	ina230 at 41 {
+		compatible = "ti,ina230";
+		reg = <0x43>;
+	};
+
+	ina230 at 44 {
+		compatible = "ti,ina230";
+		reg = <0x44>;
+	};
+
+	tmp75 at 48 {
+		compatible = "ti,tmp75";
+		reg = <0x48>;
+	};
+
+	tmp75 at 4e {
+		compatible = "ti,tmp75";
+		reg = <0x4e>;
+	};
+
+	tmp75 at 4f {
+		compatible = "ti,tmp75";
+		reg = <0x4f>;
+	};
+
+	eeprom at 50 {
+		compatible = "atmel,24c128";
+		reg = <0x50>;
+	};
+
+	eeprom at 51 {
+		compatible = "atmel,24c128";
+		reg = <0x51>;
+	};
+
+	i2cswitch at 71 {
+		compatible = "nxp,pca9846";
+		idle-state = <0>;
+		i2c-mux-idle-disconnect;
+		reg = <0x71>;
+
+		i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			adc128d818 at 1f {
+				compatible = "ti,adc128d818";
+				reg = <0x1f>;
+				ti,mode = /bits/ 8 <2>;
+			};
+
+			max31790 at 20{
+				compatible = "max31790";
+				reg = <0x20>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				fan-mode = "pwm";
+				fanconfig = /bits/ 8 <0x19 0x19 0x19 0x18 0x18 0x18>;
+			};
+
+			tca6424 at 22{
+				compatible = "ti,tca6424";
+				reg = <0x22>;
+			};
+
+			max31790 at 23{
+				compatible = "max31790";
+				reg = <0x23>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				fan-mode = "pwm";
+				fanconfig = /bits/ 8 <0x19 0x19 0x19 0x18 0x18 0x18>;
+			};
+
+			max11615 at 33 {
+				compatible = "maxim,max11615";
+				reg = <0x33>;
+			};
+
+			eeprom at 52 {
+				compatible = "atmel,24c128";
+				reg = <0x52>;
+			};
+
+			pca9552 at 61 {
+				compatible = "nxp,pca9552";
+				reg = <0x61>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+		};
+
+		i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			adc128d818 at 1f {
+				compatible = "ti,adc128d818";
+				reg = <0x1f>;
+				ti,mode = /bits/ 8 <2>;
+			};
+
+			max31790 at 20{
+				compatible = "max31790";
+				reg = <0x20>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				fan-mode = "pwm";
+				fanconfig = /bits/ 8 <0x19 0x19 0x19 0x18 0x18 0x18>;
+			};
+
+			tca6424 at 22{
+				compatible = "ti,tca6424";
+				reg = <0x22>;
+			};
+
+			max31790 at 23{
+				compatible = "max31790";
+				reg = <0x23>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				fan-mode = "pwm";
+				fanconfig = /bits/ 8 <0x19 0x19 0x19 0x18 0x18 0x18>;
+			};
+
+			max11615 at 33 {
+				compatible = "maxim,max11615";
+				reg = <0x33>;
+			};
+
+			eeprom at 52 {
+				compatible = "atmel,24c128";
+				reg = <0x52>;
+			};
+
+			pca9552 at 61 {
+				compatible = "nxp,pca9552";
+				reg = <0x61>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+		};
+	};
+
+	i2cswitch at 73 {
+		compatible = "nxp,pca9544";
+		idle-state = <0>;
+		i2c-mux-idle-disconnect;
+		reg = <0x73>;
+
+		i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			max11617 at 6a {
+				compatible = "maxim,max11617";
+				reg = <0x6a>;
+			};
+		};
+
+		i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			max11617 at 6a {
+				compatible = "maxim,max11617";
+				reg = <0x6a>;
+			};
+		};
+	};
+};
+
+&i2c15 {
+	status = "okay";
+	bus-frequency = <400000>;
+};
+
+&adc0 {
+	ref_voltage = <2500>;
+	status = "okay";
+	pinctrl-0 = <&pinctrl_adc0_default &pinctrl_adc1_default
+			&pinctrl_adc2_default &pinctrl_adc3_default
+			&pinctrl_adc4_default &pinctrl_adc5_default
+			&pinctrl_adc6_default &pinctrl_adc7_default>;
+};
+
+&adc1 {
+	ref_voltage = <2500>;
+	status = "okay";
+	pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc9_default>;
+};
+
+
+&ehci0 {
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
-- 
2.25.1

