From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 3 Mar 2024 13:03:57 +0100
Subject: [PATCH v2 1/1] ARM:dts:aspeed: Initial device tree for AMD Onyx
 Platform
In-Reply-To: <20240301222257.3309541-1-supreeth.venkatesh@amd.com>
References: <20240301222257.3309541-1-supreeth.venkatesh@amd.com>
Message-ID: <86387c8d-35f2-4715-86a2-3aff571c3dd8@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 01/03/2024 23:22, Supreeth Venkatesh wrote:
> Add initial device tree and makefile updates for
> AMD Onyx platform.
> 
> AMD Onyx platform is an AMD customer reference board with an Aspeed
> ast2600 BMC manufactured by AMD.
> It describes I2C devices, UARTs, MAC, FMC, etc.
> present on AMD Onyx platform.
> 
> Signed-off-by: Supreeth Venkatesh <supreeth.venkatesh@amd.com>
> ---
> Changes since v1:
> * Incorporate review comments

I don't see how did you resolve checkpatch warning.

> * Update commit message
> * Remove vmalloc and earlyprintk
> ---
>  arch/arm/boot/dts/aspeed/Makefile             |  1 +
>  .../boot/dts/aspeed/aspeed-bmc-amd-onyx.dts   | 94 +++++++++++++++++++
>  2 files changed, 95 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dts
> 
> diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
> index fb9cc95f1b60..2b27d377aae2 100644
> --- a/arch/arm/boot/dts/aspeed/Makefile
> +++ b/arch/arm/boot/dts/aspeed/Makefile
> @@ -5,6 +5,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>  	aspeed-ast2600-evb.dtb \
>  	aspeed-bmc-amd-daytonax.dtb \
>  	aspeed-bmc-amd-ethanolx.dtb \
> +	aspeed-bmc-amd-onyx.dtb \
>  	aspeed-bmc-ampere-mtjade.dtb \
>  	aspeed-bmc-ampere-mtmitchell.dtb \
>  	aspeed-bmc-arm-stardragon4800-rep2.dtb \
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dts
> new file mode 100644
> index 000000000000..1831b8d18db2
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dts
> @@ -0,0 +1,94 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +// Copyright (c) 2021 - 2024 AMD Inc.
> +// Author: Supreeth Venkatesh <supreeth.venkatesh@amd.com>
> +
> +/dts-v1/;
> +
> +#include "aspeed-g6.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +
> +/ {
> +	model = "AMD Onyx BMC";
> +	compatible = "amd,onyx-bmc", "aspeed,ast2600";
> +
> +	aliases {
> +		serial0 = &uart1;
> +		serial4 = &uart5;
> +	};
> +
> +	chosen {
> +		stdout-path = &uart5;
> +		bootargs = "console=ttyS4,115200n8";

Again: drop, not needed. You ignored my comment. Use stdout path.

This is a friendly reminder during the review process.

It seems my or other reviewer's previous comments were not fully
addressed. Maybe the feedback got lost between the quotes, maybe you
just forgot to apply it. Please go back to the previous discussion and
either implement all requested changes or keep discussing them.

Thank you.


Best regards,
Krzysztof

