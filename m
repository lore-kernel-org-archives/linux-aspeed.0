From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 12 Apr 2021 11:46:24 +0930
Subject: [PATCH v3] ARM: dts: aspeed: add ASRock E3C246D4I BMC
In-Reply-To: <20210401044232.9637-1-zev@bewilderbeest.net>
References: <20210401044232.9637-1-zev@bewilderbeest.net>
Message-ID: <84202973-1a94-4630-beeb-f33d044a0364@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Thu, 1 Apr 2021, at 15:12, Zev Weiss wrote:
> This is a relatively low-cost AST2500-based Xeon E-2100/E-2200 series
> mini-ITX board that we hope can provide a decent platform for OpenBMC
> development.
> 
> This initial device-tree provides the necessary configuration for
> basic BMC functionality such as host power control, serial console and
> KVM support, and POST code snooping.
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> ---
> 
> Changes since v2:
>  - un-bungled filename in dtb-$(CONFIG_ARCH_ASPEED)
> Changes since v1:
>  - added entry to dtb-$(CONFIG_ARCH_ASPEED)
>  - added board to compatible
>  - added pinctrl properties to adc
>  - split out of mostly-unrelated patch series
> 
>  arch/arm/boot/dts/Makefile                    |   1 +
>  .../boot/dts/aspeed-bmc-asrock-e3c246d4i.dts  | 202 ++++++++++++++++++
>  2 files changed, 203 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 8e5d4ab4e75e..c22151b50ddc 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1406,6 +1406,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>  	aspeed-bmc-ampere-mtjade.dtb \
>  	aspeed-bmc-arm-centriq2400-rep.dtb \
>  	aspeed-bmc-arm-stardragon4800-rep2.dtb \
> +	aspeed-bmc-asrock-e3c246d4i.dtb \
>  	aspeed-bmc-bytedance-g220a.dtb \
>  	aspeed-bmc-facebook-cmm.dtb \
>  	aspeed-bmc-facebook-galaxy100.dtb \
> diff --git a/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts 
> b/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts
> new file mode 100644
> index 000000000000..dcab6e78dfa4
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts
> @@ -0,0 +1,202 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/dts-v1/;
> +
> +#include "aspeed-g5.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +#include <dt-bindings/i2c/i2c.h>
> +
> +/{
> +	model = "ASRock E3C246D4I BMC";
> +	compatible = "asrock,e3c246d4i-bmc", "aspeed,ast2500";
> +
> +	aliases {
> +		serial4 = &uart5;
> +	};
> +
> +	chosen {
> +		stdout-path = &uart5;
> +		bootargs = "console=tty0 console=ttyS4,115200 earlyprintk";
> +	};
> +
> +	memory at 80000000 {
> +		reg = <0x80000000 0x20000000>;
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		heartbeat {
> +			/* BMC_HB_LED_N */
> +			gpios = <&gpio ASPEED_GPIO(H, 6) GPIO_ACTIVE_LOW>;
> +			linux,default-trigger = "timer";
> +		};
> +
> +		system-fault {
> +			/* SYSTEM_FAULT_LED_N */
> +			gpios = <&gpio ASPEED_GPIO(Z, 2) GPIO_ACTIVE_LOW>;
> +			panic-indicator;
> +		};
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		uid-button {
> +			label = "uid-button";
> +			gpios = <&gpio ASPEED_GPIO(F, 1) GPIO_ACTIVE_LOW>;
> +			linux,code = <ASPEED_GPIO(F, 1)>;
> +		};
> +	};
> +
> +	iio-hwmon {
> +		compatible = "iio-hwmon";
> +		io-channels = <&adc 0>, <&adc 1>, <&adc 2>, <&adc 3>, <&adc 4>,
> +			<&adc 5>, <&adc 6>, <&adc 7>, <&adc 8>, <&adc 9>,
> +			<&adc 10>, <&adc 11>, <&adc 12>;
> +	};
> +};
> +
> +&fmc {
> +	status = "okay";
> +	flash at 0 {
> +		status = "okay";
> +		m25p,fast-read;
> +		label = "bmc";
> +		spi-max-frequency = <100000000>; /* 100 MHz */
> +#include "openbmc-flash-layout.dtsi"
> +	};
> +};
> +
> +&uart5 {
> +	status = "okay";
> +};
> +
> +&vuart {
> +	status = "okay";
> +	aspeed,sirq-active-high;

This should probably go away, but otherwise,

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
