From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Mon, 27 Jun 2022 16:32:49 +0700
Subject: [PATCH] ARM: dts: aspeed: Add device tree for Ampere's Mt.
 Mitchell BMC
In-Reply-To: <97934f38-4da5-ab9e-7089-d6e48edd5e6a@linaro.org>
References: <20220621092120.2427152-1-quan@os.amperecomputing.com>
 <97934f38-4da5-ab9e-7089-d6e48edd5e6a@linaro.org>
Message-ID: <9120c167-38c2-f8c4-e039-4202d5844639@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 24/06/2022 22:51, Krzysztof Kozlowski wrote:
> On 21/06/2022 11:21, Quan Nguyen wrote:
>> The Mt. Mitchell BMC is an ASPEED AST2600-based BMC for the Mt. Mitchell
>> hardware reference platform with AmpereOne(TM) processor.
>>
>> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
>> Signed-off-by: Phong Vo <phong@os.amperecomputing.com>
>> Signed-off-by: Thang Q. Nguyen <thang@os.amperecomputing.com>
>> ---
>>   arch/arm/boot/dts/Makefile                    |   1 +
>>   .../boot/dts/aspeed-bmc-ampere-mtmitchell.dts | 579 ++++++++++++++++++
>>   2 files changed, 580 insertions(+)
>>   create mode 100644 arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index 5112f493f494..93c236c14fa0 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -1558,6 +1558,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>>   	aspeed-ast2600-evb.dtb \
>>   	aspeed-bmc-amd-ethanolx.dtb \
>>   	aspeed-bmc-ampere-mtjade.dtb \
>> +	aspeed-bmc-ampere-mtmitchell.dtb \
>>   	aspeed-bmc-arm-centriq2400-rep.dtb \
>>   	aspeed-bmc-arm-stardragon4800-rep2.dtb \
>>   	aspeed-bmc-asrock-e3c246d4i.dtb \
>> diff --git a/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts b/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
>> new file mode 100644
>> index 000000000000..42425e13030a
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
>> @@ -0,0 +1,579 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +// Copyright 2022 Ampere Computing LTC.
>> +
>> +/dts-v1/;
>> +
>> +#include "aspeed-g6.dtsi"
>> +#include <dt-bindings/gpio/aspeed-gpio.h>
>> +
>> +/ {
>> +	model = "Ampere Mt.Mitchell BMC";
>> +	compatible = "ampere,mtmitchell-bmc", "aspeed,ast2600";
> 
> The compatible has to be documented. Please rebase on top of:
> https://lore.kernel.org/all/20220529104928.79636-3-krzysztof.kozlowski at linaro.org/
> 
Thanks Krzysztof for the review.

Will rebase and add compatible string as a separate patch in next version.

>> +
>> +	chosen {
>> +		stdout-path = &uart5;
>> +		bootargs = "console=ttyS4,115200n8 earlycon";
> 
> console is not needed, earlycon is debugging tool so definitely should
> not go to mainline widely distributed DTS. Remove entire bootargs.
> 
Will do.

>> +	};
>> +
>> +	memory at 80000000 {
>> +		device_type = "memory";
>> +		reg = <0x80000000 0x80000000>;
>> +	};
>> +
>> +	reserved-memory {
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges;
>> +
>> +		gfx_memory: framebuffer {
>> +			size = <0x01000000>;
>> +			alignment = <0x01000000>;
>> +			compatible = "shared-dma-pool";
>> +			reusable;
>> +		};
>> +
>> +		video_engine_memory: video {
>> +			size = <0x04000000>;
>> +			alignment = <0x01000000>;
>> +			compatible = "shared-dma-pool";
>> +			reusable;
>> +		};
>> +
>> +		/* 1GB memory */
>> +		vga_memory: region at bf000000 {
>> +			no-map;
>> +			compatible = "shared-dma-pool";
>> +			reg = <0xbf000000 0x01000000>;  /* 16M */
>> +		};
>> +
> 
> No need for blank line.
> 
Will fix.

>> +	};
>> +
>> +	gpio-keys {
>> +		compatible = "gpio-keys";
>> +
>> +		S0_overtemp {
> 
> Only lower-case letters, no underscore but hyphen. Missing prefix (e.g.
> key/event/switch/button)
> 
> See:
> https://lore.kernel.org/all/20220616005224.18391-1-krzysztof.kozlowski at linaro.org/
> 
> 
Will fix them to s[0|1]-[overtemp|hightemp]-event in next version.

>> +			label = "S0_OVERTEMP";
>> +			gpios = <&gpio0 ASPEED_GPIO(V, 7) GPIO_ACTIVE_LOW>;
>> +			linux,code = <ASPEED_GPIO(V, 7)>;
>> +		};
>> +
>> +		S0_hightemp {
>> +			label = "S0_HIGHTEMP";
>> +			gpios = <&gpio0 ASPEED_GPIO(V, 0) GPIO_ACTIVE_LOW>;
>> +			linux,code = <ASPEED_GPIO(V, 0)>;
>> +		};
>> +
>> +		S1_overtemp {
>> +			label = "S1_OVERTEMP";
>> +			gpios = <&gpio0 ASPEED_GPIO(X, 6) GPIO_ACTIVE_LOW>;
>> +			linux,code = <ASPEED_GPIO(X, 6)>;
>> +		};
>> +
>> +		S1_hightemp {
>> +			label = "S1_HIGHTEMP";
>> +			gpios = <&gpio0 ASPEED_GPIO(X, 3) GPIO_ACTIVE_LOW>;
>> +			linux,code = <ASPEED_GPIO(X, 3)>;
>> +		};
>> +	};
>> +
>> +	ltc2497_reg: ltc2497_regulator {
> 
> No underscores in node name, no specific names (Devicetree spec requires
> generic), so ltc2497 has to go. You could add some more specific
> prefix/suffix to describe the function.
> 
This is to monitor peripheral voltage so it would be updated to:

          voltage_monitor: voltage-monitor {

>> +		compatible = "regulator-fixed";
>> +		regulator-name = "ltc2497_reg";
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +		regulator-always-on;
>> +	};
>> +
>> +	gpioI5mux: mux-controller {
>> +		compatible = "gpio-mux";
>> +		#mux-control-cells = <0>;
>> +		mux-gpios = <&gpio0 ASPEED_GPIO(I, 5) GPIO_ACTIVE_HIGH>;
>> +	};
>> +
>> +	adc0mux: adc0mux {
>> +		compatible = "io-channel-mux";
>> +		io-channels = <&adc0 0>;
>> +		#io-channel-cells = <1>;
>> +		io-channel-names = "parent";
>> +		mux-controls = <&gpioI5mux>;
>> +		channels = "s0", "s1";
>> +	};
>> +
>> +	adc1mux: adc1mux {
>> +		compatible = "io-channel-mux";
>> +		io-channels = <&adc0 1>;
>> +		#io-channel-cells = <1>;
>> +		io-channel-names = "parent";
>> +		mux-controls = <&gpioI5mux>;
>> +		channels = "s0", "s1";
>> +	};
>> +
>> +	adc2mux: adc2mux {
>> +		compatible = "io-channel-mux";
>> +		io-channels = <&adc0 2>;
>> +		#io-channel-cells = <1>;
>> +		io-channel-names = "parent";
>> +		mux-controls = <&gpioI5mux>;
>> +		channels = "s0", "s1";
>> +	};
>> +
>> +	adc3mux: adc3mux {
>> +		compatible = "io-channel-mux";
>> +		io-channels = <&adc0 3>;
>> +		#io-channel-cells = <1>;
>> +		io-channel-names = "parent";
>> +		mux-controls = <&gpioI5mux>;
>> +		channels = "s0", "s1";
>> +	};
>> +
>> +	adc4mux: adc4mux {
>> +		compatible = "io-channel-mux";
>> +		io-channels = <&adc0 4>;
>> +		#io-channel-cells = <1>;
>> +		io-channel-names = "parent";
>> +		mux-controls = <&gpioI5mux>;
>> +		channels = "s0", "s1";
>> +	};
>> +
>> +	adc5mux: adc5mux {
>> +		compatible = "io-channel-mux";
>> +		io-channels = <&adc0 5>;
>> +		#io-channel-cells = <1>;
>> +		io-channel-names = "parent";
>> +		mux-controls = <&gpioI5mux>;
>> +		channels = "s0", "s1";
>> +	};
>> +
>> +	adc6mux: adc6mux {
>> +		compatible = "io-channel-mux";
>> +		io-channels = <&adc0 6>;
>> +		#io-channel-cells = <1>;
>> +		io-channel-names = "parent";
>> +		mux-controls = <&gpioI5mux>;
>> +		channels = "s0", "s1";
>> +	};
>> +
>> +	adc7mux: adc7mux {
>> +		compatible = "io-channel-mux";
>> +		io-channels = <&adc0 7>;
>> +		#io-channel-cells = <1>;
>> +		io-channel-names = "parent";
>> +		mux-controls = <&gpioI5mux>;
>> +		channels = "s0", "s1";
>> +	};
>> +
>> +	adc8mux: adc8mux {
>> +		compatible = "io-channel-mux";
>> +		io-channels = <&adc1 0>;
>> +		#io-channel-cells = <1>;
>> +		io-channel-names = "parent";
>> +		mux-controls = <&gpioI5mux>;
>> +		channels = "s0", "s1";
>> +	};
>> +
>> +	adc9mux: adc9mux {
>> +		compatible = "io-channel-mux";
>> +		io-channels = <&adc1 1>;
>> +		#io-channel-cells = <1>;
>> +		io-channel-names = "parent";
>> +		mux-controls = <&gpioI5mux>;
>> +		channels = "s0", "s1";
>> +	};
>> +
>> +	adc10mux: adc10mux {
>> +		compatible = "io-channel-mux";
>> +		io-channels = <&adc1 2>;
>> +		#io-channel-cells = <1>;
>> +		io-channel-names = "parent";
>> +		mux-controls = <&gpioI5mux>;
>> +		channels = "s0", "s1";
>> +	};
>> +
>> +	adc11mux: adc11mux {
>> +		compatible = "io-channel-mux";
>> +		io-channels = <&adc1 3>;
>> +		#io-channel-cells = <1>;
>> +		io-channel-names = "parent";
>> +		mux-controls = <&gpioI5mux>;
>> +		channels = "s0", "s1";
>> +	};
>> +
>> +	adc12mux: adc12mux {
>> +		compatible = "io-channel-mux";
>> +		io-channels = <&adc1 4>;
>> +		#io-channel-cells = <1>;
>> +		io-channel-names = "parent";
>> +		mux-controls = <&gpioI5mux>;
>> +		channels = "s0", "s1";
>> +	};
>> +
>> +	adc13mux: adc13mux {
>> +		compatible = "io-channel-mux";
>> +		io-channels = <&adc1 5>;
>> +		#io-channel-cells = <1>;
>> +		io-channel-names = "parent";
>> +		mux-controls = <&gpioI5mux>;
>> +		channels = "s0", "s1";
>> +	};
>> +
>> +	adc14mux: adc14mux {
>> +		compatible = "io-channel-mux";
>> +		io-channels = <&adc1 6>;
>> +		#io-channel-cells = <1>;
>> +		io-channel-names = "parent";
>> +		mux-controls = <&gpioI5mux>;
>> +		channels = "s0", "s1";
>> +	};
>> +
>> +	adc15mux: adc15mux {
>> +		compatible = "io-channel-mux";
>> +		io-channels = <&adc1 7>;
>> +		#io-channel-cells = <1>;
>> +		io-channel-names = "parent";
>> +		mux-controls = <&gpioI5mux>;
>> +		channels = "s0", "s1";
>> +	};
>> +
>> +	iio-hwmon {
>> +		compatible = "iio-hwmon";
>> +		io-channels = <&adc0mux 0>, <&adc0mux 1>,
>> +			<&adc1mux 0>, <&adc1mux 1>,
>> +			<&adc2mux 0>, <&adc2mux 1>,
>> +			<&adc3mux 0>, <&adc3mux 1>,
>> +			<&adc4mux 0>, <&adc4mux 1>,
>> +			<&adc5mux 0>, <&adc5mux 1>,
>> +			<&adc6mux 0>, <&adc6mux 1>,
>> +			<&adc7mux 0>, <&adc7mux 1>,
>> +			<&adc8mux 0>, <&adc8mux 1>,
>> +			<&adc9mux 0>, <&adc9mux 1>,
>> +			<&adc10mux 0>, <&adc10mux 1>,
>> +			<&adc11mux 0>, <&adc11mux 1>,
>> +			<&adc12mux 0>, <&adc12mux 1>,
>> +			<&adc13mux 0>, <&adc13mux 1>,
>> +			<&adc14mux 0>, <&adc14mux 1>,
>> +			<&adc15mux 0>, <&adc15mux 1>,
>> +			<&ltc2497 0>, <&ltc2497 1>,
>> +			<&ltc2497 2>, <&ltc2497 3>,
>> +			<&ltc2497 4>, <&ltc2497 5>,
>> +			<&ltc2497 6>, <&ltc2497 7>,
>> +			<&ltc2497 8>, <&ltc2497 9>,
>> +			<&ltc2497 10>, <&ltc2497 11>,
>> +			<&ltc2497 12>, <&ltc2497 13>,
>> +			<&ltc2497 14>, <&ltc2497 15>;
>> +	};
>> +};
>> +
>> +&mdio0 {
>> +	status = "okay";
>> +
>> +	ethphy0: ethernet-phy at 0 {
>> +		compatible = "ethernet-phy-ieee802.3-c22";
>> +		reg = <0>;
>> +	};
>> +};
>> +
>> +&mac0 {
>> +	status = "okay";
>> +
>> +	phy-mode = "rgmii";
>> +	phy-handle = <&ethphy0>;
>> +
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_rgmii1_default>;
>> +};
>> +
>> +&fmc {
>> +	status = "okay";
>> +	flash at 0 {
>> +		status = "okay";> +		m25p,fast-read;
>> +		label = "bmc";
>> +		spi-max-frequency = <50000000>;
>> +#include "openbmc-flash-layout-64.dtsi"
>> +	};
>> +
>> +	flash at 1 {
>> +		status = "okay";
>> +		m25p,fast-read;
>> +		label = "alt-bmc";
>> +		spi-max-frequency = <50000000>;
>> +#include "openbmc-flash-layout-64-alt.dtsi"
>> +	};
>> +};
>> +
>> +&spi1 {
>> +	status = "okay";
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_spi1_default>;
>> +
>> +	flash at 0 {
>> +		status = "okay";
>> +		m25p,fast-read;
>> +		label = "pnor";
>> +		spi-max-frequency = <20000000>;
>> +	};
>> +};
>> +
>> +&uart1 {
>> +	status = "okay";
>> +};
>> +
>> +&uart2 {
>> +	status = "okay";
>> +};
>> +
>> +&uart3 {
>> +	status = "okay";
>> +};
>> +
>> +&uart4 {
>> +	status = "okay";
>> +};
>> +
>> +&i2c0 {
>> +	status = "okay";
>> +
>> +	temp at 2e {
> 
> Generic node name, so usually it is "temperature-sensor"
> 
Will change all tmp75 and tmp175 nodes name to temperature-sensor in 
next version.

Thanks a lot for the comment.
- Quan

>> +		compatible = "adi,adt7490";
>> +		reg = <0x2e>;
>> +	};
>> +};
>> +
>> +&i2c1 {
>> +	status = "okay";
>> +};
>> +
>> +&i2c2 {
>> +	status = "okay";
>> +
>> +	psu at 58 {
>> +		compatible = "pmbus";
>> +		reg = <0x58>;
>> +	};
>> +
>> +	psu at 59 {
>> +		compatible = "pmbus";
>> +		reg = <0x59>;
>> +	};
>> +};
>> +
>> +&i2c3 {
>> +	status = "okay";
>> +};
>> +
>> +&i2c4 {
>> +	status = "okay";
>> +
>> +	ltc2497: ltc2497 at 16 {
> 
> Generic node name.
> 
>> +		compatible = "lltc,ltc2497";
>> +		reg = <0x16>;
>> +		vref-supply = <&ltc2497_reg>;
>> +		#io-channel-cells = <1>;
>> +		status = "okay";
>> +	 };
>> +
>> +	eeprom at 50 {
>> +		compatible = "atmel,24c64";
>> +		reg = <0x50>;
>> +		pagesize = <32>;
>> +	};
>> +
>> +	i2c-mux at 70 {
>> +		compatible = "nxp,pca9545";
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +		reg = <0x70>;
>> +		i2c-mux-idle-disconnect;
>> +
>> +		i2c4_bus70_chn0: i2c at 0 {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			reg = <0x0>;
>> +
>> +			outlet_temp1: tmp75 at 48 {
> 
> Generic node name.
> 
>> +				compatible = "ti,tmp75";
>> +				reg = <0x48>;
>> +			};
>> +			psu1_inlet_temp2: tmp75 at 49 {
> 
> Generic node name.
> 
>> +				compatible = "ti,tmp75";
>> +				reg = <0x49>;
>> +			};
>> +		};
>> +
>> +		i2c4_bus70_chn1: i2c at 1 {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			reg = <0x1>;
>> +
>> +			pcie_zone_temp1: tmp75 at 48 {
> 
> Generic node name.
> 
>> +				compatible = "ti,tmp75";
>> +				reg = <0x48>;
>> +			};
>> +			psu0_inlet_temp2: tmp75 at 49 {
> 
> Generic node name.
> 
>> +				compatible = "ti,tmp75";
>> +				reg = <0x49>;
>> +			};
>> +		};
>> +
>> +		i2c4_bus70_chn2: i2c at 2 {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			reg = <0x2>;
>> +
>> +			pcie_zone_temp2: tmp75 at 48 {
> 
> Generic node name.
> 
>> +				compatible = "ti,tmp75";
>> +				reg = <0x48>;
>> +			};
>> +			outlet_temp2: tmp75 at 49 {
> 
> Generic node name.
> 
>> +				compatible = "ti,tmp75";
>> +				reg = <0x49>;
>> +			};
>> +		};
>> +
>> +		i2c4_bus70_chn3: i2c at 3 {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			reg = <0x3>;
>> +
>> +			mb_inlet_temp1: tmp75 at 7c {
> 
> Generic node name.
> 
>> +				compatible = "microchip,emc1413";
>> +				reg = <0x7c>;
>> +			};
>> +			mb_inlet_temp2: tmp75 at 4c {
> 
> Generic node name.
> 
>> +				compatible = "microchip,emc1413";
>> +				reg = <0x4c>;
>> +			};
>> +		};
>> +	};
>> +};
>> +
>> +&i2c5 {
>> +	status = "okay";
>> +
>> +	i2c-mux at 70 {
>> +		compatible = "nxp,pca9548";
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +		reg = <0x70>;
>> +		i2c-mux-idle-disconnect;
>> +	};
>> +};
>> +
>> +&i2c6 {
>> +	status = "okay";
>> +	rtc at 51 {
>> +		compatible = "nxp,pcf85063a";
>> +		reg = <0x51>;
>> +	};
>> +};
>> +
>> +&i2c7 {
>> +	status = "okay";
>> +};
>> +
>> +&i2c9 {
>> +	status = "okay";
>> +};
>> +
>> +&i2c11 {
>> +	status = "okay";
>> +};
>> +
>> +&i2c14 {
>> +	status = "okay";
>> +	eeprom at 50 {
>> +		compatible = "atmel,24c64";
>> +		reg = <0x50>;
>> +		pagesize = <32>;
>> +	};
>> +
>> +	bmc_ast2600_cpu: tmp175 at 35 {
> 
> Generic node name.
> 
> Best regards,
> Krzysztof

