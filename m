From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 26 Apr 2024 08:35:40 +0200
Subject: [PATCH v3 13/14] ARM: dts: aspeed: Add IBM P11 Blueridge BMC
 system
In-Reply-To: <20240425213701.655540-14-eajames@linux.ibm.com>
References: <20240425213701.655540-1-eajames@linux.ibm.com>
 <20240425213701.655540-14-eajames@linux.ibm.com>
Message-ID: <b6c54d2e-9906-4607-bc19-e0de077c25b9@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 25/04/2024 23:37, Eddie James wrote:
> Add the device tree for the new BMC system. The Blueridge is a
> P11 system with four processors.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  .../dts/aspeed/aspeed-bmc-ibm-blueridge.dts   | 1711 +++++++++++++++++
>  1 file changed, 1711 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dts
> 
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dts
> new file mode 100644
> index 000000000000..8503ce2480b5
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dts
> @@ -0,0 +1,1711 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +// Copyright 2024 IBM Corp.
> +/dts-v1/;
> +
> +#include "aspeed-g6.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +#include <dt-bindings/i2c/i2c.h>
> +#include <dt-bindings/leds/leds-pca955x.h>
> +
> +/ {
> +	model = "Blueridge";
> +	compatible = "ibm,blueridge-bmc", "aspeed,ast2600";
> +
> +	aliases {
> +		serial4 = &uart5;
> +		i2c16 = &i2c2mux0;
> +		i2c17 = &i2c2mux1;
> +		i2c18 = &i2c2mux2;
> +		i2c19 = &i2c2mux3;
> +		i2c20 = &i2c4mux0chn0;
> +		i2c21 = &i2c4mux0chn1;
> +		i2c22 = &i2c4mux0chn2;
> +		i2c23 = &i2c5mux0chn0;
> +		i2c24 = &i2c5mux0chn1;
> +		i2c25 = &i2c6mux0chn0;
> +		i2c26 = &i2c6mux0chn1;
> +		i2c27 = &i2c6mux0chn2;
> +		i2c28 = &i2c6mux0chn3;
> +		i2c29 = &i2c11mux0chn0;
> +		i2c30 = &i2c11mux0chn1;
> +	};
> +
> +	chosen {
> +		stdout-path = &uart5;
> +		bootargs = "console=ttyS4,115200n8 earlycon";

Drop bootargs. ALWAYS.


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
> +		event_log: tcg_event_log at b3d00000 {

No underscores.

Didn't you already received such basic review?


> +			no-map;
> +			reg = <0xb3d00000 0x100000>;
> +		};
> +
> +		ramoops at b3e00000 {
> +			compatible = "ramoops";
> +			reg = <0xb3e00000 0x200000>; /* 16 * (4 * 0x8000) */
> +			record-size = <0x8000>;
> +			console-size = <0x8000>;
> +			ftrace-size = <0x8000>;
> +			pmsg-size = <0x8000>;
> +			max-reason = <3>; /* KMSG_DUMP_EMERG */
> +		};
> +
> +		/* LPC FW cycle bridge region requires natural alignment */
> +		flash_memory: region at b4000000 {
> +			no-map;
> +			reg = <0xb4000000 0x04000000>; /* 64M */
> +		};
> +
> +		/* VGA region is dictated by hardware strapping */
> +		vga_memory: region at bf000000 {
> +			no-map;
> +			compatible = "shared-dma-pool";
> +			reg = <0xbf000000 0x01000000>;  /* 16M */
> +		};
> +	};
> +
> +	i2c2mux: i2cmux {
> +		compatible = "i2c-mux-gpio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		status = "okay";

??? Drop


> +
> +		i2c-parent = <&i2c2>;
> +		mux-gpios = <&gpio0 ASPEED_GPIO(G, 4) GPIO_ACTIVE_HIGH>,
> +			    <&gpio0 ASPEED_GPIO(G, 5) GPIO_ACTIVE_HIGH>;
> +		idle-state = <0>;
> +
> +		i2c2mux0: i2c at 0 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0>;
> +		};
> +
> +		i2c2mux1: i2c at 1 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <1>;
> +		};
> +
> +		i2c2mux2: i2c at 2 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <2>;
> +		};
> +
> +		i2c2mux3: i2c at 3 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <3>;
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		/* BMC Card fault LED at the back */
> +		led-bmc-ingraham0 {
> +			gpios = <&gpio0 ASPEED_GPIO(H, 1) GPIO_ACTIVE_LOW>;
> +		};
> +
> +		/* Enclosure ID LED at the back */
> +		led-rear-enc-id0 {
> +			gpios = <&gpio0 ASPEED_GPIO(H, 2) GPIO_ACTIVE_LOW>;
> +		};
> +
> +		/* Enclosure fault LED at the back */
> +		led-rear-enc-fault0 {
> +			gpios = <&gpio0 ASPEED_GPIO(H, 3) GPIO_ACTIVE_LOW>;
> +		};
> +
> +		/* PCIE slot power LED */
> +		led-pcieslot-power {
> +			gpios = <&gpio0 ASPEED_GPIO(P, 4) GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +
> +	gpio-keys-polled {
> +		compatible = "gpio-keys-polled";
> +		poll-interval = <1000>;
> +
> +		event-fan0-presence {
> +			label = "fan0-presence";
> +			gpios = <&pca0 6 GPIO_ACTIVE_LOW>;
> +			linux,code = <6>;
> +		};
> +
> +		event-fan1-presence {
> +			label = "fan1-presence";
> +			gpios = <&pca0 7 GPIO_ACTIVE_LOW>;
> +			linux,code = <7>;
> +		};
> +
> +		event-fan2-presence {
> +			label = "fan2-presence";
> +			gpios = <&pca0 8 GPIO_ACTIVE_LOW>;
> +			linux,code = <8>;
> +		};
> +
> +		event-fan3-presence {
> +			label = "fan3-presence";
> +			gpios = <&pca0 9 GPIO_ACTIVE_LOW>;
> +			linux,code = <9>;
> +		};
> +
> +		event-fan4-presence {
> +			label = "fan4-presence";
> +			gpios = <&pca0 10 GPIO_ACTIVE_LOW>;
> +			linux,code = <10>;
> +		};
> +
> +		event-fan5-presence {
> +			label = "fan5-presence";
> +			gpios = <&pca0 11 GPIO_ACTIVE_LOW>;
> +			linux,code = <11>;
> +		};
> +	};
> +
> +	iio-hwmon {
> +		compatible = "iio-hwmon";
> +		io-channels = <&adc1 7>;
> +	};
> +};
> +
> +&adc1 {
> +	status = "okay";
> +	aspeed,int-vref-microvolt = <2500000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc9_default
> +		&pinctrl_adc10_default &pinctrl_adc11_default
> +		&pinctrl_adc12_default &pinctrl_adc13_default
> +		&pinctrl_adc14_default &pinctrl_adc15_default>;
> +};
> +
> +&ehci1 {
> +	status = "okay";
> +};
> +
> +&uhci {
> +	status = "okay";
> +};
> +
> +&gpio0 {
> +	gpio-line-names =
> +	/*A0-A7*/	"","","","","","","","",
> +	/*B0-B7*/	"","","","","","","checkstop","",
> +	/*C0-C7*/	"","","","","","","","",
> +	/*D0-D7*/	"","","","","","","","",
> +	/*E0-E7*/	"","","","","","","","",
> +	/*F0-F7*/	"","","rtc-battery-voltage-read-enable","reset-cause-pinhole","","","factory-reset-toggle","",
> +	/*G0-G7*/	"","","","","","","","",
> +	/*H0-H7*/	"","bmc-ingraham0","rear-enc-id0","rear-enc-fault0","","","","",
> +	/*I0-I7*/	"","","","","","","bmc-secure-boot","",
> +	/*J0-J7*/	"","","","","","","","",
> +	/*K0-K7*/	"","","","","","","","",
> +	/*L0-L7*/	"","","","","","","","",
> +	/*M0-M7*/	"","","","","","","","",
> +	/*N0-N7*/	"","","","","","","","",
> +	/*O0-O7*/	"","","","usb-power","","","","",
> +	/*P0-P7*/	"","","","","pcieslot-power","","","",
> +	/*Q0-Q7*/	"cfam-reset","","regulator-standby-faulted","","","","","",
> +	/*R0-R7*/	"bmc-tpm-reset","power-chassis-control","power-chassis-good","","","","","",
> +	/*S0-S7*/	"presence-ps0","presence-ps1","presence-ps2","presence-ps3",
> +	"power-ffs-sync-history","","","",
> +	/*T0-T7*/	"","","","","","","","",
> +	/*U0-U7*/	"","","","","","","","",
> +	/*V0-V7*/	"","","","","","","","",
> +	/*W0-W7*/	"","","","","","","","",
> +	/*X0-X7*/	"","","","","","","","",
> +	/*Y0-Y7*/	"","","","","","","","",
> +	/*Z0-Z7*/	"","","","","","","","";
> +
> +	i2c3_mux_oe_n-hog {
> +		gpio-hog;
> +		gpios = <ASPEED_GPIO(G, 6) GPIO_ACTIVE_LOW>;
> +		output-high;
> +		line-name = "I2C3_MUX_OE_N";
> +	};
> +
> +	usb_power-hog {
> +		gpio-hog;
> +		gpios = <ASPEED_GPIO(O, 3) GPIO_ACTIVE_LOW>;
> +		output-high;
> +	};
> +};
> +
> +&emmc_controller {
> +	status = "okay";
> +};
> +
> +&pinctrl_emmc_default {
> +	bias-disable;
> +};
> +
> +&emmc {
> +	status = "okay";
> +	clk-phase-mmc-hs200 = <180>, <180>;
> +};
> +
> +&ibt {
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +
> +	eeprom at 51 {
> +		compatible = "atmel,24c64";
> +		reg = <0x51>;
> +	};
> +
> +	tca_pres1: tca9554 at 20{

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

Also missing space before {


> +		compatible = "ti,tca9554";
> +		reg = <0x20>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		gpio-line-names = "",
> +			"RUSSEL_FW_I2C_ENABLE_N",
> +			"RUSSEL_OPPANEL_PRESENCE_N",
> +			"BLYTH_OPPANEL_PRESENCE_N",
> +			"CPU_TPM_CARD_PRESENT_N",
> +			"DASD_BP2_PRESENT_N",
> +			"DASD_BP1_PRESENT_N",
> +			"DASD_BP0_PRESENT_N";
> +	};
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
> +
> +	power-supply at 68 {
> +		compatible = "ibm,cffps";
> +		reg = <0x68>;
> +	};
> +
> +	power-supply at 69 {
> +		compatible = "ibm,cffps";
> +		reg = <0x69>;
> +	};
> +
> +	pca_pres1: pca9552 at 61 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +		compatible = "nxp,pca9552";
> +		reg = <0x61>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		gpio-line-names =
> +			"SLOT0_PRSNT_EN_RSVD", "SLOT1_PRSNT_EN_RSVD",
> +			"SLOT2_PRSNT_EN_RSVD", "SLOT3_PRSNT_EN_RSVD",
> +			"SLOT4_PRSNT_EN_RSVD", "SLOT0_EXPANDER_PRSNT_N",
> +			"SLOT1_EXPANDER_PRSNT_N", "SLOT2_EXPANDER_PRSNT_N",
> +			"SLOT3_EXPANDER_PRSNT_N", "SLOT4_EXPANDER_PRSNT_N",
> +			"", "", "", "", "", "";
> +	};
> +};
> +
> +&i2c4 {
> +	status = "okay";
> +
> +	tmp275 at 48 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation



> +		compatible = "ti,tmp275";
> +		reg = <0x48>;
> +	};
> +
> +	tmp275 at 49 {

So it's everywhere...

> +		compatible = "ti,tmp275";
> +		reg = <0x49>;
> +	};
> +
> +	tmp275 at 4a {
> +		compatible = "ti,tmp275";
> +		reg = <0x4a>;
> +	};
> +
> +	i2c-mux at 70 {
> +		compatible = "nxp,pca9546";
> +		reg = <0x70>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		status = "okay";

Why? Drop

> +		i2c-mux-idle-disconnect;
> +
> +		i2c4mux0chn0: i2c at 0 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0>;
> +
> +			eeprom at 50 {
> +				compatible = "atmel,24c64";
> +				reg = <0x50>;
> +			};
> +
> +			pca9551 at 60 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +				compatible = "nxp,pca9551";
> +				reg = <0x60>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +
> +				led at 0 {
> +					label = "cablecard0-cxp-top";
> +					reg = <0>;
> +					retain-state-shutdown;
> +					default-state = "keep";
> +					type = <PCA955X_TYPE_LED>;
> +				};
> +
> +				led at 1 {
> +					label = "cablecard0-cxp-bot";
> +					reg = <1>;
> +					retain-state-shutdown;
> +					default-state = "keep";
> +					type = <PCA955X_TYPE_LED>;
> +				};
> +			};
> +		};
> +
> +		i2c4mux0chn1: i2c at 1 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <1>;

