From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 28 Nov 2023 08:38:56 +0100
Subject: [PATCH 2/2] ARM: dts: aspeed: asrock: Add ASRock X570D4U BMC
In-Reply-To: <20231128013136.2699317-3-renze@rnplus.nl>
References: <20231128013136.2699317-1-renze@rnplus.nl>
 <20231128013136.2699317-3-renze@rnplus.nl>
Message-ID: <c9f8c072-de00-4f4a-b675-b42a5cbd4922@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 28/11/2023 02:30, Renze Nicolai wrote:
> This is a relatively low-cost AST2500-based Amd Ryzen 5000 Series
> micro-ATX board that we hope can provide a decent platform for OpenBMC
> development.
> 
> This initial device-tree provides the necessary configuration for
> basic BMC functionality such as serial console, KVM support
> and POST code snooping.
> 
> Signed-off-by: Renze Nicolai <renze@rnplus.nl>
> ---
>  arch/arm/boot/dts/aspeed/Makefile             |   1 +
>  .../dts/aspeed/aspeed-bmc-asrock-x570d4u.dts  | 344 ++++++++++++++++++
>  2 files changed, 345 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts
> 
> diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
> index d3ac20e316d0..2205bd079d0c 100644
> --- a/arch/arm/boot/dts/aspeed/Makefile
> +++ b/arch/arm/boot/dts/aspeed/Makefile
> @@ -10,6 +10,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>  	aspeed-bmc-arm-stardragon4800-rep2.dtb \
>  	aspeed-bmc-asrock-e3c246d4i.dtb \
>  	aspeed-bmc-asrock-romed8hm3.dtb \
> +	aspeed-bmc-asrock-x570d4u.dtb \
>  	aspeed-bmc-bytedance-g220a.dtb \
>  	aspeed-bmc-delta-ahe50dc.dtb \
>  	aspeed-bmc-facebook-bletchley.dtb \
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts
> new file mode 100644
> index 000000000000..9fb1d76abacb
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts
> @@ -0,0 +1,344 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/dts-v1/;
> +#include "aspeed-g5.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +
> +/ {
> +	model = "Asrock Rack X570D4U BMC";
> +	compatible = "asrock,x570d4u-bmc";
> +
> +	chosen {
> +			stdout-path = &uart5;
> +			bootargs = "console=ttyS4,115200 earlycon";

Drop console. stdout-path defines the console and earlycon is for debugging.

> +	};
> +
> +	memory at 80000000 {
> +			reg = <0x80000000 0x20000000>;

You have messed up indentation everywhere.

> +	};
> +
> +	reserved-memory {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			pci_memory: region at 9A000000 {
> +				no-map;
> +				reg = <0x9A000000 0x00010000>; /* 64K */
> +			};
> +
> +			video_engine_memory: jpegbuffer {
> +				size = <0x02800000>;	/* 40M */
> +				alignment = <0x01000000>;
> +				compatible = "shared-dma-pool";
> +				reusable;
> +			};
> +
> +			gfx_memory: framebuffer {
> +				size = <0x01000000>;
> +				alignment = <0x01000000>;
> +				compatible = "shared-dma-pool";
> +				reusable;
> +			};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		heartbeat {

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check W=1` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).


Best regards,
Krzysztof

