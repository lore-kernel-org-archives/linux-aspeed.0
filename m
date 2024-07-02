From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 2 Jul 2024 12:47:09 +0200
Subject: [PATCH v1 3/3] ARM: dts: aspeed: Add IEISystems NF5280M7 BMC
 machine
In-Reply-To: <20240701105259.972135-3-liuxiwei@ieisystem.com>
References: <20240701105259.972135-1-liuxiwei@ieisystem.com>
 <20240701105259.972135-3-liuxiwei@ieisystem.com>
Message-ID: <d7281992-821b-4eee-b028-7402a58524e3@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 01/07/2024 12:52, George Liu wrote:
> The IEISystems NF5280M7 is an x86 platform server with an
> AST2600-based BMC.
> This dts file provides a basic configuration for its OpenBMC
> development.
> 

...

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
> +		bootargs = "console=ttyS4,115200n8 earlycon";

earlycon is debugging tool, not production, drop. This leads to totally
redundant bootargs, so drop it entirely.

> +	};
> +
> +	memory at 80000000 {
> +		device_type = "memory";
> +		reg = <0x80000000 0x80000000>;
> +	};
> +

...


> +&i2c2 {
> +	status = "okay";

Missing blank line (everywhere)

> +	pca9546 at 70{

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +		compatible = "nxp,pca9546";
> +		reg = <0x70>;
> +		bus2_mux70_0: i2c at 2{
> +			reg = <0>;
> +			tmp112 at 49{

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


Everywhere: missing space before {


> +				compatible = "ti,tmp112";
> +				reg = <0x49>;
> +				label = "Inlet_Temp";
> +			};

Missing blank line

> +			emc1413 at 4c{

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +				compatible = "microchip,emc1413";
> +				reg = <0x4c>;
> +				label = "Outlet_Temp";
> +			};
> +		};
> +	};
> +};
> +
> +&i2c4 {
> +	multi-master;
> +	status = "okay";
> +	ipmb0 at 10 {
> +		compatible = "ipmb-dev";
> +		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> +		i2c-protocol;
> +	};
> +};
> +
> +&i2c5 {
> +	bus-frequency = <1000000>;
> +	multi-master;
> +	status = "okay";
> +	pca9546 at 70{

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

Above comment applies to multiple places.

> +		compatible = "nxp,pca9546";
> +		reg = <0x70>;
> +		bus5_mux00: i2c at 0 {
> +			reg = <0>;
> +			status = "okay";

Where is it disabled?

> +			vrmp2888 at 76 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +				compatible = "mps,mp2888";
> +				reg = <0x76>;
> +			};
> +			vrmp2888 at 72 {
> +				compatible = "mps,mp2888";
> +				reg = <0x72>;
> +			};
> +			vrmp2888 at 62{
> +				compatible = "mps,mp2888";
> +				reg = <0x62>;
> +			};
> +		};
> +		bus5_mux01: i2c at 1{
> +			reg = <1>;
> +			status = "okay";

Where is it disabled?

> +			vrmp2888 at 76{

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +				compatible = "mps,mp2888";
> +				reg = <0x76>;
> +			};
> +			vrmp2888 at 72 {
> +				compatible = "mps,mp2888";
> +				reg = <0x72>;
> +			};
> +			vrmp2888 at 62{
> +				compatible = "mps,mp2888";
> +				reg = <0x62>;
> +			};
> +		};
> +		bus5_mux02: i2c at 2{
> +			reg = <2>;
> +		};
> +		bus5_mux03: i2c at 3{
> +			reg = <3>;
> +		};
> +	};
> +};
> +
> +&i2c6 {
> +	multi-master;
> +	status = "okay";
> +
> +	i2c-switch at 70 {
> +		compatible = "nxp,pca9548";
> +		reg = <0x70>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		i2c6s0ch0: i2c at 0 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0>;
> +
> +			eeprom at 50 {
> +				compatible = "atmel,24c256";
> +				reg = <0x50>;
> +			};
> +			pca9548 at 71 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +				compatible = "nxp,pca9548";
> +				reg = <0x71>;
> +				i2c-mux-idle-disconnect;
> +
> +				i2c6s1ch0: i2c at 0 {




> +		};
> +	};
> +};
> +
> +&i2c7 {
> +	multi-master;
> +	#retries = <3>;
> +	status = "okay";
> +
> +	adc128d818 at 1d {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +		compatible = "ti,adc128d818";
> +		reg = <0x1d>;
> +		ti,mode = /bits/ 8 <0x01>;
> +	};



Best regards,
Krzysztof

