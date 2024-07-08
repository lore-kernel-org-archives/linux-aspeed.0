From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 8 Jul 2024 12:39:05 +0200
Subject: [PATCH v2] ARM: dts: aspeed: Add IEISystems NF5280M7 BMC machine
In-Reply-To: <20240708062316.208383-1-liuxiwei@ieisystem.com>
References: <20240708062316.208383-1-liuxiwei@ieisystem.com>
Message-ID: <a049486a-0ec6-4e12-afbf-7c0def8ef23b@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 08/07/2024 08:23, George Liu wrote:
> The IEISystems NF5280M7 is an x86 platform server with an
> AST2600-based BMC.
> This dts file provides a basic configuration for its OpenBMC
> development.
> 
> Signed-off-by: George Liu <liuxiwei@ieisystem.com>
> ---

No changelog, so did you just ignore all feedback?

>  arch/arm/boot/dts/aspeed/Makefile             |   1 +
>  .../aspeed/aspeed-bmc-ieisystems-nf5280m7.dts | 697 ++++++++++++++++++
>  2 files changed, 698 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dts
> 
> diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
> index 5e3392621697..51531d494415 100644
> --- a/arch/arm/boot/dts/aspeed/Makefile
> +++ b/arch/arm/boot/dts/aspeed/Makefile
> @@ -40,6 +40,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>  	aspeed-bmc-ibm-rainier-1s4u.dtb \
>  	aspeed-bmc-ibm-rainier-4u.dtb \
>  	aspeed-bmc-ibm-system1.dtb \
> +	aspeed-bmc-ieisystems-nf5280m7.dtb \
>  	aspeed-bmc-intel-s2600wf.dtb \
>  	aspeed-bmc-inspur-fp5280g2.dtb \
>  	aspeed-bmc-inspur-nf5280m6.dtb \
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dts
> new file mode 100644
> index 000000000000..d706b4f64f6c
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dts
> @@ -0,0 +1,697 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +// Copyright (c) 2023 IEISystems Corporation
> +
> +/dts-v1/;
> +
> +#include "aspeed-g6.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +#include <dt-bindings/leds/leds-pca955x.h>
> +#include <dt-bindings/i2c/i2c.h>
> +
> +/ {
> +	model = "NF5280M7 BMC";
> +	compatible = "ieisystems,nf5280m7-bmc", "aspeed,ast2600";
> +	aliases {
> +		i2c200 = &bus2_mux70_0;
> +		i2c500 = &bus5_mux00;
> +		i2c501 = &bus5_mux01;
> +		i2c600 = &i2c6s0ch0;
> +		i2c601 = &i2c6s0ch1;
> +		i2c602 = &i2c6s0ch2;
> +		i2c603 = &i2c6s0ch3;
> +		i2c604 = &i2c6s0ch4;
> +		i2c605 = &i2c6s0ch5;
> +		i2c606 = &i2c6s0ch6;
> +		i2c607 = &i2c6s0ch7;
> +		i2c610 = &i2c6s1ch0;
> +		i2c611 = &i2c6s1ch1;
> +		i2c612 = &i2c6s1ch2;
> +		i2c613 = &i2c6s1ch3;
> +		i2c614 = &i2c6s1ch4;
> +		i2c615 = &i2c6s1ch5;
> +		i2c616 = &i2c6s1ch6;
> +		i2c617 = &i2c6s1ch7;
> +		i2c620 = &i2c6s2ch0;
> +		i2c621 = &i2c6s2ch1;
> +		i2c622 = &i2c6s2ch2;
> +		i2c623 = &i2c6s2ch3;
> +		i2c624 = &i2c6s2ch4;
> +		i2c625 = &i2c6s2ch5;
> +		i2c626 = &i2c6s2ch6;
> +		i2c627 = &i2c6s2ch7;
> +	};
> +
> +	chosen {
> +		stdout-path = &uart5;
> +		bootargs = "console=ttyS4,115200n8";

Not much improved.

> +	};
> +
> +	memory at 80000000 {
> +		device_type = "memory";
> +		reg = <0x80000000 0x80000000>;
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		video_engine_memory: jpegbuffer {
> +			size = <0x02000000>;	/* 32M */
> +			alignment = <0x01000000>;
> +			compatible = "shared-dma-pool";
> +			reusable;
> +		};
> +
> +		vga_memory: frammebuffer {
> +			no-map;
> +			reg = <0x9ff00000 0x01000000>; /* 16M */
> +		};
> +	};
> +
> +	iio-hwmon {
> +		compatible = "iio-hwmon";
> +		io-channels = <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
> +                      <&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
> +                      <&adc1 0>, <&adc1 1>, <&adc1 2>, <&adc1 3>,
> +                      <&adc1 4>, <&adc1 5>, <&adc1 6>, <&adc1 7>;
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		cpld {

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check W=1` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

> +			label = "cpld";
> +			gpios = <&gpio0 ASPEED_GPIO(N, 2) GPIO_ACTIVE_HIGH>;
> +			linux,code = <ASPEED_GPIO(N, 2)>;
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		fan-fault {

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check W=1` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

> +			label = "fan-fault";
> +			gpios = <&gpio0 ASPEED_GPIO(B, 0) GPIO_ACTIVE_LOW>;
> +		};
> +
> +		system-hot {
> +			label = "system-hot";
> +			gpios = <&gpio0 ASPEED_GPIO(B, 1) GPIO_ACTIVE_LOW>;
> +		};
> +
> +		psu-fault {
> +			label = "psu-fault";
> +			gpios = <&gpio0 ASPEED_GPIO(B, 2) GPIO_ACTIVE_LOW>;
> +		};
> +
> +		heartbeat {
> +			label = "heartbeat";
> +			gpios = <&gpio0 ASPEED_GPIO(P, 7) GPIO_ACTIVE_LOW>;
> +		};
> +
> +		memory-fault {
> +			label = "memory-fault";
> +			gpios = <&gpio0 ASPEED_GPIO(Y, 2) GPIO_ACTIVE_LOW>;
> +		};
> +
> +		system-fault {
> +			label = "system-fault";
> +			gpios = <&gpio0 ASPEED_GPIO(Y, 3) GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +};
> +
> +&fmc {
> +	status = "okay";
> +
> +	flash at 0 {
> +		status = "okay";
> +
> +		m25p,fast-read;
> +		label = "bmc";
> +		spi-max-frequency = <50000000>;
> +#include "openbmc-flash-layout-64.dtsi"
> +	};
> +	flash at 1 {
> +		status = "okay";
> +
> +		m25p,fast-read;
> +		label = "alt-bmc";
> +		spi-max-frequency = <50000000>;
> +#include "openbmc-flash-layout-64-alt.dtsi"
> +	};
> +};
> +
> +
> +&spi1 {
> +	status = "okay";
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_spi1_default>;
> +
> +	flash at 0 {
> +		status = "okay";
> +
> +		m25p,fast-read;
> +		label = "bios";
> +		spi-max-frequency = <50000000>;
> +	};
> +};
> +
> +&peci0 {
> +	status = "okay";
> +
> +	gpios = <&gpio0 ASPEED_GPIO(F, 6) 0>;
> +
> +	peci-client at 30 {
> +		compatible = "intel,peci-client";
> +		reg = <0x30>;
> +	};
> +
> +	peci-client at 31 {
> +		compatible = "intel,peci-client";
> +		reg = <0x31>;
> +	};
> +};
> +
> +&gpio0 {
> +	status = "okay";
> +
> +	gpio-line-names =
> +	/*A0-A7*/	"","","","","","","","",
> +	/*B0-B7*/	"","","","","","","","",
> +	/*C0-C7*/	"","","","","","","","",
> +	/*D0-D7*/	"","","","","","","","",
> +	/*E0-E7*/	"","","","","","","","",
> +	/*F0-F7*/	"","","","","","","","",
> +	/*G0-G7*/	"","","","","","","","",
> +	/*H0-H7*/	"","","","","","","","",
> +	/*I0-I7*/	"","","","","","POWER_OUT","RESET_OUT","",
> +	/*J0-J7*/	"","","","","","","","",
> +	/*K0-K7*/	"","","","","","","","",
> +	/*L0-L7*/	"","","","","","","","",
> +	/*M0-M7*/	"","","","","","","","",
> +	/*N0-N7*/	"","","","","","","","",
> +	/*O0-O7*/	"","","","","","","","",
> +	/*P0-P7*/	"RESET_BUTTON","","","NMI_BUTTON","NMI_OUT","","","",
> +	/*Q0-Q7*/	"","","","","","","","",
> +	/*R0-R7*/	"","","","","","","","",
> +	/*S0-S7*/	"","","","SIO_ONCONTROL","","","","",
> +	/*T0-T7*/	"","","","","","","","",
> +	/*U0-U7*/	"","","","","","","","",
> +	/*V0-V7*/	"","SIO_S5","POWER_BUTTON","","PS_PWROK","","","",
> +	/*W0-W7*/	"","","","","","","","",
> +	/*X0-X7*/	"","","POST_COMPLETE","","","","","",
> +	/*Y0-Y7*/	"","","","","","","","",
> +	/*Z0-Z7*/	"","","","","","","","";
> +};
> +
> +&kcs3 {
> +	aspeed,lpc-io-reg = <0xCA2>;
> +	status = "okay";
> +};
> +
> +&kcs4 {
> +	aspeed,lpc-io-reg = <0xCA4>;
> +	status = "okay";
> +};
> +
> +&lpc_snoop {
> +	snoop-ports = <0x80>;
> +	status = "okay";
> +};
> +
> +&mdio1 {
> +	status = "okay";
> +
> +	ethphy1: ethernet-phy at 0 {
> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <0>;
> +	};
> +};
> +
> +&mac2 {
> +	status = "okay";
> +
> +	phy-mode = "rgmii";
> +	phy-handle = <&ethphy1>;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_rgmii3_default>;
> +};
> +
> +&mac3 {
> +	status = "okay";
> +
> +	phy-mode = "rmii";
> +	use-ncsi;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_rmii4_default>;
> +};
> +
> +&adc0 {
> +	status = "okay";
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_adc0_default &pinctrl_adc1_default
> +		&pinctrl_adc2_default &pinctrl_adc3_default
> +		&pinctrl_adc4_default &pinctrl_adc5_default
> +		&pinctrl_adc6_default &pinctrl_adc7_default>;
> +};
> +
> +&adc1 {
> +	status = "okay";
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc9_default
> +		&pinctrl_adc10_default &pinctrl_adc11_default
> +		&pinctrl_adc12_default &pinctrl_adc13_default
> +		&pinctrl_adc14_default &pinctrl_adc15_default>;
> +};
> +
> +&uart1 {
> +	status = "okay";
> +};
> +
> +&uart3 {
> +	status = "okay";
> +};
> +
> +&uart4 {
> +	status = "okay";
> +};
> +
> +&uart5 {
> +	status = "okay";
> +};
> +
> +&vuart1 {
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	multi-master;
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	multi-master;
> +	status = "okay";
> +
> +	eeprom at 50 {
> +		compatible = "atmel,24c256";
> +		reg = <0x50>;
> +	};
> +};
> +
> +&i2c2 {
> +	status = "okay";
> +
> +	i2c-mux at 70 {
> +		compatible = "nxp,pca9546";
> +		reg = <0x70>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		bus2_mux70_0:i2c at 2 {

Why did you change the format and dropped the space after :?

Please respond to previous feedback and acknowledge each comment.

Best regards,
Krzysztof

