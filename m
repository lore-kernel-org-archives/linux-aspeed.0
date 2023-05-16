From: Chen.PJ 陳柏任 TAO <Chen.PJ@inventec.com>
Date: Tue, 16 May 2023 08:46:39 +0000
Subject: [PATCH v2] ARM: dts: aspeed: Adding Inventec Starscream BMC
In-Reply-To: <d0cd49b86ba6446e8ed78cbeea0e8c1d>
References: <d0cd49b86ba6446e8ed78cbeea0e8c1d>
Message-ID: <f943333cf0b64c2ca10ec27fbba4ca93@inventec.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Initial introduction of Inventec Starscream x86 family equipped with AST2600 BMC SoC.

Signed-off-by: Chen PJ <Chen.pj@inventec.com>

---
v2:
 - Correct License description
 - Remove not supported device
 - Using openbmc-flash-layout.dtsi
 - Correct device format
---
---
 arch/arm/boot/dts/Makefile                    |   1 +
 .../dts/aspeed-bmc-inventec-starscream.dts    | 513 ++++++++++++++++++
 2 files changed, 514 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-inventec-starscream.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index eb681903d50b..0002290ae028 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1630,6 +1630,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-quanta-s6q.dtb \
 	aspeed-bmc-supermicro-x11spi.dtb \
 	aspeed-bmc-inventec-transformers.dtb \
+	aspeed-bmc-inventec-starscream.dtb \
 	aspeed-bmc-tyan-s7106.dtb \
 	aspeed-bmc-tyan-s8036.dtb \
 	aspeed-bmc-vegman-n110.dtb \
