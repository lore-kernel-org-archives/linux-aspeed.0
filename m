From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 16 May 2023 11:02:53 +0200
Subject: [PATCH v2] ARM: dts: aspeed: Adding Inventec Starscream BMC
In-Reply-To: <f943333cf0b64c2ca10ec27fbba4ca93@inventec.com>
References: <d0cd49b86ba6446e8ed78cbeea0e8c1d>
 <f943333cf0b64c2ca10ec27fbba4ca93@inventec.com>
Message-ID: <2658c8aa-4bb2-fcd5-75c4-08612c8dd5a6@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 16/05/2023 10:46, Chen.PJ ??? TAO wrote:
> Initial introduction of Inventec Starscream x86 family equipped with AST2600 BMC SoC.

Please wrap commit message according to Linux coding style / submission
process (neither too early nor over the limit):
https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597

> 
> Signed-off-by: Chen PJ <Chen.pj@inventec.com>
> 
> ---
> v2:
>  - Correct License description
>  - Remove not supported device
>  - Using openbmc-flash-layout.dtsi
>  - Correct device format
> ---
> ---
>  arch/arm/boot/dts/Makefile                    |   1 +
>  .../dts/aspeed-bmc-inventec-starscream.dts    | 513 ++++++++++++++++++
>  2 files changed, 514 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed-bmc-inventec-starscream.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index eb681903d50b..0002290ae028 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1630,6 +1630,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>  	aspeed-bmc-quanta-s6q.dtb \
>  	aspeed-bmc-supermicro-x11spi.dtb \
>  	aspeed-bmc-inventec-transformers.dtb \
> +	aspeed-bmc-inventec-starscream.dtb \

Please keep alphabetical order.

>  	aspeed-bmc-tyan-s7106.dtb \
>  	aspeed-bmc-tyan-s8036.dtb \
>  	aspeed-bmc-vegman-n110.dtb \
> diff --git a/arch/arm/boot/dts/aspeed-bmc-inventec-starscream.dts b/arch/arm/boot/dts/aspeed-bmc-inventec-starscream.dts
> new file mode 100644
> index 000000000000..a6c733b29d04
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed-bmc-inventec-starscream.dts
> @@ -0,0 +1,513 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +// Copyright 2023 Inventec Corp.
> +
> +/dts-v1/;
> +
> +#include "aspeed-g6.dtsi"
> +#include "aspeed-g6-pinctrl.dtsi"
> +#include <dt-bindings/i2c/i2c.h>
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +
> +/ {
> +	model = "STARSCREAM BMC";
> +	compatible = "inventec,starscream-bmc", "aspeed,ast2600";

Still missing bindings.

> +
> +	aliases {
> +		serial4 = &uart5;
> +	};
> +
> +	chosen {
> +		stdout-path = &uart5;
> +		bootargs = "console=tty0 console=ttyS4,115200n8 root=/dev/ram rw init=/linuxrc";

Drop bootargs. They are not part of hardware description.

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
> +		ssp_memory: ssp_memory {

No underscores in node names.

> +			size = <0x00200000>;
> +			alignment = <0x00100000>;
> +			compatible = "shared-dma-pool";
> +			no-map;
> +		};
> +	};
> +
> +	iio-hwmon {
> +		compatible = "iio-hwmon";
> +		io-channels =
> +		<&adc_u74 0>, // P0_VDD11
> +		<&adc_u74 1>, // P1_VDD11
> +		<&adc_u74 2>, // P0_3V3_S5
> +		<&adc_u74 3>, // P1_3V3_S5
> +		<&adc_u74 4>, // P3V3
> +		<&adc_u74 5>, // VBAT
> +		<&adc_u74 6>, // P3V3_STBY
> +		<&adc_u74 7>, // P5V_STBY
> +		<&adc_u74 8>, // P5V
> +		<&adc_u74 9>, // P12V
> +		<&adc_u74 10>, // P1_VDD18_S5
> +		<&adc_u74 11> // P0_VDD18_S5
> +		;
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		// UID led

Redundant/obvious comment drop.

> +		uid {

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).

> +			label = "UID_LED";
> +			gpios = <&gpio0 ASPEED_GPIO(X, 2) GPIO_ACTIVE_LOW>;
> +		};
> +
> +		// Heart beat led
> +		heartbeat {

Ditto

> +			label = "HB_LED";
> +			gpios = <&gpio0 ASPEED_GPIO(P, 7) GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +};

...

> +
> +		usb_hub:i2c at 0 {

Missing space after label. Fix it everywhere.

> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0>;
> +
> +			// USB U114
> +			usb2512b at 2c {

Node names should be generic. See also explanation and list of examples
in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +				compatible = "microchip,usb2514b";
> +				reg = <0x2c>;
> +			};
> +		};
> +
> +		riser1:i2c at 1 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <1>;
> +		};
> +
> +		riser2:i2c at 2 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <2>;
> +		};
> +
> +		i2c at 3 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <3>;
> +		};
> +	};
> +};
> +
> +&i2c6 {
> +	status = "okay";
> +
> +	// FRU Motherboard
> +	eeprom at 51 {
> +		compatible = "atmel,24c64";
> +		reg = <0x51>;
> +		pagesize = <32>;
> +	};
> +
> +	// ADC_U74
> +	adc_u74:max1139 at 35 {

Node names should be generic. See also explanation and list of examples
in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +		compatible = "maxim,max1139";
> +		reg = <0x35>;
> +		#io-channel-cells = <1>;
> +	};
> +
> +	psu at 58 {
> +		compatible = "pmbus";
> +		reg = <0x58>;
> +	};
> +
> +	psu at 5a {
> +		compatible = "pmbus";
> +		reg = <0x5a>;
> +	};
> +
> +	// Motherboard Temp_U89
> +	tmp421 at 4e {

Node names should be generic. See also explanation and list of examples
in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +		compatible = "ti,tmp421";
> +		reg = <0x4e>;
> +	};
> +
> +	// RunBMC Temp_U6
> +	tmp75 at 49 {

Node names should be generic. See also explanation and list of examples
in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +		compatible = "ti,tmp75";
> +		reg = <0x49>;
> +	};
> +
> +	// Right ear board Temp_U1
> +	emc1412 at 7c {

Node names should be generic. See also explanation and list of examples
in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


Best regards,
Krzysztof

