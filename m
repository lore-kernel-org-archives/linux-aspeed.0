From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 14 Nov 2023 21:34:50 +0100
Subject: [PATCH 2/2] ARM: dts: aspeed: Add ASRock SPC621D8HM3 BMC
In-Reply-To: <20231114112819.28572-6-zev@bewilderbeest.net>
References: <20231114112819.28572-4-zev@bewilderbeest.net>
 <20231114112819.28572-6-zev@bewilderbeest.net>
Message-ID: <a988886c-a799-4dc2-81ba-eb3bd86438dd@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 14/11/2023 12:28, Zev Weiss wrote:
> This is a Xeon board broadly similar (aside from CPU vendor) to the
> already-support romed8hm3 (half-width, single-socket, ast2500).  It
> doesn't require anything terribly special for OpenBMC support, so this
> device-tree should provide everything necessary for basic
> functionality with it.
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> ---
>  arch/arm/boot/dts/aspeed/Makefile             |   1 +
>  .../aspeed/aspeed-bmc-asrock-spc621d8hm3.dts  | 316 ++++++++++++++++++
>  2 files changed, 317 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-spc621d8hm3.dts
> 
> diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
> index d3ac20e316d0..2df0a2e88df7 100644
> --- a/arch/arm/boot/dts/aspeed/Makefile
> +++ b/arch/arm/boot/dts/aspeed/Makefile
> @@ -10,6 +10,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>  	aspeed-bmc-arm-stardragon4800-rep2.dtb \
>  	aspeed-bmc-asrock-e3c246d4i.dtb \
>  	aspeed-bmc-asrock-romed8hm3.dtb \
> +	aspeed-bmc-asrock-spc621d8hm3.dtb \
>  	aspeed-bmc-bytedance-g220a.dtb \
>  	aspeed-bmc-delta-ahe50dc.dtb \
>  	aspeed-bmc-facebook-bletchley.dtb \
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-spc621d8hm3.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-spc621d8hm3.dts
> new file mode 100644
> index 000000000000..95b440d90f56
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-spc621d8hm3.dts
> @@ -0,0 +1,316 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/dts-v1/;
> +
> +#include "aspeed-g5.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +#include <dt-bindings/i2c/i2c.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +/{
> +	model = "ASRock SPC621D8HM3 BMC";
> +	compatible = "asrock,spc621d8hm3-bmc", "aspeed,ast2500";
> +
> +	aliases {
> +		serial4 = &uart5;
> +
> +		i2c20 = &i2c1mux0ch0;
> +		i2c21 = &i2c1mux0ch1;
> +	};
> +
> +	chosen {
> +		stdout-path = &uart5;
> +		bootargs = "console=tty0 console=ttyS4,115200 earlycon";

Drop bootargs. Serial (and rate) should be selected by stdout path.

earlycon is for debug, not wide usage.

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

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


It does not look like you tested the DTS against bindings. Please run
`make dtbs_check W=1` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).


Best regards,
Krzysztof

