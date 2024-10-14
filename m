From: Chanh Nguyen <chanh@amperemail.onmicrosoft.com>
Date: Mon, 14 Oct 2024 17:54:57 +0700
Subject: [PATCH] ARM: dts: aspeed: Add device tree for Ampere's Mt.
 Jefferson BMC
In-Reply-To: <20241014105031.1963079-1-chanh@os.amperecomputing.com>
References: <20241014105031.1963079-1-chanh@os.amperecomputing.com>
Message-ID: <ea9e34ec-c557-4616-a95e-7b20229db03a@amperemail.onmicrosoft.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi @Andrew, I just upstreamed the patch 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/Documentation/devicetree/bindings/trivial-devices.yaml?id=3d973b98d2744cfced1f06167c83e2cc2d7b63d5 
 ?to linux-next branch,? I think we also need to pick it up to 
https://github.com/openbmc/linux/tree/dev-6.6, which will help pass the 
"onnn,adt7462" compatible warning log from the dt_binding_check tool.

On 14/10/2024 17:50, Chanh Nguyen wrote:
> The Mt. Jefferson BMC is an ASPEED AST2600-based BMC for the Mt. Jefferson
> hardware reference platform with AmpereOne(TM)M processor.
> 
> Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
> ---
>   arch/arm/boot/dts/aspeed/Makefile             |   1 +
>   .../aspeed/aspeed-bmc-ampere-mtjefferson.dts  | 646 ++++++++++++++++++
>   2 files changed, 647 insertions(+)
>   create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dts
> 
> diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
> index c4f064e4b073..b1fb0853a789 100644
> --- a/arch/arm/boot/dts/aspeed/Makefile
> +++ b/arch/arm/boot/dts/aspeed/Makefile
> @@ -6,6 +6,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>   	aspeed-bmc-amd-daytonax.dtb \
>   	aspeed-bmc-amd-ethanolx.dtb \
>   	aspeed-bmc-ampere-mtjade.dtb \
> +	aspeed-bmc-ampere-mtjefferson.dtb \
>   	aspeed-bmc-ampere-mtmitchell.dtb \
>   	aspeed-bmc-arm-stardragon4800-rep2.dtb \
>   	aspeed-bmc-asrock-e3c246d4i.dtb \
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dts
> new file mode 100644
> index 000000000000..f24111ab9e65
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dts
> @@ -0,0 +1,646 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Copyright 2024 Ampere Computing LLC.
> +
> +/dts-v1/;
> +
> +#include "aspeed-g6.dtsi"
> +#include <dt-bindings/i2c/i2c.h>
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +
> +/ {
> +	model = "Ampere Mt. Jefferson BMC";
> +	compatible = "ampere,mtjefferson-bmc", "aspeed,ast2600";
> +
> +	aliases {
> +		i2c20 = &i2c4_bus70_chn0;
> +		i2c22 = &i2c4_bus70_chn2;
> +		i2c24 = &i2c2_bus70_chn0;
> +
> +		/*
> +		 *  I2C OCP alias port
> +		 */
> +		i2c30 = &ocpslot;
> +
> +		/*
> +		 *  I2C NVMe alias port
> +		 */
> +		i2c48 = &nvmeslot_0;
> +		i2c49 = &nvmeslot_1;
> +		i2c50 = &nvmeslot_2;
> +		i2c51 = &nvmeslot_3;
> +		i2c52 = &nvmeslot_4;
> +		i2c53 = &nvmeslot_5;
> +		i2c54 = &nvmeslot_6;
> +		i2c55 = &nvmeslot_7;
> +		i2c56 = &nvmeslot_8;
> +		i2c57 = &nvmeslot_9;
> +		i2c58 = &nvmeslot_10;
> +		i2c59 = &nvmeslot_11;
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
> +		vga_memory: region at bf000000 {
> +			no-map;
> +			compatible = "shared-dma-pool";
> +			reg = <0xbf000000 0x01000000>;  /* 16M */
> +		};
> +	};
> +
> +	voltage_mon_reg: voltage-mon-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "ltc2497_reg";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		led-bmc-ready {
> +			gpios = <&gpio0 ASPEED_GPIO(W, 5) (GPIO_ACTIVE_HIGH | GPIO_TRANSITORY)>;
> +		};
> +
> +		led-sw-heartbeat {
> +			gpios = <&gpio0 ASPEED_GPIO(N, 3) GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		led-identify {
> +			gpios = <&gpio0 ASPEED_GPIO(S, 3) GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		led-fault {
> +			gpios = <&gpio0 ASPEED_GPIO(P, 4) GPIO_ACTIVE_HIGH>;
> +		};
> +	};
> +
> +	iio-hwmon {
> +		compatible = "iio-hwmon";
> +		io-channels =   <&adc0 0>, <&adc0 1>, <&adc0 2>,
> +				<&adc_i2c_2 0>, <&adc_i2c_2 1>,
> +				<&adc_i2c_2 2>, <&adc_i2c_2 3>,
> +				<&adc_i2c_2 4>, <&adc_i2c_2 5>,
> +				<&adc_i2c_2 6>, <&adc_i2c_2 7>,
> +				<&adc_i2c_2 8>, <&adc_i2c_2 9>,
> +				<&adc_i2c_2 10>, <&adc_i2c_2 11>,
> +				<&adc_i2c_2 12>, <&adc_i2c_2 13>,
> +				<&adc_i2c_2 14>, <&adc_i2c_2 15>,
> +				<&adc_i2c_0 0>, <&adc_i2c_0 1>,
> +				<&adc_i2c_0 2>, <&adc_i2c_0 3>,
> +				<&adc_i2c_0 4>, <&adc_i2c_0 5>,
> +				<&adc_i2c_0 6>, <&adc_i2c_0 7>,
> +				<&adc_i2c_0 8>, <&adc_i2c_0 9>,
> +				<&adc_i2c_0 10>, <&adc_i2c_0 11>,
> +				<&adc_i2c_0 12>;
> +	};
> +};
> +
> +&mdio0 {
> +	status = "okay";
> +
> +	ethphy0: ethernet-phy at 0 {
> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <0>;
> +	};
> +};
> +
> +&mac0 {
> +	status = "okay";
> +
> +	phy-mode = "rgmii";
> +	phy-handle = <&ethphy0>;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_rgmii1_default>;
> +};
> +
> +&mac3 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_rmii4_default>;
> +	clock-names = "MACCLK", "RCLK";
> +	use-ncsi;
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
> +&spi1 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_spi1_default>;
> +
> +	flash at 0 {
> +		status = "okay";
> +		m25p,fast-read;
> +		label = "pnor";
> +		spi-max-frequency = <20000000>;
> +	};
> +};
> +
> +&uart1 {
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	status = "okay";
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
> +	i2c-mux at 70 {
> +		compatible = "nxp,pca9548";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reg = <0x70>;
> +		i2c-mux-idle-disconnect;
> +
> +		i2c2_bus70_chn0: i2c at 0 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x0>;
> +			psu at 58 {
> +				compatible = "pmbus";
> +				reg = <0x58>;
> +			};
> +
> +			psu at 59 {
> +				compatible = "pmbus";
> +				reg = <0x59>;
> +			};
> +		};
> +	};
> +};
> +
> +&i2c3 {
> +	status = "okay";
> +	bus-frequency = <1000000>;
> +	multi-master;
> +	mctp-controller;
> +
> +	mctp at 10 {
> +		compatible = "mctp-i2c-controller";
> +		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> +	};
> +};
> +
> +&i2c4 {
> +	status = "okay";
> +	eeprom at 50 {
> +		compatible = "atmel,24c64";
> +		reg = <0x50>;
> +		pagesize = <32>;
> +	};
> +
> +	i2c-mux at 70 {
> +		compatible = "nxp,pca9545";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reg = <0x70>;
> +		i2c-mux-idle-disconnect;
> +
> +		i2c4_bus70_chn0: i2c at 0 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x0>;
> +
> +			eeprom at 52 {
> +				compatible = "atmel,24c256";
> +				reg = <0x52>;
> +				pagesize = <32>;
> +			};
> +			temperature-sensor at 48 {
> +				compatible = "ti,tmp75";
> +				reg = <0x48>;
> +			};
> +			temperature-sensor at 49 {
> +				compatible = "ti,tmp75";
> +				reg = <0x49>;
> +			};
> +			temperature-sensor at 4a{
> +				compatible = "ti,tmp75";
> +				reg = <0x4a>;
> +			};
> +			temperature-sensor at 4b {
> +				compatible = "ti,tmp464";
> +				reg = <0x4b>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				channel at 0 {
> +					reg = <0x0>;
> +					status = "disabled";
> +				};
> +				channel at 1 {
> +					reg = <0x1>;
> +					status = "disabled";
> +				};
> +				channel at 2 {
> +					reg = <0x2>;
> +					status = "disabled";
> +				};
> +				channel at 3 {
> +					reg = <0x3>;
> +					status = "disabled";
> +				};
> +				channel at 4 {
> +					reg = <0x4>;
> +				};
> +			};
> +			temperature-sensor at 4d {
> +				compatible = "ti,tmp75";
> +				reg = <0x4d>;
> +			};
> +			temperature-sensor at 4e {
> +				compatible = "ti,tmp75";
> +				reg = <0x4e>;
> +			};
> +			temperature-sensor at 4f {
> +				compatible = "ti,tmp75";
> +				reg = <0x4f>;
> +			};
> +			temperature-sensor at 28 {
> +				compatible = "nuvoton,nct7802";
> +				reg = <0x28>;
> +
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				channel at 1 { /* RTD1 */
> +					reg = <1>;
> +					sensor-type = "temperature";
> +					temperature-mode = "thermistor";
> +				};
> +			};
> +			adc_i2c_0: adc at 14 {
> +				compatible = "lltc,ltc2497";
> +				reg = <0x14>;
> +				vref-supply = <&voltage_mon_reg>;
> +				#io-channel-cells = <1>;
> +			};
> +		};
> +
> +		i2c4_bus70_chn2: i2c at 2 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x2>;
> +
> +			adc_i2c_2: adc at 14 {
> +				compatible = "lltc,ltc2497";
> +				reg = <0x14>;
> +				vref-supply = <&voltage_mon_reg>;
> +				#io-channel-cells = <1>;
> +			};
> +		};
> +	};
> +};
> +
> +&i2c5 {
> +	status = "okay";
> +	i2c-mux at 70 {
> +		compatible = "nxp,pca9548";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reg = <0x70>;
> +		i2c-mux-idle-disconnect;
> +
> +		i2c at 0 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x0>;
> +
> +			i2c-mux at 71 {
> +				compatible = "nxp,pca9548";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				reg = <0x71>;
> +				i2c-mux-idle-disconnect;
> +
> +				nvmeslot_8: i2c at 0 {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					reg = <0x0>;
> +				};
> +				nvmeslot_9: i2c at 1 {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					reg = <0x1>;
> +				};
> +				nvmeslot_10: i2c at 2 {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					reg = <0x2>;
> +				};
> +				nvmeslot_11: i2c at 3 {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					reg = <0x3>;
> +				};
> +			};
> +
> +			i2c-mux at 72 {
> +				compatible = "nxp,pca9548";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				reg = <0x72>;
> +				i2c-mux-idle-disconnect;
> +
> +				nvmeslot_4: i2c at 4 {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					reg = <0x4>;
> +				};
> +				nvmeslot_5: i2c at 5 {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					reg = <0x5>;
> +				};
> +				nvmeslot_6: i2c at 6 {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					reg = <0x6>;
> +				};
> +				nvmeslot_7: i2c at 7 {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					reg = <0x7>;
> +				};
> +			};
> +
> +			i2c-mux at 74 {
> +				compatible = "nxp,pca9548";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				reg = <0x74>;
> +				i2c-mux-idle-disconnect;
> +
> +				ocpslot: i2c at 0 {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					reg = <0x0>;
> +
> +					ocpslot_temp: temperature-sensor at 1f {
> +						compatible = "ti,tmp421";
> +						reg = <0x1f>;
> +						#address-cells = <1>;
> +						#size-cells = <0>;
> +
> +						channel at 0 {
> +							reg = <0x0>;
> +							status = "disabled";
> +						};
> +						channel at 1 {
> +							reg = <0x1>;
> +						};
> +					};
> +				};
> +
> +				nvmeslot_0: i2c at 4 {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					reg = <0x4>;
> +				};
> +				nvmeslot_1: i2c at 5 {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					reg = <0x5>;
> +				};
> +				nvmeslot_2: i2c at 6 {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					reg = <0x6>;
> +				};
> +				nvmeslot_3: i2c at 7 {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					reg = <0x7>;
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&i2c6 {
> +	status = "okay";
> +
> +	rtc at 51 {
> +		compatible = "nxp,pcf8563";
> +		reg = <0x51>;
> +	};
> +};
> +
> +&i2c7 {
> +	status = "okay";
> +
> +	temperature-sensor at 4f {
> +		compatible = "ti,tmp75";
> +		reg = <0x4f>;
> +	};
> +};
> +
> +&i2c8 {
> +	status = "okay";
> +
> +	fan-controller at 5c {
> +		compatible = "onnn,adt7462";
> +		reg = <0x5c>;
> +	};
> +};
> +
> +&i2c9 {
> +	status = "okay";
> +
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	eeprom at 50 {
> +		compatible = "atmel,24c02";
> +		reg = <0x50>;
> +	};
> +
> +	eeprom at 52 {
> +		compatible = "atmel,24c02";
> +		reg = <0x52>;
> +	};
> +
> +	temperature-sensor at 18 {
> +		compatible = "jedec,jc-42.4-temp";
> +		reg = <0x18>;
> +	};
> +
> +	temperature-sensor at 1a {
> +		compatible = "jedec,jc-42.4-temp";
> +		reg = <0x1a>;
> +	};
> +};
> +
> +&i2c10 {
> +	status = "okay";
> +};
> +
> +&i2c11 {
> +	status = "okay";
> +	ssif-bmc at 10 {
> +		compatible = "ssif-bmc";
> +		reg = <0x10>;
> +	};
> +};
> +
> +&i2c14 {
> +	status = "okay";
> +	eeprom at 50 {
> +		compatible = "atmel,24c64";
> +		reg = <0x50>;
> +		pagesize = <32>;
> +	};
> +
> +	bmc_ast2600_cpu: temperature-sensor at 48 {
> +		compatible = "ti,tmp75";
> +		reg = <0x48>;
> +	};
> +};
> +
> +&i2c15 {
> +	status = "okay";
> +	gpio_expander1: gpio-expander at 22 {
> +		compatible = "nxp,pca9535";
> +		reg = <0x22>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		gpio-line-names =
> +			"presence-ocp1","presence-ocp2",
> +			"","",
> +			"","",
> +			"","",
> +			"","",
> +			"","",
> +			"","",
> +			"","";
> +	};
> +};
> +
> +&adc0 {
> +	status = "okay";
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_adc0_default &pinctrl_adc1_default
> +		&pinctrl_adc2_default>;
> +};
> +
> +&vhub {
> +	status = "okay";
> +};
> +
> +&video {
> +	status = "okay";
> +	memory-region = <&video_engine_memory>;
> +};
> +
> +&gpio0 {
> +	gpio-line-names =
> +	/*A0-A7*/	"","","","","cpu-type-detect","i2c2-reset-n","i2c6-reset-n","i2c5-reset-n",
> +	/*B0-B7*/	"","","","","host0-sysreset-n","host0-pmin-n","fru-rd-complete",
> +			"chassis-id-sel",
> +	/*C0-C7*/	"s0-vrd-fault-n","","bmc-debug-mode","","cpld-3v3-irq-n","","vrd-sel",
> +			"spd-sel",
> +	/*D0-D7*/	"presence-ps0","presence-ps1","hsc-12vmain-alt2-n","ext-high-temp-n",
> +			"","","","",
> +	/*E0-E7*/	"eth-phy-rst-n","eth-phy-int-n","","","","","","",
> +	/*F0-F7*/	"s0-pcp-oc-warn-n","","power-chassis-control",
> +			"cpu-bios-recover","s0-heartbeat","hs-scout-proc-hot","s0-vr-hot-n","",
> +	/*G0-G7*/	"","","hsc-12vmain-alt1-n","","","bp-cpld-program-en","led-fp-sta-gr",
> +			"led-fp-sta-amb",
> +	/*H0-H7*/	"jtag-program-sel","jtag-cmpl2","wd-disable-n","power-chassis-good","","",
> +			"","",
> +	/*I0-I7*/	"","","","","","","power-button","rtc-battery-voltage-read-enable",
> +	/*J0-J7*/	"","","","","","","","",
> +	/*K0-K7*/	"","","","","","","","",
> +	/*L0-L7*/	"","","","","reset-button","","","",
> +	/*M0-M7*/	"nmi-n","s0-ddr-save","soc-spi-nor-access","presence-cpu0","s0-rtc-lock",
> +			"","","",
> +	/*N0-N7*/	"hpm-fw-recovery","hpm-stby-rst-n","jtag-sel-s0","led-sw-hb",
> +			"jtag-dbgr-prsnt-n","","","",
> +	/*O0-O7*/	"","","","","","","","",
> +	/*P0-P7*/	"ps0-ac-loss-n","ps1-ac-loss-n","","","led-fault","user-mode","jtag-srst-n",
> +			"led-bmc-hb",
> +	/*Q0-Q7*/	"","","","","","","","",
> +	/*R0-R7*/	"","","","","","","","",
> +	/*S0-S7*/	"","","identify-button","led-identify","","spi-nor-access","host0-ready","",
> +	/*T0-T7*/	"","","","","","","","",
> +	/*U0-U7*/	"","","","","","","","",
> +	/*V0-V7*/	"s0-hightemp-n","s0-fault-alert","s0-sys-auth-failure-n",
> +			"host0-reboot-ack-n","s0-fw-boot-ok","host0-shd-req-n",
> +			"host0-shd-ack-n","s0-overtemp-n",
> +	/*W0-W7*/	"ocp-aux-pwren","ocp-main-pwren","ocp-pgood","",
> +			"bmc-ok","bmc-ready","spi0-program-sel","spi0-backup-sel",
> +	/*X0-X7*/	"","","","","","","","",
> +	/*Y0-Y7*/	"","","","vrd-prg-en-n","","","","host0-special-boot",
> +	/*Z0-Z7*/	"","ps0-pgood","ps1-pgood","","","","","";
> +
> +	ocp-aux-pwren-hog {
> +		gpio-hog;
> +		gpios = <ASPEED_GPIO(W, 0) GPIO_ACTIVE_HIGH>;
> +		output-high;
> +		line-name = "ocp-aux-pwren";
> +	};
> +
> +};
> +
> +&gpio1 {
> +	gpio-line-names =
> +	/*18A0-18A7*/	"","","","","","","","",
> +	/*18B0-18B7*/	"","","","","s0-soc-pgood","vga-ft-press-n","emmc-rst-n","s01-uart1-sel",
> +	/*18C0-18C7*/	"uart1-mode0","uart1-mode1","uart2-mode0","uart2-mode1",
> +			"","","","",
> +	/*18D0-18D7*/	"","","","","","","","",
> +	/*18E0-18E3*/	"","","","";
> +};

