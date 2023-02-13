From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 13 Feb 2023 12:25:57 +1030
Subject: [PATCH v4 1/1] ARM: dts: aspeed: Add device tree for Ufispace NCPLite BMC
In-Reply-To: <20230210103829.74470-2-jordan.chang@ufispace.com>
References: <20230210103829.74470-1-jordan.chang@ufispace.com>
 <20230210103829.74470-2-jordan.chang@ufispace.com>
Message-ID: <12424bbd-cd3c-4d96-a7d8-1c83241b845f@app.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Fri, 10 Feb 2023, at 21:08, Jordan Chang wrote:
> Add initial version of device tree for Ufispace NCPLite platform
> which is equipped with AST2600-based BMC.
>
> Signed-off-by: Jordan Chang <jordan.chang@ufispace.com>
> ---
>  arch/arm/boot/dts/Makefile                    |   1 +
>  .../boot/dts/aspeed-bmc-ufispace-ncplite.dts  | 359 ++++++++++++++++++
>  2 files changed, 360 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed-bmc-ufispace-ncplite.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 2ee9c043218b..d26e0651e805 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1626,6 +1626,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>  	aspeed-bmc-inventec-transformers.dtb \
>  	aspeed-bmc-tyan-s7106.dtb \
>  	aspeed-bmc-tyan-s8036.dtb \
> +	aspeed-bmc-ufispace-ncplite.dtb \
>  	aspeed-bmc-vegman-n110.dtb \
>  	aspeed-bmc-vegman-rx20.dtb \
>  	aspeed-bmc-vegman-sx20.dtb
> diff --git a/arch/arm/boot/dts/aspeed-bmc-ufispace-ncplite.dts 
> b/arch/arm/boot/dts/aspeed-bmc-ufispace-ncplite.dts
> new file mode 100644
> index 000000000000..a3853bdcae9d
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed-bmc-ufispace-ncplite.dts
> @@ -0,0 +1,359 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +// Copyright (c) 2022 Ufispace Co., Ltd.
> +/dts-v1/;
> +
> +#include "aspeed-g6.dtsi"
> +#include <dt-bindings/i2c/i2c.h>
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +
> +/ {
> +	model = "Ufispace NCPLite BMC";
> +	compatible = "ufispace,ncplite-bmc", "aspeed,ast2600";
> +
> +	aliases {
> +		serial4 = &uart5;
> +	};
> +
> +	chosen {
> +		stdout-path = &uart5;
> +	};
> +
> +	memory at 80000000 {
> +		device_type = "memory";
> +		reg = <0x80000000 0x80000000>;
> +	};
> +
> +	iio-hwmon {
> +		compatible = "iio-hwmon";
> +		io-channels = <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
> +			      <&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
> +			      <&adc1 0>, <&adc1 1>, <&adc1 2>, <&adc1 3>,
> +			      <&adc1 4>, <&adc1 5>, <&adc1 6>, <&adc1 7>;
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		event-fan-alert {
> +			label = "fan-alert";
> +			gpios = <&gpio0 ASPEED_GPIO(M, 2) GPIO_ACTIVE_LOW>;
> +			linux,code = <ASPEED_GPIO(M, 2)>;
> +		};
> +
> +		event-allpwr-good {
> +			label = "allpwr-good";
> +			gpios = <&gpio0 ASPEED_GPIO(V, 4) GPIO_ACTIVE_HIGH>;
> +			linux,code = <ASPEED_GPIO(V, 4)>;
> +		};
> +
> +		event-psu0-alert {
> +			label = "psu0-alert";
> +			gpios = <&gpio0 ASPEED_GPIO(V, 1) GPIO_ACTIVE_LOW>;
> +			linux,code = <ASPEED_GPIO(V, 1)>;
> +		};
> +
> +		event-psu1-alert {
> +			label = "psu1-alert";
> +			gpios = <&gpio0 ASPEED_GPIO(V, 2) GPIO_ACTIVE_LOW>;
> +			linux,code = <ASPEED_GPIO(V, 2)>;
> +		};
> +
> +		event-thermal-alert {
> +			label = "thermal-alert";
> +			gpios = <&gpio0 ASPEED_GPIO(P, 2) GPIO_ACTIVE_LOW>;
> +			linux,code = <ASPEED_GPIO(P, 2)>;
> +		};
> +
> +		event-cpu-caterr {
> +			label = "cpu-caterr";
> +			gpios = <&gpio0 ASPEED_GPIO(N, 3) GPIO_ACTIVE_LOW>;
> +			linux,code = <ASPEED_GPIO(N, 3)>;
> +		};
> +
> +		event-cpu-thermtrip {
> +			label = "cpu-thermtrip";
> +			gpios = <&gpio0 ASPEED_GPIO(V, 5) GPIO_ACTIVE_LOW>;
> +			linux,code = <ASPEED_GPIO(V, 5)>;
> +		};
> +
> +		event-psu0-presence {
> +			label = "psu0-presence";
> +			gpios = <&gpio0 ASPEED_GPIO(F, 6) GPIO_ACTIVE_LOW>;
> +			linux,code = <ASPEED_GPIO(F, 6)>;
> +		};
> +
> +		event-psu1-presence {
> +			label = "psu1-presence";
> +			gpios = <&gpio0 ASPEED_GPIO(F, 7) GPIO_ACTIVE_LOW>;
> +			linux,code = <ASPEED_GPIO(F, 7)>;
> +		};
> +
> +		event-psu0-power-ok {
> +			label = "psu0-power-ok";
> +			gpios = <&gpio0 ASPEED_GPIO(M, 4) GPIO_ACTIVE_HIGH>;
> +			linux,code = <ASPEED_GPIO(M, 4)>;
> +		};
> +
> +		event-psu1-power-ok {
> +			label = "psu1-power-ok";
> +			gpios = <&gpio0 ASPEED_GPIO(M, 5) GPIO_ACTIVE_HIGH>;
> +			linux,code = <ASPEED_GPIO(M, 5)>;
> +		};
> +	};
> +
> +	gpio-keys-polled {
> +		compatible = "gpio-keys-polled";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		poll-interval = <1000>;
> +
> +		event-fan0-presence {
> +			label = "fan0-presence";
> +			gpios = <&fan_ioexp 2 GPIO_ACTIVE_LOW>;
> +			linux,code = <2>;
> +		};
> +
> +		event-fan1-presence {
> +			label = "fan1-presence";
> +			gpios = <&fan_ioexp 6 GPIO_ACTIVE_LOW>;
> +			linux,code = <6>;
> +		};
> +
> +		event-fan2-presence {
> +			label = "fan2-presence";
> +			gpios = <&fan_ioexp 10 GPIO_ACTIVE_LOW>;
> +			linux,code = <10>;
> +		};
> +
> +		event-fan3-presence {
> +			label = "fan3-presence";
> +			gpios = <&fan_ioexp 14 GPIO_ACTIVE_LOW>;
> +			linux,code = <14>;
> +		};
> +	};
> +};
> +
> +&mac2 {
> +	status = "okay";
> +	use-ncsi;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_rmii3_default>;
> +	clocks = <&syscon ASPEED_CLK_GATE_MAC3CLK>,
> +		 <&syscon ASPEED_CLK_MAC3RCLK>;
> +	clock-names = "MACCLK", "RCLK";
> +};
> +
> +&fmc {
> +	status = "okay";
> +	flash at 0 {
> +		status = "okay";
> +		m25p,fast-read;
> +		label = "bmc";
> +		spi-max-frequency = <50000000>;
> +#include "openbmc-flash-layout-64.dtsi"
> +	};
> +
> +	flash at 1 {
> +		status = "okay";
> +		m25p,fast-read;
> +		label = "alt-bmc";
> +		spi-max-frequency = <50000000>;
> +#include "openbmc-flash-layout-64-alt.dtsi"
> +	};
> +};
> +
> +&uart1 {
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
> +&kcs3 {
> +	status = "okay";
> +	aspeed,lpc-io-reg = <0xca2>;
> +};
> +
> +&lpc_reset {
> +	status = "okay";
> +};
> +
> +&lpc_ctrl {
> +	status = "okay";
> +};
> +
> +&uart_routing {
> +	status = "okay";
> +};
> +
> +&wdt1 {
> +	status = "okay";
> +};
> +
> +&wdt2 {
> +	status = "okay";
> +};
> +
> +&peci0 {
> +	status = "okay";
> +};
> +
> +&udc {
> +	status = "okay";
> +};
> +
> +&adc0 {
> +	vref = <2500>;
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
> +	vref = <2500>;
> +	status = "okay";
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc9_default
> +		&pinctrl_adc10_default &pinctrl_adc11_default
> +		&pinctrl_adc12_default &pinctrl_adc13_default
> +		&pinctrl_adc14_default &pinctrl_adc15_default>;
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	status = "okay";
> +
> +	temperature-sensor at 48 {
> +		compatible = "national,lm75";
> +		reg = <0x48>;
> +	};
> +
> +	temperature-sensor at 49 {
> +		compatible = "national,lm75";
> +		reg = <0x49>;
> +	};
> +
> +	temperature-sensor at 4c {
> +		compatible = "national,lm86";
> +		reg = <0x4c>;
> +	};
> +};
> +
> +&i2c2 {
> +	status = "okay";
> +
> +	temperature-sensor at 4f {
> +		cpmpatible = "national,lm75";

s/cpmp/comp/

Otherwise:

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