reg is after compatible, which means if there is no compatible, reg is
always first. This applies you all your DTS patches. This patchset and
future.


> +
> +			eeprom at 51 {
> +				compatible = "atmel,24c64";
> +				reg = <0x51>;
> +			};
> +		};
> +
> +		i2c4mux0chn2: i2c at 2 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <2>;
> +
> +			eeprom at 52 {
> +				compatible = "atmel,24c64";
> +				reg = <0x52>;
> +			};
> +		};
> +	};
> +};
> +
> +&i2c5 {
> +	status = "okay";
> +
> +	tmp275 at 48 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +		compatible = "ti,tmp275";
> +		reg = <0x48>;
> +	};
> +
> +	tmp275 at 49 {
> +		compatible = "ti,tmp275";
> +		reg = <0x49>;
> +	};
> +
> +	i2c-mux at 70 {
> +		compatible = "nxp,pca9546";
> +		reg = <0x70>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		status = "okay";

Drop


> +		i2c-mux-idle-disconnect;
> +
> +		i2c5mux0chn0: i2c at 0 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0>;
> +
> +			eeprom at 50 {
> +				compatible = "atmel,24c64";
> +				reg = <0x50>;
> +			};
> +
> +			pca9551 at 60 {
> +				compatible = "nxp,pca9551";
> +				reg = <0x60>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +
> +				led at 0 {
> +					label = "cablecard3-cxp-top";
> +					reg = <0>;
> +					retain-state-shutdown;
> +					default-state = "keep";
> +					type = <PCA955X_TYPE_LED>;
> +				};
> +
> +				led at 1 {
> +					label = "cablecard3-cxp-bot";
> +					reg = <1>;
> +					retain-state-shutdown;
> +					default-state = "keep";
> +					type = <PCA955X_TYPE_LED>;
> +				};
> +			};
> +		};
> +
> +		i2c5mux0chn1: i2c at 1 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <1>;
> +
> +			eeprom at 51 {
> +				compatible = "atmel,24c64";
> +				reg = <0x51>;
> +			};
> +
> +			pca9551 at 61 {
> +				compatible = "nxp,pca9551";
> +				reg = <0x61>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;


And here you have correct order of properties...



Best regards,
Krzysztof

