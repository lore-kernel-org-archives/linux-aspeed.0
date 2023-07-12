From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 12 Jul 2023 10:27:36 +0200
Subject: [PATCH v1 2/2] ARM: dts: aspeed: yosemitev4: add Facebook
 Yosemite V4 BMC
In-Reply-To: <20230712073752.54624-3-Delphine_CC_Chiu@wiwynn.com>
References: <20230712073752.54624-1-Delphine_CC_Chiu@wiwynn.com>
 <20230712073752.54624-3-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <f5cd65fb-60b1-f470-8ad0-78dd5be9cf68@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 12/07/2023 09:37, Delphine CC Chiu wrote:
> Add linux device tree entry related to
> Yosemite V4 specific devices connected to BMC SoC.
> 
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  arch/arm/boot/dts/Makefile                    |   1 +
>  .../dts/aspeed-bmc-facebook-yosemitev4.dts    | 570 ++++++++++++++++++
>  2 files changed, 571 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev4.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 59829fc90315..871e6d271262 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1631,6 +1631,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>  	aspeed-bmc-facebook-galaxy100.dtb \
>  	aspeed-bmc-facebook-greatlakes.dtb \
>  	aspeed-bmc-facebook-minipack.dtb \
> +	aspeed-bmc-facebook-yosemitev4.dtb \
>  	aspeed-bmc-facebook-tiogapass.dtb \
>  	aspeed-bmc-facebook-wedge40.dtb \
>  	aspeed-bmc-facebook-wedge100.dtb \
> diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev4.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev4.dts
> new file mode 100644
> index 000000000000..1df151fb6ff3
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev4.dts
> @@ -0,0 +1,570 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +// Copyright 2022 Facebook Inc.
> +
> +/dts-v1/;
> +#include "aspeed-g6.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +#include <dt-bindings/leds/leds-pca955x.h>
> +#include <dt-bindings/i2c/i2c.h>
> +
> +/ {
> +	model = "Facebook Yosemite V4 BMC";
> +	compatible = "facebook,yosemitev4-bmc", "aspeed,ast2600";
> +
> +	aliases {
> +		serial4 = &uart5;
> +		serial5 = &uart6;
> +		serial6 = &uart7;
> +		serial7 = &uart8;
> +		serial8 = &uart9;
> +	};
> +
> +	chosen {
> +		bootargs = "console=ttyS4,57600n8";

Use stdout-path

> +	};
> +
> +	memory at 80000000 {
> +		device_type = "memory";
> +		reg = <0x80000000 0x80000000>;
> +	};

...

> +
> +&i2c0 {
> +	status = "okay";
> +	bus-frequency = <400000>;
> +	multi-master;
> +	adm1278 at 40 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +		compatible = "adi,adm1278";
> +		reg = <0x40>;
> +	};
> +};
> +
> +&i2c1 {
> +	status = "okay";
> +	bus-frequency = <400000>;
> +	multi-master;
> +	adm1278 at 40 {

Look, you already got such comment so you are repeating same mistakes.
https://lore.kernel.org/all/a8854c8e-8868-461d-9f7b-d5b44f7288c7 at linaro.org/

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +		compatible = "adi,adm1278";
> +		reg = <0x40>;
> +	};
> +};
> +
> +&i2c2 {
> +	status = "okay";
> +	bus-frequency = <400000>;
> +	multi-master;
> +	adm1278 at 40 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +		compatible = "adi,adm1278";

I stop here, there is no point to review same mistakes.

Best regards,
Krzysztof

