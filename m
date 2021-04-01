From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 01 Apr 2021 10:34:51 +1030
Subject: [PATCH 3/3] ARM: dts: aspeed: add ASRock E3C246D4I BMC
In-Reply-To: <20210330002338.335-4-zev@bewilderbeest.net>
References: <20210330002338.335-1-zev@bewilderbeest.net>
 <20210330002338.335-4-zev@bewilderbeest.net>
Message-ID: <815c666b-d657-4d0a-bea4-d2e182d9e5d1@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Tue, 30 Mar 2021, at 10:53, Zev Weiss wrote:
> This is a relatively low-cost AST2500-based Xeon E-2100/E-2200 series
> mini-ITX board that we hope can provide a decent platform for OpenBMC
> development.
> 
> This initial device-tree provides the necessary configuration for
> basic BMC functionality such as host power control, serial console and
> KVM support, and POST code snooping.
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> ---
>  .../boot/dts/aspeed-bmc-asrock-e3c246d4i.dts  | 188 ++++++++++++++++++
>  1 file changed, 188 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts
> 
> diff --git a/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts 
> b/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts
> new file mode 100644
> index 000000000000..27b34c3cf67a
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts
> @@ -0,0 +1,188 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/dts-v1/;
> +
> +#include "aspeed-g5.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +#include <dt-bindings/i2c/i2c.h>
> +
> +/{
> +	model = "ASRock E3C246D4I BMC";
> +	compatible = "aspeed,ast2500";
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

You're hooking up the ADC lines to the iio-hwmon bridge...
> +
> +&adc {
> +	status = "okay";
> +};

But you haven't requested the ADC lines from pinmux here.

It will *happen* to work as expected because ADC is the default mux 
state for the pins, but by not requesting the lines you're leaving the 
pins available for a conflicting request, which can be annoying to 
debug.

> +
> +&kcs3 {
> +	status = "okay";
> +	aspeed,lpc-io-reg = <0xca2>;
> +};

Given you need KCS support, do you mind testing my KCS series?

https://lore.kernel.org/linux-arm-kernel/20210319062752.145730-1-andrew at aj.id.au/

The cover letter got detached, and is here:

https://lore.kernel.org/linux-arm-kernel/20210319061952.145040-1-andrew at aj.id.au/

Andrew
