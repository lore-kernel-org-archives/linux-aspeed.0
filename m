From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 23 Jul 2024 11:20:12 +0200
Subject: [PATCH 2/2] ARM: dts: aspeed: catalina: add Meta Catalina BMC
In-Reply-To: <20240722145857.2131100-3-potin.lai.pt@gmail.com>
References: <20240722145857.2131100-1-potin.lai.pt@gmail.com>
 <20240722145857.2131100-3-potin.lai.pt@gmail.com>
Message-ID: <2ab2130f-0fb6-4026-aa17-207182e6d4d9@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 22/07/2024 16:58, Potin Lai wrote:
> From: Potin Lai <potin.lai@quantatw.com>
> 
> Add linux device tree entry for Meta(Facebook) Catalina compute-tray
> BMC using AT2600 SoC.
> 

...

> +		i2c45 = &imux45;
> +		i2c46 = &imux46;
> +		i2c47 = &imux47;
> +		i2c48 = &imux48;
> +		i2c49 = &imux49;
> +		i2c50 = &imux50;
> +		i2c51 = &imux51;
> +		i2c52 = &imux52;
> +		i2c53 = &imux53;
> +		i2c54 = &imux54;
> +		i2c55 = &imux55;
> +	};
> +
> +	chosen {
> +		bootargs = "console=ttyS4,57600n8";

Preferred is to use stdout-path property.

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
> +			      <&adc1 2>;
> +	};
> +
> +	spi1_gpio: spi1-gpio {
> +		compatible = "spi-gpio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		gpio-sck = <&gpio0 ASPEED_GPIO(Z, 3) GPIO_ACTIVE_HIGH>;
> +		gpio-mosi = <&gpio0 ASPEED_GPIO(Z, 4) GPIO_ACTIVE_HIGH>;
> +		gpio-miso = <&gpio0 ASPEED_GPIO(Z, 5) GPIO_ACTIVE_HIGH>;
> +		num-chipselects = <1>;
> +		cs-gpios = <&gpio0 ASPEED_GPIO(Z, 0) GPIO_ACTIVE_LOW>;
> +
> +		tpm at 0 {
> +			compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
> +			spi-max-frequency = <33000000>;
> +			reg = <0>;
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		led-0 {
> +			label = "bmc_heartbeat_amber";
> +			gpios = <&gpio0 ASPEED_GPIO(P, 7) GPIO_ACTIVE_LOW>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +
> +		led-1 {
> +			label = "fp_id_amber";
> +			default-state = "off";
> +			gpios = <&gpio0 ASPEED_GPIO(B, 5) GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		led-2 {
> +			label = "bmc_ready_noled";
> +			gpios = <&gpio0 ASPEED_GPIO(B, 3) (GPIO_ACTIVE_HIGH|GPIO_TRANSITORY)>;
> +		};
> +
> +		led-3 {
> +			label = "bmc_ready_cpld_noled";
> +			gpios = <&gpio0 ASPEED_GPIO(P, 5) (GPIO_ACTIVE_HIGH|GPIO_TRANSITORY)>;
> +		};
> +	};
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
> +&mdio0 {
> +	status = "okay";
> +};
> +
> +//&mac0 {

Please drop dead code or document why this is being commented out.

> +//	status = "okay";
> +//	phy-mode = "rmii";
> +//	pinctrl-names = "default";
> +//	pinctrl-0 = <&pinctrl_rgmii1_default>;
> +//	fixed-link {
> +//		speed = <1000>;
> +//		full-duplex;
> +//	};
> +//};
> +
> +&mac3 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	//pinctrl-0 = <&pinctrl_rmii4_default>;

Drop

> +	pinctrl-0 = <&pinctrl_ncsi4_default>;
> +	use-ncsi;
> +	ncsi-ctrl,start-redo-probe;
> +	ncsi-package = <1>;
> +};
> +
> +&fmc {
> +	status = "okay";
> +	flash at 0 {
> +		status = "okay";
> +		m25p,fast-read;
> +		label = "bmc";
> +		spi-max-frequency = <50000000>;
> +#include "openbmc-flash-layout-128.dtsi"
> +	};
> +	flash at 1 {
> +		status = "okay";
> +		m25p,fast-read;
> +		label = "alt-bmc";
> +		spi-max-frequency = <50000000>;
> +	};
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +
> +	i2c-mux at 71 {
> +		compatible = "nxp,pca9546";
> +		reg = <0x71>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		imux24: i2c at 0 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0>;
> +		};
> +		imux25: i2c at 1 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <1>;
> +		};
> +		imux26: i2c at 2 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <2>;
> +		};
> +		imux27: i2c at 3 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <3>;
> +		};
> +	};
> +
> +	i2c-mux at 72 {
> +		compatible = "nxp,pca9546";
> +		reg = <0x72>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		imux28: i2c at 0 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0>;
> +		};
> +		imux29: i2c at 1 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <1>;
> +
> +			// IO Mezz 0 IOEXP
> +			pca9535_30_20: pca9535 at 20 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +				compatible = "nxp,pca9535";
> +				reg = <0x20>;
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +			};
> +
> +			// IO Mezz 0 FRU EEPROM
> +			eeprom at 50 {
> +				compatible = "atmel,24c64";
> +				reg = <0x50>;
> +			};
> +		};
> +		imux30: i2c at 2 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <2>;
> +		};
> +		imux31: i2c at 3 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <3>;
> +		};
> +	};
> +
> +	i2c-mux at 73 {
> +		compatible = "nxp,pca9546";
> +		reg = <0x73>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		imux32: i2c at 0 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0>;
> +		};
> +		imux33: i2c at 1 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <1>;
> +
> +			i2c-mux at 70 {
> +				compatible = "nxp,pca9548";
> +				reg = <0x70>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				imux48: i2c at 0 {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					reg = <0>;
> +				};
> +				imux49: i2c at 1 {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					reg = <1>;
> +				};
> +				imux50: i2c at 2 {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					reg = <2>;
> +				};
> +				imux51: i2c at 3 {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					reg = <3>;
> +				};
> +				imux52: i2c at 4 {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					reg = <3>;
> +				};
> +				imux53: i2c at 5 {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					reg = <3>;
> +				};
> +				imux54: i2c at 6 {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					reg = <3>;
> +				};
> +				imux55: i2c at 7 {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					reg = <3>;
> +
> +					ina230 at 40 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

In other places as well.


Best regards,
Krzysztof

