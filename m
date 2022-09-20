From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 20 Sep 2022 18:04:23 +0200
Subject: [PATCH v2] ARM: dts: aspeed: Add AMD DaytonaX BMC
In-Reply-To: <20220920153928.6454-1-aladyshev22@gmail.com>
References: <20220920153928.6454-1-aladyshev22@gmail.com>
Message-ID: <62aab493-fe9b-07af-2d9a-a85ba1d1060f@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 20/09/2022 17:39, Konstantin Aladyshev wrote:
> Add initial version of device tree for the BMC in the AMD DaytonaX
> platform.


Thank you for your patch. There is something to discuss/improve.

> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 05d8aef6e5d2..9eff88d410aa 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1575,6 +1575,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>  	aspeed-ast2600-evb-a1.dtb \
>  	aspeed-ast2600-evb.dtb \
>  	aspeed-bmc-amd-ethanolx.dtb \
> +	aspeed-bmc-amd-daytonax.dtb \
>  	aspeed-bmc-ampere-mtjade.dtb \
>  	aspeed-bmc-arm-stardragon4800-rep2.dtb \
>  	aspeed-bmc-asrock-e3c246d4i.dtb \
> diff --git a/arch/arm/boot/dts/aspeed-bmc-amd-daytonax.dts b/arch/arm/boot/dts/aspeed-bmc-amd-daytonax.dts
> new file mode 100644
> index 000000000000..0e066b5ae0fb
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed-bmc-amd-daytonax.dts
> @@ -0,0 +1,320 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/dts-v1/;
> +
> +#include "aspeed-g5.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +/ {
> +	model = "AMD DaytonaX BMC";
> +	compatible = "amd,daytonax-bmc", "aspeed,ast2500";

Missing bindings documentation.

> +
> +	memory at 80000000 {
> +		reg = <0x80000000 0x20000000>;
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		video_engine_memory: jpegbuffer {
> +			size = <0x02000000>;	/* 32M */
> +			alignment = <0x01000000>;
> +			compatible = "shared-dma-pool";
> +			reusable;
> +		};
> +	};
> +
> +	aliases {
> +		serial0 = &uart1;
> +		serial4 = &uart5;
> +	};
> +
> +	chosen {
> +		stdout-path = &uart5;
> +		bootargs = "console=ttyS4,115200 earlycon";

bootargs do not belong to mainline DTS. earlycon for sure.

> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		fault {

Does not look like you tested the DTS against bindings. Please run `make
dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
for instructions).

Nodes are wrong.

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +			gpios = <&gpio ASPEED_GPIO(A, 2) GPIO_ACTIVE_LOW>;
> +		};
> +
> +		identify {

Ditto

> +			gpios = <&gpio ASPEED_GPIO(A, 3) GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +
> +	iio-hwmon {
> +		compatible = "iio-hwmon";
> +		io-channels = <&adc 0>, <&adc 1>, <&adc 2>, <&adc 3>, <&adc 4>,
> +			<&adc 5>, <&adc 6>, <&adc 7>, <&adc 8>, <&adc 9>,
> +			<&adc 10>, <&adc 11>, <&adc 12>, <&adc 13>, <&adc 14>,
> +			<&adc 15>;
> +	};
> +};
> +
> +&fmc {

(...)


> +	fan at 15 {
> +		reg = <0x07>;
> +		aspeed,fan-tach-ch = /bits/ 8 <0x0f>;
> +	};
> +};
> +
> +&video {
> +	status = "okay";
> +	memory-region = <&video_engine_memory>;
> +};
> +
> +&vhub {
> +	status = "okay";
> +};
> +

No need for trailing new line.

Best regards,
Krzysztof
