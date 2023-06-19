From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 19 Jun 2023 08:58:53 +0200
Subject: [PATCH v5 2/2] ARM: dts: aspeed: Adding Inventec Starscream BMC
In-Reply-To: <20230619064249.3623-2-chen.pj@inventec.com>
References: <20230619064249.3623-1-chen.pj@inventec.com>
 <20230619064249.3623-2-chen.pj@inventec.com>
Message-ID: <f5e6a29f-6df7-b56c-c7b2-9914008eaa33@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 19/06/2023 08:42, PJ Chen wrote:
> From: Chen PJ <Chen.pj@inventec.com>
> 
> Initial introduction of Inventec Starscream x86 family
> equipped with AST2600 BMC SoC.
> 
> Signed-off-by: Chen PJ <Chen.pj@inventec.com>
> 

...

> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		video_engine_memory: video {
> +			size = <0x04000000>;
> +			alignment = <0x01000000>;
> +			compatible = "shared-dma-pool";
> +			reusable;
> +		};
> +	};
> +
> +

Drop stray blank lines. Only one blank line, not two. Comment applies to
multiple places.

> +	iio-hwmon {
> +		compatible = "iio-hwmon";
> +		io-channels =
> +		<&adc_u74 0>, // P0_VDD11
> +		<&adc_u74 1>, // P1_VDD11
> +		<&adc_u74 2>, // P0_3V3_S5
> +		<&adc_u74 3>, // P1_3V3_S5
> +		<&adc_u74 4>, // P3V3
> +		<&adc_u74 5>, // VBAT
> +		<&adc_u74 6>, // P3V3_STBY
> +		<&adc_u74 7>, // P5V_STBY
> +		<&adc_u74 8>, // P5V
> +		<&adc_u74 9>, // P12V
> +		<&adc_u74 10>, // P1_VDD18_S5
> +		<&adc_u74 11> // P0_VDD18_S5
> +		;
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		uid {

No improvements. Still not fixed and not tested.

Best regards,
Krzysztof

