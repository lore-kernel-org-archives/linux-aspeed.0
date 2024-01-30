From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 30 Jan 2024 11:39:11 +0100
Subject: [PATCH] ARM: dts: aspeed: asus: Add ASUS X4TF BMC
In-Reply-To: <20240130085652.198010-2-Kelly_Hung@asus.com>
References: <20240130085652.198010-1-Kelly_Hung@asus.com>
 <20240130085652.198010-2-Kelly_Hung@asus.com>
Message-ID: <3edf1a47-9f73-4e99-98ea-182248102346@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 30/01/2024 09:56, Kelly Hung wrote:
> From: kelly1732000 <Kelly_Hung@asus.com>
> 
> This initial device-tree provides the necessary configuration for
> basic BMC functionality and work on ASUS X4TF production.
> 
> Signed-off-by: kelly1732000 <Kelly_Hung@asus.com>
> ---
>  .../boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts  | 828 ++++++++++++++++++
>  1 file changed, 828 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts

It's impossible to test this file. You miss Makefile.

> 
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts
> new file mode 100644
> index 000000000000..723bbb33137f
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts
> @@ -0,0 +1,828 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +// Copyright 2023 ASUS Corp.
> +/dts-v1/;
> +
> +#include "aspeed-g6.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +#include <dt-bindings/i2c/i2c.h>
> +
> +
> +/ {
> +	model = "ASUS-X4TF";
> +	compatible = "asus,x4tf", "aspeed,ast2600";
> +
> +	chosen {
> +		stdout-path = &uart5;
> +		bootargs = "console=ttyS4,115200n8 earlycon";

earlycon is a debugging feature, not mainline. Also, move console to
stdout-path, so entire bootargs can be dropped.

> +	};
> +
> +	memory at 80000000 {
> +		device_type = "memory";
> +		reg = <0x80000000 0x40000000>;
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		gfx_memory: framebuffer {
> +			size = <0x01000000>;
> +			alignment = <0x01000000>;
> +			compatible = "shared-dma-pool";
> +			reusable;
> +		};
> +
> +		video_engine_memory: video {
> +			size = <0x04000000>;
> +			alignment = <0x01000000>;
> +			compatible = "shared-dma-pool";
> +			reusable;
> +		};
> +
> +		rvas_memory: rvas {
> +			size = <0x04000000>;
> +			alignment = <0x01000000>;
> +			compatible = "shared-dma-pool";
> +			reusable;
> +		};
> +
> +		bmc_dev_memory: bmc_dev_memory {

No underscores in node names. This applies everywhere.


> +			size = <0x00100000>;
> +			alignment = <0x00100000>;
> +			compatible = "shared-dma-pool";
> +			no-map;
> +		};
> +
> +		pci_msi_memory: pci_msi_memory {
> +			no-map;
> +			reg = <0x9e770000 0x100>;
> +			compatible = "shared-dma-pool";
> +		};
> +		/* 1GB memory */
> +		vga_memory: region at bf000000 {
> +			no-map;
> +			compatible = "shared-dma-pool";
> +			reg = <0xbf000000 0x01000000>;  /* 16M */
> +		};
> +		ssp_memory: ssp_memory {
> +			size = <0x02000000>;
> +			alignment = <0x01000000>;
> +			compatible = "shared-dma-pool";
> +			no-map;
> +		};
> +	};
> +
> +	vcc_sdhci0: regulator-vcc-sdhci0 {
> +		compatible = "regulator-fixed";
> +		status = "disabled";

Why? It makes it entirely pointless.

> +		regulator-name = "SDHCI0 Vcc";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpios = <&gpio0 ASPEED_GPIO(V, 0) GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	vccq_sdhci0: regulator-vccq-sdhci0 {
> +		compatible = "regulator-gpio";
> +		status = "disabled";

Pointless node.

> +		regulator-name = "SDHCI0 VccQ";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpios = <&gpio0 ASPEED_GPIO(V, 1) GPIO_ACTIVE_HIGH>;
> +		gpios-states = <1>;
> +		states = <3300000 1>,
> +			 <1800000 0>;
> +	};
> +
> +	vcc_sdhci1: regulator-vcc-sdhci1 {
> +		compatible = "regulator-fixed";
> +		status = "disabled";

Pointless node.


> +		regulator-name = "SDHCI1 Vcc";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpios = <&gpio0 ASPEED_GPIO(V, 2) GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	vccq_sdhci1: regulator-vccq-sdhci1 {
> +		compatible = "regulator-gpio";
> +		status = "disabled";

Pointless node.

> +		regulator-name = "SDHCI1 VccQ";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpios = <&gpio0 ASPEED_GPIO(V, 3) GPIO_ACTIVE_HIGH>;
> +		gpios-states = <1>;
> +		states = <3300000 1>,
> +			 <1800000 0>;
> +	};

Missing blank line.

> +	iio-hwmon {
> +		compatible = "iio-hwmon";
> +		io-channels = <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
> +				<&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
> +				<&adc1 0>, <&adc1 1>, <&adc1 2>, <&adc1 3>,
> +				<&adc1 4>, <&adc1 5>, <&adc1 6>, <&adc1 7>;
> +	};
> +> +	video-engine at 1e700000 {

Wrong placement. Also tools would tell you that.

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check W=1` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

> +		compatible = "aspeed,ast2600-video-engine";
> +		reg = <0x1e700000 0x20000>;
> +		clocks = <&syscon ASPEED_CLK_GATE_VCLK>, <&syscon ASPEED_CLK_GATE_ECLK>;
> +		clock-names = "vclk", "eclk";
> +		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +		memory-region = <&video_engine_memory>;
> +		//resets = <&syscon ASPEED_RESET_VIDEO>;

Dead code.

> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		heartbeat {

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check W=1` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

> +			gpios = <&gpio0 ASPEED_GPIO(P, 7) GPIO_ACTIVE_LOW>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +		uid_led {

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check W=1` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

> +			gpios = <&gpio0 ASPEED_GPIO(P, 1) (GPIO_ACTIVE_LOW | GPIO_OPEN_DRAIN)>;
> +			default-state = "off";
> +		};

Missing blank line, everywhere.

> +		status_Y {
> +			gpios = <&gpio1 ASPEED_GPIO(B, 1) GPIO_ACTIVE_LOW>;
> +			default-state = "off";
> +		};
> +		sys_boot_status {
> +			gpios = <&gpio1 ASPEED_GPIO(B, 0) GPIO_ACTIVE_LOW>;
> +			default-state = "off";
> +		};
> +	};
> +	spigpio {

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check W=1` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).


> +		status = "okay";

Why?

> +		compatible = "spi-gpio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		sck-gpios = <&gpio0 ASPEED_GPIO(Z, 3) GPIO_ACTIVE_HIGH>;
> +		mosi-gpios = <&gpio0 ASPEED_GPIO(Z, 4) GPIO_ACTIVE_HIGH>;
> +		miso-gpios = <&gpio0 ASPEED_GPIO(Z, 5) GPIO_ACTIVE_HIGH>;
> +		num-chipselects = <1>;
> +		cs-gpios = <&gpio0 ASPEED_GPIO(Z, 0) GPIO_ACTIVE_HIGH>;
> +	};
> +

Redundant blank line.

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
> +&peci0 {
> +	status = "okay";
> +};
> +
> +&lpc_snoop {
> +	snoop-ports = <0x80>;
> +	status = "okay";
> +};
> +
> +

Redundant blank line. Clean this code before sending upstream from such
trivialities.

> +&mdio0 {
> +	status = "disabled";
> +};
> +
> +
> +&mdio1 {
> +	status = "disabled";
> +};
> +
> +&mdio2 {
> +	status = "okay";
> +
> +	ethphy2: ethernet-phy at 0 {
> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <0>;
> +	};
> +};
> +
> +&mdio3 {
> +	status = "okay";
> +
> +	ethphy3: ethernet-phy at 0 {
> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <0>;
> +	};
> +};
> +
> +&mac0 {
> +	status = "disabled";
> +};
> +
> +&mac1 {
> +	status = "disabled";
> +};
> +
> +//for X4TF
> +&mac2 {
> +	status = "okay";
> +	phy-mode = "rmii";
> +	#phy-handle = <&ethphy2>;
> +	use-ncsi;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_rmii3_default>;
> +};
> +
> +

Ditto

> +&mac3 {
> +	status = "okay";
> +	phy-mode = "rmii";
> +	#phy-handle = <&ethphy3>;
> +	use-ncsi;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_rmii4_default>;
> +};
> +
> +

Ditto

> +&syscon {
> +	uart-clock-high-speed;

That's a syscon property?

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check W=1` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

> +	status = "okay";
> +};
> +
> +&rtc {
> +	status = "disabled";
> +};
> +
> +&fmc {
> +	status = "okay";
> +	flash at 0 {
> +		status = "okay";

Drop. Everywhere where it is not needed.


> +		m25p,fast-read;
> +		label = "bmc-spi";
> +		spi-max-frequency = <50000000>;
> +		spi-bus-width = <1>;
> +		partitions {
> +			compatible = "fixed-partitions";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			bmc at 0 {
> +				label = "bmc";
> +				reg = <0x0 0x4000000>;
> +			};
> +			u-boot at 0 {
> +				label = "u-boot";
> +				reg = <0x0 0x200000>;
> +			};
> +			u-boot-env at 1f0000 {
> +				label = "u-boot-env";
> +				reg = <0x1f0000 0x10000>;
> +			};
> +			kernel at 200000 {
> +				label = "kernel";
> +				reg = <0x200000 0xc00000>;
> +			};
> +			rofs at a00000 {
> +				label = "rofs";
> +				reg = <0xa00000 0x2a00000>;
> +			};
> +			rwfs at 2a00000 {
> +				label = "rwfs";
> +				reg = <0x2a00000 0x43f0000>;
> +			};
> +		};
> +	};
> +};
> +
> +&spi1 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_spi1_default>;
> +
> +	flash at 0 {
> +		status = "okay";
> +		w25q256,fast-read;
> +		label = "bios-spi";
> +		spi-max-frequency = <50000000>;
> +		partitions {
> +			compatible = "fixed-partitions";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			biosfullimg at 0 {
> +				reg = <0x0 0x2000000>; //  32768 *1024 = 0x2000000, 32 MB
> +				label = "biosfullimg";
> +			};
> +		};
> +	};
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	status = "okay";
> +};
> +
> +&i2c2 {
> +	status = "okay";
> +};
> +
> +&i2c3 {
> +	status = "okay";
> +};
> +
> +&i2c4 {
> +	status = "okay";
> +	tmp75 at 48 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation



> +		compatible = "ti,tmp75";
> +		reg = <0x48>;
> +	};
> +	tmp75 at 49 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

I am going to skip the rest. Please fix all the trivialities and test
your patches with tools.

Best regards,
Krzysztof