diff --git a/arch/arm/boot/dts/aspeed-bmc-inventec-starscream.dts b/arch/arm/boot/dts/aspeed-bmc-inventec-starscream.dts
new file mode 100644
index 000000000000..a6c733b29d04
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed-bmc-inventec-starscream.dts
@@ -0,0 +1,513 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright 2023 Inventec Corp.
+
+/dts-v1/;
+
+#include "aspeed-g6.dtsi"
+#include "aspeed-g6-pinctrl.dtsi"
+#include <dt-bindings/i2c/i2c.h>
+#include <dt-bindings/gpio/aspeed-gpio.h>
+
+/ {
+	model = "STARSCREAM BMC";
+	compatible = "inventec,starscream-bmc", "aspeed,ast2600";
+
+	aliases {
+		serial4 = &uart5;
+	};
+
+	chosen {
+		stdout-path = &uart5;
+		bootargs = "console=tty0 console=ttyS4,115200n8 root=/dev/ram rw init=/linuxrc";
+	};
+
+	memory at 80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x80000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		gfx_memory: framebuffer {
+			size = <0x01000000>;
+			alignment = <0x01000000>;
+			compatible = "shared-dma-pool";
+			reusable;
+		};
+
+		video_engine_memory: video {
+			size = <0x04000000>;
+			alignment = <0x01000000>;
+			compatible = "shared-dma-pool";
+			reusable;
+		};
+
+		ssp_memory: ssp_memory {
+			size = <0x00200000>;
+			alignment = <0x00100000>;
+			compatible = "shared-dma-pool";
+			no-map;
+		};
+	};
+
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels =
+		<&adc_u74 0>, // P0_VDD11
+		<&adc_u74 1>, // P1_VDD11
+		<&adc_u74 2>, // P0_3V3_S5
+		<&adc_u74 3>, // P1_3V3_S5
+		<&adc_u74 4>, // P3V3
+		<&adc_u74 5>, // VBAT
+		<&adc_u74 6>, // P3V3_STBY
+		<&adc_u74 7>, // P5V_STBY
+		<&adc_u74 8>, // P5V
+		<&adc_u74 9>, // P12V
+		<&adc_u74 10>, // P1_VDD18_S5
+		<&adc_u74 11> // P0_VDD18_S5
+		;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		// UID led
+		uid {
+			label = "UID_LED";
+			gpios = <&gpio0 ASPEED_GPIO(X, 2) GPIO_ACTIVE_LOW>;
+		};
+
+		// Heart beat led
+		heartbeat {
+			label = "HB_LED";
+			gpios = <&gpio0 ASPEED_GPIO(P, 7) GPIO_ACTIVE_LOW>;
+		};
+	};
+};
+
+&mdio0 {
+	status = "okay";
+
+	ethphy0: ethernet-phy at 0 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <1>;
+	};
+};
+
+&mac2 {
+	status = "okay";
+	pinctrl-names = "default";
+	phy-mode = "rmii";
+	pinctrl-0 = <&pinctrl_rmii3_default>;
+	use-ncsi;
+};
+
+&mac3 {
+	status = "okay";
+
+	phy-mode = "rgmii";
+	phy-handle = <&ethphy0>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rgmii4_default>;
+};
+
+&fmc {
+	status = "okay";
+	flash at 0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "bmc";
+		spi-max-frequency = <50000000>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+#include "openbmc-flash-layout.dtsi"
+	};
+
+	flash at 1 {
+		status = "okay";
+		m25p,fast-read;
+		label = "bmc2";
+		spi-max-frequency = <50000000>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+	};
+};
+
+&spi1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi1_default>;
+
+	flash at 0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "bios";
+		spi-max-frequency = <50000000>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+	};
+};
+
+
+&wdt1 {
+	status = "okay";
+};
+
+&vuart1 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&uart3 {
+	status = "okay";
+};
+
+&uart5 {
+	status = "okay";
+};
+
+&kcs3 {
+	aspeed,lpc-io-reg = <0xca2>;
+	status = "okay";
+};
+
+&uart_routing {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+};
+&i2c1 {
+	status = "okay";
+};
+&i2c2 {
+	status = "okay";
+};
+&i2c3 {
+	status = "okay";
+};
+
+&i2c4 {
+	status = "okay";
+
+	// I2C EXPANDER
+	i2c-switch at 71 {
+		compatible = "nxp,pca9546";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x71>;
+
+		i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+			// AMD SB-TSI CPU1
+			sbtsi at 4c {
+				compatible = "amd,sbtsi";
+				reg = <0x4c>;
+			};
+		};
+
+		i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			// AMD SB-TSI CPU2
+			sbtsi at 48 {
+				compatible = "amd,sbtsi";
+				reg = <0x48>;
+			};
+		};
+	};
+};
+
+&i2c5 {
+	status = "okay";
+
+	// I2C EXPANDER U153
+	i2c-switch at 70 {
+		compatible = "nxp,pca9546";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x70>;
+
+		usb_hub:i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			// USB U114
+			usb2512b at 2c {
+				compatible = "microchip,usb2514b";
+				reg = <0x2c>;
+			};
+		};
+
+		riser1:i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		riser2:i2c at 2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		i2c at 3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+	};
+};
+
+&i2c6 {
+	status = "okay";
+
+	// FRU Motherboard
+	eeprom at 51 {
+		compatible = "atmel,24c64";
+		reg = <0x51>;
+		pagesize = <32>;
+	};
+
+	// ADC_U74
+	adc_u74:max1139 at 35 {
+		compatible = "maxim,max1139";
+		reg = <0x35>;
+		#io-channel-cells = <1>;
+	};
+
+	psu at 58 {
+		compatible = "pmbus";
+		reg = <0x58>;
+	};
+
+	psu at 5a {
+		compatible = "pmbus";
+		reg = <0x5a>;
+	};
+
+	// Motherboard Temp_U89
+	tmp421 at 4e {
+		compatible = "ti,tmp421";
+		reg = <0x4e>;
+	};
+
+	// RunBMC Temp_U6
+	tmp75 at 49 {
+		compatible = "ti,tmp75";
+		reg = <0x49>;
+	};
+
+	// Right ear board Temp_U1
+	emc1412 at 7c {
+		compatible = "emc1403";
+		reg = <0x7c>;
+	};
+};
+
+&i2c7 {
+	status = "okay";
+	// I2C EXPANDER U40
+	i2c-switch at 70 {
+		compatible = "nxp,pca9545";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x70>;
+
+		i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		i2c at 2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		i2c at 3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+	};
+};
+
+
+&i2c8 {
+	status = "okay";
+	// FRU RunBMC
+	eeprom at 51 {
+		compatible = "atmel,24c512";
+		reg = <0x51>;
+		pagesize = <128>;
+	};
+
+	// Fan controller
+	max31790 at 20 {
+		compatible = "maxim,max31790";
+		reg = <0x20>;
+	};
+	max31790 at 23 {
+		compatible = "maxim,max31790";
+		reg = <0x23>;
+	};
+	emc2302 at 2e {
+		compatible = "smsc,emc2305";
+		reg = <0x2e>;
+	};
+
+	pac1934 at 13 {
+		compatible = "microchip,pac1934";
+		reg = <0x13>;
+		shunt-resistors = <4000 4000 4000 4000>;
+	};
+
+	pac1932 at 12 {
+		compatible = "microchip,pac1932";
+		reg = <0x12>;
+		shunt-resistors = <4000 4000>;
+	};
+};
+
+&i2c9 {
+	status = "okay";
+};
+
+&i2c10 {
+	status = "okay";
+};
+
+&i2c11 {
+	status = "okay";
+};
+
+&i2c12 {
+	status = "okay";
+	// FRU SCM
+	eeprom at 51 {
+		compatible = "atmel,24c512";
+		reg = <0x51>;
+		pagesize = <128>;
+	};
+
+	// SCM Temp_U17
+	tmp75 at 4f {
+		compatible = "ti,tmp75";
+		reg = <0x4f>;
+	};
+};
+
+
+&gpio0 {
+	status = "okay";
+	gpio-line-names =
+	/*A0-A7*/   "","","","","","","","",
+	/*B0-B7*/   "alert-psu0-smb-r-n","bmc-ready","","assert-cpu0-prochot-r-n","","","","",
+	/*C0-C7*/   "","","","","","","","",
+	/*D0-D7*/   "","","","","","","","",
+	/*E0-E7*/   "","","","","","","","",
+	/*F0-F7*/   "","","","","reset-sgpio-r-n","","","",
+	/*G0-G7*/   "","","scm-jtag-mux-select","","","","","",
+	/*H0-H7*/   "","","","","reset-out","power-out","","",
+	/*I0-I7*/   "","","","","","","irq-bmc-cpu0-buf-nmi-n","",
+	/*J0-J7*/   "","","","","","","","",
+	/*K0-K7*/   "","","","","","","","",
+	/*L0-L7*/   "","","","","","","","",
+	/*M0-M7*/   "","","","","","","","",
+	/*N0-N7*/   "","","ncsi-ocp-clk-en-n","","","","","",
+	/*O0-O7*/   "","","","","","","cpu1-thermal-trip-n","",
+	/*P0-P7*/   "","","","","","","","",
+	/*Q0-Q7*/   "cpu0-prochot-n","","cpu1-prochot-n","","cpu0-pe-rst0","","","",
+	/*R0-R7*/   "","","","","","","","",
+	/*S0-S7*/   "","","","","","PCH_SLP_S4_BMC_N","cpu0-thermtrip-n","alert-psu1-smb-r-n",
+	/*T0-T7*/   "","","","","","","","",
+	/*U0-U7*/   "","","","","","","","",
+	/*V0-V7*/   "bios-recovery-buf-n","","assert-cpu1-prochot-r-n","","power-chassis-good","","","",
+	/*W0-W7*/   "","","","","","","","",
+	/*X0-X7*/   "","","","","platform-type","","","",
+	/*Y0-Y7*/   "","","","","","","","",
+	/*Z0-Z7*/   "","cpld-power-break-n","","","","","","",
+	/*AA0-AA7*/ "","","","","","","","",
+	/*AB0-AB7*/ "","","","","","","","",
+	/*AC0-AC7*/ "","","","","","","","";
+};
+
+&sgpiom0 {
+	status = "okay";
+	max-ngpios = <64>;
+	ngpios = <64>;
+	bus-frequency = <1000000>;
+	gpio-line-names =
+	/*in - out - in - out */
+	/*A0-A7*/   "","","","","","","","",
+	/*A0-A7*/   "","","","","","","","",
+	/*B0-B7*/   "","reset-cpu0-i2c-n","","reset-cpu1-i2c-n","","reset-i2c-bus7-n","","usb2514-1-reset-n",
+	/*B0-B7*/   "","bmc-cpu0-uart-en","","hdt-buff-en-n","","assert-clear-cmos","","hdt-mux-select-mon",
+	/*C0-C7*/   "led-identify","cpld-jtag-oe-r-n","cpu0-spd-host-ctrl-n","reset-cpld-hdt-n","","i3c-mux-select","","spi-mux-select",
+	/*C0-C7*/   "","","","","","","","",
+	/*D0-D7*/   "","","","","","","","",
+	/*D0-D7*/   "","","","","","","bios-post-complete-buf-n","",
+	/*E0-E7*/   "","","","","","","","",
+	/*E0-E7*/   "","","","","","","","",
+	/*F0-F7*/   "presence-fan0-n","","presence-fan1-n","","presence-fan2-n","","presence-fan3-n","",
+	/*F0-F7*/   "presence-fan4-n","","presence-fan5-n","","presence-cpu0-n","","presence-cpu1-n","",
+	/*G0-G7*/   "","","","","","","","",
+	/*G0-G7*/   "","","","","presence-psu0-cpld-n","","presence-psu1-cpld-n","",
+	/*H0-H7*/   "","","","","","","","",
+	/*H0-H7*/   "","","","","presence-riser0-n","","presence-riser1-n","";
+};
+
+
+&lpc_snoop {
+	status = "okay";
+	snoop-ports = <0x80>;
+};
+
+&emmc_controller {
+	status = "okay";
+};
+
+&emmc {
+	status = "okay";
+	non-removable;
+	max-frequency = <52000000>;
+	bus-width = <8>;
+};
+
+&video {
+	status = "okay";
+	memory-region = <&video_engine_memory>;
+};
+
+&vhub {
+	status = "okay";
+	aspeed,vhub-downstream-ports = <7>;
+	aspeed,vhub-generic-endpoints = <21>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb2ad_default>;
+};
+
+&rtc {
+	status = "okay";
+};
+
-- 
2.25.1

