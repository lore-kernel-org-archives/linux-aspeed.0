From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 25 Aug 2023 08:19:28 +0200
Subject: [PATCH] Add Meta openBMC Minerva dts file.
In-Reply-To: <20230825032945.1649050-1-peteryin.openbmc@gmail.com>
References: <20230825032945.1649050-1-peteryin.openbmc@gmail.com>
Message-ID: <fb09f5e6-8381-312f-2f1e-f2b471cec68a@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 25/08/2023 05:29, peteryin wrote:
> This is for Meta openBMC Minerva dts.
> 
> Signed-off-by: peteryin <peteryin.openbmc@gmail.com>
> ---
>  .../boot/dts/aspeed-bmc-facebook-minerva.dts  | 330 ++++++++++++++++++>  1 file changed, 330 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-minerva.dts
> 
> diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-minerva.dts
> new file mode 100644
> index 000000000000..4fb9b5f72942
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-minerva.dts
> @@ -0,0 +1,330 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +// Copyright (c) 2023 Facebook Inc.
> +/dts-v1/;
> +
> +#include "aspeed-g6.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +
> +/ {
> +	model = "Facebook Minerva";
> +	compatible = "facebook, minerva-bmc", "aspeed,ast2600";

Missing bindings and that's not correct compatible.

> +
> +	aliases {
> +		serial0 = &uart1;
> +		serial4 = &uart5;
> +	};
> +
> +	chosen {
> +		bootargs = "console=ttyS4,57600n8";

Drop, use stdout path instead.

> +	};
> +

...

> +&gpio0 {
> +	pinctrl-names = "default";
> +	gpio-line-names =
> +	/*A0-A7*/	"","","","","","","","",
> +	/*B0-B7*/	"","","","","","","","",
> +	/*C0-C7*/	"","","","","","","","",
> +	/*D0-D7*/	"","","SOL_UART_SET","","","","","",
> +	/*E0-E7*/	"","","","","","","","",
> +	/*F0-F7*/	"","","","","","","","",
> +	/*G0-G7*/	"","","","","","","","",
> +	/*H0-H7*/	"","","","","","","","",
> +	/*I0-I7*/	"","","","","","","","",
> +	/*J0-J7*/	"","","","","","","","",
> +	/*K0-K7*/	"","","","","","","","",
> +	/*L0-L7*/	"","","","","","","","",
> +	/*M0-M7*/	"","","","","","","","",
> +	/*N0-N7*/	"LED_POSTCODE_0","LED_POSTCODE_1",
> +			"LED_POSTCODE_2","LED_POSTCODE_3",
> +			"LED_POSTCODE_4","LED_POSTCODE_5",
> +			"LED_POSTCODE_6","LED_POSTCODE_7",
> +	/*O0-O7*/	"","","","","","","","",
> +	/*P0-P7*/	"","","","","","","","",
> +	/*Q0-Q7*/	"","","","","","","","",
> +	/*R0-R7*/	"","","","","","","","",
> +	/*S0-S7*/	"","","","","","","","",
> +	/*T0-T7*/	"","","","","","","","",
> +	/*U0-U7*/	"","","","","","","","",
> +	/*V0-V7*/	"","","","","","","","",
> +	/*W0-W7*/	"","","","","","","","",
> +	/*X0-X7*/	"","","","","","","","",
> +	/*Y0-Y7*/	"","","","","","","","",
> +	/*Z0-Z7*/	"","","","","","","","";
> +};
> +

Stray blank line.

Best regards,
Krzysztof

