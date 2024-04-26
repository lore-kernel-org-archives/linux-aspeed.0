From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 26 Apr 2024 13:13:07 +0200
Subject: [PATCH] ARM: dts: aspeed: sbp1: IBM sbp1 BMC board
In-Reply-To: <20240426100909.1351939-1-naresh.solanki@9elements.com>
References: <20240426100909.1351939-1-naresh.solanki@9elements.com>
Message-ID: <0b811850-14f5-4895-9614-cd61b697b8e0@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 26/04/2024 12:09, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> Add a device tree for IBM sbp1 BMC board which is based on AST2600 SOC.
> 
> sbp1 baseboard has:
> - support for up to four Sapphire Rapids sockets having 16 DIMMS each.
>   - 240 core/480 threads at maximum
> - 32x CPU PCIe slots
> - 2x M.2 PCH PCIe slots
> - Dual 200Gbit/s NIC
> - SPI TPM
> 
> Added the following:
> - Indication LEDs
> - I2C mux & GPIO controller, pin assignments,
> - Thermister,
> - Voltage regulator
> - EEPROM/VPD
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
>  arch/arm/boot/dts/aspeed/Makefile             |    1 +
>  .../boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dts   | 6224 +++++++++++++++++
>  2 files changed, 6225 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dts
> 
> diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
> index d3ac20e316d0..5fc9ed3f5150 100644
> --- a/arch/arm/boot/dts/aspeed/Makefile
> +++ b/arch/arm/boot/dts/aspeed/Makefile
> @@ -33,6 +33,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>  	aspeed-bmc-ibm-rainier.dtb \
>  	aspeed-bmc-ibm-rainier-1s4u.dtb \
>  	aspeed-bmc-ibm-rainier-4u.dtb \
> +	aspeed-bmc-ibm-sbp1.dtb \
>  	aspeed-bmc-intel-s2600wf.dtb \
>  	aspeed-bmc-inspur-fp5280g2.dtb \
>  	aspeed-bmc-inspur-nf5280m6.dtb \
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dts
> new file mode 100644
> index 000000000000..5395295b677b
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dts
> @@ -0,0 +1,6224 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +// Copyright 2024 IBM Corp.
> +/dts-v1/;
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/i2c/i2c.h>
> +#include "aspeed-g6.dtsi"
> +
> +/ {
> +	model = "IBM SBP1";
> +	compatible = "ibm,sbp1-bmc", "aspeed,ast2600";

Please run scripts/checkpatch.pl and fix reported warnings. Then please
run `scripts/checkpatch.pl --strict` and (probably) fix more warnings.
Some warnings can be ignored, especially from --strict run, but the code
here looks like it needs a fix. Feel free to get in touch if the warning
is not clear.

> +
> +	chosen {
> +		stdout-path = &uart1;
> +		bootargs = "console=tty0 console=ttyS0,115200 earlycon";

Drop entire bootargs. That's debugging.


> +	};
> +
> +	memory at 80000000 {
> +		reg = <0x80000000 0x20000000>;
> +		device_type = "memory";
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
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		led-power {
> +			label = "LED_BMC_READY";
> +			gpios = <&gpio0 ASPEED_GPIO(H, 1) GPIO_ACTIVE_LOW>;
> +			color = <LED_COLOR_ID_GREEN>;
> +			default-state = "off";
> +			retain-state-suspended;
> +			panic-indicator;
> +		};
> +
> +		// Misc ID LEDs
> +		led-id_tpm {

No underscores in node names.

I am pretty sure you received from me before all three feedbacks above.


...


> +
> +	iio-hwmon {
> +		compatible = "iio-hwmon";
> +		// Voltage sensors top to down

Use consistent comment style.


> +		io-channels = <&p12v_vd 0>, <&p5v_aux_vd 0>, <&p5v_bmc_aux_vd 0>, <&p3v3_aux_vd 0>,
> +			<&p3v3_bmc_aux_vd 0>, <&p1v8_bmc_aux_vd 0>, <&adc1 4>, <&adc0 2>, <&adc1 0>,
> +			<&p2V5_aux_vd 0>, <&p3v3_rtc_vd 0>;
> +	};
> +
> +	p12v_vd: voltage_divider1 {

No underscores in node names.

> +		compatible = "voltage-divider";
> +		io-channels = <&adc1 3>;
> +		#io-channel-cells = <1>;
> +
> +		/* Scale the system voltage by 1127/127 to fit the ADC range.

This is not networking code. See Linux Coding style.



...

> +
> +	thermistor0: thermistor.0 {

? Neither dots. Do you see any code like this in Linux kernel?


...


regulator-boot-on;
> +	};
> +
> +	p12v_b_consumer {
> +		status = "okay";

Why? Who disabled it?


...


> +
> +	bmc_mux_nic: mux at 77 { //  U61040
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "maxim,max7357";

Compatible is always the first property. reg is second.

> +		reg = <0x77>;
> +
> +		reset-gpios = <&gpio0 ASPEED_GPIO(R, 3) (GPIO_ACTIVE_LOW | GPIO_OPEN_DRAIN)>; // BMC_MUX_NIC_RST_INT_N
> +		vdd-supply = <&p3v3_aux>;
> +
> +		i2c at 0 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0>;

reg is before address/size cells.

> +
> +			smb_pex_nic: pinctrl at 20 { // U62160
> +				compatible = "cypress,cy8c9540";
> +				reg = <0x20>;
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				#interrupt-cells=<2>;
> +				interrupt-parent = <&smb_pex_vr_ctrl>;
> +				interrupts = <8 IRQ_TYPE_LEVEL_HIGH>; // SMB_PEX_NIC_INT
> +				interrupt-controller;
> +
> +				vdd-supply = <&p3v3_aux>;
> +				// Reset is PEX_NIC_RST
> +				reset-gpios = <&gpio0 ASPEED_GPIO(Q, 3) GPIO_ACTIVE_HIGH>;
> +
> +				gpio-reserved-ranges = <19 1>, <22 6>, <30 6>, <38 2>;
> +
> +				gpio-line-names =
> +				/* GPORT0 */
> +				"IRQ_NIC2_OVT_WRNG", "FM_NIC2_ALLSTANDBY_N", "IRQ_NIC2_OVT_SHTDN",
> +				"SMB_VR_PVCORE_NIC2_ALERT_N", "FM_NIC2_PERST1_N", "SMB_NIC2_ALERT_N",

Some random alignment.


...


> +			reg = <3>;
> +
> +			smb_m2_ssb_ssd1: regulator at 3a {
> +				reg = <0x3a>;
> +				vss1-supply = <&p3v3_aux>;
> +				compatible = "maxim,max5978";
> +				interrupt-parent = <&smb_pex_vr_ctrl>;
> +				interrupts = <30 IRQ_TYPE_LEVEL_LOW>; // M2_SSD1_SSB_ALERT_N
> +					leds {

Broken indentation.

This DTS does not pass basic sanity checks. It's unreadable. Does not
follow coding style.

Do not upstream your downstream code directly, but clean it to match
upstream code quality.

I finished review here because it's absolutely huge, unmanageable patch
with trivial issues which should not be sent upstream in the first place.

All comments above apply to entire patchset and all your future
patchset. Please do not ask us to keep repeating obvious comments but
learn from them and improve your future submissions.

Best regards,
Krzysztof

