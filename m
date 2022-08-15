From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Mon, 15 Aug 2022 13:20:27 +0700
Subject: [PATCH v2 2/2] ARM: dts: aspeed: Add device tree for Ampere's Mt.
 Mitchell BMC
In-Reply-To: <5848e2d7-33e1-4093-b70f-b52ef9068083@www.fastmail.com>
References: <20220720085230.3801945-1-quan@os.amperecomputing.com>
 <20220720085230.3801945-3-quan@os.amperecomputing.com>
 <5848e2d7-33e1-4093-b70f-b52ef9068083@www.fastmail.com>
Message-ID: <82b66694-5df0-2458-30a8-656bd1e14bc3@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Thanks Andrew for the review.

On 21/07/2022 09:02, Andrew Jeffery wrote:
> Hello,
> 
> On Wed, 20 Jul 2022, at 18:22, Quan Nguyen wrote:
>> The Mt. Mitchell BMC is an ASPEED AST2600-based BMC for the Mt. Mitchell
>> hardware reference platform with AmpereOne(TM) processor.
>>
>> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
>> Signed-off-by: Phong Vo <phong@os.amperecomputing.com>
>> Signed-off-by: Thang Q. Nguyen <thang@os.amperecomputing.com>
>> ---
>> v2 :
>>    + Remove bootargs                                       [Krzysztof]
>>    + Fix gpio-keys nodes name to conform with device tree binding
>>    documents                                               [Krzysztof]
>>    + Fix some nodes to use generic name                    [Krzysztof]
>>    + Remove unnecessary blank line                         [Krzysztof]
>>    + Fix typo "LTC" to "LLC" in license info and corrected license
>>    info to GPL-2.0-only
>>
>>   arch/arm/boot/dts/Makefile                    |   1 +
>>   .../boot/dts/aspeed-bmc-ampere-mtmitchell.dts | 577 ++++++++++++++++++
>>   2 files changed, 578 insertions(+)
>>   create mode 100644 arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index f9484f5ef126..ecb9dafb8f1a 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -1573,6 +1573,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>>   	aspeed-ast2600-evb.dtb \
>>   	aspeed-bmc-amd-ethanolx.dtb \
>>   	aspeed-bmc-ampere-mtjade.dtb \
>> +	aspeed-bmc-ampere-mtmitchell.dtb \
>>   	aspeed-bmc-arm-centriq2400-rep.dtb \
>>   	aspeed-bmc-arm-stardragon4800-rep2.dtb \
>>   	aspeed-bmc-asrock-e3c246d4i.dtb \
>> diff --git a/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
>> b/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
>> new file mode 100644
>> index 000000000000..2e68f5264bb1
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
>> @@ -0,0 +1,577 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +// Copyright (c) 2022, Ampere Computing LLC
>> +
>> +/dts-v1/;
>> +
>> +#include "aspeed-g6.dtsi"
>> +#include <dt-bindings/gpio/aspeed-gpio.h>
>> +
>> +/ {
>> +	model = "Ampere Mt.Mitchell BMC";
>> +	compatible = "ampere,mtmitchell-bmc", "aspeed,ast2600";
>> +
>> +	chosen {
>> +		stdout-path = &uart5;
>> +	};
>> +
>> +	memory at 80000000 {
>> +		device_type = "memory";
>> +		reg = <0x80000000 0x80000000>;
> 
> This is 2GB of memory
> 
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
> 
> But you say 1GB of memory here
> 

Thank you for the review.

This comment will be removed in next version.

>> +		vga_memory: region at bf000000 {
>> +			no-map;
>> +			compatible = "shared-dma-pool";
>> +			reg = <0xbf000000 0x01000000>;  /* 16M */
> 
> And this makes sense for 1GB.
> 
> So I think your memory node has the wrong length in reg?
> 
>> +		};
>> +	};
>> +
>> +	gpio-keys {
>> +		compatible = "gpio-keys";
>> +
>> +		s0-overtemp-event {
>> +			label = "S0_OVERTEMP";
>> +			gpios = <&gpio0 ASPEED_GPIO(V, 7) GPIO_ACTIVE_LOW>;
>> +			linux,code = <ASPEED_GPIO(V, 7)>;
>> +		};
>> +
>> +		s0-hightemp-event {
>> +			label = "S0_HIGHTEMP";
>> +			gpios = <&gpio0 ASPEED_GPIO(V, 0) GPIO_ACTIVE_LOW>;
>> +			linux,code = <ASPEED_GPIO(V, 0)>;
>> +		};
>> +
>> +		s1-overtemp-event {
>> +			label = "S1_OVERTEMP";
>> +			gpios = <&gpio0 ASPEED_GPIO(X, 6) GPIO_ACTIVE_LOW>;
>> +			linux,code = <ASPEED_GPIO(X, 6)>;
>> +		};
>> +
>> +		s1-hightemp-event {
>> +			label = "S1_HIGHTEMP";
>> +			gpios = <&gpio0 ASPEED_GPIO(X, 3) GPIO_ACTIVE_LOW>;
>> +			linux,code = <ASPEED_GPIO(X, 3)>;
>> +		};
>> +	};
> 
> I really want us to stop using GPIO keys and just poll the GPIO in userspace if necessary.
> 
> The discussion here might help, eventually:
> 
> https://gerrit.openbmc.org/c/openbmc/dbus-sensors/+/54740
> 

Will remove them in next version.

BTW, We are testing with phosphor-multi-gpio-monitor daemon but facing 
issue as there is only one target (we are interesting on both RASING and 
FALLING edge of the gpio) and no extra information passed to the target 
to indicate whether it is on RAISING or FALLING edge of the gpio line.

>> +
>> +	voltage_mon_reg: voltage-mon-regulator {
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
>> +			<&adc_i2c 0>, <&adc_i2c 1>,
>> +			<&adc_i2c 2>, <&adc_i2c 3>,
>> +			<&adc_i2c 4>, <&adc_i2c 5>,
>> +			<&adc_i2c 6>, <&adc_i2c 7>,
>> +			<&adc_i2c 8>, <&adc_i2c 9>,
>> +			<&adc_i2c 10>, <&adc_i2c 11>,
>> +			<&adc_i2c 12>, <&adc_i2c 13>,
>> +			<&adc_i2c 14>, <&adc_i2c 15>;
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
>> +		status = "okay";
>> +		m25p,fast-read;
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
>> +	temperature-sensor at 2e {
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
>> +	adc_i2c: adc-i2c at 16 {
>> +		compatible = "lltc,ltc2497";
>> +		reg = <0x16>;
>> +		vref-supply = <&voltage_mon_reg>;
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
>> +			outlet_temp1: temperature-sensor at 48 {
>> +				compatible = "ti,tmp75";
>> +				reg = <0x48>;
>> +			};
>> +			psu1_inlet_temp2: temperature-sensor at 49 {
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
>> +			pcie_zone_temp1: temperature-sensor at 48 {
>> +				compatible = "ti,tmp75";
>> +				reg = <0x48>;
>> +			};
>> +			psu0_inlet_temp2: temperature-sensor at 49 {
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
>> +			pcie_zone_temp2: temperature-sensor at 48 {
>> +				compatible = "ti,tmp75";
>> +				reg = <0x48>;
>> +			};
>> +			outlet_temp2: temperature-sensor at 49 {
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
>> +			mb_inlet_temp1: temperature-sensor at 7c {
>> +				compatible = "microchip,emc1413";
>> +				reg = <0x7c>;
>> +			};
>> +			mb_inlet_temp2: temperature-sensor at 4c {
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
>> +	bmc_ast2600_cpu: temperature-sensor at 35 {
>> +		compatible = "ti,tmp175";
>> +		reg = <0x35>;
>> +	};
>> +};
>> +
>> +&adc0 {
>> +	ref_voltage = <2500>;
>> +	status = "okay";
>> +
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_adc0_default &pinctrl_adc1_default
>> +		&pinctrl_adc2_default &pinctrl_adc3_default
>> +		&pinctrl_adc4_default &pinctrl_adc5_default
>> +		&pinctrl_adc6_default &pinctrl_adc7_default>;
>> +};
>> +
>> +&adc1 {
>> +	ref_voltage = <2500>;
>> +	status = "okay";
>> +
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc9_default
>> +		&pinctrl_adc10_default &pinctrl_adc11_default
>> +		&pinctrl_adc12_default &pinctrl_adc13_default
>> +		&pinctrl_adc14_default &pinctrl_adc15_default>;
>> +};
>> +
>> +&vhub {
>> +	status = "okay";
>> +};
>> +
>> +&video {
>> +	status = "okay";
>> +	memory-region = <&video_engine_memory>;
>> +};
>> +
>> +&gpio0 {
>> +	gpio-line-names =
>> +	/*A0-A7*/	"","","","","","i2c2-reset-n","i2c6-reset-n","i2c4-reset-n",
>> +	/*B0-B7*/	"","","","","host0-sysreset-n","host0-pmin-n","","",
>> +	/*C0-C7*/	"s0-vrd-fault-n","s1-vrd-fault-n","bmc-debug-mode","",
> 
> Mildly interested in the functionality of "bmc-debug-mode" :)
> 

This gpio will be removed in next version.

>> +			"irq-n","","vrd-sel","spd-sel",
>> +	/*D0-D7*/	"presence-ps0","presence-ps1","hsc-12vmain-alt2-n","ext-high-temp-n",
>> +			"","bmc-ncsi-txen","","",
> 
> Is "bmc-ncsi-txen" something that should be associated with the MAC?
> 
>> +	/*E0-E7*/	"eth-phy-rst-n","eth-phy-int-n","clk50m-bmc-ncsi","","","","","",
> 
> Same question for eth-phy-rst-n and eth-phy-int-n.
> 
These two gpios will be removed in next version as well

>> +	/*F0-F7*/	"s0-pcp-oc-warn-n","s1-pcp-oc-warn-n","power-chassis-control",
>> +			"cpu-bios-recover","cpld-done","hs-scout-proc-hot",
>> +			"s0-vr-hot-n","s1-vr-hot-n",
>> +	/*G0-G7*/	"","","hsc-12vmain-alt1-n","bmc-salt12-s0-ssif-n","","","","",
>> +	/*H0-H7*/	"","fpga-program-b","wd-disable-n","power-chassis-good","","","","",
>> +	/*I0-I7*/	"","","","","","adc-sw","power-button","rtc-battery-voltage-read-enable",
>> +	/*J0-J7*/	"","","","","","","","",
>> +	/*K0-K7*/	"","","","","","","","",
>> +	/*L0-L7*/	"","","","","","","","",
>> +	/*M0-M7*/	"bmc-uart-cts1","s0-ddr-save","soc-spi-nor-access","presence-cpu0",
>> +			"s0-rtc-lock","","","",
> 
> Why isn't "bmc-uart-cts1" muxed into the associated UART? Why is it a GPIO?
> 
Will remove in next version

>> +	/*N0-N7*/	"hpm-fw-recovery","hpm-stby-rst-n","jtag-sel-s0","led-sw-hb",
>> +			"jtag-dbgr-prsnt-n","","","",
>> +	/*O0-O7*/	"","","","","","","","",
>> +	/*P0-P7*/	"ps0-ac-loss-n","ps1-ac-loss-n","","",
>> +			"led-fault","cpld-user-mode","jtag-srst-n","led-bmc-hb",
>> +	/*Q0-Q7*/	"","","","","","","","",
>> +	/*R0-R7*/	"","","","","","","","",
>> +	/*S0-S7*/	"","","identify-button","led-identify",
>> +			"s1-ddr-save","spi-nor-access","sys-pgood","presence-cpu1",
>> +	/*T0-T7*/	"","","","","","","","",
>> +	/*U0-U7*/	"","","","","","","","",
>> +	/*V0-V7*/	"s0-hightemp-n","s0-fault-alert","s0-sys-auth-failure-n",
>> +			"host0-reboot-ack-n","host0-ready","host0-shd-req-n",
>> +			"host0-shd-ack-n","s0-overtemp-n",
>> +	/*W0-W7*/	"ocp-aux-pwren","ocp-main-pwren","ocp-pgood","",
>> +			"bmc-ok","bmc-ready","spi0-program-sel","spi0-backup-sel",
>> +	/*X0-X7*/	"i2c-backup-sel","s1-fault-alert","s1-fw-boot-ok",
>> +			"s1-hightemp-n","s0-spi-auth-fail-n","s1-sys-auth-failure-n",
>> +			"s1-overtemp-n","cpld-s1-spi-auth-fail-n",
>> +	/*Y0-Y7*/	"","","","","","","bmc-spi-fm-boot-abr-pd","host0-special-boot",
>> +	/*Z0-Z7*/	"reset-button","ps0-pgood","ps1-pgood","","","","","";
>> +};
>> +
>> +&gpio1 {
>> +	gpio-line-names =
>> +	/*18A0-18A7*/	"","","","","","","","",
>> +	/*18B0-18B7*/	"","","","","emmc-rst-n","","s0-soc-pgood","",
> 
> "emmc-rst-n" should be specified as part of mmc-pwrseq-emmc, right?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/mmc/mmc-pwrseq-emmc.yaml?h=v5.19-rc7
> 

Agree, this pin should be part of mmc-pwrseq-emmc and will be removed in 
next version.

Thanks a lot for the comment.
- Quan
