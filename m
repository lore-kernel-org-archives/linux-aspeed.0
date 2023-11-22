From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 22 Nov 2023 08:40:22 +0100
Subject: [PATCH v2 2/2] ARM: dts: aspeed: Minerva Harma: Add Facebook
 Minerva Harma (AST2600) BMC
In-Reply-To: <20231122032234.744144-3-peteryin.openbmc@gmail.com>
References: <20231122032234.744144-1-peteryin.openbmc@gmail.com>
 <20231122032234.744144-3-peteryin.openbmc@gmail.com>
Message-ID: <cdbc75b9-3be1-4017-9bee-c8f161b6843c@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 22/11/2023 04:22, Peter Yin wrote:
> Add linux device tree entry related to
> Minerva Harma specific devices connected to BMC SoC.
> 
> Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
> ---
>  arch/arm/boot/dts/aspeed/Makefile             |   1 +
>  .../aspeed-bmc-facebook-minerva-harma.dts     | 533 ++++++++++++++++++
>  2 files changed, 534 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva-harma.dts
> 

...

> +
> +	iio-hwmon {
> +		compatible = "iio-hwmon";
> +		io-channels = <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
> +			<&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
> +			<&adc1 2>;
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		BMC_HEARTBEAT_N {

These are not proper names. Underscores and capital letters are not
allowed. Also - not tested.

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check W=1` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

> +			label = "bmc_heartbeat_n";

Drop, instead color and function.

> +			gpios = <&gpio0 ASPEED_GPIO(P, 7) GPIO_ACTIVE_LOW>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +
> +		FM_ID_LED_N {
> +			label = "fm_id_led_n";

Color and function

> +			default-state = "off";
> +			gpios = <&gpio0 13 GPIO_ACTIVE_HIGH>;
> +		};
> +	};
> +};


Best regards,
Krzysztof

